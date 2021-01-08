---
title:  更改事件计时
description: 如何更改每个验证事件的计时。
navigation_weight:  2

---


更改事件计时
======

您可以通过在初始请求中提供 `pin_expiry` 和/或 `next_event_wait` 自定义值来更改[默认计时](/verify/guides/verification-events#timing-of-each-event)：

* `pin_expiry`： 
  * 代码过期的时间
  * 必须为 60 到 3600 秒之间的整数
  * [工作流](/verify/guides/workflows-and-events)之间的默认到期时间有所不同，但通常为 300 秒

* `next_event_wait`： 
  * Nexmo 触发下一次验证尝试的时间
  * 每个[工作流](/verify/guides/workflows-and-events)的默认计时有所不同

如果您同时指定 `pin_expiry` 和 `next_event_wait` 的值，则 `pin_expiry` 的值必须是 `next_event_wait` 的整数倍。

示例
---

下表显示了一些示例值以及与默认工作流 (SMS -> TTS -> TTS) 一起使用时的效果：

| `pin_expiry` | `next_event_wait` |效果|
|-|-|-|
|360 秒|120 秒|所有三次尝试都使用相同的验证码|
|240 秒|120 秒|第一次和第二次尝试使用相同的代码，Verify API 会为第三次尝试生成新的代码|
|120 秒（或 90 秒或 200 秒）|120 秒|Verify API 为每次尝试生成一个新代码|

