---
title:  JWTを生成
description:  このステップでは、カンバセーションの各ユーザーに対して、有効なJWTを生成する方法を学びます

---

JWTを生成する
========

JWTは、ユーザーを認証するために使用されます。ターミナルで次のコマンドを実行して、ユーザー`Alice`と`Bob`のJWTを生成します。

Alice JWTを生成する
--------------

次のコマンドで、`APPLICATION_ID`を自分のアプリケーションのIDに置き換えます。

```shell
nexmo jwt:generate sub=Alice exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

Alice用に生成したJWTを書き留めます。

```screenshot
image: public/screenshots/tutorials/client-sdk/generated-jwt-key.png
```

Bob JWTを生成する
------------

次のコマンドで、`APPLICATION_ID`を自分のアプリケーションのIDに置き換えます。

```shell
nexmo jwt:generate sub=Bob exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

Bob用に生成したJWTを書き留めます。

> **注** ：上記のコマンドは、JWTの有効期限を今から1日（最大値）に設定します。

> **注** ：本番環境では、アプリケーションは、JWTを生成するエンドポイントを、クライアント要求ごとに公開する必要があります。

> **注** ：[JWTガイド](/concepts/guides/authentication#json-web-tokens-jwt)を確認してください

