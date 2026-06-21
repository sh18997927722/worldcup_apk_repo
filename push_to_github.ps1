#!/usr/bin/env pwsh
# 推送到 sh18997927722/aksapple 仓库
# 用法：先设置环境变量 $env:GITHUB_TOKEN = "ghp_..." 再运行本脚本

$ErrorActionPreference = "Stop"
$repoPath = "C:\Users\舒华\.qclaw\workspace-agent-e9a3a0e6\worldcup_apk_repo"
$token = $env:GITHUB_TOKEN
$owner = "sh18997927722"
$repo = "aksapple"

if (-not $token) {
    Write-Host "❌ 请先设置 GitHub Token：`n`$env:GITHUB_TOKEN = 'ghp_...'" -ForegroundColor Red
    exit 1
}

Set-Location $repoPath

# 确认仓库为空/已存在：强制推送到 aksapple
$remoteUrl = "https://$token@github.com/$owner/$repo.git"

# 如果已经存在 remote，先移除重设
$existing = git remote -v 2>$null | Select-String "origin" | Select-Object -First 1
if ($existing) {
    git remote remove origin
}

git remote add origin $remoteUrl

# 本地分支名统一为 main，匹配 GitHub 新仓库默认分支
$currentBranch = git branch --show-current 2>$null
if ($currentBranch -ne "main") {
    git branch -M main
}

# 强制推送（用 worldcup_apk_repo 完全覆盖仓库内容）
Write-Host "推送到 https://github.com/$owner/$repo ..." -ForegroundColor Cyan
git push -u origin main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 推送成功！去 https://github.com/$owner/$repo/actions 点 'Build Android APK' 触发构建。" -ForegroundColor Green
} else {
    Write-Host "❌ 推送失败，请检查 token 权限或仓库名称。" -ForegroundColor Red
}
