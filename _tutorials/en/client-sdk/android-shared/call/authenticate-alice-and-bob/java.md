---
title: Authenticate Users
description: In this step you authenticate your users via the JWTs you created earlier
---

# Authenticate Users

Your users must be authenticated to be able to participate in the call. The login screen (which consists of the `LoginFragment` and `LoginViewModel` classes) is responsible for the authentication process.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/login-screen-users.png
```

> **NOTE:** You perform this authentication using the `JWTs` that you generated in an earlier step.

## Get NexmoClient instance

You will retrieve the client instance inside the `LoginViewModel` class. In a production application you would provide it via injection, but for tutorial purposes you will retrieve the instance directly.

Locate the `private val client` property in the `LoginViewModel` class and update its implementation:

```java
private NexmoClient client = NexmoClient.get();
```

Ensure that you add the required `import` statement.

## Login user

Your user must be authenticated to be able to participate in the call.

Locate the `onLoginUser` method inside the `LoginViewModel` class and replace it with this code:

```java
void onLoginUser(User user) {
    if (!StringUtils.isBlank(user.jwt)) {
        this.user = user;
        client.login(user.jwt);
    }
}
```

> **NOTE:** Inside the `LoginFragment` class, examine the `loginUser` method that was written for you. This method is called when one of the two `Login ...` buttons are clicked and, in turn, invokes the above `onLoginUser` method.

> **NOTE:** The `User` type is the `data class` that we defined in the `Config.kt` file.

## Monitor connection state

When a successful connection is established you need to navigate the user to `MainFragment`.

Locate the `LoginViewModel` constructor inside the `LoginViewModel` class and replace it with this code:


```java
public LoginViewModel() {
    client.setConnectionListener(new NexmoConnectionListener() {
        @Override
        public void onConnectionStatusChange(@NonNull ConnectionStatus connectionStatus, @NonNull ConnectionStatusReason connectionStatusReason) {
            if (connectionStatus == ConnectionStatus.CONNECTED) {
                navigate();
                return;
            }

            connectionStatusMutableLiveData.postValue(connectionStatus);
        }
    });
}
```

The code above monitors the connection state and, if the user is authenticated (`ConnectionStatus.CONNECTED`), will navigate the user to `MainFragment`.

You are now ready to make the call within the app.

