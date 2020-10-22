---
title: Create .NET Voice Application
description: This describes how to create the csproj for a .NET Voice Application.
---

# Create the Voice Project File

To start, you will create an Voice `csproj` file. You will have it not configure kestrel for https for testing purposes.

In your terminal, execute the following command:

```shell
dotnet new mvc --no-https -n VonageVoice
```
