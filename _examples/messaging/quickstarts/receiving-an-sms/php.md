---
title: PHP
---

Install the Nexmo PHP client using `composer`:

```
$ composer require nexmo/client:@beta
```

The code below handles the incoming SMS messages.

```code
source: '.repos/nexmo-community/nexmo-php-quickstart/sms/receive-sms.php'
from_line: 6
```

Save this as `index.php` and start the server by running:

```
$ php -t . -S localhost:8000
```
