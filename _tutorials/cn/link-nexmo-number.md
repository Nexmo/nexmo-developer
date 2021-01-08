---
title:  链接 Vonage 号码
description:  在此步骤中，您将学习如何将 Vonage 号码链接到您应用程序。

---

链接 Vonage 号码
============

使用 Dashboard
------------

1. 在 [Dashboard](https://dashboard.nexmo.com/voice/your-applications) 中找到您的应用程序。
2. 点击"您的应用程序"列表中的应用程序。然后点击"号码"选项卡。
3. 点击"链接"按钮，将 Vonage 号码链接到该应用程序。

使用 Nexmo CLI
------------

获得适合的号码后，可以将其与您的 Vonage 应用程序链接。使用新生成的号码替换 `YOUR_NEXMO_NUMBER`，使用您的应用程序 ID 替换 `APPLICATION_ID` 并运行此命令：

    nexmo link:app YOUR_NEXMO_NUMBER APPLICATION_ID

