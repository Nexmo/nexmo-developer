---
title:  Ngrokの実行方法
description:  Ngrokを実行してアプリケーションをローカルでテストする方法。

---

<a id="how-to-run-ngrok"></a>

Webhookをパブリックインターネット経由でVonageのAPIにアクセスできるようにする必要があります。開発中に独自のサーバーを起動せずにこれを達成する簡単な方法は、[Ngrok](https://ngrok.com/)を使用することです。詳細については、[Ngrokに関するドキュメントをお読みください](/tools/ngrok)。

Ngrokをダウンロードしてインストールし、次のコマンドを実行して、ポート3000におけるアプリケーションをパブリックインターネットに公開します：

```shell
./ngrok http 3000
```

有料会員の場合、次のように入力できます：

```shell
./ngrok http 3000 -subdomain=your_domain
```

> **注：** この例では、NgrokはVonageアプリケーションの作成時に指定したVonage Webhookを`localhost:3000`に迂回させます。ここではポート3000が表示されていますが、ご都合に合わせて任意の空きポートを使用できます。

