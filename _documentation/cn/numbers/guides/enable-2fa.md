---
title:  使用短代码启用 2FA
description: 使用短代码以验证您的用户是否拥有注册您服务所需的电话号码
navigation_weight:  2

---


启用双重认证
======

[双重认证](/concepts/guides/glossary#2fa) (2FA) 可让您确信客户提供给您的号码属于他们。要向美国客户发送短信，则可使用[短代码](/concepts/guides/glossary#short-code)。客户通过直接响应短代码或通过您的 Web 应用程序来验证其号码。Nexmo 的[双重认证 API](/api/sms/us-short-codes/2fa) 具有此功能。

> 这些说明假定您使用的是共享短代码。Nexmo 还为您组织提供特定的专用短代码。[在此处](https://help.nexmo.com/hc/en-us/articles/115013144287-Short-codes-Features-Overview)了解有关短代码的更多信息。

要为 2FA 配置共享的美国短代码：

1. 登录到[开发人员 Dashboard](https://dashboard.nexmo.com)。
2. 在左侧导航菜单中，依次点击 **号码** 和 **购买号码** 。
3. 点击 **添加共享短代码** 链接。
4. 点击 **为双重认证添加短代码** 按钮。
5. 配置您的消息和公司名称。
6. 点击 **更新** 。Nexmo 将处理您的申请。审批最多需要五个工作日。

短代码的强制性要求
---------

当您使用 Nexmo 的预批准美国短代码时，您 **必须** 在网站的选择加入页面上显示以下信息：

* 频率：您的服务用户多久收到一次来自您的消息
* 如何退出：向您的短代码发送一条 `STOP` 短信。
* 如何获得帮助：向您的短代码发送一条 `HELP` 短信。
* 用户接收消息的成本（消息和数据速率）
* 您的服务条款和条件
* 您的隐私政策

示例：
````
You will receive no more than 2 msgs/day. To opt-out at any time, send STOP to 98765.
To receive more information, send HELP to 98765. Message and data rates may apply.
The terms and conditions can be viewed at <http://url.to/your_t&c.html>. 
Our Privacy Policy can be reviewed at <http://url.to/your_privacypolicy.html>.
````
