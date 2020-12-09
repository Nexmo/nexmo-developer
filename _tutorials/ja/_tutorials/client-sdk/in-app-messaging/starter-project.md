---
title:  スタータープロジェクト
description:  このステップでは、スタータープロジェクトのクローンを作成します

---

スタータープロジェクト
===========

物事を簡単にするために、スタータープロジェクトが用意されています。

1. この[GitHubリポジトリ](https://github.com/nexmo-community/client-sdk-android-tutorial-messaging)のクローンを作成します（リポジトリには2つのプロジェクト`kotlin-start`と`kotlin-complted`が含まれているため、Android Studioの`New project from version control`機能は使用できません）。

2. Android Studioで`kotlin-start`プロジェクトを開きます：

   1. メニューに移動する `File -> Open`
   2. 複製されたリポジトリから`kotlin-start`フォルダを選択しクリックする `Open`

**3\.** プロジェクトを作成します `Build -> Make Project``Make Project`ボタンが無効になっている場合は、Android Studioがプロジェクトの解析を完了するまでお待ちください（進行状況はAndroid Studioの右下に表示されます）。

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/make-project.png
```

プロジェクトナビゲーションの概要
----------------

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/nav-graph.png
```

アプリケーションは4つの画面で構成されています：

* **ログイン** - ユーザーのログ記録を担当します
* **チャット** -メッセージを送信し、着信メッセージを聞くことを許可します

プロジェクトの内部構造
-----------

このチュートリアルで修正されるすべてのファイルは、`app/src/main/java/com/vonage/tutorial/voice`のディレクトリにあります：

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/project-files.png
```

> **注：** 各画面は2つのクラスで表されます。シンビューである`Fragment`と、ビューロジックを処理する`ViewModel`です。

