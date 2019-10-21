```javascript
new NexmoClient()
    .login(USER_JWT)
    .then(application => {
        ...
        application.on("member:call", (member, call) => {
          notification.textContent = `You're receiving a call`;
          ...
          document.getElementById("hangup").addEventListener("click", () => {
            call.hangUp();
            notification.textContent = "The call has ended";
          })
        })
    })
    .catch(console.log);

```
