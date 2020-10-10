---
title: Set up Startup Route
description: Configure the startup route for the ASP.NET Core app to start at the Sms View
---

# Set Startup Route for SMS View

Open `startup.cs` and navigate to the `app.UseEndpoints` delegate and change `Home` to `Sms` in the `MapControllerRoute` request. It will now look like this:

```csharp
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=Sms}/{action=Index}/{id?}");
});
```