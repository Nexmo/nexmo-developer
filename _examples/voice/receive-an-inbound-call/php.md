---
title: PHP
language: php
---

## Implement a server

The following code implements a server which responds to callbacks on
`/webhooks/answer`:

```code
config: voice.inbound.php
```

## Run your server

Save the previous code to a file called `index.php` and then run a local server:

```
$ php -t . -S localhost:3000
```

