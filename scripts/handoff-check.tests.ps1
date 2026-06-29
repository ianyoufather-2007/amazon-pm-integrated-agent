param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$rootPath = (Resolve-Path $Root).Path
$validator = Join-Path $rootPath 'scripts/handoff-check.ps1'
$validExample = Join-Path $rootPath 'examples/anonymized-stage-handoff.json'
$tempDir = Join-Path ([IO.Path]::GetTempPath()) ('amazon-pm-handoff-tests-' + [guid]::NewGuid().ToString('N'))
$powershellExecutable = (Get-Process -Id $PID).Path
$passed = 0
$failed = 0

New-Item -ItemType Directory -Path $tempDir | Out-Null

function Assert-Passes {
    param([string]$Label, [string]$InputFile)
    & $powershellExecutable -NoProfile -File $validator -Root $rootPath -InputPath $InputFile 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "FAIL: $Label (expected pass, got failure)"
        $script:failed++
    }
    else {
        $script:passed++
    }
}

function Assert-Fails {
    param([string]$Label, [string]$InputFile)
    & $powershellExecutable -NoProfile -File $validator -Root $rootPath -InputPath $InputFile 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "FAIL: $Label (expected failure, got pass)"
        $script:failed++
    }
    else {
        $script:passed++
    }
}

function New-MutatedHandoff {
    param([string]$FileName, [scriptblock]$Mutate)
    $obj = Get-Content -LiteralPath $validExample -Raw -Encoding UTF8 | ConvertFrom-Json
    & $Mutate $obj
    $path = Join-Path $tempDir $FileName
    $obj | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $path -Encoding UTF8
    return $path
}

try {
    # 1. Valid example must pass
    Assert-Passes 'valid example' $validExample

    # 2. Invalid execution.status
    $p = New-MutatedHandoff 'invalid-status.json' { param($o); $o.execution.status = 'unknown' }
    Assert-Fails 'invalid execution.status' $p

    # 3. Blocked without P0 data gap
    $p = New-MutatedHandoff 'blocked-no-p0.json' {
        param($o)
        $o.execution.status = 'blocked'
        $o.stage_gate.data_gaps = @($o.stage_gate.data_gaps | Where-Object { $_.priority -ne 'P0' })
    }
    Assert-Fails 'blocked without P0 gap' $p

    # 4. Invalid execution.route
    $p = New-MutatedHandoff 'invalid-route.json' { param($o); $o.execution.route = 'unknown_route' }
    Assert-Fails 'invalid execution.route' $p

    # 5. Invalid execution.round
    $p = New-MutatedHandoff 'invalid-round.json' { param($o); $o.execution.round = 'round_99' }
    Assert-Fails 'invalid execution.round' $p

    # 6. current_stage out of range (too high)
    $p = New-MutatedHandoff 'stage-too-high.json' { param($o); $o.execution.current_stage = 8 }
    Assert-Fails 'current_stage > 7' $p

    # 7. current_stage is negative
    $p = New-MutatedHandoff 'stage-negative.json' { param($o); $o.execution.current_stage = -1 }
    Assert-Fails 'current_stage < 0' $p

    # 8. next_stage regresses before current_stage
    $p = New-MutatedHandoff 'next-before-current.json' {
        param($o)
        $o.execution.current_stage = 4
        $o.handoff.next_stage = 2
    }
    Assert-Fails 'next_stage < current_stage' $p

    # 9. Invalid evidence source_kind
    $p = New-MutatedHandoff 'bad-source-kind.json' {
        param($o)
        $o.evidence_inventory[0].source_kind = 'internal'
    }
    Assert-Fails 'invalid evidence source_kind' $p

    # 10. Invalid evidence confidence
    $p = New-MutatedHandoff 'bad-confidence.json' {
        param($o)
        $o.evidence_inventory[0].confidence = 'high'
    }
    Assert-Fails 'invalid evidence confidence' $p

    # 11. Invalid date format in evidence
    $p = New-MutatedHandoff 'bad-date.json' {
        param($o)
        $o.evidence_inventory[0].collected_on = '2026/06/01'
    }
    Assert-Fails 'invalid evidence date format (slash-separated)' $p

    # 12. Windows path leak in handoff content
    $rawWithPath = (Get-Content -LiteralPath $validExample -Raw -Encoding UTF8) -replace '"product_direction"\s*:\s*"[^"]*"', '"product_direction": "see C:\\Users\\admin\\docs\\plan.docx"'
    $pathLeakFile = Join-Path $tempDir 'path-leak.json'
    Set-Content -LiteralPath $pathLeakFile -Value $rawWithPath -Encoding UTF8
    Assert-Fails 'Windows path in handoff content' $pathLeakFile

    # 13. Invalid data_gap priority
    $p = New-MutatedHandoff 'bad-gap-priority.json' {
        param($o)
        $o.stage_gate.data_gaps[0].priority = 'P3'
    }
    Assert-Fails 'invalid data_gap priority (P3)' $p
}
finally {
    Remove-Item -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "Handoff check tests: $passed passed, $failed failed."
if ($failed -gt 0) { exit 1 }
exit 0
