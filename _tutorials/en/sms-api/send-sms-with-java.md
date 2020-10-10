---
title: Send SMS Messages with Java
description: Send an SMS message with Vonage in Java.
---

# Send SMS Messages with Java

Put the following in your `main` method:

```
AuthMethod auth = new TokenAuthMethod(API_KEY, API_SECRET);
NexmoClient client = new NexmoClient(auth);
```

Fill in `API_KEY` and `API_SECRET` with the values you copied from the Vonage API Dashboard. This code creates a NexmoClient object that can be used to send SMS messages. You will need to provide other AuthMethods to be able to make voice calls (which will be covered in another tutorial). 

Now we have a configured client object, we can send an SMS message:

```
TextMessage message = new TextMessage(FROM_NUMBER, TO_NUMBER, "Hello from Nexmo!");
SmsSubmissionResult[] responses = client.getSmsClient().submitMessage(message);
for (SmsSubmissionResult response : responses) {
    System.out.println(response);
}
```

Replace `FROM_NUMBER` and `TO_NUMBER` with strings containing the virtual number you bought, and your own mobile phone number. Once you’ve done that, save and run `gradle run` again. You should see something like this printed to the screen:

`SMS-SUBMIT-RESULT -- STATUS:0 ERR:null DEST:4412341234 MSG-ID:0C0000002D9C9A89 CLIENT-REF:null PRICE:0.0333000`

You should receive a text message. If it didn’t work, check out if something was printed after `ERR:` in the line above, and wait a few more seconds for the message to appear.

> You have now learned how to send an SMS message with Vonage. Following on from this, this tutorial will show you how to build a web service around it.