---
title: Authenticate User
description: In this step you authenticate your users via the JWTs you created earlier
---

# Authenticate User

Users must be authenticated before being able to participate in the Conversation. You authenticate your users with the `JWTs` that you generated in an earlier step. In this step, you will create a login screen (using the `LoginFragment` and `LoginViewModel` classes) to manage the authentication process.

## Update `fragment_login` layout

Open `fragment_login.xml` file.

> **NOTE** You can open any file by using the `Go to file...` action. Press `Shift + Cmd + O` and enter the file name.

Click the `Code` button in the top right corner to display the layout XML code:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/show-code-view.png
```

Replace the file contents with the following code:

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:padding="10dp">

    <Button
            android:id="@+id/loginAsAliceButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Login as Alice"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintVertical_bias="0.2" />

    <androidx.core.widget.ContentLoadingProgressBar
            android:id="@+id/progressBar"
            style="?android:attr/progressBarStyleLarge"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:visibility="invisible"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toBottomOf="@id/loginAsAliceButton" />

    <TextView
            android:id="@+id/connectionStatusTextView"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textColor="@color/colorPrimary"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toBottomOf="@id/progressBar"
            tools:text="Connection status" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

## Update `LoginViewModel`

Replace the contents of the `ViewModel.java` file with the following code:

Replace the file contents with the following code:


```java
package com.vonage.tutorial.voice;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;
import com.nexmo.client.NexmoClient;
import com.nexmo.client.request_listener.NexmoConnectionListener.ConnectionStatus;

public class LoginViewModel extends ViewModel {

    private NexmoClient client = null; // TODO: Retrieve NexmoClient instance

    NavManager navManager = NavManager.getInstance();
    private MutableLiveData<ConnectionStatus> _connectionStatusMutableLiveData = new MutableLiveData<>();
    public LiveData<ConnectionStatus> connectionStatusLiveData = _connectionStatusMutableLiveData;

    public LoginViewModel() {
        // TODO: Add client connection listener
    }

    void onLoginUser(User user) {
        // TODO: Login user
    }
}
```

### Get NexmoClient instance

In a production application you would typically retrieve the client instance inside the `LoginViewModel` class via injection. However, in this tutorial, you will retrieve the instance directly. Replace the `client` property in the `LoginViewModel` class:

```java
private NexmoClient client = NexmoClient.get();
```

### Login user

You must authenticate your user to enable them to participate in the Conversation. Replace the `onLoginUser` method inside `LoginViewModel` class:

```java
void onLoginUser(User user) {
    if (!user.jwt.trim().isEmpty()) {
        client.login(user.jwt);
    }
}
```

> **NOTE:** Examine the `loginUser` method of the `LoginFragment` class. This method is called when one of the two `Login ...` buttons are clicked and, in turn, invokes the `onLoginUser` method. 

### Monitor connection state

When a successful connection is established you need to navigate the user to the `MainFragment` class. Locate the `LoginViewModel` constructor and replace its body:


```java
public class LoginViewModel extends ViewModel {

    // ...

    public LoginViewModel() {
        client.setConnectionListener(new NexmoConnectionListener() {
            @Override
            public void onConnectionStatusChange(@NonNull ConnectionStatus connectionStatus, @NonNull ConnectionStatusReason connectionStatusReason) {
                if (connectionStatus == ConnectionStatus.CONNECTED) {
                    NavDirections navDirections = LoginFragmentDirections.actionLoginFragmentToMainFragment();
        navManager.navigate(navDirections);
                    return;
                }

                _connectionStatusMutableLiveData.postValue(connectionStatus);
            }
        });
    }

    // ...
}
```

The above code monitors the connection state and if the user is authenticated (`ConnectionStatus.CONNECTED`) it will navigate the user to the `MainFragment`, otherwise it will emit the connection status to the UI (`LoginFragment`).

## Update `LoginFragment`

Replace the contents of the `LoginFragment.java` file with the following code:

```java
package com.vonage.tutorial.voice;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProvider;
import com.nexmo.client.request_listener.NexmoConnectionListener.ConnectionStatus;

public class LoginFragment extends Fragment {

    private Button loginAsAliceButton;
    private ProgressBar progressBar;
    private TextView connectionStatusTextView;

    private LoginViewModel viewModel;

    public LoginFragment() {
        super(R.layout.fragment_login);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        viewModel = new ViewModelProvider(requireActivity()).get(LoginViewModel.class);

        viewModel.connectionStatusLiveData.observe(getViewLifecycleOwner(), connectionStatus -> {
            connectionStatusTextView.setText(connectionStatus.toString());

            if (connectionStatus == ConnectionStatus.DISCONNECTED) {
                setDataLoading(false);
            }
        });

        loginAsAliceButton = view.findViewById(R.id.loginAsAliceButton);
        progressBar = view.findViewById(R.id.progressBar);
        connectionStatusTextView = view.findViewById(R.id.connectionStatusTextView);


        loginAsAliceButton.setOnClickListener(it -> loginUser(Config.getAlice()));
    }

    private void setDataLoading(Boolean dataLoading) {
        loginAsAliceButton.setEnabled(!dataLoading);

        int visibility;

        if (dataLoading) {
            visibility = View.VISIBLE;
        } else {
            visibility = View.GONE;
        }

        progressBar.setVisibility(visibility);
    }

    private void loginUser(User user) {
        if (user.jwt.trim().isEmpty()) {
            Toast.makeText(getActivity(), "Error: Please set Config." + user.name + " jwt", Toast.LENGTH_SHORT).show();
        } else {
            viewModel.onLoginUser(user);
            setDataLoading(true);
        }
    }
}
```

# Run the app

You can either launch the app on the physical phone (with [USB Debugging enabled](https://developer.android.com/studio/debug/dev-options#enable)) or create a new [Android Virtual Device](https://developer.android.com/studio/run/managing-avds). When device is present press `Run` button: 

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/launch-app.png
```

You should see the login screen with the `Login Alice` button. Click the button to log in and the empty main screen will open.
