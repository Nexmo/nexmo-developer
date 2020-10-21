---
title: Add an SMS Controller
description: Add an SMS Controller to the csproj to handle the SMS routes
---

# Add SMS Controller

Right-click on the `Controllers` Folder and select add->Controller. Select "MVC Controller - Empty" and name it `SmsController`.

Add a `using` statements for `Vonage.Messaging` and `Vonage.Utility` at the top of this file.

## Add Receive SMS Action

Finally we'll just need to add a route to receive the webhook from Vonage, parse out the SMS data structure, and print some stuff to our console:

```csharp
[HttpGet("/webhooks/inbound-sms")]
public IActionResult InboundSms()
{
    var sms = WebhookParser.ParseQuery<InboundSms>(Request.Query);
    Console.WriteLine("SMS Received");
    Console.WriteLine($"Message Id: {sms.MessageId}");
    Console.WriteLine($"To: {sms.To}");
    Console.WriteLine($"From: {sms.Msisdn}");
    Console.WriteLine($"Text: {sms.Text}");
    return Ok();
}
```
