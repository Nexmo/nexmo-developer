---
title: Add an SMS Controller
description: Add an SMS Controller to the csproj to handle the SMS routes
---

# Add SMS Controller

Right-click on the `Controllers` Folder and select add->Controller. Select "Add Empty MVC Controller" and name it `SmsController`.

Add `using` statements for `Vonage.Messaging`, `Vonage.Request`, and `Microsoft.Extensions.Configuration` at the top of this file.

## Inject Configuration

Dependency inject an `IConfiguration` object via the constructor like so:

```csharp
public IConfiguration Configuration { get; set; }

public SmsController(IConfiguration config)
{
    Configuration = config;
}
```

## Add Send SMS Action

Next, add a Send SMS Action to the controller:

```csharp
[HttpPost]
public IActionResult Sms(Models.SmsModel sendSmsModel)
{
    if (ModelState.IsValid)
    {
        try
        {
            var VONAGE_API_KEY = Configuration["VONAGE_API_KEY"];
            var VONAGE_API_SECRET = Configuration["VONAGE_API_SECRET"];
            var credentials = Credentials.FromApiKeyAndSecret(VONAGE_API_KEY, VONAGE_API_SECRET);
            var client = new SmsClient(credentials);
            var request = new SendSmsRequest { To = sendSmsModel.To, From = sendSmsModel.From, Text = sendSmsModel.Text };
            var response = client.SendAnSms(request);
            ViewBag.MessageId = response.Messages[0].MessageId;
        }
        catch(VonageSmsResponseException ex)
        {
            ViewBag.Error = ex.Message;
        }
    }
    return View("Index");
}
```