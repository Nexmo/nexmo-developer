---
language: httpie
---

##### Install HTTPie

To install with [homebrew](https://brew.sh) on MacOS:

```sh
$ brew install httpie
```

Alternatively follow [Linux](https://github.com/jakubroztocil/httpie#id5) or [Windows](https://github.com/jakubroztocil/httpie#id6) installation instructions.

§

##### Generate a JWT

We'll use this `$JWT` variable in our HTTPie commands.

```sh
JWT="$(
  nexmo jwt:generate ./private.key \
  application_id=APPLICATION_ID
)"
```
