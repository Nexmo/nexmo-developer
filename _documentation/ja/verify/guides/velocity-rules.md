---
title:  Verify Velocity Rules
description:  Verify の不正防止システム
navigation_weight: 4

---


Verify Velocity Rules
=====================

Verify API は、アプリケーションに 2FA を実装し、疑わしいサインアップを回避するための迅速かつ簡単な方法を提供します。

しかし、Vonage は、独自のプラットフォームでの不正行為を防止する必要もあります。これを実現する 1 つの方法は、Velocity Rules と呼ばれる不正防止システムを使用することです。

仕組み
---

Velocity Rules は、オペレーターネットワークによる顧客アカウントのボリュームとコンバージョン率の組み合わせに基づいて、疑わしいトラフィックをブロックします。ボリュームはリクエスト数、コンバージョン率は検証の成功率です。

> **注** ：プラットフォームは、その後 [Verify チェックエンドポイント](/verify/code-snippets/check-verify-request) への呼び出しが行われた場合に、Verify リクエストが成功したかどうかのみを判断できます。Verify 要求ごとに、コードは Verify チェックを実行する必要があります。

あるネットワークの顧客のコンバージョン率が 35% を下回り、一定の期間中に設定された最小トラフィック量を下回った場合、当社のプラットフォームはその特定のネットワークへのそれ以上のトラフィックをブロックします。以降の Verify リクエストは、コード 7 を返します。 `This number is blacklisted for verification.`

コンバージョンを監視する
------------

コンバージョン率を監視して、Velocity Rules で設定された境界内に収まるようにしてください。

コンバージョン率は、成功した検証の試行回数を、試行の総数と比較して計算し、パーセンテージで表します。

`Conversion rate = (# successful verifications / # total verifications) * 100`

> この情報は、[Developer Dashboard](https://dashboard.nexmo.com/verify/analytics) の [Verify] > [Analytics] ナビゲーションメニューオプションから入手できます。

また、[Verify チェック](/api/verify#verifyCheck)プロセス中にプラットフォームから受け取った応答に基づいて、コンバージョン率を追跡することもできます。

ネットワークのブロック解除
-------------

検証の試行で常にエラーコード 7 が返される場合：`This number is blacklisted for verification.`、そのネットワークは Velocity Rules によってブロックされている可能性があります。[サポートに連絡](mailto://support@nexmo.com)してサービスを復元できますが、まず、以下を実行することをお勧めします。

* このネットワーク (または国) に送信された最新のブロックされた検証の試行を確認する
* 正当な検証の試みであることを確認する

これを行った後、トラフィックが正規のものであることが確認でき、このネットワークへのサービスを復元したい場合は、[サポートに連絡して](mailto://support@nexmo.com)支援を依頼してください。

詳細情報
----

* [リスクの高い国への Verify サービス](https://help.nexmo.com/hc/en-us/articles/360018406532)

