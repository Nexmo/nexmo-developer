---
title: Selective Audio Controls
menu_weight: 2
---

```javascript
// As the customer is the first person to join, there is no canHear/canSpeak entry
// The customer's leg ID is 6a4d6af0-55a6-4667-be90-8614e4c8e83c
[
  {
    "action": "conversation",
    "name": "selective-audio-demo",
    "startOnEnter": false,
    "musicOnHoldUrl": ["https://nexmo-community.github.io/ncco-examples/assets/voice_api_audio_streaming.mp3"],
  }
]

// The agent joins and can both hear, and speak to the customer
// The agent's leg ID is 533c0874-f43d-446c-a153-f35bf30783fa
[
  {
    "action": "conversation",
    "name": "selective-audio-demo",
    "startOnEnter": true,
    "record": true,
    "canHear": ["6a4d6af0-55a6-4667-be90-8614e4c8e83c"], // Customer leg ID
    "canSpeak": ["6a4d6af0-55a6-4667-be90-8614e4c8e83c"] // Customer leg ID
  }
]

// Finally, the supervisor joins the conversation. They can hear both the customer
// and the agent, but only speak to the agent
// The supervisor's leg ID is e2833e43-db39-4c1a-b689-d17ad2cf3529
[
  {
    "action": "conversation",
    "name": "selective-audio-demo",
    "startOnEnter": true,
    "record": true,
    "canHear": ["6a4d6af0-55a6-4667-be90-8614e4c8e83c", "533c0874-f43d-446c-a153-f35bf30783fa"] // Customer leg ID, Agent leg ID
    "canSpeak": ["533c0874-f43d-446c-a153-f35bf30783fa"] // Agent leg ID
  }
]
```
