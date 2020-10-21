---
title: Add Delivery Receipt Route to Controller
description: Add Delivery Receipt route to 
---

# Add Delivery Receipt Route

In order to receive Delivery receipts we'll need to add another route to our `SmsController`. This will be a `GET` route at `/webhooks/dlr`. This will just print to the console

```csharp
[HttpGet("/webhooks/dlr")]
public IActionResult ReceiveDlr()
{
    var dlr = Vonage.Utility.WebhookParser.ParseQuery<DeliveryReceipt>(Request.Query);
    Console.WriteLine("DLR Received");
    Console.WriteLine($"Message Id: {dlr.MessageId}");
    Console.WriteLine($"To: {dlr.Msisdn}");
    Console.WriteLine($"From: {dlr.To}");
    Console.WriteLine($"Time: {dlr.MessageTimestamp}");
    return Ok();
}
```