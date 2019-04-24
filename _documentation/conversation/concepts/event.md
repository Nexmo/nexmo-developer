---
title: Event
description: Conversations are event-driven. Event objects are generated when key activities occur.
navigation_weight: 9
---

# Event

Conversations and other Nexmo objects such as Members and Applications generate Events. When key activities occur an event is generated, which can be handled by the application. For example when a User joins a Conversation a `member:joined` event is fired. Other events include `app:knocking`, and `conversation:created`.
Nexmo Application with `rtc` among its capabilities, will receive the dispatched event on the `rtc` `event_url` webhook.

Event type | Description
----|----
`app:knocking:cancel` | 
`app:knocking` | 
`audio:dtmf` | DTMF tone is received into the Leg.
`audio:earmuff:off` | Leg is unearmuffed.
`audio:earmuff:on` | Leg is earmuffed.
`audio:mute:off` | Leg is unmuted.
`audio:mute:on` | Leg is muted.
`audio:play:stop` | Audio streamed into a Leg is stopped.
`audio:play:done` | Audio streamed into a Leg stops playing, that is the audio data finishes.
`audio:play` | Audio is streamed into a Leg.
`audio:record:stop` | 
`audio:record:done` | 
`audio:record` | Call is being recorded.
`audio:ringing:start` | 
`audio:say:stop` | 
`audio:say:done` | 
`audio:say` | 
`audio:speaking:on` | 
`audio:speaking:off` |  
`conversation:created` | new Conversation is created.
`conversation:deleted` | Conversation object is deleted.
`conversation:updated` | Conversation object is updated.
`member:invited` | Member is invited into a Conversation.
`member:joined` | Member joins a Conversation.
`member:left` | Member leaves a Conversation.
`member:media` | 
`event:delete` | Event object is deleted.
`image:delivered` | Image is delivered.
`image:seen` | Image is viewed by the recipient.
`image` | Image is uploaded.
`rtc:status` | 
`rtc:transfer` | 
`rtc:hangup` | 
`rtc:terminate` | 
`sip:status` | 
`sip:answered` | SIP call is answered.
`sip:machine` | When the entity answering the SIP call is a machine.
`sip:hangup` | User on a SIP Call hangs up.
`sip:ringing` | SIP call starts ringing, such as when Nexmo makes an Outbound Call.
`text:seen` | Text message is seen by the recipient.
`text:delivered` | Text message is delivered to the recipient.
`text` | new In App Text  message was created.
`text:update` | Text message was updated.
`text:typing:on` | Member is typing.
`text:typing:off` |  Member stops typing.
`video:mute:off` | Member video is unmuted.
`video:mute:on` | Member video is muted

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
