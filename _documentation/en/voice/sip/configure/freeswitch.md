---
title: FreeSWITCH
description: How to setup Nexmo SIP with FreeSWITCH
---

# FreeSWITCH

Below we provide example configurations for using Nexmo's SIP service with [FreeSWITCH](http://www.freeswitch.org).

## Inbound configuration

Modify `autoload_configs/acl.conf.xml` and allow traffic from Nexmo's IP addresses:

```xml
<list name="nexmo" default="deny">
  <node type="allow" cidr="5.10.112.121/32"/>
  <node type="allow" cidr="5.10.112.122/32"/>
  <node type="allow" cidr="119.81.44.6/32"/>
  <node type="allow" cidr="119.81.44.7/32"/>
  <node type="allow" cidr="169.60.141.29/32"/>
  <node type="allow" cidr="169.60.141.30/32"/>
</list>
```

Add the following to `sip_profiles/internal.xml`:

```xml
<param name="apply-inbound-acl" value="nexmo"/>
```

Create a public dial plan for Nexmo in `dialplan/public/nexmo_sip.xml`:

```xml
    <include>
      <extension name="nexmo_sip">
        <condition field="destination_number" expression="^(\d+)$">
          <action application="set" data="domain_name=$${domain}"/>
          <action application="transfer" data="1000 XML default"/>
        </condition>
      </extension>
    </include>
```

If you want to match a specific number from request URI, modify the expression:

````
(\d+)
````

> *Note*: this forwards incoming calls to registered extension 1000

## Outbound configuration

To configure FreeSWITCH you need to:

Create an external profile:

```xml
<include>
   <gateway name="nexmo">
     <param name="proxy" value="sip.nexmo.com"/>
     <param name="register" value="true"/>
     <param name="caller-id-in-from" value="false"/>
     <param name="from-user" value="<long_virtual_number>"/>
     <param name="username" value="<key>"/>
     <param name="password" value="<secret>"/>
   </gateway>
  </include>
```

Make a dial plan:

```xml
<include>
  <extension name="international.mycompany.com">
    <condition field="destination_number" expression="^(00\d+)$">
      <action application="set" data="effective_caller_id_number=${outbound_caller_id_number}"/>
      <action application="set" data="effective_caller_id_name=${outbound_caller_id_name}"/>
      <action application="bridge" data="{origination_caller_id_name=<CALLER_ID>}sofia/gateway/nexmo/$1"/>
    </condition>
  </extension>
</include>
```
