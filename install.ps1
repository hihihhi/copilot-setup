# copilot-setup installer — PowerShell (Windows, air-gapped)
# Zero dependencies. Usage: .\install.ps1 [-Target C:\path\to\repo]
param([string]$Target = (Get-Location).Path)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "`n╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     copilot-setup  —  zero-dep installer   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝`n" -ForegroundColor Cyan
Write-Host "Installing into: $Target`n"

# copilot-instructions.md
$githubDir = Join-Path $Target ".github"
New-Item -ItemType Directory -Force -Path $githubDir | Out-Null
$dest = Join-Path $githubDir "copilot-instructions.md"
if (Test-Path $dest) {
    Copy-Item $dest "$dest.bak" -Force
    Write-Host "[INFO]  Backed up existing copilot-instructions.md" -ForegroundColor Cyan
}
Copy-Item (Join-Path $ScriptDir ".github\copilot-instructions.md") $dest -Force
Write-Host "[OK]    copilot-instructions.md installed" -ForegroundColor Green

# Path-scoped instructions
$instrDest = Join-Path $githubDir "instructions"
New-Item -ItemType Directory -Force -Path $instrDest | Out-Null
$count = 0
Get-ChildItem (Join-Path $ScriptDir ".github\instructions") -File | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $instrDest $_.Name) -Force
    $count++
}
Write-Host "[OK]    Installed $count path-scoped instruction file(s)" -ForegroundColor Green

# Prompt library
$promptDest = Join-Path $githubDir "prompts"
New-Item -ItemType Directory -Force -Path $promptDest | Out-Null
$count = 0
Get-ChildItem (Join-Path $ScriptDir ".github\prompts") -File | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $promptDest $_.Name) -Force
    $count++
}
Write-Host "[OK]    Installed $count prompt file(s)" -ForegroundColor Green

# VS Code settings
$vscodeDir = Join-Path $Target ".vscode"
New-Item -ItemType Directory -Force -Path $vscodeDir | Out-Null
$settingsDest = Join-Path $vscodeDir "settings.json"
if (Test-Path $settingsDest) {
    Write-Host "[INFO]  .vscode/settings.json already exists — skipping (merge manually)" -ForegroundColor Cyan
} else {
    Copy-Item (Join-Path $ScriptDir ".vscode\settings.json") $settingsDest -Force
    Write-Host "[OK]    .vscode/settings.json installed" -ForegroundColor Green
}

Write-Host "`n╔════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║         Installation complete!             ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝`n" -ForegroundColor Green
Write-Host "Commit these files into your repository to share with your team."
Write-Host "`nAvailable prompts (type /name in Copilot Chat):"
Get-ChildItem (Join-Path $promptDest "*.prompt.md") | ForEach-Object {
    $name = $_.BaseName -replace "\.prompt$", ""
    Write-Host ("  {0,-20} →  /{1}" -f $name, $name)
}
