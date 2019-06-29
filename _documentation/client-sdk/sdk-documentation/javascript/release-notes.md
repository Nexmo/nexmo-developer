---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes

## Version 5.3.3 - June 29, 2019

### Fixes

- Change digits to digit in the sendDTMF() request method payload
- Stream is not being terminated on a call transfer
- `member:call` is not being emitted if `media.audio_settings.enabled` is false or doesn't exist

### New

- Set member.callStatus `started` when initialising an IP - IP call
- Set member.callStatus `ringing` when enabling the ringing with `media.startRinging()`

### Internal changes

- Move stream clean up from `member:left` to `rtc:hangup` in Media module

## Version 5.2.1 - June 12, 2019

### New

- Add the new nexmoGetRequest utility method to make a GET network request directly to CS

/**
 * Perform a GET network request directly to CS
 *
 * @param {string} url the request url to CS
 * @param {string} data_type the type of data expected back from the request (events, conversations, users)
 * @param {object} [params] network request params
 * @param {string} [params.cursor] cursor parameter to access the next or previous page of a data set
 * @param {number} [params.page_size] the number of resources returned in a single request list
 * @param {string} [params.order] 'asc' or 'desc' ordering of resources (usually based on creation time)
 * @param {string} [params.event_type] the type of event used to filter event requests ('member:joined', 'audio:dtmf', etc)
 *
 * @returns {Promise<XMLHttpRequest.response>} the XMLHttpRequest.response
 * @static
 * @example <caption>Sending a nexmo GET request</caption>
 */
  nexmoGetRequest(url, data_type, params).then((response) => {
    response.body: {},
    response.cursor: {
        prev: '',
        next: '',
        self: ''
    },
    response.page_size: 10
 });

- Support `reason` for member:delete `conversation.leave`, `member.kick`, `call.hangup` and `call.reject`
- Listen for the `member:left` event with `reason`

//listening for member:left with reason
conversation.on('member:left', (member, event) => {
  console.log(event.body.reason);
});

/**
* Reason object format
*
* @param {object} [reason] the reason for kicking out a member
* @param {string} [reason.code] the code of the reason
* @param {string} [reason.text] the description of the reason
*/

- Add `callStatus` field in the `Member` object, defining the status of a call
- Emit `member:call:status` event each time the `member.callStatus` changes

conversation.on("member:call:status", (member) => {
   console.log(member.callStatus);
});

## Version 5.2.0 - May 30, 2019

### New

- Add the `call` instance in `application.calls` map in `createCall()` function (IP -IP call)

- Update caller parameter in call object in a PSTN - IP call from `unknown` to `channel.from.number` or `channel.from.uri` if exists

- Emit the new `leg:status:update` event each time a member leg status change

```javascript
/**
  * Conversation listening for leg:status:update events.
  *
  * @event Conversation#leg:status:update
  *
  * @property {Member} member - the member whose leg status changed
  * @property {Event} event - leg:status:update event
  * @param {string} event.cid - the conversation id
  * @param {string} event.body.leg_id - the conversation leg id
  * @param {string} event.body.type - the conversation leg type (phone or app)
  * @param {string} event.body.status - the conversation member leg status
  * @param {Array} event.body.statusHistory - array of previous leg statuses
*/
conversation.on("leg:status:update", (member, event) {
  console.log(member, event);
});
```

- Add the the `channel.legs` field in member events offered by CS

```text
conversation.on(<member_event>, (member, event) {
  console.log(event);
  // member_id: <member_id>,
  // conversation_id: <conversation_id>,
  // ...
  // channel: {
  //  to: {
  //    type: app
  //  },
  //  type: app,
  //  leg_ids: [<leg_id>]
  //  legs : [{ leg_id: <leg_id>, status: <leg_status>}],
  //  leg_settings: {},
  // },
  // state: <state>,
  // leg_ids: []
});
```

---

## Version 5.1.0 - May 29, 2019

### New

- Send DTMF event to a conversation

 ```text
  * Send DTMF in a conversation
  *
  * @param {string} digits - the DTMF digit(s) to send
  * @returns {Promise<Event>}
 ```

```javascript
 conversation.media.sendDTMF('digits')
```

- Emit new event `audio:dtmf`

```javascript
conversation.on("audio:dtmf",(from, event)=>{
  event.digit // the dtmf digit(s) received
  event.from //id of the user who sent the dtmf
  event.timestamp //timestamp of the event
  event.cid // conversation id the event was sent to
  event.body // additional context about the dtmf
});
```

- Set customized audio constraints for IP calls when enabling audio

```javascript
 conversation.media.enable({
    'audioConstraints': audioConstraints
 })
```

```text
  * Replaces the stream's audio tracks currently being used as the sender's sources with a new one with new audio constraints
  * @param {object} constraints - audio constraints
  * @returns {Promise<MediaStream>} - Returns the new stream with the updated audio constraints.
  * @example
  * conversation.media.updateAudioConstraints({'autoGainControl': true})
  **/
```

