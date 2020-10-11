---
title: Generate NCCOs
description: Generate NCCOs
---

## Generate NCCOs

A Nexmo Call Control Object (NCCO) is a JSON array that is used to control the flow of a Voice API call. Nexmo expects your answer webhook to return an NCCO to control the various stages of the call.

To manage NCCOs this example application uses array manipulation and a few simple methods.

The router handles encoding to JSON, the `Menu` object provides access to the NCCO stack with its `getStack()` method:

```javascript


// src/Menu.js

 getStack()
    {
        return this.ncco;
    }

```

There are also some helper methods to provide the foundation for managing the NCCO stack. You may find these useful in your own applications:

```javascript
// src/Menu.js

append(ncco)
    {
        this.ncco.push(ncco);
    }

    prepend(ncco)
    {
        this.ncco.unshift(ncco);
    }
```
