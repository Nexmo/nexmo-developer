---
title:  新しいAndroidプロジェクトを作成する
description:  このステップでは、Androidプロジェクトを作成し、AndroidクライアントSDKライブラリを追加します。

---

Androidプロジェクトを作成する
------------------

* Android Studioを開き、メニューから`File`＞`New`＞`New Project...`を選択します。

* `Empty Activity`テンプレートタイプを選択し、`Next`をクリックします。

* `Project Name`を入力して、`Java`言語を選択します。

* クリックします `Finish`

* これで、新しいAndroidプロジェクトが作成されます。

### 依存関係を追加する

Gradle設定にカスタムMaven URLリポジトリを追加する必要があります。トップレベルの`build.gradle`ファイルに、次のURLを追加します。

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/maven'
```

次に、プロジェクトにクライアントSDKを追加します。アプリレベルの`build.gradle`ファイル（通常は`app/build.gradle`）に、次の依存関係を追加します：

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/dependencies'
```

### Java 1\.8を設定する

アプリレベルの`build.gradle`ファイル（通常は`app/build.gradle`）に、Java 1\.8を設定します。

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/add-sdk/android/gradlejava18'
```

