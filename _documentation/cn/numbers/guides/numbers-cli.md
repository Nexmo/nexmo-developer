---
title:  使用 Nexmo CLI 管理号码
description: 使用 Nexmo CLI 租用、配置和管理 Number inventor
navigation_weight:  2

---


使用 Nexmo CLI 管理号码
=================

您可以使用 [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) 执行以下操作：

* [列出号码](#list-your-numbers)
* [搜索新号码](#search-for-new-numbers)
* [租用号码](#rent-a-number)
* [更新号码](#update-a-number)
* [取消号码](#cancel-a-number)

阅读[安装说明](https://github.com/Nexmo/nexmo-cli#installation)，以开始操作。

列出号码
----

`nexmo numbers:list` 命令列出了帐户拥有的所有号码。

可选标志：

|     标志      |                             描述                              |
|-------------|-------------------------------------------------------------|
| `--size`    | 要返回的结果数                                                     |
| `--page`    | 每页显示的结果数                                                    |
| `--pattern` | 您要搜索的模式。使用 `*` 通配符来匹配号码的开头或结尾。例如，`*123*`匹配包含模式 `123` 的所有号码。 |
````
> nexmo numbers:list
31555555555
44655555555
44555555555

> nexmo numbers:list --verbose
Item 1-3 of 3

msisdn      | country | type       | features  | voiceCallbackType | voiceCallbackValue | moHttpURL | voiceStatusCallbackUrl
----------------------------------------------------------------------------------------------------------------------------
31555555555 | NL      | mobile-lvn | VOICE,SMS | app               | b6d9f957           | undefined | https://example.com
44655555555 | GB      | mobile-lvn | VOICE,SMS | app               | b6d9f957           | undefined | https://example.com
44555555555 | GB      | mobile-lvn | SMS       | app               | b6d9f957           | undefined | https://example.com
````
搜索新号码
-----

使用 `nexmo number:search` 命令列出可购买的号码。

可选标志：

|     标志      |                             描述                              |
|-------------|-------------------------------------------------------------|
| `--pattern` | 您要搜索的模式。使用 `*` 通配符来匹配号码的开头或结尾。例如，`*123*`匹配包含模式 `123` 的所有号码。 |
| `--voice`   | 搜索支持语音的号码                                                   |
| `--sms`     | 搜索支持短信的号码                                                   |
| `--size`    | 要返回的结果数                                                     |
| `--page`    | 每页显示的结果数                                                    |
````
> nexmo number:search US
12057200555
12069396555
12069396555
12155961555

> nexmo number:search NL --sms --pattern *007 --verbose
msisdn      | country | cost | type       | features
-----------------------------------------------------
31655551007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
31655552007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
31655553007 | NL      | 3.00 | mobile-lvn | VOICE,SMS
````
租用号码
----

使用 `nexmo number:buy` 命令租用可用的号码。系统将提示您确认购买。

您必须指定 **以下其中一项** ：

* 您想租用的 `number`
* `country_code` 和 `pattern` 以自动选择任何匹配的可用号码

````
> nexmo number:buy 12069396555
Buying 12069396555\. This operation will charge your account.

Please type "confirm" to continue: confirm

Number purchased

> nexmo number:buy US *555
Buying 12069396555\. This operation will charge your account.

Please type "confirm" to continue: confirm

Number purchased: 12069396555

> nexmo number:buy 12069396555 --confirm
Number purchased: 12069396555
````

更新号码
----

使用 `nexmo number:update` 命令更新指定号码的语音属性。

> **注意** ：要更改应用程序 ID、链接的电话号码、SIP URI 或 Webhook，您可以改用 `nexmo link` 命令，如[此处所述](https://github.com/Nexmo/nexmo-cli#linking)。

````
> nexmo number:update 445555555555 --voice_callback_type app --voice_callback_value asdasdas-asdd-2344-2344-asdasdasd345
--voice_callback_status https://example.com/webhooks/status
Number updated
````

取消号码
----

使用 `nexmo number:cancel` 命令取消您帐户中的现有号码。您必须指定要取消的号码，在从帐户中删除该号码之前，系统会提示您确认取消。

````
> nexmo number:cancel 12069396555
This is operation can not be reversed.

Please type "confirm" to continue: confirm

Number cancelled: 12069396555

> nexmo number:cancel 12069396555 --confirm
Number cancelled: 12069396555
````
