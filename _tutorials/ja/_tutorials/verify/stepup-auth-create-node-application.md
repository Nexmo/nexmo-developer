---
title:  Node.jsアプリケーションの作成
description:  このステップでは、基本的なNode.jsアプリケーションを作成します

---

Node.jsアプリケーションを作成します
=====================

ターミナルプロンプトで次のコマンドを入力します：

```sh
mkdir stepup-auth
cd stepup-auth
touch server.js
```

`npm init`を実行してNode.jsアプリケーションを作成し、すべてのデフォルトを受け入れます。

作成するアプリケーションは、ルーティングに[Express](https://expressjs.com/)フレームワークを使用し、UIを構築するために[Pug](https://www.npmjs.com/package/pug)テンプレートシステムを使用します。

`express`および`pug`に加えて、次の外部モジュールを使用します：

* `express-session` - ユーザーのログイン状態を管理する
* `body-parser` - `POST`リクエストを解析する
* `dotenv` - Vonage APIキーとシークレットとアプリケーションの名前を`.env`ファイルに格納する
* `nexmo` - [Node Server SDK](https://github.com/nexmo/nexmo-node)

ターミナルプロンプトで次の`npm`コマンドを実行して、これらの依存関係をインストールします：

```sh
npm install express express-session pug body-parser dotenv nexmo
```

> **注** ：このチュートリアルでは、[Node.js](https://nodejs.org/)がインストールされており、UNIXのような環境で実行されていることを前提としています。Windows環境のターミナルコマンドは、異なる場合があります。

