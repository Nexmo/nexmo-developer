---
title: PHP
language: php
---

Create a file named `index.php` with the following contents:

```php
<?php

// Incoming receipts can be either a GET or a POST, depending
// on your account settings
$request = array_merge($_GET, $_POST);

// Check that this is a delivery receipt.
if (!isset($request['messageId']) OR !isset($request['status'])) {
    error_log('This is not a delivery receipt');
    return;
}

// Output all of the parameters received
error_log(print_r($request, true));
```

Run this locally using the built in PHP web server

```bash
php -t . -S localhost:5000
```

