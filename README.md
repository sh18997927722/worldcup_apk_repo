# 2026 世界杯追踪器 · Android 端

基于 Capacitor + Web 技术栈的 Android APK。

## 项目结构

```
.
├── worldcup_app/          # Capacitor 项目
│   ├── www/               # Web 前端
│   ├── android/           # Android 原生项目
│   ├── capacitor.config.json
│   ├── package.json
│   └── package-lock.json
└── .github/workflows/
    └── build_capacitor_apk.yml
```

## 构建方式

1. 推送代码到 GitHub 主分支
2. 进入 Actions → `Build Android APK`
3. 等待 5-10 分钟
4. 在 Artifacts 下载 APK

## 本地开发

```bash
cd worldcup_app
npm install
npx cap sync android
npx cap open android
```

## 数据说明

- 比赛数据来自 ESPN 公开 API
- 启动时先显示本地缓存，后台自动拉取最新比分
- 每 3 分钟自动刷新一次
