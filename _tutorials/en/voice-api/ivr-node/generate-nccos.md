---
title: Generate NCCOs
description: Generate NCCOs
---

## Generate NCCOs

A Nexmo Call Control Object (NCCO) is a JSON array that is used to control the flow of a Voice API call. Nexmo expects your answer webhook to return an NCCO to control the various stages of the call.

To manage NCCOs this example application uses array of objects.

The router handles encoding to JSON, the `Menu` object provides access to the NCCO stack with its `getStack()` method:

```javascript


// index.js

public function getStack()
{
    return $this->ncco;
}
```


