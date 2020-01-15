---
title: Java
language: java
menu_weight: 3
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

member.mute(ActionStatus.OFF, listener);

//Mute my Member
call.mute(ActionStatus.OFF, listener);

```
