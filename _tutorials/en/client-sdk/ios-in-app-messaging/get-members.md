---
title: Get members
description: In this step you learn how to get the members of a conversation.
---

# Get members

Get current user's member:

```objective-c
NXMMember *myMember = conversation.myMember;
```

Get other members of this conversation:

```objective-c
NSSet<NXMMember *> *otherMembers = conversation.otherMembers;
```
