param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$InputPath = (Join-Path (Resolve-Path (Join-Path $PSScriptRoot '..')).Path 'examples/anonymized-stage-handoff.json')
)

$ErrorActionPreference = 'Stop'

$rootPath = (Resolve-Path $Root).Path
$inputFile = (Resolve-Path $InputPath).Path
$schemaFile = Join-Path $rootPath 'schemas/stage-handoff.schema.json'
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message) | Out-Null
}

function Test-RequiredProperty {
    param(
        [object]$Object,
        [string]$Property,
        [string]$Context
    )

    if ($null -eq $Object -or -not ($Object.PSObject.Properties.Name -contains $Property)) {
        Add-Failure "$Context is missing '$Property'."
        return $false
    }

    return $true
}

function Test-NonEmptyString {
    param(
        [object]$Value,
        [string]$Context
    )

    if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) {
        Add-Failure "$Context must be a non-empty string."
    }
}

function Test-StringArray {
    param(
        [object]$Value,
        [string]$Context,
        [switch]$RequireItems
    )

    if ($null -eq $Value) {
        Add-Failure "$Context must be an array."
        return
    }

    $items = @($Value)
    if ($RequireItems -and $items.Count -eq 0) {
        Add-Failure "$Context must contain at least one item."
    }

    foreach ($item in $items) {
        Test-NonEmptyString -Value $item -Context "$Context item"
    }
}

if (-not (Test-Path -LiteralPath $schemaFile)) {
    Add-Failure 'Missing schemas/stage-handoff.schema.json.'
}
else {
    try {
        $schema = Get-Content -LiteralPath $schemaFile -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($schema.title -ne 'Amazon PM Stage Handoff') {
            Add-Failure "Schema title must be 'Amazon PM Stage Handoff'."
        }
    }
    catch {
        Add-Failure "Schema JSON is invalid: $($_.Exception.Message)"
    }
}

try {
    $raw = Get-Content -LiteralPath $inputFile -Raw -Encoding UTF8
    $handoff = $raw | ConvertFrom-Json
}
catch {
    Add-Failure "Handoff JSON is invalid: $($_.Exception.Message)"
    $raw = ''
    $handoff = $null
}

if ($raw -match '[A-Za-z]:\\(?:Users|vscode|Downloads|Documents)\\') {
    Add-Failure 'Handoff contains a local Windows absolute path.'
}
if ($raw -match '(?i)\bqypm\b') {
    Add-Failure 'Handoff contains a private/internal project marker.'
}
if ($raw -match 'gh[pousr]_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}') {
    Add-Failure 'Handoff contains a token-like secret.'
}

