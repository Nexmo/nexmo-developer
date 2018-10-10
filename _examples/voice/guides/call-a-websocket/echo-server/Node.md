---
title: Node.js
language: node
---

```javascript
var WebSocketServer = require('websocket').server;

var http = require('http');
var HttpDispatcher = require('httpdispatcher');
var dispatcher     = new HttpDispatcher();
const fs = require('fs');

//Create a server
var server = http.createServer(handleRequest);

var wsServer = new WebSocketServer({
    httpServer: server,
    autoAcceptConnections: true,

});

//Lets use our dispatcher
function handleRequest(request, response){
    try {
        //log the request on console
        console.log(request.url);
        //Dispatch
        dispatcher.dispatch(request, response);
    } catch(err) {
        console.log(err);
    }
}

// Serve the ncco
dispatcher.onGet("/ncco", function(req, res) {
    fs.readFile('./ncco.json', function(error, data) {
       res.writeHead(200, { 'Content-Type': 'application/json' });
       res.end(data, 'utf-8');
    });
});

wsServer.on('connect', function(connection) {
    console.log((new Date()) + ' Connection accepted' + ' - Protocol Version ' + connection.webSocketVersion);
    connection.on('message', function(message) {
        if (message.type === 'utf8') {
            // Reflect the message back
            console.log(message.utf8Data);
        }
        else if (message.type === 'binary') {
            console.log("Binary Message Received");
            // Reflect the message back
            connection.sendBytes(message.binaryData);
        }
    });
    connection.on('close', function(reasonCode, description) {
        console.log((new Date()) + ' Peer ' + connection.remoteAddress + ' disconnected.');
    });
});

//Lets start our server
server.listen(8000, function(){
    //Callback triggered when server is successfully listening. Hurray!
    console.log("Server listening on: http://localhost:%s", 8000);
});
```

To run this code sample you need to install the following dependencies:

```
npm install http websocket httpdispatcher
```

Run your application:

```
node echo_server.js
```
