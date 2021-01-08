---
title:  验证 Velocity Rules
description: 验证反欺诈系统
navigation_weight:  4

---


验证 Velocity Rules
=================

Verify API 提供一种快速简单的方法来为应用程序实施 2FA 并避免可疑注册。

但是，Vonage 还需要防止在其平台上出现欺诈活动。一种实现方法是使用称为 Velocity Rules 的反欺诈系统。

工作原理
----

Velocity Rules 根据运营商网络的客户帐户体量和转化率阻止可疑流量。体量是指请求数，转换率是指成功验证的百分比。

> **注意** ：如果后续调用[验证检查端点](/verify/code-snippets/check-verify-request)，则平台只能确定验证请求是否成功。对于每个验证请求，您的代码应执行验证检查。

如果我们发现客户的网络转化率低于 35％ 并在给定时间段内设置最低流量，则我们的平台将为该特定网络阻止任何其他流量。任何后续验证请求都将返回代码 7： `This number is blacklisted for verification.`

监控转化
----

您应该监视转化率，以确保您在 Velocity Rules 设定的范围内。

通过将成功验证尝试的次数与总尝试次数进行比较，计算转化率并以百分比表示：

`Conversion rate = (# successful verifications / # total verifications) * 100`

> 可在验证 > 分析导航菜单的选项[开发人员 Dashboard](https://dashboard.nexmo.com/verify/analytics) 中找到此信息。

您还可以根据在[验证检查](/api/verify#verifyCheck)过程中从平台收到的响应来跟踪转化率。

解除阻止网络
------

如果您的验证尝试一直返回错误代码 7：`This number is blacklisted for verification.`，则该网络可能已被 Velocity Rules 阻止。您可通过[联系支持部门](mailto://support@nexmo.com)恢复服务，但我们建议您先执行以下操作：

* 检查发送到此网络（或国家/地区）的最新阻止验证尝试
* 确认它们是合法的验证尝试

完成此操作后，如果您对流量的真实性感到满意并希望恢复此网络的服务，请[联系支持部门](mailto://support@nexmo.com)寻求帮助。

更多信息
----

* [验证面向高风险国家/地区的服务](https://help.nexmo.com/hc/en-us/articles/360018406532)

