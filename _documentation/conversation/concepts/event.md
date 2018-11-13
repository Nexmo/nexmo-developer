---
title: Event
description: Conversations are event-driven. Event objects are generated when key activities occur.
navigation_weight: 4
---

# Event

Conversations and other Nexmo objects such as Members and Applications generate Events. When key activities occur an event is generated, which can be handled by the application. For example when a User joins a Conversation a `member:joined` event is fired. Other events include `app:knocking`, and `conversation:created`.

Event type | Posted to Event webhook | Description
----|----|----
`app:knocking:cancel` | No | TBD
`app:knocking` | No | TBD
`audio:dtmf` | Yes | Fired when a DTMF tone is received into the Leg.
`audio:earmuff:off` | Yes | Fired when a Leg is unearmuffed.
`audio:earmuff:on` | Yes | Fired when a Leg is earmuffed.
`audio:mute:off` | Yes | Fired when a Leg is unmuted.
`audio:mute:on` | Yes | Fired when a Leg is muted.
`audio:play:stop` | Yes | Fired when audio streamed into a Leg is stopped.
`audio:play:done` | Yes | Fired when audio streamed into a Leg stops playing, that is the audio data finishes.
`audio:play` | Yes | Fired when audio is streamed into a Leg.
`audio:record:stop` | Yes | TBD
`audio:record:done` | Yes | TBD
`audio:record` | Yes | Fired when a Call is being recorded.
`audio:ringing:start` | Yes | TBD
`audio:say:stop` | Yes | TBD
`audio:say:done` | Yes | TBD
`audio:say` | Yes | TBD
`audio:speaking:on` | No | TBD
`audio:speaking:off` | No | TBD
`conversation:created` | No | Fired when a new Conversation is created.
`conversation:deleted` | No | Fired when a Conversation object is deleted.
`conversation:updated` | No | Fired when a Conversation object is updated.
`member:invited` | No | Fired when a Member is invited into a Conversation.
`member:joined` | No | Fired when a Member joins a Conversation.
`member:left` | No | Fired when a Member leaves a Conversation.
`member:media` | No | TBD
`event:delete` | Yes | Fired when an Event object is deleted.
`image:delivered` | Yes | Fired when an Image is delivered.
`image:seen` | Yes | Fired when an Image is viewed by the recipient.
`image` | Yes | TBD
`rtc:offer` | No | TBD
`rtc:status` | No | TBD
`rtc:transfer` | No | TBD
`rtc:hangup` | No | TBD
`rtc:answer` | No | TBD
`rtc:terminate` | No | TBD
`sip:status` | No | During a SIP call ...
`sip:answered` | No | Fired when a SIP call is answered.
`sip:machine` | No | Fired when the entity answering the SIP call is a machine.
`sip:hangup` | No | Fired when a User on a Call hangs up.
`sip:ringing` | No | Fired when a SIP call starts ringing, such as when Nexmo makes an Outbound Call.
`text:seen` | Yes | Fired when a Text message is seen by the recipient.
`text:delivered` | Yes | Fired when a Text message is delivered to the recipient.
`text` | Yes | TBD
`text:update` | No | TBD
`text:typing:on` | Yes | TBD
`text:typing:off` | Yes | TBD
`video:mute:off` | Yes | TBD
`video:mute:on` | Yes | TBD

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
