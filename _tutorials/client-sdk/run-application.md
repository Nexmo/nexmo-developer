---
title: Run your application
description: In this step you see how to run your app to phone application.
---

# Run your application

You need to run a local web server to get your application working. 

First install a web server such as `http-server`:

```
npm install http-server
```

You can then run the server in your project directory with:

```
http-server
```

You application `index.html` is automatically loaded and a simple text field and button displayed. 

Enter the number of your mobile phone into the text field in E.164 format (for example, `447700900000`) and then click the call button.

To see the webhook server logging switch to the terminal tab running your server. You can also open up the web browser console and view logging messages there.

You will see the application attempting to connect to the target number your provided.

Once the call comes through you can answer it and hear the in-app voice call.
