---
title: Event
description: Conversations are event-driven. Event objects are generated when key activities occur.
---

# Event

Conversations and other Nexmo objects such as Members and Applications generate Events. When key activities occur an event is generated, which can be handled by the application. For example when a User joins a Conversation a `member:joined` event is fired. Other events include `member:left`, and `member:invited`.

Event type | Description
----|----
`app:knocking:cancel` | TBD
`app:knocking` | TBD
`audio:dtmf` | Fired when a DTMF tone is received into the Leg.
`audio:earmuff:off` | Fired when a Leg is unearmuffed.
`audio:earmuff:on` | Fired when a Leg is earmuffed.
`audio:mute:off` | Fired when a Leg is unmuted.
`audio:mute:on` | Fired when a Leg is muted.
`audio:play:stop` | Fired when audio streamed into a Leg is stopped.
`audio:play:done` | Fired when audio streamed into a Leg stops playing, that is the audio data finishes.
`audio:play` | Fired when audio is streamed into a Leg.
`audio:record:stop` | TBD
`audio:record:done` | TBD
`audio:record` | Fired when a Call is being recorded.
`audio:ringing:start` | TBD
`audio:say:stop` | TBD
`audio:say:done` | TBD
`audio:say` | TBD
`audio:speaking:on` | TBD
`audio:speaking:off` | TBD
`conversation:created` | Fired when a new Conversation is created.
`conversation:deleted` | Fired when a Conversation object is deleted.
`conversation:updated` | Fired when a Conversation object is updated.
`member:invited` | Fired when a Member is invited into a Conversation.
`member:joined` | Fired when a Member joins a Conversation.
`member:left` | Fired when a Member leaves a Conversation.
`member:media` | TBD
`event:delete` | Fired when an Event object is deleted.
`image:delivered` | Fired when an Image is delivered.
`image:seen` | Fired when an Image is viewed by the recipient.
`image` | TBD
`rtc:offer` | TBD
`rtc:status` | TBD
`rtc:transfer` | TBD
`rtc:hangup` | TBD
`rtc:answer` | TBD
`rtc:terminate` | TBD
`sip:status` | During a SIP call ...
`sip:answered` | Fired when a SIP call is answered.
`sip:machine` | Fired when the entity answering the SIP call is a machine.
`sip:hangup` | Fired when a User on a Call hangs up.
`sip:ringing` | Fired when a SIP call starts ringing, such as when Nexmo makes an Outbound Call.
`text:seen` | Fired when a Text message is seen by the recipient.
`text:delivered` | Fired when a Text message is delivered to the recipient.
`text` | TBD
`text:update` | TBD
`text:typing:on` | TBD
`text:typing:off` | TBD
`video:mute:off` | TBD
`video:mute:on` | TBD

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
