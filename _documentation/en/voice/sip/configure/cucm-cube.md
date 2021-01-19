---
title: Cisco CUCM/CUBE
description: How to set up Vonage SIP with Cisco CUCM/CUBE
---

# Nexmo SIP Trunking Configuration Guide 

## `CUCM 11.5.1.12900` With `CUBE 16.05.01b`

### May 2017

## Contents

1. Introduction
2. SIP Trunking Network Components
   * 2.1 Hardware Components
   * 2.2 Software Requirements
3. Features
      * 3.1.1 Features Supported
      * 3.1.2 Features Not Supported by PBX
      * 3.1.3 Caveats and Limitations
4. Configuration.
   * 4.1 IP Address Worksheet
   * 4.2 Configuring Cisco Unified Communications manager
      * 4.2.1 Cisco UC Version
      * 4.2.2 Cisco Unified Call manager Service Parameters
      * 4.2.3 Off-Net Calls via Nexmo SIP Trunk
      * 4.2.4 Dial Plan
   * 4.3 Configuring Cisco Unified Border Element
      * 4.3.1 Network Interface
      * 4.3.2 Global Cisco UBE Settings
      * 4.3.3 Codecs
      * 4.3.4 Dial Peer.
      * 4.3.5 Configuration Example
   * 4.4 Configure Numbers in Nexmo Account


## 1. Introduction

This document is intended for Nexmo SIP trunk customer’s technical staff and Value Added
Retailer (VAR) having installation and operational responsibilities. This configuration guide
provides steps for configuring Cisco Unified Communications Manager (Cisco UCM)
`11.5.1.12900-21` and Cisco Unified Boarder Element (Cisco UBE) `16.05.01b` to Nexmo SIP
Trunking services.

## 2. SIP Trunking Network Components

The network for the SIP trunk reference configuration is illustrated below and is representative of
a Cisco UCM and Cisco UBE configuration to Nexmo SIP trunking.

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-1.png
```

### 2.1 Hardware Components

* Cisco `UCS-C240-M3S` VMWare host running ESXi 5.5.0 Standard
* Cisco ISR4321/K9 router as CUBE
* Cisco ISR4321/K9 (1RU) processor with 1684579K/6147K bytes of memory with 3
Gigabit Ethernet interfaces
* Processor board ID FLM1925W0X
* IP Phones 7942(SCCP), 7841(SIP)

### 2.2 Software Requirements

* Cisco Unified Communications Manager 11.5.1.12900-
* Cisco Unity Connection 11.5.1.12900-
* IOS `16.05.01b` for ISR4321/K9 Cisco Unified Border Element
* Cisco IOS Software [Everest], ISR Software (`X86_64_LINUX_IOSD-UNIVERSALK9-M`),
Version `16.5.1b`, RELEASE SOFTWARE (`fc1`)
* Cisco IOS XE Software, Version `16.05.01b`

## 3. Features

#### 3.1.1 Features Supported

* Incoming and outgoing off-net calls using G711ULAW & G711ALAW voice codecs
* Calling Line (number) Identification Presentation
* Calling Line (number) Identification Restriction
* Call hold and resume
* Call transfer (unattended and attended )
* Call Conference
* Call forward (all, no answer)
* DTMF relay both directions (RFC2833)
* Media flow-through on Cisco UBE

#### 3.1.2 Features Not Supported by PBX

* None

#### 3.1.3 Caveats and Limitations

* Caller ID is not updated after attended or semi-attended transfers to off-net phones. This
is due to a limitation on Cisco UBE. The issue does not impact the calls.

## 4. Configuration.

### 4.1 IP Address Worksheet

The specific values listed in the table below and in subsequent sections are used in the lab
configuration described in this document, and are for **illustrative purposes only**. The customer
must obtain and use the values for your deployment.

| Component          | Lab Value          | Customer Value        |
| ------------------ | -------------------|-----------------------|
| **Cisco UBE**                                                   |
| LAN IP Address     | `10.80.11.15`      |                       |
| LAN Subnet Mask    | `255.255.255.0`    |                       |
| WAN IP Address     | `192.65.79.XXX`    |                       |
| WAN Subnet Mask    | `255.255.255.128`  |                       |
| **Cisco UCM IP PBX**                                            |
| System IP Address  | `10.80.11.2`       |                       |


### 4.2 Configuring Cisco Unified Communications Manager

#### 4.2.1 Cisco UC Version

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-2.png
```

