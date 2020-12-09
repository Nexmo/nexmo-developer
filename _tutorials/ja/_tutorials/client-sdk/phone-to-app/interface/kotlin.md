---
title:  インタフェースの構築
description:  このステップでは、アプリの画面のみを構築します。

---

インタフェースの構築
==========

アプリの接続状態を表示できるようにするには、画面に`TextView`ビューを追加する必要があります。また、呼び出しを制御するボタン（応答、拒否、終了）も追加します。以下のレイアウトで`app/res/layout.activity_main.xml`ファイルの内容を置き換えます：

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        tools:context=".MainActivity">

    <TextView
            android:id="@+id/connectionStatusTextView"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:text="Hello World!"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent" />

    <Button
            android:id="@+id/answerCallButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:text="Answer"
            android:visibility="gone"
            app:layout_constraintBottom_toTopOf="@id/connectionStatusTextView"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toLeftOf="@id/rejectCallButton"
            tools:visibility="visible" />

    <Button
            android:id="@+id/rejectCallButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:text="Reject"
            android:visibility="gone"
            app:layout_constraintBottom_toTopOf="@id/connectionStatusTextView"
            app:layout_constraintLeft_toRightOf="@+id/answerCallButton"
            app:layout_constraintRight_toRightOf="parent"
            tools:visibility="visible" />

    <Button
            android:id="@+id/endCallButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginBottom="40dp"
            android:text="End"
            android:visibility="gone"
            app:layout_constraintBottom_toTopOf="@id/connectionStatusTextView"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            tools:visibility="visible" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

ビルドして実行
-------

`Cmd + R`を押して、アプリをビルドして実行します。