- Update audio constraints for existing audio tracks

```javascript
  conversation.media.updateAudioConstraints(audioConstraints)
 })
```

### Fixes

- Remove 'this' passed to cache worker event handler

### Internal breaking changes

- Change the media audio parameter from `media.audio` to `media.audio_settings` in `inviteWithAudio` function

---

## Version 5.0.3 - May 23, 2019

### Changes

- Change default behaviour of `autoPlayAudio` in `media.enable()` from false to true
- Pass an `autoPlayAudio` parameter to `call.createCall()` and `call.answer()` functions (default is true)

---

## Version 5.0.2 - May 30, 2019

### New

- Delete the image files before sending the `image:delete` request
- Attach of audio stream can now be chosen if it will be automatically on or off through `media.enable()`

```javascript
media.enable({
  autoPlayAudio: true | false
})
```

### Changes (internally)

- Combine the network GET, POST and DELETE requests in one generic function

---

## Version 5.0.1 - April 30, 2019

### Fixes

- Clean up user's media before leaving from an ongoing conversation

### Breaking changes

- Change `application.conversations` type from `Object` to `Map`

---

## Version 4.1.0 - April 26, 2019

### Fixes

- Fixed the bug where the audio stream resolved in media.enable() is causing echo and was not the remote stream
- Resolve the remote stream `pc.ontrack()` and not the `localStream` from getUserMedia

### Changes

- Rename `localStream` to `stream` in `media.rtcObjects` object.

---

## Version 4.0.2 - April 17, 2019

### Changes

- Removed `media.rtcNewPromises`

### New

- Internal lib dependencies update
- Added suport for Bugsnag error monitoring and reporting tool

```text
 * @class ConversationClient
 *
 * @param {object} param.log_reporter configure log reports for bugsnag tool
 * @param {Boolean} param.log_reporter.enabled=false
 * @param {string} param.log_reporter.bugsnag_key your bugsnag api key / defaults to Nexmo api key
 ```

- Updated vscode settings to add empty line (if none) at end of every file upon save
- Disable the ice candidates trickling in ice connection
- Wait until most of the candidates to be gathered both for the local and remote side
- Added new private function `editSDPOrder(offer, answer)` in `rtc_helper.js` to reorder the answer SDP when it's needed
- For rtc connection fail state
  - Disable leg
  - emit new event `media:connection:fail`

```javascript
member.on("media:connection:fail",(connection_details)=>{
  connection_details.rtc_id // my member's call id / leg id
  connection_details.remote_member_id // the id of the Member the stream belongs to
  connection_details.connection_event: // the connection fail event
  connection_details.type // the type of the connection (video or screenshare)
  connection_details.streamIndex // the streamIndex of the specific stream
});
```

```text
* @event Member#media:connection:fail
*
* @property {number} payload.rtc_id the rtc_id / leg_id
* @property {string} payload.remote_member_id the id of the Member the stream belongs to
* @property {event} payload.connection_event the connection fail event
 ```

- Add new LICENCE file

### Breaking changes (internally)

- Deprecating ice trickling logic with `onicecandidate` event handler
- Change the format of `member:media` event to the new one offered by CS

```text
type: 'member:media',
  from: member.member_id,
  conversation_id: member.conversation_id,
  body: {
    media: member.media,
    channel: member.channel
  }
```

- Change the format of `member:invited` event to the new offered by CS

```text
type: 'member:invited',
  body: {
    media: {
      audio_settings: {
        enabled: false,
        earmuffed: false,
        muted: false
      }
    }
  }
```

---

## Version 4.0.1 - March 4, 2019

### New

- Select the sync level for the login process
  - `full`: trigger full sync to include conversations and events
  - `lite`: trigger partial sync, only conversation objects (empty of events)
  - `none`: don't sync anything

  if the Cache module is enabled the manual fetch of a conversation will store them in internal storage

  usage:

  ```javascript
  new ConverationClient({'sync':'full'});
  ```

### Fixes

- `rtcstats:report` was duplicating instances in each call
- remove `screenshare` https restriction

### Breaking changes (internally)

- Deprecating `application.activeStream`, now it's part of `application.activeStreams`
- Removed the restriction to allow calling `media.enable()` while a stream is active

---

## Version 4.0.0 - February 1, 2019

### Breaking Changes

- rename SDK `stitch` to `client`
- listening for `media:stream:*` now gives `streamIndex` instead of `index` for consistency with the internal rtcObjects

```text
 * @event Member#media:stream:on
 *
 * @property {number} payload.streamIndex the index number of this stream
 * @property {number} [payload.rtc_id] the rtc_id / leg_id
 * @property {string} [payload.remote_member_id] the id of the Member the stream belongs to
 * @property {string} [payload.name] the stream's display name
 * @property {MediaStream} payload.stream the stream that is activated
 * @property {boolean} [payload.video_mute] if the video is hidden
 * @property {boolean} [payload.audio_mute] if the audio is muted
 ```

### New

- Screen Share Source ID can now be specified when invoking `media.enable()`
