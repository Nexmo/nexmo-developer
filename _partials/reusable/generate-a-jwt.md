## Generate a JWT

Once you have created a Nexmo Application you can use the Nexmo Application ID and the private key file, `private.key`, to generate a JWT.

> **TIP:** If you are using the [client library](/messages/concepts/client-library) for Node (or other languages when supported), the dynamic creation of JWTs is done for you.

If you're using the Nexmo CLI, the command to create the JWT is:

``` bash
$ JWT="$(nexmo jwt:generate private.key exp=$(($(date +%s)+86400)) application_id=NEXMO_APPLICATION_ID)"
```

This JWT will be valid for one day. After that, you will need to generate a new one.

You can then view the JWT with:

``` bash
$ echo $JWT
```

> **TIP:** You can test your JWT at [jwt.io](https://jwt.io)