#### 4.2.2 Cisco Unified Call Manager Service Parameters.

Navigation: System &rarr; Service Parameters

1. Select **Server** : `clus21pub--CUCM` Voice/Video (Active)
2. Select **Service** : Cisco Call Manager (Active)
3. All other fields are set to default values

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-3.png
```

#### 4.2.3 Off-Net Calls via Nexmo SIP Trunk

Off-net calls are served by SIP trunks configured between Cisco UCM and Nexmo Network and
calls are routed via Cisco UBE. From Cisco UBE, we have pointed the trunk to sip.nexmo.com
and opened the firewall for the list of IP addresses in the portal provided by Nexmo.

**4.2.3.1 SIP Trunk Security Profile**

Navigation: System &rarr; Security &rarr; SIP Trunk Security Profile

1. Set **Name** : _Non Secure SIP Trunk Profile_ is used as an example
2. Set **Outgoing Transport Type** : UDP in this example
3. SIP trunks to Nexmo should use UDP as a transport protocol for SIP. This is configured
    using SIP Trunk Security profile, which is later assigned to the SIP trunk itself.

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-4.png
```

**4.2.3.2 SIP Profile Configuration**

Navigation: Device &rarr; Device Settings &rarr; SIP Profile

1. Set **Name** : _Standard SIP Profile_ is used as an example

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-5.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-6.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-7.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-8.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-9.png
```

**4.2.3.3 SIP Trunk Configuration**

Create SIP trunk to Cisco UBE

Navigation : Device &rarr; Trunk

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-10.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-11.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-12.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-13.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-14.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-15.png
```

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-16.png
```

#### 4.2.4 Dial Plan

**Navigation** : Call Routing &rarr; Route/Hunt &rarr; Route Pattern


Route patterns are configured as below:

&nbsp; Cisco IP phone dial "8"+11 digit number to access PSTN via Cisco UBE. "8" is removed
before sending to Cisco UBE.

```screenshot
image: public/screenshots/sip/configuration/guides/cisco-cucm/cisco-cucm-17.png
```

### 4.3 Configuring Cisco Unified Border Element

#### 4.3.1 Network Interface

Configure Ethernet IP address and sub interface. The IP address and VLAN encapsulation used
are for illustration only, the actual IP address can vary. For SIP trunks two IP addresses must be
configured—LAN and WAN.

```
interface GigabitEthernet0/0/
ip address 192.65.79.XXX 255.255.255.
negotiation auto
interface GigabitEthernet0/0/
ip address 10.80.11.15 255.255.255.
negotiation auto
```

#### 4.3.2 Global Cisco UBE Settings

In order to enable Cisco UBE IP2IP gateway functionality, enter the following:

```
voice service voip
ip address trusted list
ipv4 173.193.199.
ipv4 174.37.245.
ipv4 5.10.112.
ipv4 5.10.112.
ipv4 119.81.44.
ipv4 119.81.44.

address-hiding
mode border-element license capacity 20
allow-connections sip to sip
sip
session refresh
asserted-id pai
early-offer forced
midcall-signaling passthru
g729 annexb-all
```

#### 4.3.3 Codecs

`G711ulaw` and `G711alaw` voice codecs are used for this testing. Codec preferences used to
change according to the test plan description

```
voice class codec 1
codec preference 1 g711ulaw
codec preference 2 g711alaw
```

#### 4.3.4 Dial Peer.

Cisco UBE uses dial-peer to route the call based on the digit to route the call accordingly.

```
dial-peer voice 1 voip
description incoming dial-peer from CUCM to CUBE
session protocol sipv
session transport udp
incoming called-number .T
voice-class codec 1
dtmf-relay rtp-nte
no vad
dial-peer voice 2 voip
description outgoing dial-peer from CUBE to CUCM
destination-pattern 120
session protocol sipv
session target ipv4:10.80.11.
session transport udp
voice-class codec 1
voice-class sip options-keepalive


