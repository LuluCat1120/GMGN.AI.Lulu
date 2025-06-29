# GMGN.AI Clone - Flutter Web 复刻项目

这是一个在24小时内使用AI辅助开发的 GMGN.AI 移动网页版复刻项目。项目旨在实现对原始应用UI/UX的像素级复制，并使用模拟（Mock）数据来驱动界面。

## 项目成果

- **GitHub Pages 部署链接**: [等待部署后填入]
- **GitHub 仓库**: [当前仓库链接]
- **UX 流程文档**: [UX_FLOW.md](./UX_FLOW.md)

## 核心功能截图

*TODO: 添加登录页面和仪表盘页面的截图*

---

## 技术栈与工具

- **前端框架**: Flutter 3.x
- **核心语言**: Dart
- **UI/UX 设计**: 基于对 GMGN.AI 移动网页版的视觉分析
- **AI 辅助开发**: 本项目的大部分代码由AI Cursor(各种模型) 根据需求文档和UI截图生成。

### AI 在开发中的作用

AI 在本项目中扮演了核心开发者的角色，主要负责：
1.  **UX分析与文档创建**: 分析需求，并生成了 `UX_FLOW.md` 文档，包含用户旅程图和页面线框图。
2.  **代码生成**: 基于UX文档和提供的UI截图，逐步生成了所有页面的Flutter Widget代码，包括布局、样式和基础交互。
3.  **项目重构**: 负责将Flutter默认项目重构为目标应用所需的多页面、带路由的结构。
4.  **模拟数据**: 创建并集成了所有界面所需的模拟数据。
5.  **文档编写**: 生成本文档的大部分内容。

---

## 如何运行项目

1.  **环境准备**:
    - 确保你已经安装了 [Flutter SDK](https://docs.flutter.dev/get-started/install)。
    - 确保你的开发环境中启用了 `web` 支持。如果没有，请运行: `flutter config --enable-web`

2.  **安装依赖**:
    ```bash
    flutter pub get
    ```

3.  **运行应用**:
    在项目根目录下，运行以下命令以在Chrome浏览器中启动应用：
    ```bash
    flutter run -d chrome
    ```

---

## 如何部署到 GitHub Pages

部署Flutter Web应用到GitHub Pages是一个简单直接的过程。

1.  **构建Web版本**:
    在项目根目录运行以下命令，这会在 `build/web` 目录下生成静态网站文件。
    ```bash
    flutter build web
    ```

2.  **配置GitHub仓库**:
    - 确保你的项目是一个GitHub仓库。
    - 进入你的仓库的 `Settings` -> `Pages`。
    - 在 `Build and deployment` 下，选择 `Deploy from a branch`。
    - 选择 `gh-pages` 分支和 `/ (root)` 目录，然后点击 `Save`。

3.  **推送构建产物到 `gh-pages` 分支**:
    - 你可以使用一个名为 `gh-pages` 的命令行工具来简化这个过程。
    - 首先，安装它：
      ```bash
      npm install -g gh-pages
      ```
    - 然后，在你的项目根目录运行以下命令，它会自动将 `build/web` 目录的内容推送到 `gh-pages` 分支：
      ```bash
      gh-pages -d build/web
      ```

4.  **访问你的网站**:
    - 等待几分钟，GitHub Actions完成部署后，你就可以在之前配置页面提供的URL上看到你的应用了。

---
此项目由AI在规定时间内完成，展示了AI在快速原型开发和前端编码中的强大能力。
