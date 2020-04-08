---
title: Webhook 参考
description: Nexmo 发送的有关语音通话的 Webhook 的详细信息。
api: "语音 API: Webhook"
---


语音 API Webhook 参考
=================

Nexmo 使用 Webhook 及其语音 API 来使您的应用程序能够与通话进行交互。Webhook 端点有两种：

* 应答呼叫时，发送[应答 Webhook](#answer-webhook)。这既适用于呼入电话，也适用于呼出电话。
* [事件 Webhook](#event-webhook) 发送给呼叫期间发生的所有事件。您的应用程序可以记录、响应或忽略每种事件类型。
* 如果发生[错误](#errors)，也会将其传递到事件 Webhook 端点。

有关更多一般信息，请查看我们的 [Webhook 指南](/concepts/guides/webhooks)。

应答 Webhook
----------

应答呼入电话后，将在设置应用程序时将 HTTP 请求发送到您指定的 `answer_url`。对于呼出电话，在拨打电话时指定 `answer_url`。

默认情况下，应答 Webhook 将是一个 `GET` 请求，但是可以通过设置 `answer_method` 字段将其覆盖为 `POST`。对于呼入电话，您在创建应用程序时配置这些值。对于呼出电话，您在拨打电话时指定这些值。

### 应答 Webhook 数据字段

字段 | 示例 | 说明
-- | -- | --
`to` | `442079460000` | 呼入电话号码（如果以编程方式启动呼叫，则可能是您的 Nexmo 号码）
`from` | `447700900000` | 致电号码（该号码可以是 Nexmo 号码或其他电话号码）
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符

#### 使用 SIP 标头传输其他数据

除了以上字段之外，您还可以指定使用 SIP 连接时所需的任何其他标头。提供的任何标头都必须以 `X-` 开头，并将以前缀 `SipHeader_` 发送到您的 `answer_url`。例如，如果您添加标头 `X-UserId` 且值为 `1938ND9`，则 Nexmo 会将 `SipHeader_X-UserId=1938ND9` 添加到对 `answer_url` 的请求中。
> 
> **警告：** 以 `X-Nexmo` 开头的标头将不会发送到您的 `answer_url`

### 应答 Webhook 数据字段示例

对于 `GET` 请求，变量将在 URL 中，如下所示：

```
/answer.php?to=442079460000&from=447700900000&conversation_uuid=CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab&uuid=aaaaaaaa-bbbb-cccc-dddd-0123456789ab&SipHeader_X-UserId=1938ND9
```

如果将 `answer_method` 设置为 `POST`，则您将在正文中收到带有 JSON 格式数据的请求：

```
{
  "from": "442079460000",
  "to": "447700900000",
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "conversation_uuid": "CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "SipHeader_X-UserId": "1938ND9"
}
```

### 响应应答 Webhook

Nexmo 希望您以 JSON 格式返回 [NCCO](/voice/voice-api/ncco-reference)，其中包含要执行的操作。

事件 Webhook
----------

当呼叫的状态发生任何更改时，HTTP 请求将到达事件 Webhook 端点。该 URL 将是您在创建应用程序时指定的 `event_url`，除非您在开始呼叫时通过设置特定的 `event_url` 来覆盖它。

默认情况下，传入请求是带有 JSON 正文的 `POST` 请求。除了 `event_url` 外，还可以通过配置 `event_method` 将方法覆盖到 `GET`。

包含的数据格式取决于发生了哪个事件：

* [`started`](#started)
* [`ringing`](#ringing)
* [`answered`](#answered)
* [`busy`](#busy)
* [`cancelled`](#cancelled)
* [`unanswered`](#unanswered)
* [`rejected`](#rejected)
* [`failed`](#failed)
* [`human/machine`](#human-machine)
* [`timeout`](#timeout)
* [`completed`](#completed)
* [`record`](#record)
* [`input`](#input)
* [`transfer`](#transfer)

### 已开始

表示呼叫已创建。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `started` | 呼叫状态
`direction` | `outbound` | 呼叫方向，可以是`inbound`或`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 正在振铃

目的地可达且正在振铃。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `ringing` | 呼叫状态
`direction` | `outbound` | 呼叫方向，可以是`inbound`或`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 已应答

呼叫已应答。

字段 | 示例 | 说明
-- | -- | --
`start_time` | - | *空*
`rate` | - | *空*
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `answered` | 呼叫状态
`direction` | `inbound` | 呼叫方向，可以是`inbound`或`outbound`
`network` | - | *空*
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 繁忙

目的地正与其他呼叫者连线。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `busy` | 呼叫状态
`direction` | `outbound` | 呼叫方向，在此上下文中为`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 已取消

呼出电话在应答前已由发起方取消。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `cancelled` | 呼叫状态
`direction` | `outbound` | 呼叫方向，在此上下文中为`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 未应答

接收方无法接通或接收方拒绝了呼叫。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `unanswered` | 呼叫状态
`direction` | `outbound` | 呼叫方向，在此上下文中为`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 已拒绝

呼叫在连接之前已被 Nexmo 拒绝。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `rejected` | 呼叫状态
`direction` | `outbound` | 呼叫方向，在此上下文中为`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 失败

呼出电话无法连接。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `failed` | 呼叫状态
`direction` | `outbound` | 呼叫方向，在此上下文中为`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 人工 / 机器

对于以编程方式进行的出站呼叫，如果设置了 `machine_detection` 选项，则将发送状态为`human`或`machine`的事件，具体取决于是否有人应答了该呼叫。

字段 | 示例 | 说明
-- | -- | --
`call_uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符（ **注** `call_uuid`，而不是某些其他端点中的 `uuid`）
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`status` | `human` | 呼叫状态，可以是`human`（如果是人工应答）或`machine`（如果呼叫是由语音信箱或其他自动服务应答）
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 超时

如果振铃阶段的持续时间超过指定的 `ringing_timeout` 持续时间，则将发送此事件。

字段 | 示例 | 说明
-- | -- | --
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `timeout` | 呼叫状态
`direction` | `outbound` | 呼叫方向，在此上下文中为`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 已完成

呼叫结束，此事件还包括有关呼叫的摘要数据。

字段 | 示例 | 说明
-- | -- | --
`end_time` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`network` | `GB-FIXED` | 呼叫中使用的网络类型
`duration` | `2` | 通话长度（单位：秒）
`start_time` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）
`rate` | `0.00450000` | 通话每分钟费用（欧元）
`price` | `0.00015000` | 通话总费用（欧元）
`from` | `442079460000` | 呼入电话号码
`to` | `447700900000` | 致电号码
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`status` | `completed` | 呼叫状态
`direction` | 入站 | 呼叫方向，可以是`inbound`或`outbound`
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 录音

当具有“录音”操作的 NCCO 完成时，此 Webhook 将到达。创建录音操作时，可以为此事件设置不同的 `eventUrl` 以进行发送。如果您要使用单独的代码来处理此事件类型，则此操作非常有用。

字段 | 示例 | 说明
-- | -- | --
`start_time` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）
`recording_url` | `https://api.nexmo.com/v1/files/bbbbbbbb-aaaa-cccc-dddd-0123456789ab` | 录音下载地址
`size` | 12222 | 录音文件大小（单位：字节）
`recording_uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此录音的唯一标识符
`end_time` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 输入

当具有“输入”操作的 NCCO 完成时，Nexmo 将发送此 Webhook。

字段 | 示例 | 说明
-- | -- | --
`dtmf` | `42` | 用户按下的按钮
`timed_out` | `true` | 输入操作是否超时：`true` 如果是，`false` 如果否
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

### 转移

当链路从一个对话转移到另一个对话时，Nexmo 将发送此 Webhook。此操作可使用 NCCO 或[`transfer`操作](/api/voice#updateCall)来完成

字段 | 示例 | 说明
-- | -- | --
`conversation_uuid_from` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 链路最初所在的对话 ID
`conversation_uuid_to` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 链路所转移到的对话 ID
`uuid` | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此呼叫的唯一标识符
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

[返回事件 Webhook 列表](#event-webhook)

错误
---

如果发生错误，事件端点也将收到 Webhook。这在调试应用程序时非常有用。

字段 | 示例 | 说明
-- | -- | --
`reason` | `Syntax error in NCCO. Invalid value type or action.` | 有关错误性质的信息
`conversation_uuid` | `CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | 此对话的唯一标识符
`timestamp` | `2020-01-01T12:00:00.000Z` | 时间戳（ISO 8601 格式）

