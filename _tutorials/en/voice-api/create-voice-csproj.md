---
title: Create .NET Voice Application
description: This describes how to create the csproj for a .NET Voice Application.
---

# Create the Voice Project File

To start, you will create a Voice `csproj` file. To make testing easier, configure Kestrel with HTTPS disabled.

In your terminal, execute the following command:

```shell
dotnet new mvc --no-https -n VonageVoice
```
