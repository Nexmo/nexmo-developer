## Generate a JWT

Once you have created a Nexmo Application you can use the Nexmo Application ID and   downloaded or locally created the private key file, `private.key`, to generate a JWT.

> **TIP:** If you are using the client library for Node (or other languages when supported), the dynamic creation of JWTs is done for you.

If you're using the Nexmo CLI the command to create the JWT is:

``` curl
$ JWT="$(nexmo jwt:generate /path/to/private.key exp=$(($(date +%s)+86400)) \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

This JWT will be valid for one day. After that, you will need to generate a new one.

> **TIP:** In production systems, it is advisable to generate a JWT dynamically for each request.

