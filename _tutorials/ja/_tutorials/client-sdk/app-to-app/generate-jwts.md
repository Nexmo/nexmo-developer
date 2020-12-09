---
title:  JWTを生成
description:  このステップでは、アプリ内音声通話の各ユーザーに対して、有効なJWTを生成する方法を学びます。

---

JWTを生成する
========

ユーザーごとにJWTを生成する必要があります。JWTは、ユーザーを認証するために使用されます。次のコマンドを実行します。`APPLICATION_ID`変数をアプリケーションのIDに置き換えることを忘れないでください。

```shell
nexmo jwt:generate ./private.key exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' sub=Alice application_id=APPLICATION_ID

nexmo jwt:generate ./private.key exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' sub=Bob application_id=APPLICATION_ID
```

上記のコマンドは、JWTの有効期限を今から1日（最大値）に設定します。

ユーザーごとに生成したJWTを書き留めます。

> **注** ：本番環境では、アプリケーションは、JWTを生成するエンドポイントを、クライアント要求ごとに公開する必要があります。

詳細情報
----

* [JWTガイド](/concepts/guides/authentication#json-web-tokens-jwt)

