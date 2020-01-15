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

member.earmuff(ActionStatus.ON, listener);

//Earmuff my Member
call.earmuff(ActionStatus.ON, listener);

```
