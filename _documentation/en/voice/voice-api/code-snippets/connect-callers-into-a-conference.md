---
title: Connect callers into a conference
navigation_weight: 6
---

# Connect callers to a conference

This code snippet shows how to join multiple calls into a conversation.

Multiple inbound calls can be joined into a conversation (conference
call) by simply connecting the call into the same named
conference.

Conference names are scoped at the Nexmo Application
level. For example, NexmoApp1 and NexmoApp2 could both have a
conference called `nexmo-conference` and there would be no problem.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`CONF_NAME` | The named identifier for your conference

```code_snippets
source: '_examples/voice/connect-callers-to-a-conference'
application:
  type: voice
  name: 'Conference Call Example'
```

## Try it out

Start your server and make multiple inbound calls to the Nexmo Number
assigned to this Nexmo Application. The inbound calls will be connected
into the same conversation (conference).
