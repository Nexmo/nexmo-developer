---
title: SMPP access
description: Using SMPP instead of REST to access the SMS API.
navigation_weight: 7
---

# SMPP Access

> This concept document describes using SMPP instead of REST to access Nexmo's APIs. Implementing SMPP access requires a deep understanding of this complex telecommunications protocol and a lot of low-level development work. Most developers can safely ignore this information.

By default, your account is configured to use Nexmo's REST APIs over HTTPS. Unless your organization is an aggregator with an existing SMPP implementation, the information in this guide will probably be irrelevant to you.

## Contents
This document covers the following:

- [What is SMPP?](#what-is-smpp)
- [Should I use SMPP to connect to the Nexmo platform?](#should-i-use-smpp-to-connect-to-the-nexmo-platform)
- [Why does Nexmo offer SMPP access?](#why-does-nexmo-offer-smpp-access)
- [Configuring SMPP access](#configuring-smpp-access)
- [Our SMPP instances](#our-smpp-instances)
- [Resources](#resources)

## What is SMPP?

[Short Message Peer-to-Peer (SMPP)](https://en.wikipedia.org/wiki/Short_Message_Peer-to-Peer) is a protocol that the telecommunications industry uses to exchange SMS messages between Short Message Service Centers (SMSC) and/or External Short Messaging Entities (ESME).

SMPP is a [level-7 TCP/IP protocol](https://en.wikipedia.org/wiki/OSI_model#Layer_7:_Application_Layer), which enables fast delivery of SMS messages. It is widely used for short message exchange outside SS7 networks because of its support for non-GSM SMS protocols such as [UMTS](https://en.wikipedia.org/wiki/UMTS) and [CDMA](https://en.wikipedia.org/wiki/Code-division_multiple_access).

Nexmo uses SMPP to connect to multiple carriers worldwide. Because SMPP is a standard, we expect any new carriers we onboard to provide standard means of connectivity. If they do, we can integrate them them with relative ease.

## Should I use SMPP to connect to the Nexmo platform?

Nexmo does **not** encourage SMPP access for the following reasons:

- SMPP is a very complex telecommunications protocol. You must be a domain expert to use it properly.
- Implementation requires a lot of low-level development work, unlike our REST APIs.
- Nexmo does **not** offer global high availability or disaster recovery over SMPP. This is due to the design of the protocol, which requires you to establish a bind between a client and a server before you can exchange messages. If one of Nexmo's SMPP instances fails, any customers using that instance must be either:
    - Be already bound to another instance and reroute traffic
    - Identify that they are no longer bound to an instance and seek to bind with another instance

## Why does Nexmo offer SMPP access?

Nexmo offers this service to integrate new carriers and make it easier for customers with an existing SMPP implementation to use our platform.

Instead of having to re-implement messaging over our REST APIs, you can simply modify your existing integration to establish a bind with Nexmo's SMPP clusters. 

## Configuring SMPP access

You can configure SMPP access to the Nexmo platform by using one of the following methods:

### Standard configuration

1. Read the [SMPP FAQ](https://help.nexmo.com/hc/en-us/sections/200621223), which contains details about character encoding, DLR formats, concatenated messages, throttle management and other important information.
2. [Email us](mailto:smpp@nexmo.com) your monthly volume forecast. We will configure our system to enable SMPP access for you and send you a confirmation email with links to further resources.

### Using Kannel

You can use [Kannel](http://www.kannel.org) version 1.4.3 or higher to configure SMPP access:

1. Complete the [standard configuration](#standard-configuration) steps.

2. Download the `kannel.conf` [configuration file](https://help.nexmo.com/hc/en-us/article_attachments/115016988548/kannel.conf).

3. Edit `kannel.conf` to replace `$nexmo_user` and `$nexmo_password` with your Nexmo SMPP credentials.

4. For security reasons `kannel.conf` only allows access from `localhost`. To enable access from a different machine, edit the following parameters in `kannel.conf`. For example, for the IP addresses `X.X.X.X` and `Y.Y.Y.Y`:

    ```
    admin-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
    ...
    box-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
    ...
    user-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
    ```

5. Restart Kannel.

6. Send a test message. For example:

    ```
    https://localhost:13013/cgi-bin/sendsms?username=username&password=pwd&to=%2B33XXXXXXX&text=Hello%20World&from=test&charset=ISO-8859-1&dlr-mask=17
    ```

## Our SMPP instances

Nexmo hosts three instances of SMPP:

- `SMPP1/2` - clustered
- `SMPP0` - not clustered

We recommend that you bind to both `SMPP1` and `SMPP2`. Only bind to `SMPP0` if you cannot bind to a clustered setup.

The standalone instance `SMPP0` is for aggregators running legacy infrastructure who cannot maintain simultaneous binds to multiple IP addresses. If you are binding to `SMPP0`, you must implement SMPP redundancy to avoid a higher risk of planned and unplanned downtime.

## Resources

- [SMS Protocol Specification v3.4](http://docs.nimta.com/SMPP_v3_4_Issue1_2.pdf)
- [Nexmo's SMPP FAQ](https://help.nexmo.com/hc/en-us/sections/200621223)
- [Nexmo's SMPP server](https://help.nexmo.com/hc/en-us/articles/204015693)
- [SMPP error codes](https://help.nexmo.com/hc/en-us/articles/204015763-SMPP-Error-Codes)
- [Sending concatenated messages via SMPP](https://help.nexmo.com/hc/en-us/articles/204015653-Sending-Concatenated-Messages-via-SMPP)
- [SMPP DLR format and error codes](https://help.nexmo.com/hc/en-us/articles/204015663)
- [Troubleshooting SMPP DLRs](https://help.nexmo.com/hc/en-us/articles/204015803-Not-receiving-Delivery-Receipts-for-SMPP-what-should-I-do-)

