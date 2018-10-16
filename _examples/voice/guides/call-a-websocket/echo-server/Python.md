---
title: Python
language: python
---

```python
#!/usr/bin/env python
import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web

class WSHandler(tornado.websocket.WebSocketHandler):
    connections = []
    def open(self):
        print("client connected")
        # Add the connection to the list of connections
        self.connections.append(self)
    def on_message(self, message):
        #Check if message is Binary or Text
        if type(message) == str:
            print("Binary Message received")
            # Echo the binary message back to where it came from
            self.write_message(message, binary=True)
        else:
            print(message)
            #Send back a simple "OK"
            self.write_message('ok')
    def on_close(self):
        # Remove the connection from the list of connections
        self.connections.remove(self)
        print("client disconnected")

class NCCOHandler(tornado.web.RequestHandler):
    def get(self):
        with open("ncco.json", 'r') as f:
            ncco = f.read()
        self.write(ncco)
        self.set_header("Content-Type", 'application/json')
        self.finish()

application = tornado.web.Application([(r'/socket', WSHandler),
                                        (r'/ncco', NCCOHandler)])
if __name__ == "__main__":
    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(8000)
    tornado.ioloop.IOLoop.instance().start()
```

Tornado is a Python web framework and asynchronous networking library. It is ideal for long polling, WebSockets, and other applications that require a long-lived connection to each user. To install it, call: `pip install tornado`

Run your application:

```
python echo_server.py
```
