---
title: NEC SV9100
description: How to set up Vonage SIP with NEC SV9100
---

# Vonage SIP Trunking Configuration Guide

## NEC SV9100 version 6.00.

### August 2017

> **Note**: Parts of this guide still refer to Nexmo. Vonage acquired Nexmo in June 2016.

## Contents

- [1. Audience](#1-audience)
- [2. SIP Trunking Network Components](#2-sip-trunking-network-components)
	- 2.1 Network Components
- [3. Features](#3-features)
  - 3.1.1 Features Supported
  - 3.1.2 Features Not Supported by PBX
  - 3.1.3 Features Not Tested
  - 3.1.4 Caveats and Limitations
- [4. Configuration](#4-configuration)
  - 4.1 IP Address Worksheet
  - 4.2 Configuring NEC SV
      - 4.2.1 SIP Server Information Setup
      - 4.2.2 SIP System Information Setup
      - 4.2.3 SIP Trunk Registration Information
      - 4.2.4 Class of Service Options (Outgoing Call Service)
      - 4.2.5 IP Trunk Party Calling Party Number Setup for Extensions
      - 4.2.6 DID Translation Table
      - 4.2.7 SIP Trunk Basic Setup
      - 4.2.8 IP Trunk Basic Setup
      - 4.2.9 Location Setup
  - 4.3 Nexmo Configuration
      - 4.3.1 Configure Numbers in Nexmo Account
- [5. Summary of Tests and Results](#5-summary-of-tests-and-results)


## 1. Audience

This document is intended for the SIP trunk customer’s technical staff and Value Added Retailer
(VAR) having installation and operational responsibilities. This configuration guide provides steps
for configuring NEC SV9100 version 6.00.50 with Nexmo SIP Trunking services.

## 2. SIP Trunking Network Components

The network for the SIP trunk reference configuration is illustrated below and is representative of
a NEC SV9100 configuration to Nexmo SIP trunking.

![](/images/sip-config/nec-sv9100/nec-sv9100-1.png)

### 2.1 Network Components

| Component      | Version                | Comments                                    |
| -------------- | ---------------------- |---------------------------------------------|
| NEC SV9100     | 6.00.50                |                                             |
| Cisco IP Phone | **Model**: `CP-7965` **App Load ID**: `jar45sccp.9-4-2TH1-1.sbn` **Boot Load ID**: `tnp65.9-3-1-CR17.bin`    | This Cisco IP Phone is the PSTN test device |

## 3. Features

#### 3.1.1 Features Supported

* Incoming and outgoing off-net calls using G711ULAW voice codecs
* Calling Line (number) Identification Presentation
* Calling Line (number) Identification Restriction
* Call hold and resume
* Call transfer (semi-attended and consultative)
* 3 way Conference
* Call forward (All, No answer)
* DTMF relay both directions (RFC2833)
* Media flow-through on NEC SV

#### 3.1.2 Features Not Supported by PBX

* None

#### 3.1.3 Features Not Tested

* None

#### 3.1.4 Caveats and Limitations

* When Public DNS is used for resolving sip.nexmo.com, NEC SV9100 receives multiple
target address. NEC sends registration to the first target and when it is challenged, it
sends with authorization details to the second target. Consequently registration fails.
Hence for this testing, a local DNS is used to resolve sip.nexmo.com to one of the
intended target IP addresses and trunk has been registered.
* In the inbound call from Nexmo, the TO header in the INVITE contains `sip.nexmo.com`
instead of the trunk FQDN which is `nexmo.tekvizionlabs.com`.
* In the outbound call from NEC, the From header in the INVITE contains trunk FQDN
(`sip.nexmo.com`) instead of the PBX IP. It appears to be a design intent of NEC SV9100.
* NEC SV9100 does not appear to support Diversion header. Consequently diversion
information is not present in the call forward INVITE from NEC SV9100.
* NEC SV9100 adds +1 to the originating number (From header) in the call forward INVITE
if NEC SV9100 is enabled for E164 dialing.
* In a 3 way conference, when PSTN drops out of the conference, the trunks are not
released until one of the PBX endpoints disconnect
* No Session Audit message is sent from Nexmo

## 4. Configuration

### 4.1 IP Address Worksheet

The specific values listed in the table below and in subsequent sections are used in the lab
configuration described in this document, and are for **illustrative purposes only**. The customer
must obtain and use the values for your deployment.

| Component                      | Lab Value         | Customer Value  |
| ------------------------------ | ----------------- | --------------- |
| **NEC SV9100**                                                       |
| LAN IP Address                 | `192.168.52.80`   |                 |
| LAN Subnet Mask                | `255.255.255.0`   |                 |
| WAN IP Address (After NAFTing) | `192.xx.xx.xxx`   |                 |
| WAN Subnet Mask                | `255.255.255.128` |                 |

### 4.2 Configuring NEC SV

This section describes NEC SV9100 configuration. A direct SIP trunk is established between
NEC SV9100 and Nexmo. There is no PBX level NATing done.

#### 4.2.1 SIP Server Information Setup

1. Navigate to **`10-XX`:** System Configuration
2. Click **`10-29`:** SIP Server Information Setup
3. Enter **Registrar Domain Name:** `sip.nexmo.com`
4. Enter **Proxy Domain Name:** `nexmo.com`
5. Enter **Proxy Host Name:** `sip`
6. Select **SIP Carrier Choice:** Carrier B

![](/images/sip-config/nec-sv9100/nec-sv9100-2.png)


#### 4.2.2 SIP System Information Setup

1. Navigate to **`10-XX`:** System Configuration
2. Click **`10-28`:** SIP System Information Setup
3. Enter **Domain Name:** `nexmo.com`
4. Enter **Host Name:** `sip`
5. Select **Transport Protocol:** UDP

![](/images/sip-config/nec-sv9100/nec-sv9100-3.png)


#### 4.2.3 SIP Trunk Registration Information

1. Navigate to **`10-XX`:** System Configuration
2. Click **`10-36`:** SIP Trunk Registration Information
3. Check **Registration**
4. Enter **User ID:** `911236e3` (Provided by Nexmo for this particular testing)
5. Enter **Authentication User ID:** `911236e3` (Provided by Nexmo for this particular testing)
6. Enter **Authentication Password**

![](/images/sip-config/nec-sv9100/nec-sv9100-4.png)


#### 4.2.4 Class of Service Options (Outgoing Call Service)

1. Navigate to **`20-XX`:** System Options
2. Click **`20-08`:** Class of Service Options (Outgoing Call Service)

The Class of Service Options are configured as below

![](/images/sip-config/nec-sv9100/nec-sv9100-5.png)


#### 4.2.5 IP Trunk Party Calling Party Number Setup for Extensions

1. Navigate to **`20-XX`:** System Options
2. Click **`21-19`:** IP Trunk (SIP) Calling Party Number Setup for Extension
3. Enter the **Calling Party Number** (DID) against the respective **ICM Extension** (For e.g. in
    this test setup ICM Extensions 109 and 111 are used. The respective `DIDs` are entered
    against them)

![](/images/sip-config/nec-sv9100/nec-sv9100-6.png)


#### 4.2.6 DID Translation Table

1. Navigate to **`22-XX`:** Incoming
2. Click **`22-11`:** DID Translation Table
3. Select a **DID Translation Entry** (e.g. 1 and 2)
4. Enter **Received Number** as the last 4 digits of the DID
5. Enter **Target 1:** ICM Extension (e.g. 109 and 111)

    ![](/images/sip-config/nec-sv9100/nec-sv9100-7.png)

    ![](/images/sip-config/nec-sv9100/nec-sv9100-8.png)


#### 4.2.7 SIP Trunk Basic Setup

1. Navigate to **`84-XX`:** VoIP Hardware Setup
2. Click **`84-14`:** SIP Trunk Basic Information Setup
3. Select **Incoming/Outgoing SIP Trunk for E.164** : Mode 1

    ![](/images/sip-config/nec-sv9100/nec-sv9100-9.png)


#### 4.2.8 IP Trunk Basic Setup

1. Navigate to **`14-XX`:** Trunk Setup
2. Click **`14-01`:** Trunk Basic Setup
3. Check **Trunk to Trunk Outgoing CallerID Through Mode**

![](/images/sip-config/nec-sv9100/nec-sv9100-10.png)

![](/images/sip-config/nec-sv9100/nec-sv9100-11.png)


#### 4.2.9 Location Setup

1. Navigate to **`10-XX`:** System Configuration
2. Click **`10-02`:** Location Setup
3. Enter **Country Code: 1**
4. Enter **Caller ID Edit Code: 9**

![](/images/sip-config/nec-sv9100/nec-sv9100-12.png)

### 4.3 Nexmo Configuration

#### 4.3.1 Configure Numbers in Nexmo Account

1. Login to the Nexmo account using the credentials provided at the time of registration. A **Key** and **Secret** will be displayed on the dashboard and this can be used as the username and password for Registration SIP Trunks.

    ![](/images/sip-config/vonage-dashboard/dashboard-key-secret.png)

2. In order to provide the URL to which the call has to be routed from Nexmo, navigate to the **Numbers** tab
3. Click **Edit** against each number as shown below

    ![](/images/sip-config/vonage-dashboard/numbers-dashboard.png)

4. A pop-up will be displayed
5. Select the " **Forward to** " and provide the URL to which the calls route
6. Click **Update** to save the changes

    ![](/images/sip-config/vonage-dashboard/edit-number.png)

## 5. Summary of Tests and Results

*N/S = Not Supported N/T= Not Tested N/A= Not Applicable*

| Test Case | Test Case Description                     | Result  | Notes
| ----------| ----------------------------------------- | ------- | ------------------------------------------------------------ |
| 1         | Calling Party Disconnects Before Answer   | PASS    | When the call comes from Nexmo, the TO header in the INVITE contains `sip.nexmo.com` instead of the trunk `FQDN` which is `nexmo.tekvizionlabs.com`.                                                       |
| 2         | Calling Party Disconnects After Answer    | PASS    |                                                              |
| 3         | Calling Party Disconnects After Answer    | PASS    |                                                              |
| 4         | Three Way Calling                         | PASS    | In a 3 way conference, when PSTN drops out of the conference, the trunks are not released until one of the PBX endpoints disconnect.                                                                      |
| 5         | Calling Party Presentation Restricted     | PASS    |                                                              |
| 6         | Calling Party Disconnects Before Answer   | PASS    | When NEC initiates a call, the FROM header in the INVITE contains trunk `FQDN` (`sip.nexmo.com`) instead of the PBX IP. It appears to be a design intent of NEC SV9100.                                  | 
| 7         | Calling Party Disconnects After Answer    | PASS    |                                                              |
| 8         | Calling Party Disconnects After Answer    | PASS    |                                                              |
| 9         | Calling Party Receives Busy               | PASS    |                                                              |
| 10        | International Outbound Dialing            | <span style="color:red">FAIL</span>    | With E164 dialing enabled, NEC adds +1 with international dialing also. Call fails henceforth. |
| 11        | Outbound Call Forward Always              | PASS    | NEC SV9100 does not appear to support Diversion header. Consequently, diversion information is not present in the call forward INVITE from NEC SV9100. NEC SV9100 adds +1 to the originating number (From header) in the call forward INVITE if NEC SV9100 is enabled for E164 dialing.                                                               |
| 12        | Outbound Call Forward Not Available (Ring No Answer) | PASS    |                                                   |
| 13        | Outbound Consultative Call Transfer       | PASS     |                                                   |
| 14        | Outbound Semi-Attended/Blind Call Transfer | PASS    |                                                   |
| 15        | Outbound Call Hold | PASS    |                                                   |
| 16        | Terminate Early Media Outbound Call Before Answer | PASS    |                                                   |
| 17        | Early Media Forward Call | PASS    |                                                   |
| 18        | Outbound, Wait for Session Audit | PASS    | No Session Audit message is sent to Nexmo |
| 19        | Outbound, Wait for Session Audit | PASS    |                                                   |
| 20        | Outbound DTMF (`RTPevent`) | PASS    |                                                   |
| 21        | Inbound DTMF (`RTPevent`) | PASS    |                                                   |