dtmf-relay rtp-nte
no vad
dial-peer voice 3 voip
description incoming dial-peer from NEXMO to CUBE
session protocol sipv
session transport udp
incoming called-number 120
voice-class codec 1
dtmf-relay rtp-nte
no vad
dial-peer voice 4 voip
description outgoing dial-peer from CUBE to NEXMO
destination-pattern .T
session protocol sipv
session target sip-server
session transport udp
voice-class codec 1
voice-class sip asserted-id pai
voice-class sip options-keepalive
dtmf-relay rtp-nte
no vad
```

#### 4.3.5 Configuration Example

User Access Verification

```
Username: cisco
Password:
nexmo#
nexmo#sh run
Building configuration.
Current configuration : 5992 bytes
version 16.
service timestamps debug datetime msec
service timestamps log datetime msec
service password-encryption
platform qfp utilization monitor load 80
no platform punt-keepalive disable-kernel-core
hostname nexmo
boot-start-marker


boot system flash isr4300-universalk9.16.05.01b.SPA.bin
boot-end-marker
vrf definition Mgmt-intf

address-family ipv
exit-address-family
address-family ipv
exit-address-family
enable secret 5
no aaa new-model
ip name-server 8.8.8.
subscriber templating
multilink bundle-name authenticated
crypto pki trustpoint TP-self-signed-
enrollment selfsigned
subject-name cn=IOS-Self-Signed-Certificate-
revocation-check none
rsakeypair TP-self-signed-
crypto pki certificate chain TP-self-signed-
certificate self-signed 01
30820330 30820218 A0030201 02020101 300D0609 2A864886 F70D0101 05050030
31312F30 2D060355 04031326 494F532D 53656C66 2D536967 6E65642D 43657274
69666963 6174652D 31303137 30353737 3439301E 170D3137 30353130 31353233
34315A17 0D323030 31303130 30303030 305A3031 312F302D 06035504 03132649
4F532D53 656C662D 5369676E 65642D43 65727469 66696361 74652D31 30313730
35373734 39308201 22300D06 092A8648 86F70D01 01010500 0382010F 00308201
0A028201 0100BF99 0B3B8C33 835DC696 011A6384 ACF8B705 E34D0B17 9BF7A
BAB68AED 970A3529 C4780464 92AD7408 96C38292 F286685A 0C3A285C 614EC7A
E0D3F7B3 D38037E0 C828DBB8 F08F5474 8A453D68 D3FAAB83 004BA2F3 55201661
1E4F6DBD 9C0771B4 E8EF4B08 C70CDAD1 8C5F8B00 3C07FEC2 375FE2E3 73BD4F
FD1B4F88 D6D19FAB C23069E0 F91E6099 FB7B00D4 0D7D5419 F5570F93 EFBB5C
EE86DC0B 72043F04 C7F2B07E 0E681425 705762BF 8B7A0360 25C1077A 2A2BC17A
68F75A15 7E2439F7 770D90F1 0E8C00F3 65AA0D65 6B891C32 BA19C16E 3B
4A296DB1 8E3E7AD3 694A03AF FA3B5051 D1762F4E 26CBCF74 57DEA2B8 35FDAA
44E65C43 76B30203 010001A3 53305130 0F060355 1D130101 FF040530 030101FF
301F0603 551D2304 18301680 144171AB 9DC3C6B5 F0CA2C01 78ADDAA8 FB66024B
70301D06 03551D0E 04160414 4171AB9D C3C6B5F0 CA2C0178 ADDAA8FB 66024B
300D0609 2A864886 F70D0101 05050003 82010100 003606AE 1AFB9104 447F53BB
71338C17 F4848B40 9F4A9AA7 9CB791AE 44B73856 241CB923 FD0B0109 2F51F91B

B5CD1660 D54BEF67 354213D4 2A442000 B0662481 36D063B3 9BD7D567 46A85C9A
9AC3E4CD 4B373ECB C8F91089 AF698DCD 37002793 AE1B645A 5F5C1EA2 CBEF72D
0763A01E D25FC6C1 A06AF364 47AC82E4 134C463B 176D32CD 16A0AD15 383FB
D62134E5 218478F0 5B389D19 75A2C399 C1CC40B5 6AC3DAB2 8AA5D21D 25728B
6696650C 5220DB5F A22A304C 8F37EA5C A1C2C37B 7C58F5D2 4B214B5E A1C99E
A741E30D 798A7C2F 92F15D55 D8E74340 3A3AF3EB 048EE669 85B8F7FD 5B607C
AB1BB24D 0C8B76C4 FAC45B66 52CF5BC0 9CCDFE0B

