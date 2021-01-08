---
title:  安装 Nexmo CLI 测试版
description:  安装 Nexmo CLI 测试版以获取最新功能

---

Nexmo CLI 允许您在命令行执行多项操作。示例包括创建应用程序、购买号码以及将号码链接到应用程序。

要使用 NPM 安装 CLI 的测试版，您可以使用：

```shell
npm install nexmo-cli@beta -g
```

设置 Nexmo CLI 以使用您的 Vonage API 密钥和 API 密码。您可以从 Dashboard 中的[设置页面](https://dashboard.nexmo.com/settings)获取。

在终端运行以下命令，同时将 `api_key` 和 `api_secret` 替换为您自己的值：

```bash
nexmo setup api_key api_secret
```

