### Usage

* Run `composer install`
* Start the web server `php -t . -S 127.0.0.1:3000`
* Test your code with the following `curl` requests:
    - `GET` + Query
        ```sh
        curl "http://127.0.0.1:3000/webhooks/answer?from=447700900000"
        ```
    - `POST` + Query
        ```sh
        curl -X "POST" "http://127.0.0.1:3000/webhooks/answer?from=447700900000"
        ```
    - `POST` + JSON
        ```sh
        curl -X "POST" "http://127.0.0.1:3000/webhooks/answer" \
        -H 'Content-Type: application/json; charset=utf-8' \
        -d $'{ "from": "447700900000" }'
        ```
