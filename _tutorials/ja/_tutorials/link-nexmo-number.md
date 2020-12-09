---
title:  Vonage番号をリンクする
description:  このステップでは、Vonage番号をアプリケーションにリンクする方法を学びます。

---

Vonage番号をリンクする
==============

Dashboardを使用する
--------------

1. [Dashboard](https://dashboard.nexmo.com/voice/your-applications)でアプリケーションを見つけます。
2. アプリケーション一覧でアプリケーションをクリックします。次に、[Numbers (番号)]タブをクリックします。
3. [Link (リンク)]ボタンをクリックすると、Vonage番号がそのアプリケーションにリンクされます。

Nexmo CLI を使用する
---------------

適切な番号を取得したら、Vonageアプリケーションとリンクすることができます。`YOUR_NEXMO_NUMBER`を新しく生成された番号に置き換え、`APPLICATION_ID`をアプリケーションIDに置き換えて次のコマンドを実行します：

    nexmo link:app YOUR_NEXMO_NUMBER APPLICATION_ID

