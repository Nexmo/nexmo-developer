---
title: Respond to user input
description: Respond to user input
---
### Respond to user input

After the user has provided input, Nexmo sends a webhook to the `eventUrl` defined in the `input`. Since we set the `eventUrl` to `/search`, our code routes the request to `searchAction`. The request includes a `dtmf` field which contains the numbers input by the user. We use this input data and randomly generate example data to return to the user, your applications will probably do something much more useful such as fetch information from a database. Here's the action:

```javascript
// src/Menu.php

 searchAction(request)
    {
        if(request.dtmf) {
            const dates = [startOfYesterday(), startOfToday(), lastDayOfWeek(startOfToday())];
            const status = ['shipped', 'backordered', 'pending'];
            const randStatus=Math.floor(Math.random() * status.length);
            const randDates=Math.floor(Math.random() * dates.length);
            this.append({
                'action' : 'talk',
                'text' : `Your order ${this.talkCharacters(request.dtmf)}
                          ${this.talkStatus(status[randStatus])}
                        as  of  ${this.talkDate(dates[randDates])}`
            });
        }

        this.append({
            'action' : 'talk',
            'text' : 'If you are done, hangup at any time. If you would like to search again'
        });

        this.promptSearch();
    }

```

As you can see from the search action, the sample application sends some rather silly data back to the user! There is an NCCO that includes the order number from the incoming `dtmf` data field, a random order status and a random date (today, yesterday or a week ago) as a spoken "update". In your own application, there would probably be some more logical, err, logic.

Once the order information is passed to the user, they are told that they can hang up at anytime. The method that adds the order prompt NCCO is reused. That way the user can search for another order, but does not hear the welcome prompt every time.

