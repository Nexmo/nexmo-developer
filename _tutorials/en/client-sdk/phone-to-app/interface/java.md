---
title: Building the interface
description: In this step you will build the only screen of the app.
---

# Building the interface

To be able view the connection status of the app you will need to add a `TextView` view to the screen. You will also add buttons to control the call (Answer, Reject, End). Replace content of `app/res/layout.activity_main.xml` file with below layout:

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

## Retrieve views references

Create 4 properties for each view inside `MainActivity` and retrieve view instances inside inside `onCreate` method:

```java
public class MainActivity extends AppCompatActivity {

    private TextView connectionStatusTextView;
    private Button answerCallButton;
    private Button rejectCallButton;
    private Button endCallButton;

    private NexmoCall call;
    private Boolean incomingCall = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Request permission
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.RECORD_AUDIO}, 123);
        }

        // Retrieve views
        connectionStatusTextView = findViewById(R.id.connectionStatusTextView);
        answerCallButton = findViewById(R.id.answerCallButton);
        rejectCallButton = findViewById(R.id.rejectCallButton);
        endCallButton = findViewById(R.id.endCallButton);
    }
}
```

## Build and Run

Press `Cmd + R` to build and run the app.
