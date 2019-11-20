---
title: What is a Dispatch workflow?
navigation_weight: 0
description: Dispatch workflows help you to build a robust messaging plan that incorporates failover to a secondary channel.
---

# What is a Dispatch workflow?

A Dispatch workflow is a facility whereby you can create a message sending plan using a template. The currently supported template is the failover template. This template allows you attempt to send a message via one channel, and if *success conditions* are not met with the specified time limit then fall back to sending the message via another channel.

In the following example the success condition is the message is read within 600 seconds.

``` json
   "failover":{
      "expiry_time": 600,
      "condition_status": "read"
    }
```

Failover can also happen immediately if the message sending fails.
