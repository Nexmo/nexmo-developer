---
title:  Nexmo CLIをインストールする
description:  Nexmo CLIをインストールして、コマンドライン機能を簡単に取得します

---

Nexmo CLIを使用すると、コマンドラインで多くの操作を実行できます。例としては、アプリケーションの作成、番号の購入、アプリケーションへの番号のリンクなどがあります。

NPMでnexmo CLIをインストールするには、以下を使用できます：

```shell
npm install nexmo-cli -g
```

Vonage APIキーと APIシークレットを使用するようにNexmo CLIを設定します。これらは、Vonage Dashboardの[設定ページ](https://dashboard.nexmo.com/settings)から取得できます。

ターミナルで次のコマンドを実行し、`api_key`と`api_secret`を独自のものに置き換えます：

```bash
nexmo setup api_key api_secret
```

