---
title:  Set Startup Route
description:  Now that you have a Voice View and controller, you will make them the default route.

---

Set Startup Route for Voice View
================================

Open `startup.cs` and navigate to the `app.UseEndpoints` delegate and change `Home` to `Voice` in the `MapControllerRoute` request. It will now look like this:

```csharp
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=voice}/{action=Index}/{id?}");
});
```

