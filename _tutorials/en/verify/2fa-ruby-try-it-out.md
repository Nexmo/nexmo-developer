---
title: Try it out!
description: Test the 2fa capability of your application
---

# Try it out!

Run your application:

```sh
rails server
```

Visit `http://localhost:3000`. If you're still logged in, log out.

A verification code will be sent to you via SMS:

![Verification code sent](/images/2fa-ruby-code-sent.png)

The following page displays:

![Enter verification code](/images/2fa-ruby-check-code.png)

Enter the code you received and you will be logged in:

![Successful verification](/images/2fa-ruby-verification-success.png)