---
title:  Nexmo CLIベータ版をインストールする
description:  Nexmo CLIベータ版をインストールして最新の機能を入手します

---

Nexmo CLIを使用すると、コマンドラインで多くの操作を実行できます。例としては、アプリケーションの作成、番号の購入、アプリケーションへの番号のリンクなどがあります。

NPMを使用してCLIのベータ版をインストールするには、以下を使用できます：

```shell
npm install nexmo-cli@beta -g
```

Vonage APIキーと APIシークレットを使用するようにNexmo CLIを設定します。これらは、Dashboardの[設定ページ](https://dashboard.nexmo.com/settings)から取得できます。

ターミナルで次のコマンドを実行し、`api_key`および`api_secret`を独自のものに置き換えます：

```bash
nexmo setup api_key api_secret
```

