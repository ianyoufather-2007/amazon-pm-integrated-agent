param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$rootPath = (Resolve-Path $Root).Path
$validator = Join-Path $rootPath 'scripts/handoff-check.ps1'
$validExample = Join-Path $rootPath 'examples/anonymized-stage-handoff.json'
$tempDir = Join-Path ([IO.Path]::GetTempPath()) ('amazon-pm-handoff-tests-' + [guid]::NewGuid().ToString('N'))
$powershellExecutable = (Get-Process -Id $PID).Path

New-Item -ItemType Directory -Path $tempDir | Out-Null

try {
    & $powershellExecutable -NoProfile -File $validator -Root $rootPath -InputPath $validExample
    if ($LASTEXITCODE -ne 0) {
        throw 'Expected the anonymized handoff example to pass validation.'
    }

    $invalidStatusPath = Join-Path $tempDir 'invalid-status.json'
    $invalidStatus = Get-Content -LiteralPath $validExample -Raw -Encoding UTF8 | ConvertFrom-Json
    $invalidStatus.execution.status = 'unknown'
    $invalidStatus | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $invalidStatusPath -Encoding UTF8

    & $powershellExecutable -NoProfile -File $validator -Root $rootPath -InputPath $invalidStatusPath
    if ($LASTEXITCODE -eq 0) {
        throw 'Expected an unsupported execution status to fail validation.'
    }

    $missingP0Path = Join-Path $tempDir 'blocked-without-p0.json'
    $missingP0 = Get-Content -LiteralPath $validExample -Raw -Encoding UTF8 | ConvertFrom-Json
    $missingP0.execution.status = 'blocked'
    $missingP0.stage_gate.data_gaps = @($missingP0.stage_gate.data_gaps | Where-Object { $_.priority -ne 'P0' })
    $missingP0 | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $missingP0Path -Encoding UTF8

    & $powershellExecutable -NoProfile -File $validator -Root $rootPath -InputPath $missingP0Path
    if ($LASTEXITCODE -eq 0) {
        throw 'Expected a blocked handoff without a P0 gap to fail validation.'
    }
}
finally {
    Remove-Item -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host 'Handoff check tests passed.'