voice service voip
ip address trusted list
ipv4 173.193.199.
ipv4 174.37.245.
ipv4 5.10.112.
ipv4 5.10.112.
ipv4 119.81.44.
ipv4 119.81.44.
address-hiding
mode border-element license capacity 20
allow-connections sip to sip
sip
session refresh
asserted-id pai
early-offer forced
midcall-signaling passthru
g729 annexb-all
voice class codec 1
codec preference 1 g711ulaw
codec preference 2 g711alaw
license udi pid ISR4321/K9 sn FDO19220MQ
license boot suite AdvUCSuiteK
license boot level uck
diagnostic bootup level minimal
spanning-tree extend system-id
username cisco privilege 15 password 7
redundancy
mode none
interface GigabitEthernet0/0/
ip address 192.65.79.160 255.255.255.
negotiation auto
interface GigabitEthernet0/0/


ip address 10.80.11.15 255.255.255.
negotiation auto
interface GigabitEthernet0/1/
no ip address
negotiation auto
interface GigabitEthernet
vrf forwarding Mgmt-intf
no ip address
negotiation auto
threat-visibility
ip forward-protocol nd
ip http server
ip http authentication local
ip http secure-server
ip route 0.0.0.0 0.0.0.0 192.65.79.
ip route 10.64.0.0 255.255.0.0 10.80.11.
ip route 172.16.24.0 255.255.248.0 10.80.11.
ip ssh server algorithm encryption aes128-ctr aes192-ctr aes256-ctr
ip ssh client algorithm encryption aes128-ctr aes192-ctr aes256-ctr
control-plane
mgcp behavior rsip-range tgcp-only
mgcp behavior comedia-role none
mgcp behavior comedia-check-media-src disable
mgcp behavior comedia-sdp-force disable
mgcp profile default
dial-peer voice 4 voip
description outgoing dial-peer from CUBE to NEXMO
destination-pattern .T
session protocol sipv
session target sip-server
session transport udp
voice-class codec 1
voice-class sip asserted-id pai
voice-class sip options-keepalive
dtmf-relay rtp-nte
no vad
dial-peer voice 1 voip
description incoming dial-peer from CUCM to CUBE
session protocol sipv


session transport udp
incoming called-number .T
voice-class codec 1
dtmf-relay rtp-nte
no vad
dial-peer voice 2 voip
description outgoing dial-peer from CUBE to CUCM
destination-pattern 120
session protocol sipv
session target ipv4:10.80.11.
session transport udp
voice-class codec 1
voice-class sip options-keepalive
dtmf-relay rtp-nte
no vad
dial-peer voice 3 voip
description incoming dial-peer from NEXMO to CUBE
session protocol sipv
session transport udp
incoming called-number 120
voice-class codec 1
dtmf-relay rtp-nte
no vad
sip-ua
credentials number 12014647035 username 911236e3 password 7 realm sip.nexmo.com
authentication username 911236e3 password 7
sip-server dns:sip.nexmo.com:
line con 0
transport input none
stopbits 1
line aux 0
stopbits 1
line vty 0 4
login local
no network-clock synchronization automatic
```

### 4.4 Configure Numbers in Nexmo Account.

1. Login to the Nexmo account using the credentials provided at the time of registration. A
    **Key** and **Secret** will be displayed on the dashboard and this can be used as the
    username and password for Registration SIP Trunks.

```screenshot
image: public/screenshots/sip/configuration/guides/vonage-dashboard/dashboard-key-secret.png
```

2. In order to provide the URL to which the call has to be routed from Nexmo, navigate to
    the **Numbers** tab
3. Click **Edit** against each number as shown below

```screenshot
image: public/screenshots/sip/configuration/guides/vonage-dashboard/numbers-dashboard.png
```

1. A pop-up will be displayed
2. Select the "**Forward to**" and provide the URL to which the calls route
3. Click **Update** to save the changes

```screenshot
image: public/screenshots/sip/configuration/guides/vonage-dashboard/edit-number.png
```
