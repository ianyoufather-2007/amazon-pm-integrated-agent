param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$rootPath = (Resolve-Path $Root).Path
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message) | Out-Null
}

function Read-RepoText {
    param([string]$RelativePath)

    $path = Join-Path $rootPath $RelativePath
    if (-not (Test-Path -LiteralPath $path)) {
        Add-Failure "Missing required file: $RelativePath"
        return $null
    }

    return Get-Content -LiteralPath $path -Encoding UTF8 -Raw
}

function Test-Contains {
    param(
        [string]$Text,
        [string]$Needle,
        [string]$Context
    )

    if ($null -eq $Text) { return }
    if (-not $Text.Contains($Needle)) {
        Add-Failure "$Context is missing '$Needle'"
    }
}

$templateDir = Join-Path $rootPath 'templates'
$templates = Get-ChildItem -LiteralPath $templateDir -Filter 'stage-*.md' -File | Sort-Object Name

if ($templates.Count -lt 8) {
    Add-Failure "Expected at least 8 stage templates, found $($templates.Count)"
}

$requiredTemplateSections = @(
    '## Purpose',
    '## Use When',
    '## Required Input',
    '## Copy-Ready Prompt',
    '## Allowed Output',
    '## Forbidden Output'
)

foreach ($template in $templates) {
    $relative = "templates/$($template.Name)"
    $text = Get-Content -LiteralPath $template.FullName -Encoding UTF8 -Raw

    foreach ($section in $requiredTemplateSections) {
        Test-Contains -Text $text -Needle $section -Context $relative
    }

    Test-Contains -Text $text -Needle 'Known facts' -Context $relative
    Test-Contains -Text $text -Needle 'P0/P1/P2 data gaps' -Context $relative
    Test-Contains -Text $text -Needle 'Decisions for meeting' -Context $relative
    Test-Contains -Text $text -Needle 'Rules:' -Context $relative

    if ($text -notmatch '(?i)risk') {
        Add-Failure "$relative should include risk handling"
    }
}

$exampleDir = Join-Path $rootPath 'examples'
$examples = Get-ChildItem -LiteralPath $exampleDir -Filter '*.md' -File | Sort-Object Name

if ($examples.Count -lt 6) {
    Add-Failure "Expected at least 6 examples, found $($examples.Count)"
}

foreach ($example in $examples) {
    $relative = "examples/$($example.Name)"
    $text = Get-Content -LiteralPath $example.FullName -Encoding UTF8 -Raw

    if ($text -notmatch 'P0|P1|P2') {
        Add-Failure "$relative should include P0/P1/P2 data-gap handling"
    }
}

$requiredFiles = @(
    'examples/anonymized-end-to-end-stage-gate-review.md',
    'examples/anonymized-stage-handoff.json',
    'docs/codex-for-oss-application.md',
    'docs/delivery-qa.md',
    'docs/handoff-contract.md',
    'docs/three-round-workflow.md',
    'schemas/stage-handoff.schema.json',
    'scripts/handoff-check.ps1',
    'scripts/handoff-check.tests.ps1',
    'scripts/privacy-check.ps1',
    'scripts/content-check.ps1',
    '.github/workflows/handoff-check.yml',
    '.github/workflows/privacy-check.yml',
    '.github/workflows/content-check.yml'
)

foreach ($file in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $rootPath $file))) {
        Add-Failure "Missing required maintenance file: $file"
    }
}

$publicEntrypoints = @(
    'AGENT.md',
    'agent.yaml',
    'README.md',
    'SKILL_INDEX.md'
)

$confusingPhrases = @(
    'private/internal',
    'internal stage-gate source package',
    'Not bundled here'
)

foreach ($file in $publicEntrypoints) {
    $text = Read-RepoText $file
    if ($null -ne $text) {
        foreach ($phrase in $confusingPhrases) {
            if ($text.Contains($phrase)) {
                Add-Failure "$file contains confusing public wording: $phrase"
            }
        }
    }
}

$readme = Read-RepoText 'README.md'
Test-Contains -Text $readme -Needle 'Privacy Check' -Context 'README.md'
Test-Contains -Text $readme -Needle 'Content Quality Check' -Context 'README.md'
Test-Contains -Text $readme -Needle 'Handoff Contract Check' -Context 'README.md'
Test-Contains -Text $readme -Needle 'anonymized-end-to-end-stage-gate-review.md' -Context 'README.md'
Test-Contains -Text $readme -Needle 'anonymized-stage-handoff.json' -Context 'README.md'
Test-Contains -Text $readme -Needle 'codex-for-oss-application.md' -Context 'README.md'

$threeRoundWorkflow = Read-RepoText 'docs/three-round-workflow.md'
Test-Contains -Text $threeRoundWorkflow -Needle 'Round 1' -Context 'docs/three-round-workflow.md'
Test-Contains -Text $threeRoundWorkflow -Needle 'Round 2' -Context 'docs/three-round-workflow.md'
Test-Contains -Text $threeRoundWorkflow -Needle 'Round 3' -Context 'docs/three-round-workflow.md'
Test-Contains -Text $threeRoundWorkflow -Needle 'Cross-round invariants' -Context 'docs/three-round-workflow.md'

$handoffContract = Read-RepoText 'docs/handoff-contract.md'
Test-Contains -Text $handoffContract -Needle 'Evidence inventory' -Context 'docs/handoff-contract.md'
Test-Contains -Text $handoffContract -Needle 'Allowed and forbidden output' -Context 'docs/handoff-contract.md'
Test-Contains -Text $handoffContract -Needle 'P0 / P1 / P2' -Context 'docs/handoff-contract.md'

$deliveryQa = Read-RepoText 'docs/delivery-qa.md'
Test-Contains -Text $deliveryQa -Needle 'Evidence QA' -Context 'docs/delivery-qa.md'
Test-Contains -Text $deliveryQa -Needle 'Decision QA' -Context 'docs/delivery-qa.md'
Test-Contains -Text $deliveryQa -Needle 'Executive pressure test' -Context 'docs/delivery-qa.md'

$applicationNote = Read-RepoText 'docs/codex-for-oss-application.md'
Test-Contains -Text $applicationNote -Needle 'Project summary' -Context 'docs/codex-for-oss-application.md'
Test-Contains -Text $applicationNote -Needle 'How Codex helps maintain this project' -Context 'docs/codex-for-oss-application.md'
Test-Contains -Text $applicationNote -Needle 'Application draft' -Context 'docs/codex-for-oss-application.md'

if ($failures.Count -gt 0) {
    Write-Host 'Content check failed:'
    $failures | ForEach-Object { Write-Host "- $_" }
    exit 1
}

Write-Host 'Content check passed.'
