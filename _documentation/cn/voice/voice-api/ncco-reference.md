---
title: NCCO 参考
description: 用于管理您的语音 API 呼叫的 Nexmo 呼叫控制对象。
---

NCCO 参考
=======

Nexmo 呼叫控制对象 \(NCCO\) 是一个 JSON 数组，可用于控制语音 API 呼叫的流程。为了使 NCCO 能够正确执行，JSON 对象必须有效。

在开发和测试 NCCO 时，您可以使用语音 Playground 交互式地试用 NCCO。您可以[在语音 API 概述中详细阅读相关信息](/voice/voice-api/overview#voice-playground)，或[直接转到 Dashboard 中的语音 Playground](https://dashboard.nexmo.com/voice/playground)。

NCCO 操作
-------

以 NCCO 中的操作顺序控制呼叫的流程。在执行下一个操作之前必须完成的操作即为 *同步* 。其他操作即为 *异步* 。也就是说，它们应该在满足条件之前继续执行以下操作。例如，当满足`endOnSilence`选项时，`record`操作即会终止。当 NCCO 中的所有操作均完成时，呼叫结束。

NCCO 操作以及每个操作的选项和类型为：

操作 | 说明 | 同步
-- | -- | --
[录音](#record) | 全部或部分通话 | 否
[对话](#conversation) | 创建或加入现有的[对话](/conversation/concepts/conversation) | 是
[连接](#connect) | 到可连接的端点，例如电话号码或 VBC 分机。| 是
[通话](#talk) | 将合成语音发送到对话。| 是，除非 *bargeIn=true*
[流式](#stream) | 将音频文件发送到对话。| 是，除非 *bargeIn=true*
[输入](#input) | 收集来自被呼叫者的数字。| 是
[通知](#notify) | 向您的应用程序发送请求，以便通过 NCCO 跟踪进度 | 是
> 
> **注意** ：[连接呼入电话](/voice/voice-api/code-snippets/connect-an-inbound-call)提供了在启动呼叫或会议后如何为 Nexmo 提供 NCCO 服务的示例

录音
---

使用`record`操作对通话或部分通话进行录音：

```json
[
  {
    "action": "record",
    "eventUrl": ["https://example.com/recordings"]
  },
  {
    "action": "connect",
    "eventUrl": ["https://example.com/events"],
    "from":"447700900000",
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001"
      }
    ]
  }
]
```

录音操作为异步。当在 NCCO 中执行了录音动作时，录音即开始；当满足操作中的同步条件时，录音即结束。即，`endOnSilence`，`timeOut` 或 `endOnKey`。如果未设置同步条件，则语音 API 会立即执行下一个 NCCO，而不进行录音。

有关后续工作流程的信息，请参阅[录音](/voice/voice-api/guides/recording) 。

您可以使用以下选项来控制`record`操作：

选项 | 说明 | 必填
-- | -- | --
| `format` | 以特定的格式对通话进行录音。选项如下： </br> * `mp3` </br> * `wav` </br> * `ogg` </br >录制超过两个信道时，默认值为 `mp3` 或 `wav`。| 否 |
| `split` | 将发送和接收的音频分别录制在立体声录音的不同信道中—设置为`conversation`以启用此功能。| 否 |
| `channels` | 要录制的信道数量（最大值为 `32`）。如果参与者人数超过 `channels`，则任何其他参与者都将被添加到文件中的最后一个信道。同时必须启用拆分`conversation`。| 否 |
| `endOnSilence` | 静默 n 秒后停止录音。停止录音后，录音数据将发送到 `event_url`。可能的值范围是 3<=`endOnSilence`<=10。| 否 |
| `endOnKey` | 按下手机上的数字即停止录音。可能的值为：`*`，`#` 或任何一位数字，例如 `9` | 否 |
| `timeOut` | 录音最大长度（单位：秒）。录音停止后，录音数据将发送到 `event_url`。可能的值范围介于 `3` 秒和 `7200` 秒（2 小时） | 否 |
| `beepStart` | 设置为 `true` 即可在录音开始时发出提示音 | 否 |
| `eventUrl` | 录音完成时异步调用的 Webhook 端点的 URL。如果消息记录由 Nexmo 托管，则此 Webhook 包含[下载录音和其他元数据所需的 URL](#recording_return_parameters)。| 否 |
| `eventMethod` | 用于向 `eventUrl` 发出请求的 HTTP 方法。默认值为 `POST`。| 否 |

<a id="recording_return_parameters"></a>
以下示例显示了发送到 `eventUrl` 的返回参数：

```json
{
  "start_time": "2020-01-01T12:00:00Z",
  "recording_url": "https://api.nexmo.com/media/download?id=aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "size": 12345,
  "recording_uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "end_time": "2020-01-01T12:01:00Z",
  "conversation_uuid": "bbbbbbbb-cccc-dddd-eeee-0123456789ab",
  "timestamp": "2020-01-01T14:00:00.000Z"
}
```

可能的返回参数为：

名称 | 说明
-- | --
`recording_uuid` | 呼叫的唯一 ID。 </br> **注意：** `recording_uuid` 与 *recording\_url* 中的文件 UUID 不同。
`recording_url` | 包含通话录音的文件 URL 
`start_time`  | 录音开始的时间，格式如下：`YYYY-MM-DD HH:MM:SS`。示例：`2020-01-01 12:00:00`
`end_time`  | 录音完成的时间，格式如下：`YYYY-MM-DD HH:MM:SS`。示例：`2020-01-01 12:00:00`
`size` | 位于 *recording\_url* 的录音大小（单位：字节）。示例：`603423`
`conversation_uuid` | 此呼叫的唯一 ID。

对话
---

您可以使用`conversation`操作来创建标准会议或仲裁会议，同时保留通信上下文。使用具有相同`name`的`conversation`会重复使用相同的持久式[对话](/conversation/concepts/conversation)。呼叫分配给对话的虚拟号码的第一人将进行创建。此操作为同步。
> 
> **注意** ：您最多可以邀请 50 人加入您的对话。

以下 NCCO 示例展示了如何配置不同类型的连接。您可以使用 `answer_url` Webhook GET 请求参数来确保将一个 NCCO 传递给参与者，将另一个 NCCO 传递给仲裁人。

```tabbed_content
source: '/_examples/voice/guides/ncco-reference/conversation'
```

您可以使用以下选项来控制 *对话* 操作：

选项 | 说明 | 必填
-- | -- | --
| `name` | 对话室的名称。名称是按照应用程序级别来命名空间的。| 是 |
| `musicOnHoldUrl` | 指向 *mp3* 文件的 URL，用于在对话开始之前向参与者流式播放文件。默认情况下，当第一个人呼叫与您的语音应用关联的虚拟号码时，即对话开始。要在仲裁人加入对话之前流式播放此 mp3，请将仲裁人以外的所有用户的 *startOnEnter* 设置为 *false* 。| 否 |
| `startOnEnter` | 默认值 *true* 确保此呼叫者加入对话 `name` 时即对话开始。将仲裁对话中的参与者设置为 *false* 。| 否 |
| `endOnExit` | 指定仲裁人挂断时是否结束仲裁对话。默认情况下将其设置为 *false* ，这意味着不管仲裁人是否仍在通话中，仅当最后一名剩余的参与者挂断时，对话才结束。将 `endOnExit` 设置为 *true* 则可以在仲裁人挂断时终止对话。| 否 |
| `record` | 设置为 *true* 即可对此对话进行录音。对于标准的对话，当一名或多名参与者连接到对话时，录音即开始。对于仲裁对话，当仲裁人加入时，录音即开始。也就是说，当为已命名的对话执行 NCCO 时，将 *startOnEnter* 设置为 *true* 。录音终止时，您下载录音的 URL 将被发送到事件 URL。</br> 默认情况下，音频以 MP3 格式录制。参阅[录音](/voice/voice-api/guides/recording#file-formats)指南了解更多详细信息 | 否 |
`eventUrl` | 将 URL 设置为 Nexmo 在每种[呼叫状态](/voice/voice-api/guides/call-flow#call-states)上异步呼叫的 Webhook 端点。| 否 |
`eventMethod` | 设置用于向 `eventUrl` 发出请求的 HTTP 方法。默认值为 POST。| 否
| `canSpeak` | 可以听到此参与者的链路 UUID 列表。如果未提供，则所有人都能听到参与者的声音。如果提供空白列表，则任何人都不会听到参与者的声音。| 否 |
| `canHear` | 此参与者可以听到的链路 UUID 列表。如果未提供，则参与者可以听到所有人的声音。如果提供空白列表，则参与者将不会听到其他任何参与者的声音| 否 |

连接
---

您可以使用`connect`操作将呼叫连接到端点，例如电话号码或 VBC 分机。

此操作为同步，在 *连接* 之后，将处理 NCCO 堆栈中的下一个操作。当您呼叫的端点繁忙或不可用时，连接操作就会结束。您可以通过嵌套连接操作来依次呼叫端点。

以下 NCCO 示例展示了如何配置不同类型的连接。

```tabbed_content
source: '/_examples/voice/guides/ncco-reference/connect'
```

您可以使用以下选项来控制`connect`操作：

选项 | 描述 | 必填
-- | -- | --
| `endpoint` | 连接到单个端点。[可用端点类型](#endpoint-types-and-values) | 是 |
| `from` | 用于标识呼叫者的 [E.164](https://en.wikipedia.org/wiki/E.164) 格式号码。§§这必须是您的 Nexmo 虚拟号码之一，另一个值将导致呼叫者 ID 未知。如果呼叫者是应用用户，则应忽略此选项。|否 |
| `eventType` | 将`synchronous`设置为：</br> * 将`connect`操作设为同步 </br> * 启用 `eventUrl` 以返回当呼叫移至特定状态时覆盖当前 NCCO 的 NCCO。| 否 |
| `timeout` | 如未应答呼叫，请设置 Nexmo 停止振铃`endpoint`之前的秒数。默认值为 `60`。 | |
| `limit` | 通话的最大长度（单位：秒）。默认和最大值为 `7200` 秒（2 小时）。| 否 |
| `machineDetection` | 当 Nexmo 检测到目的地是电话答录机时配置行为。设置为以下任一种： </br> * `continue` - Nexmo 将带有呼叫事件的 HTTP 请求发送到 `event_url` `machine` </br> * `hangup` - 结束通话 | 否 |
| `eventUrl` | 设置 Nexmo 在每个可能的[呼叫状态](/voice/voice-api/guides/call-flow#call-states)上异步呼叫的 Webhook 端点。如果将`eventType`设置为`synchronous`，则 `eventUrl` 可以在发生超时时返回覆盖当前 NCCO 的 NCCO。| 否 |
| `eventMethod` | Nexmo 用于向 *eventUrl* 发出请求的 HTTP 方法。默认值为 `POST`。| 否 |
| `ringbackTone` | 指向`ringbackTone`的 URL 值将反复向呼叫者进行播放，因此他们不会听到静音。通话完全连接后，`ringbackTone`将自动停止播放。建议不要在连接到电话端点时使用此参数，因为运营商将提供自己的`ringbackTone`。示例：`"ringbackTone":"http://example.com/ringbackTone.wav" }`.| 否 |

### 端点类型和值

#### 电话 - E.164 格式的电话号码

值 | 说明
-- | --
`number` | 以 [E.164](https://en.wikipedia.org/wiki/E.164) 格式要连接到的电话号码。
`dtmfAnswer` | 设置在应答呼叫后立即发送给用户的数字。可使用 `*` 和 `#` 数字。您使用 `p` 创建暂停。每次暂停为 500 毫秒。
`onAnswer` | 包含必需的 `url` 密钥的 JSON 对象。URL 将为 NCCO 提供服务，以便在该呼叫加入您现有的对话之前在所连接的号码中执行。可以用指向`ringbackTone`的 URL 值来指定`ringbackTone`键，以便反复向呼叫者进行播放，因此他们不会只听到静音。通话完全连接后，`ringbackTone`将自动停止播放。示例：`{"url":"https://example.com/answer", "ringbackTone":"http://example.com/ringbackTone.wav" }`。请注意，仍然支持 `ringback` 键。

#### 应用 - 将呼叫连接到应用

值 | 说明
-- | --
`user` | 要连接到的用户的用户名。此用户名必须已被[添加为用户](/api/conversation#createUser)

#### Websocket - 要连接到的 Websocket

值 | 说明
-- | --
`uri` | 您要流式传输到的 Websocket 的 URI。
`content-type` | 您正在流式传输音频的互联网媒体类型。可能的值为：`audio/l16;rate=16000` 或 `audio/l16;rate=8000`。
`headers` | 包含所需元数据的 JSON 对象。请参阅[连接到 Websocket](/voice/voice-api/guides/websockets#connecting-to-a-websocket) 以获取标头示例

#### SIP - 要连接到的 SIP 端点

值 | 说明
-- | --
`uri` | 您要连接到端点的 SIP URI，格式为 `sip:rebekka@sip.example.com`。
`headers` | `key` => `value` 包含任何所需元数据的字符串对，例如： `{ "location": "New York City", "occupation": "developer" }`

#### VBC - 要连接到的 Vonage Business Cloud \(VBC\) 分机

值 | 说明
-- | --
`extension` | 要将呼叫连接到的 VBC 分机。

通话
---

`talk`操作将合成语音发送到对话。

通话操作中提供的文本可以是纯文本，也可以是使用 [SSML](/voice/voice-api/guides/customizing-tts) 的格式化文本。SSML 标签为文本到语音合成器提供了进一步的说明，使您能够设置音调、发音，并将多种语言的文本组合在一起。SSML 标签基于 XML，并以 JSON 字符串内联发送。

默认情况下，通话操作为同步。但是，如果将 *bargeIn* 设置为 *true* ，则必须稍后在 NCCO 堆栈中设置 *输入* 操作。
以下 NCCO 示例展示了如何将合成语音消息发送到对话或呼叫：

```tabbed_content
source: '/_examples/voice/guides/ncco-reference/talk'
```

您可以使用以下选项来控制 *通话* 操作：

| 选项 | 说明 | 必填 |
| -- | -- | -- |
| `text` | 一个包含最多 1,500 个字符（SSML 标签除外）的字符串，其中包含要在呼叫或对话中合成的消息。`text`中的单个逗号为合成语音添加了短暂的暂停。要添加更长的暂停，需要在 SSML 中使用 `break` 标签。要使用 [SSML](/voice/voice-api/guides/customizing-tts) 标签，必须将文本包含在`speak`元素中。| 是 |
| `bargeIn` | 设置为 `true` ，以便用户按下键盘上的按钮时终止此操作。使用此功能，用户无需收听您的[交互式语音应答 \(IVR\)](/voice/voice-api/guides/interactive-voice-response) 中的完整消息，即可选择选项。如果将 `bargeIn` 设置为 `true`，则 NCCO 堆栈中的下一个非通话操作 **必须** 为`input`操作。默认值为 `false`。 </br> 将 `bargeIn` 设置为 `true` 后，则将保持 `true`（即使在随后的操作中设置了 `bargeIn: false`），直至出现`input`操作为止 | 否 |
| `loop` | 呼叫结束前`text`的重复次数。默认值为 1。设置为 0 即可无限循环。| 否 |
| `level` | 语音播放的音量。该值可以是 `-1` 至 `1` 之间的任何值，其中 `0` 为默认值。| 否 |
| `voiceName` | 用于传递`text`的语音名称。您将使用具有正确语言、性别和口音的语音名称来发送消息。例如，默认语音 `kimberly` 是一位说英语且带有美国口音 \(en-US\) 的女性。[文本到语音指南](/voice/voice-api/guides/text-to-speech#voice-names)中列出了可能的值。| 否 |

流式
---

`stream`操作可让您将音频流发送到对话

默认情况下，流式操作为同步。但是，如果将 *bargeIn* 设置为 *true* ，则必须稍后在 NCCO 堆栈中设置 *输入* 操作。

以下 NCCO 示例展示了如何将音频流发送到对话或呼叫：

```tabbed_content
source: '/_examples/voice/guides/ncco-reference/stream'
```

您可以使用以下选项来控制 *流式* 操作：

选项 | 说明 | 必填
-- | -- | --
| `streamUrl` | 包含单个 URL 的数组，该 URL 指向 mp3 或 wav（16 位）音频文件以流式传输到呼叫或对话。| 是 |
| `level` |  将流媒体的音频级别范围设置为 -1 >=level<=1，精度为 0\.1。默认值为 *0* 。| 否 |
| `bargeIn` | 设置为 *true* ，以便用户按下键盘上的按钮时终止此操作。使用此功能，用户无需收听您的[交互式语音应答 \(IVR](/voice/guides/interactive-voice-response)\) 中的完整消息，即可选择选项。如果在一个或多个流式操作上将 `bargeIn` 设置为 `true`，则 NCCO 堆栈中的下一个非流式操作 **必须** 为`input`操作。默认值为 `false`。 </br> 将 `bargeIn` 设置为 `true` 后，则将保持 `true`（即使在随后的操作中设置了 `bargeIn: false`），直至出现`input`操作为止 | 否 |
| `loop` | 呼叫结束前`audio`的重复次数。默认值为 `1`。设置为 `0` 可无限循环。| 否 |

所指的音频流应为 MP3 或 WAV 格式的文件。如果您在播放文件时遇到问题，请按照以下技术规范进行编码：

MP3：

* MPEG Audio Layer 3，第 2 版
* 恒定比特率
* 比特率：16 Kbps（也支持 8、32、64）
* 采样率：16\.0 KHz
* 1 个信道
* 有损压缩
* 流媒体大小：10\.1 KiB \(91%\)
* 使用 LAME 3\.99\.5 编码

WAV：

* 8 或 16 位线性 PCM
* G.711 A-law/u-law
* Microsoft GSM

输入
---

您可以使用`input`操作来收集被呼叫者输入的数字。此操作为同步，Nexmo 处理输入并将其以发送到您在请求中配置的 `eventUrl` Webhook 端点的[参数](#input-return-parameters)转发。您的 Webhook 端点应返回另一个 NCCO 以替换现有的 NCCO，并根据用户输入控制呼叫。您可以使用此功能来创建交互式语音应答 \(IVR\)。例如，如果您的用户按 *4* ，则返回一个 [连接](#connect) NCCO，将呼叫转发给您的销售部门。

以下 NCCO 示例展示了如何配置 IVR 端点：

```json
[
  {
    "action": "talk",
    "text": "Please enter a digit"
  },
  {
    "action": "input",
    "eventUrl": ["https://example.com/ivr"]
  }
]
```

以下 NCCO 示例展示了如何使用 `bargeIn` 来允许用户中断`talk`操作。请注意，`input`操作 **必须** 在具有 `bargeIn` 属性的任何操作之后进行（例如，`talk`或`stream`）。

```json
[
  {
    "action": "talk",
    "text": "Please enter a digit",
    "bargeIn": true
  },
  {
    "action": "input",
    "eventUrl": ["https://example.com/ivr"]
  }
]
```

以下选项可用于控制`input`操作：

选项 | 说明 | 必填
-- | -- | --
`timeOut` | 被叫方活动的结果在上一个操作之后的 `timeOut` 秒发送到 `eventUrl` Webhook 端点。默认值为 *3* .最大值为 10。| 否
`maxDigits` | 用户可以按下的位数。最大值为 `20`，默认值为 `4` 位数。| 否
`submitOnHash` | 设置为 `true`，以便在被叫方按 *\#* 后将其活动发送到位于 `eventUrl` 的 Webhook 端点。如果未按 *＃* ，则结果将在 `timeOut` 秒后提交。默认值为 `false`。也就是说，结果在 `timeOut` 秒后发送到您的 Webhook 端点。| 否
`eventUrl` | 在`timeOut`暂停处于活动状态，或按 *\#* 后，Nexmo 会将被叫方按下的数字发送到此 URL。| 否
`eventMethod` | 用于将事件信息发送到 `event_url` 的 HTTP 方法。默认值为 POST。|否

以下示例显示了发送到 `eventUrl` 的参数：

```json
{
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "conversation_uuid": "bbbbbbbb-cccc-dddd-eeee-0123456789ab",
  "timed_out": true,
  "dtmf": "1234",
  "timestamp": "2020-01-01T14:00:00.000Z"
}
```

#### 输入返回参数

返回到 `eventUrl` 的输入参数为：

名称 | 说明
-- | --
`uuid` | 用户发起输入的呼叫链路的唯一 ID。
`conversation_uuid` | 此对话的唯一 ID。
`timed_out` | 如果此输入基于`timeOut`的值超时，则返回 `true`。
`dtmf` | 被叫方按顺序输入的号码。

通知
---

使用`notify`操作将自定义有效负载发送到事件 URL

```json
[
  {
    "action": "notify",
    "payload": {
      "foo": "bar"
    },
    "eventUrl": [
      "https://example.com/webhooks/event"
    ],
    "eventMethod": "POST"
  }
]
```

选项 | 说明 | 必填
-- | -- | --
`payload` | 发送到您的事件 URL 的 JSON 正文 | 是
`eventUrl` | 要将事件发送到的 URL。如果在收到通知时返回一个 NCCO，它将替换当前的 NCCO | 是
`eventMethod` | 向您的 `eventUrl` 发送`payload`时使用的 HTTP方法 | 否

