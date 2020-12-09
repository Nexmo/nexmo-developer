---
title:  スタータープロジェクト
description:  このステップでは、スタータープロジェクトのクローンを作成します

---

スタータープロジェクト
===========

物事を簡単にするために、スタータープロジェクトが用意されています。

1. この[GitHubプロジェクト](https://github.com/nexmo-community/client-sdk-android-tutorial-voice-app-to-app)をクローンします（リポジトリに複数のプロジェクトが含まれているため、Android Studioの`New project from version control`機能は使用できません）。

2. `Android Studio`でプロジェクトを開きます：

   1. メニューに移動します `File -> Open`
   2. クローンされたリポジトリから`kotlin-start`（Kotlinの場合）または `java-start`（Javaの場合）フォルダを選択し、クリックします `Open`

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/select-start-project.png
```

**3\.** プロジェクトを作成します `Build -> Make Project``Make Project`ボタンが無効になっている場合は、Android Studioがプロジェクトの解析を完了するまでお待ちください（進行状況はAndroid Studioの右下に表示されます）。

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/make-project.png
```

プロジェクトナビゲーションの概要
----------------

```screenshot
image: public/screenshots/tutorials/client-sdk/android-app-to-app/nav-graph.png
```

アプリケーションは4つの画面で構成されています：

* **ログイン** - ユーザーのログ記録を担当します
* **メイン** - 通話を開始することができ、着信を待機します
* **着信通話** - 着信通話に対し応答または拒否します
* **オンコール（on call）** - 通話中に表示され、現在のコールを終了できます

プロジェクト内部構造
----------

このチュートリアルで修正されるすべてのファイルは、`app/src/main/java/com/vonage/tutorial/voice`のディレクトリにあります：

```screenshot
image: public/screenshots/tutorials/client-sdk/android-app-to-app/project-files.png
```

> **注：** 各画面は2つのクラスで表されます。シンビューである`Fragment`と、ビューロジックを処理する`ViewModel`です。

