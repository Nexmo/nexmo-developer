---
title:  SMPP 访问
description: 使用 SMPP 而不是 REST 来访问短信 API。
navigation_weight:  7

---


SMPP 访问
=======

> 本概念文档介绍了使用 SMPP 而非 REST 来访问 Nexmo 的 API。实现 SMPP 访问需要对这种复杂的电信协议有深入的了解，并需要进行许多底层开发工作。大多数开发人员可以放心地忽略此信息。

默认情况下，您的帐户配置为通过 HTTPS 使用 Nexmo 的 REST API。除非您的组织是现有 SMPP 实施的信息聚合商，否则本指南中的信息可能与您无关。

目录
---

本文档涵盖以下内容：

* [什么是 SMPP？](#what-is-smpp)
* [我应该使用 SMPP 连接到 Nexmo 平台吗？](#should-i-use-smpp-to-connect-to-the-nexmo-platform)
* [Nexmo 为什么要提供 SMPP 访问？](#why-does-nexmo-offer-smpp-access)
* [正在配置 SMPP 访问](#configuring-smpp-access)
* [我们的 SMPP 实例](#our-smpp-instances)
* [资源](#resources)

什么是 SMPP？
---------

[短信点对点 (SMPP)](https://en.wikipedia.org/wiki/Short_Message_Peer-to-Peer) 是电信行业用于在短信服务中心 (SMSC) 和/或外部短信实体 (ESME) 之间交换短信的协议。

SMPP 是 [7 级 TCP/IP 协议](https://en.wikipedia.org/wiki/OSI_model#Layer_7:_Application_Layer)，可实现短信的快速传递。由于它支持非 GSM 短信协议（例如 [UMTS](https://en.wikipedia.org/wiki/UMTS) 和 [CDMA](https://en.wikipedia.org/wiki/Code-division_multiple_access)），因此被广泛用于 SS7 网络之外的短信交换。

Nexmo 使用 SMPP 连接全球多个运营商。由于 SMPP 是标准协议，因此我们希望参与其中的任何新运营商都能提供标准的连接方式。如果他们照做，我们就能相对轻松地将他们集成。

我应该使用 SMPP 连接到 Nexmo 平台吗？
-------------------------

Nexmo **不** 鼓励使用 SMPP 访问的原因如下：

* SMPP 是一项极其复杂的电信协议。您必须是域专家才能正确使用它。
* 与我们的 REST API 不同，实施需要大量的底层开发工作。
* Nexmo **不** 提供 SMPP 上的全局高可用性或灾难恢复。这是由于协议的设计所致，该协议要求您在交换消息之前先在客户端和服务器之间建立绑定。如果 Nexmo 的某个 SMPP 实例失败，则使用该实例的任何客户都必须： 
  * 已绑定到另一个实例并重新路由流量
  * 确定它们不再绑定到实例，并寻求与另一个实例绑定

Nexmo 为什么要提供 SMPP 访问？
---------------------

Nexmo 提供这项服务以集成新的运营商，并使现有 SMPP 实施的客户更容易使用我们的平台。

无需通过 REST API 重新实现消息传递，您只需修改现有的集成即可与 Nexmo 的 SMPP 集群建立绑定。

正在配置 SMPP 访问
------------

您可以使用以下方法之一配置对 Nexmo 平台的 SMPP 访问：

### 标准配置

1. 阅读 [SMPP 常见问题解答](https://help.nexmo.com/hc/en-us/sections/200621223)，其中包含有关字符编码、DLR 格式、级联消息、节流管理和其他重要信息的详情。
2. 将您的每月流量预测[发送电子邮件给我们](mailto:smpp@nexmo.com)。我们将配置系统以便为您启用 SMPP 访问，并向您发送一封确认电子邮件，其中包含指向其他资源的链接。

### 使用 Kannel

您可以使用 [Kannel](http://www.kannel.org) 版本 1\.4\.3 或更高版本来配置 SMPP 访问：

1. 完成[标准配置](#standard-configuration)步骤。

2. 下载 `kannel.conf` [配置文件](https://help.nexmo.com/hc/en-us/article_attachments/115016988548/kannel.conf)。

3. 编辑 `kannel.conf` 以用您的 Nexmo SMPP 凭据替换`$nexmo_user`和`$nexmo_password`。

4. 出于安全原因，`kannel.conf`仅允许从`localhost`进行访问。要启用来自其他设备的访问，请在 `kannel.conf` 中编辑以下参数。例如，对于 IP 地址 `X.X.X.X` 和 `Y.Y.Y.Y`：
````
   admin-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
   ...
   box-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
   ...
   user-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
````
5. 重新启动 Kannel。

6. 发送测试消息。示例：
````
   https://localhost:13013/cgi-bin/sendsms?username=username&password=pwd&to=%2B33XXXXXXX&text=Hello%20World&from=test&charset=ISO-8859-1&dlr-mask=17
````
我们的 SMPP 实例
-----------

Nexmo 托管三个 SMPP 实例：

* `SMPP1/2` - 集群
* `SMPP0` - 非集群

我们建议您同时绑定 `SMPP1` 和 `SMPP2`。仅当无法绑定到集群设置时才绑定到 `SMPP0`。

独立实例 `SMPP0` 适用于运行旧式基础架构的信息聚合商，这些聚合商无法同时绑定到多个 IP 地址。如果绑定到 `SMPP0`，则必须实现 SMPP 冗余，以避免计划内和计划外停机的更高风险。

资源
---

* [短信协议规范 3\.4 版本](http://docs.nimta.com/SMPP_v3_4_Issue1_2.pdf)
* [Nexmo 的 SMPP 常见问题解答](https://help.nexmo.com/hc/en-us/sections/200621223)
* [Nexmo 的 SMPP 服务器](https://help.nexmo.com/hc/en-us/articles/204015693)
* [SMPP 错误代码](https://help.nexmo.com/hc/en-us/articles/204015763-SMPP-Error-Codes)
* [通过 SMPP 发送级联消息](https://help.nexmo.com/hc/en-us/articles/204015653-Sending-Concatenated-Messages-via-SMPP)
* [SMPP DLR 格式和错误代码](https://help.nexmo.com/hc/en-us/articles/204015663)
* [对 SMPP DLR 进行故障排除](https://help.nexmo.com/hc/en-us/articles/204015803-Not-receiving-Delivery-Receipts-for-SMPP-what-should-I-do-)

