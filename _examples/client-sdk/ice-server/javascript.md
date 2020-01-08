---
title: JavaScript
menu_weight: 1
---

```javascript
// configure STUN server
const config = {
  iceServers: [
    {
      urls: ['stun:stun.l.google.com:19302', ...]
    }
  ]
}
const nexmoClient = new NexmoClient(config);

// Configure TURN server
const config = {
  iceServers: [
    {
      urls: ['turn:turn.l.google.com:19302', ...],
      username: 'username',
      credential: 'password'
    }
  ]
}
const nexmoClient = new NexmoClient(config);
```
