---
title: Create the project
description: Create the project and install your dependencies
---

# Create the project

Make a directory for your application, `cd` into the directory and then use the Node.js package manager `npm` to create a `package.json` file for your application's dependencies:

```sh
$ mkdir myapp
$ cd myapp
$ npm init
```

Press [Enter] to accept each of the defaults.

Then, install the [express](https://expressjs.com) web application framework, [express-ws](https://www.npmjs.com/package/express-ws) and [WaveFile](https://www.npmjs.com/package/wavefile) packages:

```sh
$ npm install express express-ws wavefile
```
