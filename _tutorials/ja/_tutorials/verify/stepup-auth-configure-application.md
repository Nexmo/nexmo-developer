---
title:  アプリケーションを設定する
description:  認証およびその他の詳細を保存する設定ファイルを作成します

---

アプリケーションを構成する
=============

APIキーとシークレット（[Developer Dashboard](https://dashboard.nexmo.com)で確認できます）と組織の名前を設定ファイルに保存します。

アプリケーションディレクトリのルートに`.env`という名前のファイルを作成し、次の情報を入力します。このとき、`YOUR_API_KEY`と`YOUR_API_SECRET`を独自のキーとシークレットに置き換えます：

    NEXMO_API_KEY=YOUR_API_KEY
    NEXMO_API_SECRET=YOUR_API_SECRET
    NEXMO_BRAND_NAME=AcmeInc

