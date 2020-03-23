## Generate a JWT

> **TIP:** You only need to do this step if you are testing with Curl, as the client libraries generate JWTs as needed for you.

Once you have created a Nexmo Application you can use the Nexmo Application ID and the private key file, `private.key`, to generate a JWT.

> **TIP:** If you are using the [client library](/messages/code-snippets/client-library) for Node (or other languages when supported), the dynamic creation of JWTs is done for you.

If you're using the Nexmo CLI, the command to create the JWT is:

``` shell
JWT="$(nexmo jwt:generate private.key exp=$(($(date +%s)+86400)) application_id=NEXMO_APPLICATION_ID)"
```

This JWT will be valid for one day. After that, you will need to generate a new one.

You can then view the JWT with:

``` shell
echo $JWT
```

Alternatively, you can use our [JWT web app](/jwt) to generate a JWT.

> **TIP:** You can test your generated JWT at [jwt.io](https://jwt.io)
