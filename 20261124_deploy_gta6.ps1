# 20261124_deploy_gta6.ps1
# make.fun GTA 6 Bounty Deployer (Artisan Edition)

$ErrorActionPreference = "Stop"

# 1. Load Environment Variables
$envPath = Join-Path $PSScriptRoot ".env"
if (-not (Test-Path $envPath)) {
    Write-Host "🔴 Error: .env file not found! Please create it and add GITHUB_TOKEN and GITHUB_USERNAME." -ForegroundColor Red
    exit 1
}

$envVars = Get-Content $envPath | ConvertFrom-StringData
$GITHUB_TOKEN = $envVars.GITHUB_TOKEN
$GITHUB_USER = $envVars.GITHUB_USERNAME
$REPO_NAME = "makefun-gta6-artisan-20261124"

if (-not $GITHUB_TOKEN -or $GITHUB_TOKEN -eq "REPLACE_WITH_YOUR_TOKEN") {
    Write-Host "🔴 Error: Please fill in your GITHUB_TOKEN in the .env file!" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Deploying GTA 6 Project: $REPO_NAME..." -ForegroundColor Cyan

# 2. Create Repository
$headers = @{
    "Authorization" = "token $GITHUB_TOKEN"
    "Accept"        = "application/vnd.github.v3+json"
}
$body = @{
    name = $REPO_NAME
    description = "Orange GTA 6: Open-world crime game prototype for make.fun bounty."
    private = $false
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body
    Write-Host "✅ Repository created: $($response.html_url)" -ForegroundColor Green
} catch {
    Write-Host "ℹ️ Repository may already exist." -ForegroundColor Yellow
}

# 3. Git Push
git init
git config user.email "artisan@orange.studio"
git config user.name "Artisan Assistant"
git add .
git commit -m "Initial commit: GTA 6 Bounty 2026-11-24"

$remoteUrl = "https://$GITHUB_USER`:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
if (git remote | Select-String "origin") {
    git remote remove origin
}
git remote add origin $remoteUrl
git branch -M main
git push -u origin main --force

Write-Host "`n🏆 GTA 6 Deployment Successful!" -ForegroundColor Green
Write-Host "🔗 Submit here: https://make.fun/bounty/gta6-01" -ForegroundColor Cyan
Write-Host "🔗 Your Repo: https://github.com/$GITHUB_USER/$REPO_NAME" -ForegroundColor Cyan
