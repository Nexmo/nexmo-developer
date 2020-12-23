---
title: Build chat screen
description: In this step you build chat screen.
---

# Conversation

Chat screen (`ChatFragment` and `ChatViewModel` classes) is responsible for fetching the conversation and all the conversation events and sending messages.

## Update `fragment_chat` layout

Open `fragment_chat.xml` layout and click `Code` button in top right corner to display layout XML code:

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
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:padding="10dp">

    <androidx.core.widget.ContentLoadingProgressBar
            android:id="@+id/progressBar"
            style="?android:attr/progressBarStyleLarge"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toTopOf="parent" />

    <TextView
            android:id="@+id/errorTextView"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textColor="#FF9494"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toBottomOf="@id/progressBar"
            tools:text="Error" />

    <androidx.constraintlayout.widget.ConstraintLayout
            android:id="@+id/chatContainer"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:visibility="gone"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintLeft_toLeftOf="parent"
            app:layout_constraintRight_toRightOf="parent"
            app:layout_constraintTop_toBottomOf="parent"
            tools:visibility="visible">

        <Button
                android:id="@+id/logoutButton"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                app:layout_constraintBottom_toTopOf="@id/conversationEventsScrollView"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toTopOf="parent"
                tools:text="Logout user" />

        <androidx.core.widget.NestedScrollView
                android:id="@+id/conversationEventsScrollView"
                android:layout_width="0dp"
                android:layout_height="0dp"
                app:layout_constraintBottom_toTopOf="@+id/messageEditText"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@id/logoutButton">

            <TextView
                    android:id="@+id/conversationEventsTextView"
                    android:layout_width="match_parent"
                    android:layout_height="match_parent"
                    android:textSize="20sp"
                    tools:text="Conversation events" />

        </androidx.core.widget.NestedScrollView>

        <TextView
                android:id="@+id/userNameTextView"
                android:layout_width="wrap_content"
                android:layout_height="0dp"
                android:gravity="center_vertical"
                android:textSize="20sp"
                app:layout_constraintBottom_toBottomOf="parent"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toLeftOf="@id/messageEditText"
                app:layout_constraintTop_toBottomOf="@+id/conversationEventsScrollView"
                android:paddingRight="10dp"
                tools:text="User name" />

        <EditText
                android:id="@+id/messageEditText"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:hint="Message"
                android:inputType="text"
                android:textColor="@color/black"
                android:textColorHint="#AAAAAA"
                app:layout_constraintBottom_toBottomOf="parent"
                app:layout_constraintLeft_toRightOf="@id/userNameTextView"
                app:layout_constraintRight_toLeftOf="@id/sendMessageButton"
                app:layout_constraintTop_toBottomOf="@+id/conversationEventsScrollView"
                tools:text="Message" />

        <Button
                android:id="@+id/sendMessageButton"
                android:layout_width="wrap_content"
                android:layout_height="0dp"
                android:text="Send"
                app:layout_constraintBottom_toBottomOf="parent"
                app:layout_constraintLeft_toRightOf="@id/messageEditText"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@+id/conversationEventsScrollView" />

    </androidx.constraintlayout.widget.ConstraintLayout>

</androidx.constraintlayout.widget.ConstraintLayout>
```

## Update `ChatViewModel`

Open `ChatViewModel` and Replace file content with below code snippet:

```java
package com.vonage.tutorial.messaging;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;
import com.nexmo.client.*;
import com.nexmo.client.request_listener.NexmoApiError;
import com.nexmo.client.request_listener.NexmoRequestListener;

import java.util.ArrayList;

public class ChatViewModel extends ViewModel {

    private NexmoClient client = NexmoClient.get();

    private NexmoConversation conversation;

    private MutableLiveData<String> _errorMessage = new MutableLiveData<>();
    LiveData<String> errorMessage = _errorMessage;

    private MutableLiveData<String> _userName = new MutableLiveData<>();
    LiveData<String> userName = _userName;

    private MutableLiveData<ArrayList<NexmoEvent>> _conversationEvents = new MutableLiveData<>();
    ;
    LiveData<ArrayList<NexmoEvent>> conversationEvents = _conversationEvents;

    private NexmoMessageEventListener messageListener = new NexmoMessageEventListener() {
        @Override
        public void onTextEvent(@NonNull NexmoTextEvent textEvent) {
            //TODO: Update the conversation
        }

        @Override
        public void onAttachmentEvent(@NonNull NexmoAttachmentEvent attachmentEvent) {

        }

        @Override
        public void onEventDeleted(@NonNull NexmoDeletedEvent deletedEvent) {

        }

        @Override
        public void onSeenReceipt(@NonNull NexmoSeenEvent seenEvent) {

        }

        @Override
        public void onDeliveredReceipt(@NonNull NexmoDeliveredEvent deliveredEvent) {

        }

        @Override
        public void onTypingEvent(@NonNull NexmoTypingEvent typingEvent) {

        }
    };

