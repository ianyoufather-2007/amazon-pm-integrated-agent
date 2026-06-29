param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string[]]$PrivateMarkers = @()
)

$ErrorActionPreference = 'Stop'

$rootPath = (Resolve-Path $Root).Path
$scriptPath = (Resolve-Path $PSCommandPath).Path

function Get-RepoRelativePath {
    param(
        [string]$BasePath,
        [string]$TargetPath
    )

    $base = $BasePath
    if (-not $base.EndsWith([IO.Path]::DirectorySeparatorChar)) {
        $base += [IO.Path]::DirectorySeparatorChar
    }

    $baseUri = New-Object Uri($base)
    $targetUri = New-Object Uri($TargetPath)

    return [Uri]::UnescapeDataString($baseUri.MakeRelativeUri($targetUri).ToString()).Replace('/', [IO.Path]::DirectorySeparatorChar)
}

$skipDirs = @(
    '.git',
    'node_modules',
    '.venv',
    'venv',
    '__pycache__',
    '.pytest_cache',
    'dist',
    'build'
)

$binaryExtensions = @(
    '.png', '.jpg', '.jpeg', '.gif', '.webp', '.ico', '.pdf', '.zip',
    '.gz', '.7z', '.rar', '.xlsx', '.xls', '.pptx', '.docx'
)

$checks = @(
    @{ Name = 'Local Windows absolute path'; Pattern = '[A-Za-z]:\\(?:Users|vscode|Downloads|Documents)\\' },
    @{ Name = 'GitHub token-like secret'; Pattern = 'gh[pousr]_[A-Za-z0-9_]{20,}' },
    @{ Name = 'OpenAI token-like secret'; Pattern = 'sk-[A-Za-z0-9_-]{20,}' },
    @{ Name = 'AWS secret-like key'; Pattern = 'AKIA[0-9A-Z]{16}' },
    @{ Name = 'Raw cookie header'; Pattern = '(?i)\bcookie\s*:' },
    @{ Name = 'Session credential assignment'; Pattern = '(?i)\b(sessionid|auth_token|refresh_token)\s*[=:]' }
)

foreach ($marker in $PrivateMarkers) {
    $checks += @{ Name = "Private project marker: $marker"; Pattern = "(?i)\b$([regex]::Escape($marker))\b" }
}

$files = Get-ChildItem -Path $rootPath -Recurse -File -Force | Where-Object {
    $fullName = $_.FullName
    $relative = Get-RepoRelativePath -BasePath $rootPath -TargetPath $fullName
    $parts = $relative -split '[\\/]'

    if ($fullName -eq $scriptPath) { return $false }
    if ($parts | Where-Object { $skipDirs -contains $_ }) { return $false }
    if ($binaryExtensions -contains $_.Extension.ToLowerInvariant()) { return $false }

    return $true
}

$findings = New-Object System.Collections.Generic.List[string]

foreach ($file in $files) {
    $relative = Get-RepoRelativePath -BasePath $rootPath -TargetPath $file.FullName
    $lineNumber = 0

    foreach ($line in Get-Content -LiteralPath $file.FullName -Encoding UTF8) {
        $lineNumber += 1

        foreach ($check in $checks) {
            if ($line -match $check.Pattern) {
                $findings.Add(('{0}:{1}: {2}' -f $relative, $lineNumber, $check.Name))
            }
        }
    }
}

if ($findings.Count -gt 0) {
    Write-Host 'Privacy check failed. Review these possible leaks before publishing:'
    $findings | ForEach-Object { Write-Host "- $_" }
    exit 1
}

Write-Host 'Privacy check passed.'
