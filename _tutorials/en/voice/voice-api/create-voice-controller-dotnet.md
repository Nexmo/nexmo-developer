---
title: Add a Voice Controller
description: Add a Voice Controller to the csproj to handle Voice requests
---

# Add Voice Controller

Right-click on the `Controllers` folder and select add->Controller. Select "Add Empty MVC Controller" and name it `VoiceController`.

Add `using` statements for `Vonage.Voice`, `Vonage.Voice.Nccos`, `Vonage.Voice.Nccos.Endpoints`, `Vonage.Request`, and `Microsoft.Extensions.Configuration` at the top of this file.

## Inject Configuration

Dependency inject an `IConfiguration` object via the constructor:

```csharp
private readonly IConfiguration _config { get; set; }

public VoiceController(IConfiguration config)
{
    _config = config;
}
```
