---
title:  プロジェクトの権限
description:  このステップでは、必要な許可をプロジェクトプロパティに追加します。

---

プロジェクトの許可
=========

電話をかけるときにマイクを使用するので、マイクを使用する許可を要求する必要があります。

1. 必要なアクセス許可を`AndroidManifest.xml`ファイルに追加します（通常は`app/src/main/AndroidManifest.xml`）：

   ```xml
   <manifest ...>
       <uses-permission android:name="android.permission.INTERNET" />
       <uses-permission android:name="android.permission.RECORD_AUDIO" />
   </manifest>
   ```

2. AndroidバージョンM（APIレベル23）以上を実行しているデバイスの場合は、実行時に`RECORD_AUDIO`許可を要求する必要があります。`onCreate`メソッド内の`MainActivity`クラスに権限要求を追加します：

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    // this is the current activity
    if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.RECORD_AUDIO}, 123);
    }
}
```

ビルドして実行
-------

`Cmd + R`を押して、アプリをビルドして実行します。

