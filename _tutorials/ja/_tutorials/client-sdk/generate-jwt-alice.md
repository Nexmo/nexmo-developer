---
title:  JWTを生成する
description:  このステップでは、クライアントSDKアプリケーション用の有効なJWTを生成する方法を学びます。
--------------------------------------------------------------------------------

JWTを生成する
========

クライアントSDKは、認証に[JWT](/concepts/guides/authentication#json-web-tokens-jwt)を使用します。JWTは、ユーザー名、関連付けられたアプリケーションID、およびユーザーに付与されたアクセス許可を識別します。秘密鍵を使用して署名され、有効なトークンであることが証明されます。

> **注** ：このページでは、テスト用に1回限りのJWTを作成します。本番アプリでは、サーバーは、クライアント要求ごとにJWTを生成するエンドポイントを公開する必要があります。

CLIの使用
------

次のコマンドを実行して、Nexmo CLIを使用してJWTを生成できますが、`APP_ID`変数を独自の値に置き換えてください：

```shell
nexmo jwt:generate ./private.key exp=$(($(date +%s)+21600)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' sub=Alice application_id=APP_ID
```

生成されたJWTは、次の6時間有効です。

別の方法：Webインターフェースの使用
-------------------

または、`Alice`の[online JWT generator (オンラインJWTジェネレータ)](/jwt)を **Sub** パラメータとして使用し、 **Application ID (アプリケーションID)** のアプリケーションIDを使用してJWTを生成することもできます。

詳細情報

---

* [JWTガイド](/concepts/guides/authentication#json-web-tokens-jwt)

