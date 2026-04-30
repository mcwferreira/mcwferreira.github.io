# Deploy this repo to GitHub (GitHub Pages picks up pushes to the default branch).
# Requires git write access to origin (SSH key or `gh auth setup-git` / credential manager).

param(
  [Parameter(Mandatory = $false)]
  [string]$Message = "Deploy site"
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$branch = git rev-parse --abbrev-ref HEAD
if ($LASTEXITCODE -ne 0) { throw "Not a git repository." }

git add -A
$status = git status --porcelain
if (-not $status) {
  Write-Host "Nothing to commit; working tree clean."
} else {
  git commit -m $Message
}

git push origin $branch
Write-Host "Pushed branch: $branch"
