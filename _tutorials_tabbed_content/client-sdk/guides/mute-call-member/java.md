---
title: Java
language: java
---

```java
NexmoRequestListener<CallMember> listener = new NexmoRequestListener<>() {
        @Override
        public void onError(NexmoApiError nexmoApiError) {
            //Handle error
        }

        @Override
        public void onSuccess(CallMember member) {
            //Handle success
        }
};

member.mute(ActionStatus.ON, listener);

//Mute my Member
call.mute(ActionStatus.ON, listener);

```
