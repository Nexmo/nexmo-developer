---
title: Try it out!
description: Test your application
---

# Try it out!

First, kill any running instances of your application (using Ctrl+C) and then run your program again using:

```sh
node server.js
```

Visit `http://localhost:3000` in your browser and click the "Verify me" button:

![The home page](/images/tutorials/verify-stepup-auth-home-page.png)

Enter your mobile number in [E.164 format](/concepts/guides/glossary#e-164-format) and then click the "Get Verification Code" button:

![Entering your mobile number](/images/tutorials/verify-stepup-auth-enter-number-filled.png)

You will shortly receive an SMS at that number, containing a code. Enter the code and click "Verify me!":

![Entering the PIN code](/images/tutorials/verify-stepup-auth-enter-code-filled.png)

You should be returned to the home page and, if you entered the number correctly, it will be displayed:

![Successful authentication](/images/tutorials/verify-stepup-auth-success.png)