---
title: Building a Web Service to Send SMS
description: Build a HTTP service and then test it with Postman.
---

# Building a Web Service to Send SMS

This tutorial will show you how to build a tiny HTTP service and then test it with Postman. 

Open your `build.gradle` and add the following to the top:

```
apply plugin: 'war'
apply from: 'https://raw.github.com/akhikhl/gretty/master/pluginScripts/gretty.plugin'
```

The first line tells Gradle it should build a war file, using source files in `src/main/java` and `src/main/webapp`. The second line adds the ability to fire up your web app straight from Gradle using the Jetty servlet container.

Run `gradle appRun` now. Note that you use `appRun` and not `run` to run the web server. It will take a while the first time, while it downloads some dependencies.

Eventually, you should see something like this:

```
11:11:59 INFO  Jetty 9.2.15.v20160210 started and listening on port 8080
11:11:59 INFO  project runs at:
11:11:59 INFO    http://localhost:8080/project
Press any key to stop the server.
<===========--> 87% EXECUTING
> :appRun
```

This means Jetty is now running your (empty) web service. Fire up the URL you see, to check it’s running OK. It should look a bit like this:

![Empty web service launched by Jetty](https://www.nexmo.com/wp-content/uploads/2017/04/empty-web.png)

Create a file called `src/main/java/getstarted/SendSMSServlet.java`. It’s going to look similar to the last class:

```
public class SendSMSServlet extends HttpServlet {
    private String FROM_NUMBER;
    private NexmoClient client;
 
    public void init(ServletConfig config) {
        // Load configuration from the servlet container:
        FROM_NUMBER = config.getInitParameter("from_number");
        String api_key = config.getInitParameter("api_key");
        String api_secret = config.getInitParameter("api_secret");
 
        client = new NexmoClient(new TokenAuthMethod(api_key, api_secret));
    }
 
    protected void doPost(HttpServletRequest req,
                      HttpServletResponse resp)
               throws ServletException,
                      java.io.IOException {
        try {
            // Extract form parameters from the request:
            String to_number = req.getParameter("to");
            String message = req.getParameter("message");
 
            SmsSubmissionResult[] responses = client.getSmsClient().submitMessage(
                new TextMessage(FROM_NUMBER, to_number, message));
            for (SmsSubmissionResult response : responses) {
                resp.getWriter().println(response);
            }
        } catch (NexmoClientException nce) {
            throw new ServletException(nce);
        }
    }
}
```

Configure the servlet in our servlet container by creating the following at `src/main/webapp/WEB-INF/web.xml`:

```
<web-app>
    <servlet>
        <servlet-name>send-sms</servlet-name>
        <servlet-class>getstarted.SendSMSServlet</servlet-class>
        <init-param>
            <param-name>from_number</param-name>
            <param-value>YOUR_NEXMO_NUMBER</param-value>
        </init-param>
        <init-param>
            <param-name>api_key</param-name>
            <param-value>YOUR_API_KEY</param-value>
        </init-param>
        <init-param>
            <param-name>api_secret</param-name>
            <param-value>YOUR_API_SECRET</param-value>
        </init-param>
    </servlet>
    <servlet-mapping>
        <servlet-name>send-sms</servlet-name>
        <url-pattern>/*</url-pattern>
    </servlet-mapping>
</web-app>
```

Replace the placeholders with your own values, and then run `gradle appRun`. If everything builds correctly, let’s fire up [Postman](https://www.getpostman.com/) and make a POST request, like this:

![Postman POST request](https://www.nexmo.com/wp-content/uploads/2017/04/postman-request.png)