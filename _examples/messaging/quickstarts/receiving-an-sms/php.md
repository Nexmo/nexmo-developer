---
title: PHP
language: php
menu_weight: 3
---

Install nexmo-php by running: `composer require nexmo/client`

Once you've done that, create a file named `index.php` to receive the incoming webhook:

```php
<?php
require_once "vendor/autoload.php";

$inbound = \Nexmo\Message\InboundMessage::createFromGlobals();
if($inbound->isValid()){
    error_log($inbound->getBody());
} else {
    error_log('invalid message');
}
```

Run this locally using the built in PHP web server

```bash
php -t . -S localhost:8000
```
