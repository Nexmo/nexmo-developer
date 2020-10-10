---
title: Request user input via IVR
description: Request user input via IVR
---

### Request user input via IVR (Interactive Voice Response)

For our example application, the user needs to supply their order ID. For this part, first add another "talk" NCCO to the prompt (if the greeting was included, you'd greet the user every time we asked them for their order number). The next NCCO is where the user's input is received:

```php
<?php

// src/Menu.php

protected function promptSearch()
{
    $this->append([
        'action' => 'talk',
        'text' => 'Using the numbers on your phone, enter your order number followed by the pound sign'
    ]);

    $this->append([
        'action' => 'input',
        'eventUrl' => [$this->config['base_path'] . '/search'],
        'timeOut' => '10',
        'submitOnHash' => true
    ]);
}
```

The `eventUrl` option in your NCCO is used to specify where to send the webhook when the user has entered their data. This is essentially the same thing you do with the `action` property of a HTML `<form>`. This is where the `$config` array and the base URL are used.

A few other `input` specific properties are used. `timeOut` gives the user more time to enter the order number and `submitOnHash` lets them avoid waiting by ending their order ID with the pound sign (that's a hash symbol '#' for all you British English speakers).
