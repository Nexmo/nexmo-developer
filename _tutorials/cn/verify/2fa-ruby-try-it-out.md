---
title:  试试看！
description:  测试应用程序的 2fa 功能

---

试试看！
====

运行您的应用程序：

```sh
rails server
```

访问 `http://localhost:3000`。如果您仍然处于登录状态，请注销。

验证码将通过短信发送给您：

![验证码已发送](/images/2fa-ruby-code-sent.png)

以下页面显示：

![输入验证码](/images/2fa-ruby-check-code.png)

输入您收到的验证码后即可登录：

![验证成功](/images/2fa-ruby-verification-success.png)

