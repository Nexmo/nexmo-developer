---
title: Handle the Form Post
description: Accept the POST request from the form and send an SMS.
---

# Handle the Form Post

Add the following function to the bottom of your python file, to accept the POST request from the form:

```
@app.route('/send_sms', methods=['POST'])
def send_sms():
    """ A POST endpoint that sends an SMS. """
 
    # Extract the form values:
    to_number = request.form['to_number']
    message = request.form['message']
 
    # Send the SMS message:
    result = nexmo_client.send_message({
        'from': VONAGE_NUMBER,
        'to': to_number,
        'text': message,
    })
 
    # Redirect the user back to the form:
    return redirect(url_for('index'))
```

If your `FLASK_DEBUG` flag is set to true, then your changes should automatically be reloaded into the running server. Refresh your form, fill in your phone number and a message. Make sure the number is in international format without the '+' at the start. Hit "Send SMS" and check your phone.

If the application did not work, check out the extra lines in the [sample code](https://github.com/Nexmo/nexmo-python-code-snippets/blob/master/sms/send-an-sms.py) in `server.py` and `index.html` that use Flask’s flash message mechanism to report errors to the user.