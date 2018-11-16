---
title: Event
description: Conversations are event-driven. Event objects are generated when key activities occur.
navigation_weight: 4
---

# Event

Conversations and other Nexmo objects such as Members and Applications generate Events. When key activities occur an event is generated, which can be handled by the application. For example when a User joins a Conversation a `member:joined` event is fired. Other events include `app:knocking`, and `conversation:created`.

Event type | Posted to Event webhook | Description
----|----|----
`app:knocking:cancel` | No |
`app:knocking` | No |
`audio:dtmf` | Yes | DTMF tone is received into the Leg.
`audio:earmuff:off` | Yes | Leg is unearmuffed.
`audio:earmuff:on` | Yes | Leg is earmuffed.
`audio:mute:off` | Yes | Leg is unmuted.
`audio:mute:on` | Yes | Leg is muted.
`audio:play:stop` | Yes | Audio streamed into a Leg is stopped.
`audio:play:done` | Yes | Audio streamed into a Leg stops playing, that is the audio data finishes.
`audio:play` | Yes | Audio is streamed into a Leg.
`audio:record:stop` | Yes |
`audio:record:done` | Yes |
`audio:record` | Yes | Call is being recorded.
`audio:ringing:start` | Yes |
`audio:say:stop` | Yes |
`audio:say:done` | Yes |
`audio:say` | Yes |
`audio:speaking:on` | No |
`audio:speaking:off` | No |
`conversation:created` | No | new Conversation is created.
`conversation:deleted` | No | Conversation object is deleted.
`conversation:updated` | No | Conversation object is updated.
`member:invited` | No | Member is invited into a Conversation.
`member:joined` | No | Member joins a Conversation.
`member:left` | No | Member leaves a Conversation.
`member:media` | No |
`event:delete` | Yes | Event object is deleted.
`image:delivered` | Yes | Image is delivered.
`image:seen` | Yes | Image is viewed by the recipient.
`image` | Yes |
`rtc:offer` | No |
`rtc:status` | No |
`rtc:transfer` | No |
`rtc:hangup` | No |
`rtc:answer` | No |
`rtc:terminate` | No |
`sip:status` | No |
`sip:answered` | No | SIP call is answered.
`sip:machine` | No | When the entity answering the SIP call is a machine.
`sip:hangup` | No | User on a Call hangs up.
`sip:ringing` | No | SIP call starts ringing, such as when Nexmo makes an Outbound Call.
`text:seen` | Yes | Text message is seen by the recipient.
`text:delivered` | Yes | Text message is delivered to the recipient.
`text` | Yes |
`text:update` | No |
`text:typing:on` | Yes |
`text:typing:off` | Yes |
`video:mute:off` | Yes |
`video:mute:on` | Yes |

## Handling Events

The following code snippet shows that code can be executed based on the event fired:

``` javascript
...
    events.forEach((value, key) => {
        if (conversation.members[value.from]) {
            const date = new Date(Date.parse(value.timestamp))
            switch (value.type) {
                case 'text:seen':
                    ...
                    break;
                case 'text:delivered':
                    ...
                    break;
                case 'text':
                    ...
                    break;
                case 'member:joined':
                    ...
                    break;
                case 'member:left':
                    ...
                    break;
                case 'member:invited':
                    ...
                    break;
                case 'member:media':
                    ...
                    break;
                default:
                ...
            }
        }
    })
...
```
