---
title: Send text-to-speech greeting
description: Send text-to-speech greeting
---

### Send text-to-speech greeting

Nexmo sends a webhook to the `/answer` endpoint of the application when the call is answered. The routing code sends this to the `answerAction()` method of the `Menu` object, which begins by adding an NCCO containing a greeting.

```javascript
// src/Menu.js

  answerAction()
    {
        this.append({
            'action' : 'talk',
            'text':'Thanks for calling our order status hotline.'
        });

        this.promptSearch();
    }
```

This is a great example of how to return a simple text-to-speech message.
