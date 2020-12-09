---
title:  起動ルートの設定
description:  これで、音声ビューとコントローラーが設定されたので、それらをデフォルトルートにします。

---

音声ビューの起動ルートを設定する
================

`startup.cs`を開き、`app.UseEndpoints`デリゲートに移動し、`MapControllerRoute`要求で`Home`を`Voice`に変更します。これで次のようになります：

```csharp
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=voice}/{action=Index}/{id?}");
});
```