if ($null -ne $handoff) {
    foreach ($property in @('schema_version', 'project', 'execution', 'evidence_inventory', 'stage_gate', 'handoff')) {
        Test-RequiredProperty -Object $handoff -Property $property -Context 'Root' | Out-Null
    }

    if ($handoff.schema_version -ne '1.0.0') {
        Add-Failure "schema_version must be '1.0.0'."
    }

    foreach ($property in @('marketplace', 'product_direction', 'language')) {
        if (Test-RequiredProperty -Object $handoff.project -Property $property -Context 'project') {
            Test-NonEmptyString -Value $handoff.project.$property -Context "project.$property"
        }
    }

    foreach ($property in @('route', 'round', 'current_stage', 'status')) {
        Test-RequiredProperty -Object $handoff.execution -Property $property -Context 'execution' | Out-Null
    }

    if (@('pm_triage', 'stage_gate') -notcontains $handoff.execution.route) {
        Add-Failure 'execution.route must be pm_triage or stage_gate.'
    }
    if (@('pm_triage', 'round_1', 'round_2', 'round_3', 'delivery') -notcontains $handoff.execution.round) {
        Add-Failure 'execution.round is unsupported.'
    }
    if (@('ready', 'conditional', 'blocked') -notcontains $handoff.execution.status) {
        Add-Failure 'execution.status must be ready, conditional, or blocked.'
    }

    $currentStage = 0
    if (-not [int]::TryParse([string]$handoff.execution.current_stage, [ref]$currentStage) -or $currentStage -lt 0 -or $currentStage -gt 7) {
        Add-Failure 'execution.current_stage must be an integer from 0 to 7.'
    }

    $roundRanges = @{
        pm_triage = @(0, 0)
        round_1 = @(1, 4)
        round_2 = @(4, 5)
        round_3 = @(6, 7)
    }
    if ($roundRanges.ContainsKey([string]$handoff.execution.round)) {
        $range = $roundRanges[[string]$handoff.execution.round]
        if ($currentStage -lt $range[0] -or $currentStage -gt $range[1]) {
            Add-Failure "execution.current_stage is outside the allowed range for $($handoff.execution.round)."
        }
    }

    $evidenceItems = @($handoff.evidence_inventory)
    if ($evidenceItems.Count -eq 0) {
        Add-Failure 'evidence_inventory must contain at least one item.'
    }
    foreach ($item in $evidenceItems) {
        foreach ($property in @('id', 'type', 'source_kind', 'collected_on', 'confidence', 'notes')) {
            Test-RequiredProperty -Object $item -Property $property -Context 'evidence_inventory item' | Out-Null
        }
        Test-NonEmptyString -Value $item.id -Context 'evidence_inventory.id'
        Test-NonEmptyString -Value $item.type -Context 'evidence_inventory.type'
        if (@('public', 'synthetic', 'user_provided', 'estimated') -notcontains $item.source_kind) {
            Add-Failure "Unsupported evidence source_kind: $($item.source_kind)"
        }
        if (@('confirmed', 'estimated', 'unverified') -notcontains $item.confidence) {
            Add-Failure "Unsupported evidence confidence: $($item.confidence)"
        }
        $collectedOn = [datetime]::MinValue
        if (-not [datetime]::TryParseExact([string]$item.collected_on, 'yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::None, [ref]$collectedOn)) {
            Add-Failure "evidence_inventory.collected_on must use YYYY-MM-DD: $($item.collected_on)"
        }
    }

    foreach ($property in @('allowed_outputs', 'forbidden_outputs', 'known_facts', 'signal_reading', 'risks', 'data_gaps', 'decisions_for_meeting')) {
        Test-RequiredProperty -Object $handoff.stage_gate -Property $property -Context 'stage_gate' | Out-Null
    }

    Test-StringArray -Value $handoff.stage_gate.allowed_outputs -Context 'stage_gate.allowed_outputs' -RequireItems
    Test-StringArray -Value $handoff.stage_gate.forbidden_outputs -Context 'stage_gate.forbidden_outputs' -RequireItems
    Test-StringArray -Value $handoff.stage_gate.known_facts -Context 'stage_gate.known_facts' -RequireItems
    Test-StringArray -Value $handoff.stage_gate.signal_reading -Context 'stage_gate.signal_reading'
    Test-StringArray -Value $handoff.stage_gate.risks -Context 'stage_gate.risks'
    Test-StringArray -Value $handoff.stage_gate.decisions_for_meeting -Context 'stage_gate.decisions_for_meeting'

    $dataGaps = @($handoff.stage_gate.data_gaps)
    foreach ($gap in $dataGaps) {
        foreach ($property in @('priority', 'gap', 'why_it_matters', 'next_action')) {
            Test-RequiredProperty -Object $gap -Property $property -Context 'stage_gate.data_gaps item' | Out-Null
        }
        if (@('P0', 'P1', 'P2') -notcontains $gap.priority) {
            Add-Failure "Unsupported data-gap priority: $($gap.priority)"
        }
        Test-NonEmptyString -Value $gap.gap -Context 'stage_gate.data_gaps.gap'
        Test-NonEmptyString -Value $gap.why_it_matters -Context 'stage_gate.data_gaps.why_it_matters'
        Test-NonEmptyString -Value $gap.next_action -Context 'stage_gate.data_gaps.next_action'
    }
    if ($handoff.execution.status -eq 'blocked' -and @($dataGaps | Where-Object { $_.priority -eq 'P0' }).Count -eq 0) {
        Add-Failure 'A blocked handoff must include at least one P0 data gap.'
    }

    foreach ($property in @('next_stage', 'required_inputs', 'deliverables', 'acceptance_checks')) {
        Test-RequiredProperty -Object $handoff.handoff -Property $property -Context 'handoff' | Out-Null
    }

    Test-StringArray -Value $handoff.handoff.required_inputs -Context 'handoff.required_inputs'
    Test-StringArray -Value $handoff.handoff.deliverables -Context 'handoff.deliverables' -RequireItems
    Test-StringArray -Value $handoff.handoff.acceptance_checks -Context 'handoff.acceptance_checks' -RequireItems

    if ($null -ne $handoff.handoff.next_stage) {
        $nextStage = 0
        if (-not [int]::TryParse([string]$handoff.handoff.next_stage, [ref]$nextStage) -or $nextStage -lt 0 -or $nextStage -gt 7) {
            Add-Failure 'handoff.next_stage must be null or an integer from 0 to 7.'
        }
        elseif ($nextStage -lt $currentStage) {
            Add-Failure 'handoff.next_stage cannot be earlier than execution.current_stage.'
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Host 'Handoff check failed:'
    $failures | ForEach-Object { Write-Host "- $_" }
    exit 1
}

Write-Host "Handoff check passed: $inputFile"
