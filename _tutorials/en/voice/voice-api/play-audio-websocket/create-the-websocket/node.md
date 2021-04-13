---
title: Create the WebSocket
description: Handle WebSocket connections
---

# Create the WebSocket

First, handle the `connection` event so that you can report when your webhook server is online and ready to receive the call audio:

```javascript
expressWs.getWss().on('connection', function (ws) {
  console.log('Websocket connection is open');
});
```

When writing audio to a Voice API WebSocket, the audio is expected in a [specific format](https://developer.nexmo.com/voice/voice-api/guides/websockets#writing-audio-to-the-websocket). To do this, you will need a function that separates the binary audio data into arrays of the correct size:

```javascript
function chunkArray(array, chunkSize) {
    var chunkedArray = [];
    for (var i = 0; i < array.length; i += chunkSize)
        chunkedArray.push(array.slice(i, i + chunkSize));
    return chunkedArray;
}
```

Then, create a route handler for the `/socket` route. When the WebSocket is connected this route will get called:

```javascript
app.ws('/socket', (ws, req) => {
    const wav = new WaveFile(fs.readFileSync("./sound.wav"));
    wav.toSampleRate(16000);
    wav.toBitDepth("16");

    const samples = chunkArray(wav.getSamples()[0], 320);
    for (var index = 0; index < samples.length; ++index) {
        ws.send(Uint16Array.from(samples[index]).buffer);
    }
})
```

The route loads an audio file from disk, you can download the same one from [GitHub](https://github.com/nexmo-community/voice-api-web-socket-audio/raw/main/sound.wav), uses the WaveFile library to change the sample rate and bit depth for the Voice API. Next it gets the audio samples from the first channel of audio, and uses the function from earlier to change the size of the binary audio data array. Finally the binary audio data is iterated over and sent to the call via the WebSocket with the `send()` function.

> **NOTE:** [Vonage will only buffer 1024 messages](https://developer.vonage.com/voice/voice-api/guides/websockets#writing-audio-to-the-websocket) which should be enough for around 20 seconds of audio, if your file is longer than this you should implement a delay of 18-19ms between each message.