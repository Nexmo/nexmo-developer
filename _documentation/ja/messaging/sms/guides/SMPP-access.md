---
title:  SMPP アクセス
description:  REST でなく SMPP を使って SMS 用 API にアクセスします。
navigation_weight:  7

---


SMPP アクセス
=========

> この基本概念ドキュメントでは Nexmo の API へのアクセスに REST でなく SMPP を使用する方法について説明しています。SMPP アクセスの通信プロトコルは複雑であり、低水準言語での開発作業を多数伴うため、実装には十分な知識が必要です。ただし、ほとんどの開発者には既に十分な知識があると考えられます。

アカウントはデフォルトで、Nexmo の REST 用 API を HTTP 経由で使用するように設定されます。所属組織が SMPP を実装済みのアグリゲーターでない限り、このガイドの情報は通常適用されません。

内容
---

このドキュメントでは次のトピックを取り上げます。

* [SMPP とは](#what-is-smpp)
* [Nexmo プラットフォームへの接続に SMPP を使用すべきか](#should-i-use-smpp-to-connect-to-the-nexmo-platform)
* [Nexmo で SMPP アクセスを提供する理由](#why-does-nexmo-offer-smpp-access)
* [SMPP アクセスの設定](#configuring-smpp-access)
* [Nexmo の SMPP インスタンス](#our-smpp-instances)
* [関連情報](#resources)

SMPP とは
-------

[Short Message Peer-to-Peer (SMPP)](https://en.wikipedia.org/wiki/Short_Message_Peer-to-Peer) とは、ショートメッセージサービスセンター (SMSC) 間や SMSC と外部のショートメッセージ設備 (ESME) との間で SMS メッセージを交わすために通信業界で使用されるプロトコルです。

SMPP は [第 7 層の TCP/IP プロトコル](https://en.wikipedia.org/wiki/OSI_model#Layer_7:_Application_Layer)で、SMS メッセージの高速配信を可能にします。[UMTS](https://en.wikipedia.org/wiki/UMTS) や [CDMA](https://en.wikipedia.org/wiki/Code-division_multiple_access) などの GSM 以外の SMS プロトコルをサポートするため、外部の SS7 ネットワークとショートメッセージの交換に広く利用されています。

Nexmo では SMPP を使って世界中の複数の通信会社に接続しています。SMPP は標準的なプロトコルであるため、新たに契約する通信会社も標準的な接続手段として対応することを求めています。対応する場合、新規通信会社と比較的簡単に統合できます。

Nexmo プラットフォームへの接続に SMPP を使用すべきか
--------------------------------

Nexmo は次の理由で SMPP アクセスを推奨 **しません** 。

* SMPP は非常に複雑な通信プロトコルであり、適切に使用するにはドメインに精通し ている必要があるため。
* REST API と違い、実装に低水準言語での開 発作業を多数必要とするため。
* Nexmo は SMPP 経由での高可用性やディザスタリカバリ を提供して **いない** ため。SMPP プロトコルの設計上、メッセー ジの交換前にクライアントとサーバーを連携 させる必要があることがその理由です。Nexmo の SMPP インスタンスが故障した場合、そのインスタンスのユーザーは次のいずれかが必要になります。 
  * 別のインスタンスにバインド済みであり、トラフィックを再ルートする
  * どのインスタンスにもバインドしていないことを特定し、別のインスタンスへのバインドを試みる

Nexmo で SMPP アクセスを提供する理由
------------------------

Nexmo が SMPP プロトコルを提供するのは、新規通信会社を統合するため、および SMPP を実装済みの顧客が当社プラットフォームを簡単に使用できるようにするためです。

REST 用 API 経由のメッセージングを実装し直す必要なしに、既存の統合を変更して Nexmo SMPP クラスタとのバインドを確立できます。

SMPP アクセスの設定
------------

次のいずれかの方法で Nexmo プラットフォームへの SMPP アクセスを設定できます。

### 標準設定

1. [SMPP に関する FAQ](https://help.nexmo.com/hc/en-us/sections/200621223) で、文字エンコード、DLR 形式、連結メッセージ、スロットル管理などの重要な情報を詳しく読みます。
2. 月次ボリューム予測を Nexmo に[メールします](mailto:smpp@nexmo.com)。Nexmo は SMPP アクセスを有効にするためのシステム設定作業を代行し、追加リソースへのリンクを掲載した確認メールを送信します。

### Kannel の使用

[Kannel](http://www.kannel.org) のバージョン 1\.4\.3 以降を使用して、SMPP アクセスを次の手順で設定できます。

1. [標準設定](#standard-configuration)手順を完了します。

2. `kannel.conf` [コンフィグファイル](https://help.nexmo.com/hc/en-us/article_attachments/115016988548/kannel.conf)をダウンロードします。

3. `kannel.conf` を編集して、`$nexmo_user` と `$nexmo_password` を Nexmo SMPP 資格情報と置き換えます。

4. セキュリティ上の理由により、`kannel.conf` では `localhost` からのアクセスのみ許可されます。別のマシンからアクセスできるようにするには、`kannel.conf` で次のパラメーターを編集します。たとえば IP アドレス `X.X.X.X` と `Y.Y.Y.Y` の場合は次のように編集します。

    ```text
      admin-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
      ...
      box-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
      ...
      user-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
    ```
5. Kannel を再起動します。

6. テストメッセージを送信します。以下は一例です。

    ```text
      https://localhost:13013/cgi-bin/sendsms?username=username&password=pwd&to=%2B33XXXXXXX&text=Hello%20World&from=test&charset=ISO-8859-1&dlr-mask=17
    ```
Nexmo の SMPP インスタンス
-------------------

Nexmo は次の 3 つの SMPP インスタンスをホストします。

* `SMPP1/2` - クラスタ
* `SMPP0` - 非クラスタ

`SMPP1` と `SMPP2` の両方にバインドすることをおすすめします。クラスタセットアップにバインドできない場合のみ `SMPP0` にバインドしてください。

スタンドアロンインスタンス `SMPP0` は、複数の IP アドレスへの同時バインドを維持できない旧式インフラストラクチャを実行するアグリゲーター向けです。`SMPP0` にバインドしている場合は SMPP を冗長化して、計画済み・未計画のダウンタイムのリスクを軽減する必要があります。

関連情報
----

* [SMS プロトコル仕様 v3\.4](http://docs.nimta.com/SMPP_v3_4_Issue1_2.pdf)
* [Nexmo の SMPP に関する FAQ](https://help.nexmo.com/hc/en-us/sections/200621223)
* [Nexmo の SMPP サーバー](https://help.nexmo.com/hc/en-us/articles/204015693)
* [SMPP エラーコード](https://help.nexmo.com/hc/en-us/articles/204015763-SMPP-Error-Codes)
* [SMPP 経由での連結メッセージの送信](https://help.nexmo.com/hc/en-us/articles/204015653-Sending-Concatenated-Messages-via-SMPP)
* [SMPP DLR 形式とエラーコード](https://help.nexmo.com/hc/en-us/articles/204015663)
* [SMPP DLR のトラブルシューティング](https://help.nexmo.com/hc/en-us/articles/204015803-Not-receiving-Delivery-Receipts-for-SMPP-what-should-I-do-)

