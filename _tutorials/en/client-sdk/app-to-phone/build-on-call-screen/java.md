---
title: Build on call screen
description: In this step you build OnCall screen.
---

# Call

On call screen (`OnCallFragment` and `OnallViewModel` classes) is responsible for starting a call.

## Update `fragment_on_call` layout

Open `fragment_on_call.xml` layout and click `Code` button in top right corner to display layout XML code:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/layout-resource.png
```

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/show-code-view.png
```

Replace file content with below code snippet:

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:padding="10dp">

    <Button
            android:id="@+id/endCall"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="End call"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintVertical_bias="0.2" />

    <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_gravity="top|center_horizontal"
            android:layout_marginTop="50dp"
            android:gravity="center"
            android:singleLine="true"
            android:text="On call"
            android:textColor="@color/white"
            android:textSize="40sp"
            app:layout_constraintTop_toBottomOf="@id/endCall"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            app:layout_constraintVertical_bias="0.2" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

## Update `OnCallViewModel`

Open `on_callViewModel` and Replace file content with below code snippet:

```java
package com.vonage.tutorial.voice;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;
import com.nexmo.client.*;

public class OnCallViewModel extends ViewModel {

    private CallManager callManager = CallManager.getInstance();
    private NavManager navManager = NavManager.getInstance();

    private MutableLiveData<String> _toast = new MutableLiveData<>();
    public LiveData<String> toast = _toast;

    private NexmoCallEventListener callEventListener = new NexmoCallEventListener() {
        @Override
        public void onMemberStatusUpdated(NexmoCallMemberStatus callMemberStatus, NexmoCallMember callMember) {
            if (callMemberStatus == NexmoCallMemberStatus.COMPLETED || callMemberStatus == NexmoCallMemberStatus.CANCELLED) {
                callManager.setOnGoingCall(null);
                navManager.popBackStack(R.id.mainFragment, false);
            }
        }

        @Override
        public void onMuteChanged(NexmoMediaActionState mediaActionState, NexmoCallMember callMember) { }

        @Override
        public void onEarmuffChanged(NexmoMediaActionState mediaActionState, NexmoCallMember callMember) { }

        @Override
        public void onDTMF(String dtmf, NexmoCallMember callMember) { }
    };

    public OnCallViewModel() {
        NexmoCall onGoingCall;

        if (callManager.getOnGoingCall() == null) {
            throw new RuntimeException("Call is null");
        } else {
            onGoingCall = callManager.getOnGoingCall();
        }

        onGoingCall.addCallEventListener(callEventListener);
    }

    @Override
    protected void onCleared() {
        super.onCleared();

        NexmoCall ongoingCall = callManager.getOnGoingCall();

        if (ongoingCall != null) {
            ongoingCall.removeCallEventListener(callEventListener);
        }
    }

    public void onBackPressed() {
        hangupInternal();
    }

    public void hangup() {
        hangupInternal();
    }

    private void hangupInternal() {
        //TODO: Hangup incoming call
    }
}
```

### Hangup incoming phone call

Locate `hangupInternal` method and replace its body:


```java
private void hangupInternal() {
    NexmoCall ongoingCall = callManager.getOnGoingCall();

    if (ongoingCall != null) {
        ongoingCall.hangup(new NexmoRequestListener<NexmoCall>() {
            @Override
            public void onSuccess(@Nullable NexmoCall call) {
                callManager.setOnGoingCall(null);
            }

            @Override
            public void onError(@NonNull NexmoApiError apiError) {
                _toast.postValue(apiError.getMessage());
            }
        });
    }
}
```

## Update `OnCallFragment`

Open `OnallFragment` and Replace file content with below code snippet:

```java
package com.vonage.tutorial.voice;

import android.os.Bundle;
import android.view.View;
import android.widget.Toast;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProvider;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

public class OnCallFragment extends Fragment implements BackPressHandler {

    OnCallViewModel viewModel;

    Button endCall;

    public OnCallFragment() {
        super(R.layout.fragment_on_call);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        viewModel = new ViewModelProvider(requireActivity()).get(OnCallViewModel.class);

        endCall = view.findViewById(R.id.endCall);

        viewModel.toast.observe(getViewLifecycleOwner(), it -> Toast.makeText(requireActivity(), it, Toast.LENGTH_SHORT));

        endCall.setOnClickListener(view1 -> viewModel.hangup());
    }


    @Override
    public void onBackPressed() {
        viewModel.onBackPressed();
    }
}
```

You are done. It's time to run the app and make the call.
