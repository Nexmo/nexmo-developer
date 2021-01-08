---
title:  设置启动路由
description:  拥有语音视图和控制器后，可以将它们设置为默认路由。

---

设置语音视图的启动路由
===========

打开 `startup.cs` 并浏览到 `app.UseEndpoints` 代理，并在 `MapControllerRoute` 请求中将 `Home` 更改为 `Voice`。现在如下所示：

```csharp
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=voice}/{action=Index}/{id?}");
});
```