    public void onInit() {
        getConversation();
        _userName.postValue(client.getUser().getName());
    }

    private void getConversation() {
        //TODO: Get the conversation
    }

    private void getConversationEvents(NexmoConversation conversation) {
        //TODO: Get the conversation events
    }

    private void updateConversation(NexmoEvent textEvent) {
        ArrayList<NexmoEvent> events = _conversationEvents.getValue();

        if (events == null) {
            events = new ArrayList<>();
        }

        events.add(textEvent);
        _conversationEvents.postValue(events);
    }

    public void onSendMessage(String message) {
        //TODO: Send new message to client SDK
    }

    public void onBackPressed() {
        client.logout();
    }

    public void onLogout() {
        client.logout();
    }

    @Override
    protected void onCleared() {
        //TODO: Unregister message listener"
    }
}
```

## Update `ChatFragment`

Open `ChatFragment` and Replace file content with below code snippet:

```java
package com.vonage.tutorial.messaging;

import android.os.Bundle;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.*;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.navigation.fragment.NavHostFragment;
import com.nexmo.client.NexmoEvent;
import com.nexmo.client.NexmoMemberEvent;
import com.nexmo.client.NexmoTextEvent;

import java.util.ArrayList;

public class ChatFragment extends Fragment implements BackPressHandler {

    private ChatViewModel viewModel;

    private ProgressBar progressBar;
    private TextView errorTextView;
    private ConstraintLayout chatContainer;
    private Button logoutButton;
    private Button sendMessageButton;
    private TextView userNameTextView;
    private EditText messageEditText;
    private TextView conversationEventsTextView;

    private Observer<String> errorMessageObserver = it -> {
        progressBar.setVisibility(View.GONE);
        errorTextView.setText(it);

        if (it.equals("")) {
            errorTextView.setVisibility(View.GONE);
            chatContainer.setVisibility(View.VISIBLE);
        } else {
            errorTextView.setVisibility(View.VISIBLE);
            chatContainer.setVisibility(View.GONE);
        }
    };

    private Observer<String> userNameObserver = it -> {
        userNameTextView.setText(it + ": ");
        logoutButton.setText("Logout " + it);
    };

    private Observer<ArrayList<NexmoEvent>> conversationEvents = events -> {
         //TODO: Process incoming events
    };

    public ChatFragment() {
        super(R.layout.fragment_chat);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        progressBar = view.findViewById(R.id.progressBar);
        errorTextView = view.findViewById(R.id.errorTextView);
        chatContainer = view.findViewById(R.id.chatContainer);
        logoutButton = view.findViewById(R.id.logoutButton);
        sendMessageButton = view.findViewById(R.id.sendMessageButton);
        userNameTextView = view.findViewById(R.id.userNameTextView);
        messageEditText = view.findViewById(R.id.messageEditText);
        conversationEventsTextView = view.findViewById(R.id.conversationEventsTextView);

        viewModel = new ViewModelProvider(requireActivity()).get(ChatViewModel.class);

        if (Config.CONVERSATION_ID.trim().isEmpty()) {
            Toast.makeText(requireActivity(), "Please set Config.CONVERSATION_ID", Toast.LENGTH_SHORT).show();
            onBackPressed();
            return;
        }

        viewModel.onInit();

        viewModel.errorMessage.observe(getViewLifecycleOwner(), errorMessageObserver);
        viewModel.conversationEvents.observe(getViewLifecycleOwner(), conversationEvents);
        viewModel.userName.observe(getViewLifecycleOwner(), userNameObserver);

        sendMessageButton.setOnClickListener(it -> {
            String message = messageEditText.getText().toString();

            if (!message.trim().isEmpty()) {
                viewModel.onSendMessage(messageEditText.getText().toString());
                messageEditText.setText("");
                hideKeyboard();
            } else {
                Toast.makeText(requireActivity(), "Message is blank", Toast.LENGTH_SHORT).show();
            }
        });

        logoutButton.setOnClickListener(it -> {
            viewModel.onLogout();
            NavHostFragment.findNavController(this).popBackStack();
        });
    }

    private String getConversationLine(NexmoTextEvent textEvent) {
        //TODO: Convert event to line string
    }

    private String getConversationLine(NexmoMemberEvent memberEvent) {
        //TODO: Convert event to line string
    }

    public void hideKeyboard() {
        InputMethodManager inputMethodManager = ContextCompat.getSystemService(getContext(), InputMethodManager.class);

        View view = getActivity().getCurrentFocus();

        if (view == null) {
            view = new View(getActivity());
        }

        inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
    }

    @Override
    public void onBackPressed() {
        viewModel.onBackPressed();
    }
}
```