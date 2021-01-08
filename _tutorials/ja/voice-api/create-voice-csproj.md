---
title:  .NET音声アプリケーションの作成
description:  ここでは、.NET音声アプリケーション用のcsprojを作成する方法について説明します。

---

音声プロジェクトファイルの作成
===============

まず、音声`csproj`ファイルを作成します。テストを簡単にするために、HTTPSを無効にしてKestrelを設定します。

ターミナルで、次のコマンドを実行します：

```shell
dotnet new mvc --no-https -n VonageVoice
```

