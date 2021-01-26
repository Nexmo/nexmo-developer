---
title: Skype for Business
description: How to set up Vonage SIP with Skype for Business with Oracle E-SBC
---

# Vonage SIP Trunking Configuration Guide 

### Skype for Business `6.0.9319` With Oracle E-SBC Acme Packet 3820 `ECZ7.3.0 Patch 2` (Build 75)

### July 2017

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
  - 4.2 Configuring Skype for Business
      - 4.2.1 Enable TCP Mode
      - 4.2.2 Adding a Trunk
      - 4.2.3 Trunk Configuration
      - 4.2.4 Voice Routing
      - 4.2.5 Dial Plan
  - 4.3 Oracle E-SBC Configuration
      - 4.3.1 Create Physical Interfaces
          - 4.3.1.1 Physical Interface for Skype for Business
          - 4.3.1.2 Physical Interface for Nexmo
      - 4.3.2 Create Network Interfaces
          - 4.3.2.1 Network Interface for Skype for Business
          - 4.3.2.2 Network Interface for Nexmo
      - 4.3.3 Create Realm-config
          - 4.3.3.1 Realm for Skype for Business
          - 4.3.3.2 Realm for Nexmo
      - 4.3.4 Create Steering Pool
          - 4.3.4.1 Steering Pool for Skype for Business
          - 4.3.4.2 Steering pool for Nexmo
      - 4.3.5 Modify SIP Config
      - 4.3.6 Create SIP Interface
          - 4.3.6.1 SIP Interface for Skype for Business
          - 4.3.6.2 SIP Interface for Nexmo
      - 4.3.7 Create Session Agent
          - 4.3.7.1 Session Agent for Skype for Business
          - 4.3.7.2 Session Agent for Nexmo
      - 4.3.8 Create Local Policy
          - 4.3.8.1 Local Policy for Skype for Business
          - 4.3.8.2 Local Policy for Nexmo
      - 4.3.9 Create Surrogate Agent
      - 4.3.10 Create Translation Rules
      - 4.3.11 Create SIP Manipulation
          - 4.3.11.1 SIP Manipulation for Skype for Business
          - 4.3.11.2 SIP Manipulation for Nexmo
  - 4.4 Nexmo Configuration
      - 4.4.1 Configure Numbers in Nexmo Account
- [5. Summary of Tests and Results](#5-summary-of-tests-and-results)

## 1. Audience

This document is intended for the SIP trunk customer’s technical staff and Value Added Retailer
(VAR) having installation and operational responsibilities. This configuration guide provides steps
for configuring Skype for Business 6.0.9319 and Oracle Enterprise SBC Acme Packet 3820
`ECZ7.3.0 Patch 2` (Build 75) to Nexmo SIP Trunking services.

## 2. SIP Trunking Network Components

The network for the SIP trunk reference configuration is illustrated below and is representative of
a Skype for Business and Oracle SBC configuration to Nexmo SIP trunking.

![](/images/sip-config/skype/skype-1.png)


### 2.1 Network Components


| Component                            | Version                                                                                                         | Comments              |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------|-----------------------|
| Skype for Business                   | `6.0.9319`                                                                                                      |                       |
| Oracle E-SBC                         | `Acme Packet 3820 ECZ7.3.0 Patch 2 (Build 75)`                                                                  |                       |
| Microsoft Exchange Server 2016       | `15.1.225.42`                                                                                                   | Microsoft Exchange UM                       |
| Skype for Business Client            | `Model: CP-7965`                                                                                                |                       |
| Cisco IP Phone                       | **Model**: `CP-7965` **App Load ID**: `jar45sccp.9-4-2TH1-1.sbn` **Boot Load ID**: `tnp65.9-3-1-CR17.bin`       | This Cisco IP Phone is the PSTN test device                       |

## 3. Features

### 3.1.1 Features Supported

* Incoming and outgoing off-net calls using G711ULAW & G711ALAW voice codecs
* Calling Line (number) Identification Presentation
* Calling Line (number) Identification Restriction
* Call hold and resume
* Call transfer (unattended and attended)
* Call Conference
* Call forward (All, No answer)
* DTMF relay both directions (RFC2833)
* Media flow-through on Oracle E-SBC


### 3.1.2 Features Not Supported by PBX

* None

### 3.1.3 Features Not Tested

* None

### 3.1.4 Caveats and Limitations

* No Session Audit message is sent from Nexmo
* Session refresh is always done by Nexmo. Skype for Business does Session refresh only
through UPDATE message and Nexmo does not support UPDATE.

## 4. Configuration

### 4.1 IP Address Worksheet

The specific values listed in the table below and in subsequent sections are used in the lab
configuration described in this document, and are for **illustrative purposes only**. The customer
must obtain and use the values for your deployment.

| Component          | Lab Value          | Customer Value        |
| ------------------ | -------------------|-----------------------|
| **Oracle E-SBC**                                                   |
| LAN IP Address     | `10.70.59.40`      |                       |
| LAN Subnet Mask    | `255.255.255.0`    |                       |
| WAN IP Address     | `192.xx.xx.xxx`    |                       |
| WAN Subnet Mask    | `255.255.255.128`  |                       |
| **Skype for Business**                                            |
| System IP Address  | `172.16.29.62`       |                       |


### 4.2 Configuring Skype for Business

This section describes the Skype for Business configuration necessary to support connectivity to
Oracle E-SBC. A SIP trunk is established between Skype for Business and Oracle E-SBC for
use by signaling traffic to and from Nexmo via Oracle E-SBC.

#### 4.2.1 Enable TCP Mode

Skype for Business and Oracle E-SBC will communicate over TCP since UDP is not supported
by Skype for Business. To enable TCP mode in Skype for Business follow the steps below.

1. Navigate to **Mediation Pools** in the Skype for Business Topology Builder
2. Here we use the co-located mediation server to communicate with the Oracle E-SBC
3. Right click and click **Edit**
4. Assign **Listening ports** for TCP on the Skype for Business side
5. Check **Enable TCP Port** option

![](/images/sip-config/skype/skype-2.png)

#### 4.2.2 Adding a Trunk

1. Right click on the **PSTN gateways** option and select **New IP/PSTN Gateway**

    ![](/images/sip-config/skype/skype-13.png)    

2. Enter the IP address of the Oracle E-SBC
3. Click **Next**

    ![](/images/sip-config/skype/skype-4.png)

4. In **Define the root trunk** page
5. **Trunk name:** 10.64.4.177 (Oracle E-SBC LAN IP)
6. **Listening Port for IP/PSTN Gateway:** 5060, Configure the listening port of the SBC
7. **SIP Transport Protocol:** Select **TCP**
8. **Associated Mediation Server:** `fe01.sfbsp.local`, Select the mediation pool to be
    associated
9. **Associated Mediation Server port:** 5060
10. Click **Finish**
11. Publish the topology for the configuration to be reflected

![](/images/sip-config/skype/skype-5.png)

#### 4.2.3 Trunk Configuration

1. Open the Skype for Business Control Panel
2. Navigate to **Voice Routing**
3. Go to the **TRUNK CONFIGURATION** page
4. Click **New** and select **Pool Trunk**
5. In the **Select a Service** page, select the trunk added in section 4.2.
6. Assign a name
7. Set **Encryption Support Level:** Select _Not supported_
8. Set **Refer Support:** _None_
9. Set the remaining options as seen in the figure below
10. Click **OK** and **Commit** the changes.

![](/images/sip-config/skype/skype-6.png)

#### 4.2.4 Voice Routing

The trunk created in the previous step needs to be assigned to a Route. This is done so that
when a Skype for Business user dials a call out to the Nexmo, the calls terminate via the
configured Oracle E-SBC trunk.

1. Open the Skype for Business control panel
2. Navigate to **Voice Routing** → **VOICE POLICY**
3. A **Dial Plan** can be configured for users if any digit modifications are needed. Here the Global Dial Plan is used.
4. Configure a **Voice Policy** for the users to use when dialing a call out to the Oracle E-SBC

    ![](/images/sip-config/skype/skype-7.png)

5. Click **New** under **Associated PSTN Usages** to create a new PSTN Usage
6. Assign a name
7. Click **New** under **Associated Routes** to create a new Route

    ![](/images/sip-config/skype/skype-8.png)

8. Assign a **Name** for the new route
9. Create a match pattern for the calls going out under **Build a Pattern to match** section.
    Here **"+1214242**" is used to match PSTN number.
10. Select the Trunk under **Associated trunks** section and click **OK**

    ![](/images/sip-config/skype/skype-9.png)

11. Save the Route
12. Save the PSTN Usage
13. Save the Voice Policy

#### 4.2.5 Dial Plan

Dial Plan is used to strip or insert digits.


1. Navigate to **Voice Routing** section in the **Skype for Business Control Panel**
2. Select **Global Dial Plan.** Here the Global Dial Plan is used.

    ![](/images/sip-config/skype/skype-10.png)

3. Open the Global dial plan
4. Navigate to **Associated Normalization Rules** and add normalization rules
5. **Keep All** is a default normalization rule which allows all the numbers
6. **Save** the changes

![](/images/sip-config/skype/skype-11.png)

### 4.3 Oracle E-SBC Configuration

#### 4.3.1 Create Physical Interfaces

This section defines the physical interfaces to the Skype for Business and Nexmo networks.

##### 4.3.1.1 Physical Interface for Skype for Business

1. Navigate to **Configuration** → **Objects** → **system** → **`phy-interface`**
2. Click **Add**
3. **Name:** `s1p`
4. **Operation Type:** Media
1. **Port:** 0
5. **Slot:** 1
6. Click **OK**

![](/images/sip-config/skype/skype-12.png)

##### 4.3.1.2 Physical Interface for Nexmo

1. Navigate to **Configuration** → **Objects** → **system** → **`phy-interface`**
2. Click **Add**
3. **Name:** `s0p`
4. **Operation Type:** Media
2. **Port:** 0
5. **Slot:** 0
6. Click **OK**

![](/images/sip-config/skype/skype-13.png)

#### 4.3.2 Create Network Interfaces

This section defines the network interfaces to the Skype for Business and Nexmo networks.


##### 4.3.2.1 Network Interface for Skype for Business

1. Navigate to **Configuration** → **Objects** → **system** → **network-interface**
2. Click **Add**
3. **Name:** `s1p`
4. **Sub port id:** 0
5. **`Hostname`:** `fe01.sfpsp.local` (Skype for Business FQDN)
6. **IP address:** 10.64.4.177 (E-SBC LAN IP)
7. **Netmask:** 255.255.0.
8. **Gateway:** 10.64.1.
9. Click **OK**

![](/images/sip-config/skype/skype-14.png)

##### 4.3.2.2 Network Interface for Nexmo

1. Navigate to **Configuration** → **Objects** → **system** → **network-interface**
2. Click **Add**
3. **Name:** `s0p`
4. **Sub port id:** 0
5. **IP address:** `192.xx.xx.xxx` (E-SBC WAN IP)
6. **Netmask:** `255.xxx.x.x`
7. **Gateway:** `192.x.x.x`
8. Click **OK**

![](/images/sip-config/skype/skype-15.png)

#### 4.3.3 Create Realm-config

Realms are used as a basis for determining egress and ingress associations between physical
and network interfaces.

##### 4.3.3.1 Realm for Skype for Business

1. Navigate to **Configuration** → **Objects** → **media-manager** → **realm-config**
2. Click **Add**
3. **Identifier:** SFB
4. **Network Interfaces:** Click Add and select Skype for Business Network interface
5. Click **OK**

![](/images/sip-config/skype/skype-16.png)

##### 4.3.3.2 Realm for Nexmo

1. Navigate to **Configuration** → **Objects** → **media-manager** → **realm-config**
2. Click **Add**
3. **Identifier:** nexmo
4. **Network Interfaces:** Click Add and select Nexmo Network interface
5. Click **OK**

![](/images/sip-config/skype/skype-17.png)

#### 4.3.4 Create Steering Pool

Steering pool define sets of ports that are used for steering media flows through the Acme
Packet E-SBC.

##### 4.3.4.1 Steering Pool for Skype for Business

1. Navigate to **Configuration** → **Objects** → **media-manager** → **steering-pool**
2. Click **Add**
3. **IP Address:** 10.64.4.177 (E-SBC LAN IP)
4. **Realm ID:** SFB (Realm of Skype for Business)
5. **Network Interface:** Select Skype for Business Network interface
6. Click **OK**

![](/images/sip-config/skype/skype-18.png)

##### 4.3.4.2 Steering pool for Nexmo

1. Navigate to **Configuration** → **Objects** → **media-manager** → **steering-pool**
2. Click **Add**
3. **IP Address:** `192.x.x.x` (E-SBC WAN IP)
4. **Realm ID:** nexmo (Realm of Nexmo)
5. **Network Interface:** Select Nexmo Network interface
6. Click **OK**

![](/images/sip-config/skype/skype-19.png)

#### 4.3.5 Modify SIP Config

SIP-config sets the values for the Acme Packet SIP operating parameters.

1. Navigate to **Configuration** → **Objects** → **session-router** → **sip-config** → **Modify**
2. **Home Realm ID:** SFB (Realm of Skype for Business)
3. **Registrar Domain:** * (This option is required when using Registration Method)
4. **Registrar Host:** * (This option is required when using Registration Method)
5. Click **OK**

![](/images/sip-config/skype/skype-20.png)

#### 4.3.6 Create SIP Interface

SIP interface defines the signaling interface (IP address and port) to which the Acme Packet E-
SBC sends and receives SIP messages. SIP Interface and Realm ID are created for both Skype
for Business and Nexmo

##### 4.3.6.1 SIP Interface for Skype for Business

1. Navigate to **Configuration** → **Objects** → **session-router** → **sip-interface**
2. Click **Add**
3. **Realm ID:** SFB
4. **SIP Ports:** Click Add
5. **Address:** Enter the SBC LAN IP address
6. **Port:** Configure the SBC listening port for TCP
7. **Transport Protocol:** TCP
8. **Allow Anonymous** : _all_ , for example
9. Click **OK**

![](/images/sip-config/skype/skype-21.png)

##### 4.3.6.2 SIP Interface for Nexmo

1. Navigate to **Configuration** → **Objects** → **session-router** → **sip-interface**
2. Click **Add**
3. **Realm ID:** Nexmo
4. **SIP Ports:** Click Add
5. **Address:** Enter the SBC WAN IP Address
6. **Port:** Configure the SBC listening port for TCP
7. **Transport Protocol:** UDP
8. **Allow Anonymous** : _all,_ for example
9. Click **OK**

![](/images/sip-config/skype/skype-22.png)

#### 4.3.7 Create Session Agent

A session agent defines an internal "next hop" signaling entity for the SIP traffic. A realm is
associated with a session agent to identify sessions coming from or going to the session agent.
Session agents are created for both Skype for Business and Nexmo.

##### 4.3.7.1 Session Agent for Skype for Business

1. Navigate to **Configuration** → **Objects** → **session-router** → **session-agent**
2. Click **Add** or **Modify**
3. **`Hostname`:** 172.16.29.62, for example
4. **IP Address:** 172.16.29.62, for example
5. **Port:** Configure the PBX listening port
6. **Transport Method:** `StaticTCP`
7. **Realm ID:** SFB

    ![](/images/sip-config/skype/skype-23.png)

8. `Out translationid`:** `addplusone`
9. `In manipulationid`:** `add_pai`
10. `Out manipulationid`:** `outManipToSFB`

    ![](/images/sip-config/skype/skype-24.png)

11. Click **Add** under **Auth attribute**

    ![](/images/sip-config/skype/skype-25.png)

12. **Auth Realm** : Nexmo FQDN (sip.nexmo.com is used for this test) provided by Nexmo
13. **Username** : User name (`911236e3` is used for this test) provided by Nexmo
14. **Password** : Password provided by Nexmo
15. Click **OK**

![](/images/sip-config/skype/skype-26.png)

##### 4.3.7.2 Session Agent for Nexmo

1. Navigate to **Configuration** → **Objects** → **session-router** → **session-agent**
2. Click **Add** or **Modify**
3. **`Hostname`:** Enter the `hostname` (`sip.nexmo.com` is issued for this test)
4. **Port:** Configure the PBX listening port
5. **Transport method:** UDP
6. **Realm ID:** Nexmo
7. **Options:** `max-udp-length=0` (Note: This setting allows the SBC to fragment UDP packets.
    Otherwise the maximum size a UDP packet may be is 1500 bytes.). Without this setting,
    E-SBC sends "513 MESSAGE TOO LARGE" if a UDP packet length is more than 1500
    bytes.

    ![](/images/sip-config/skype/skype-27.png)

8. `Out manipulationid`: Surrogate
9. Click **OK**

![](/images/sip-config/skype/skype-28.png)

#### 4.3.8 Create Local Policy

Local policies are defined to allow any SIP request from Skype for Business realm to be routed
to the Nexmo realm and vice-versa.

##### 4.3.8.1 Local Policy for Skype for Business

1. Navigate to **Configuration** → **Objects** → **session-router** → **local-policy**
2. Click **Add** or **Modify**
3. From Address: * - Used in this example
4. To Address : * - Used in this example
5. **Source Realm:** nexmo
6. **Policy Attributes:** Add or Edit
7. **Next Hop:** Enter the Skype For Business IP Address
8. **Realm:** SFB
9. **Cost:** 0
10. Click **OK**

![](/images/sip-config/skype/skype-29.png)

##### 4.3.8.2 Local Policy for Nexmo

1. Navigate to **Configuration** → **Objects** → **session-router** → **local-policy**
2. Click **Add** or **Modify**
3. **From Address:** `*` is used in this example
4. To Address : * - This is used in this example
5. **Source realm:** SFB
6. **Policy Attributes:** Add or Edit
7. **Next Hop:** Enter the Nexmo FQDN
8. **Realm:** nexmo
9. **Action:** `replace-uri` is used in this example
10. **Cost:** 0
11. Click **OK**

![](/images/sip-config/skype/skype-30.png)

#### 4.3.9 Create Surrogate Agent

Surrogate registration allows the Acme Packet SBC to perform trunk side registrations to the
Nexmo network. The values for register-user, register-contact-user and password are provided
by Nexmo.

1. Navigate to **Configuration** → **Objects** → **Show advanced** → **session-router** →
    **surrogate-agent**
2. **Register Host:** `sip.nexmo.com` is used in this example
3. **Register User** : `911236e3` is used in this example
4. **Realm ID:** SFB
5. **Customer Host:** `172.16.29.62` (Skype for Business IP)
6. **Customer Next Hop:** `172.16.29.62` (Skype for Business IP)
7. **Register Contact Host:** SBC WAN IP
8. **Register Contact User:** `911236e3` is used in this example
9. **Password:** Type the Authentication password
10. **Register Expires:** 60 is used for this test
11. **Route to Registrar:** Enabled
12. **Auth User:** `911236e3` is used in this example
13. Click **OK**

![](/images/sip-config/skype/skype-31.png)

#### 4.3.10 Create Translation Rules

The below translation rule is applied to `Out translationid` of Skype for Business Session agent.
This adds + in the user part of the TO header.

1. Navigate to **Configuration** → **Objects** → **session-router** → **translation-rules**
2. Click **Add**
3. **ID:** `addplus1` (Identifier name used for this test)
4. **Type:** add
5. **Add String:** +

![](/images/sip-config/skype/skype-32.png)

#### 4.3.11 Create SIP Manipulation

SIP manipulation specifies rules for manipulating the contents of specified SIP headers. For the
Compliance test, a set of SIP manipulations were configured that contain a set of SIP header
manipulation rules (HMR) on traffic From or To with respect to Nexmo and Skype for Business.

##### 4.3.11.1 SIP Manipulation for Skype for Business

`add_pai` rule is applied in the SIP header coming from Skype for business to Oracle E-SBC. The
manipulation script is assigned to `In manipulationid` of Session agent of Skype for Business.

```
sip-manipulation
name add_pai^1
description
split-headers
join-headers
header-rule
name add_pai^2
header-name P-ASSERTED-IDENTITY
action add
comparison-type case-sensitive
msg-type request
methods INVITE
match-value
new-value <sip:+$FROM_USER.$0+@192.xx.xx.xxx;user=phone>

header-rule
name inactsendonlytosendrecv^3
header-name Content-Type
action manipulate
comparison-type case-sensitive
msg-type request
methods INVITE
match-value

1 HMR for SIP headers coming from Skype for Business to E-SBC
2 SIP manipulaton rule developed to insert P-Asserted-Identty header
3 SIP manipulaton rule developed to change SDP atriiute from INACTIVE to SENDRECV in the INVITE


new-value
element-rule
name inactivetosendrecv
parameter-name application/sdp
type mime
action find-replace-all
match-val-type any
comparison-type case-sensitive
match-value a=inactive
new-value a=sendrecv
element-rule
name sendonlytosendrecv^4
parameter-name application/sdp
type mime
action find-replace-all
match-val-type any
comparison-type case-sensitive
match-value a=sendonly
new-value a=sendrecv
header-rule
name sessionrefresh^5
header-name Session-Expires
action manipulate
comparison-type case-sensitive
msg-type reply
methods
match-value
new-value
element-rule
name uactouas
parameter-name
type header-value
action find-replace-all
match-val-type any
comparison-type case-sensitive
match-value refresher=uas
new-value refresher=uac
```

`outManipToSFB` rule is applied to SIP headers sending from Oracle E-SBC to Skype for
business. The manipulation script is assigned to `out manipulationid` of Session agent of Skype
for Business.

```
sip-manipulation
name outManipToSFB^6
description To SFB

4 SIP manipulaton rule developed to change SDP atriiute from SENDONLY to SENDRECV in the INVITE
5 SIP manipulaton rule developed to change Session refresher parameter from UAS to UAC in the response
message
6 HMR for SIP headers sending from E-SBC to Skype for Business.


split-headers
join-headers
header-rule
name From^7
header-name From
action manipulate
comparison-type case-sensitive
msg-type request
methods
match-value
new-value
element-rule
name From_header
parameter-name
type uri-host
action replace
match-val-type any
comparison-type case-sensitive
match-value
new-value $LOCAL_IP
header-rule
name To^8
header-name To
action manipulate
comparison-type case-sensitive
msg-type request
methods
match-value
new-value
element-rule
name To
parameter-name
type uri-host
action replace
match-val-type any
comparison-type case-sensitive
match-value
new-value sfpsp.local

header-rule
name modURI^9
header-name Request-uri
action manipulate
comparison-type case-sensitive
msg-type any
methods

7 SIP manipulaton rule developed for changing the URI host IP to local SBC LAN IP in the FROM header
8 SIP manipulaton rule developed for changing the URI host IP to Skype for Business FQDN in the TO header
9 SIP manipulaton rule developed to replace the URI host IP to Skype for Business FQDN in the REQUEST-URI


match-value
new-value
element-rule
name mod2
parameter-name
type uri-host
action replace
match-val-type fqdn
comparison-type case-sensitive
match-value
new-value sfbsp.local
```

##### 4.3.11.2 SIP Manipulation for Nexmo

`Surrogate` rule is applied to SIP header coming from Oracle E-SBC to Nexmo. The manipulation
script is assigned to `out manipulationid` of Session agent of Nexmo.

```
sip-manipulation
name surrogate^10
description
split-headers
join-headers
header-rule
name ModURI^11
header-name request-uri
action manipulate
comparison-type case-sensitive
msg-type any
methods
match-value
new-value
element-rule
name mod2
parameter-name
type uri-host
action replace
match-val-type fqdn
comparison-type case-sensitive
match-value
new-value sip.nexmo.com+:+$REMOTE_PORT
header-rule
name from_nexmo^12
header-name FROM
action manipulate

10 HMR for SIP headers sending from E-SBC to Nexmo network
11 SIP manipulaton rule developed for replacing the URI host IP with Nexmo FQDN and the remote port numier in
the REQUEST_URI
12 SIP manipulaton rule developed for replacing the URI host IP to SBC WAN IP in the FROM header


comparison-type case-sensitive
msg-type request
methods
match-value
new-value
element-rule
name from_add_nexmo
parameter-name
type uri-host
action replace
match-val-type any
comparison-type case-sensitive
match-value
new-value $LOCAL_IP
header-rule
name contact^13
header-name CONTACT
action manipulate
comparison-type case-sensitive
msg-type request
methods
match-value
new-value
element-rule
name contactlocalip
parameter-name
type uri-host
action replace
match-val-type ip
comparison-type case-sensitive
match-value
new-value $LOCAL_IP
element-rule
name contactlocalport^14
parameter-name
type uri-port
action replace
match-val-type any
comparison-type case-sensitive
match-value
new-value $LOCAL_PORT
element-rule
name contactuserpart^15
parameter-name
type uri-user
action add

13 SIP manipulaton rule developed for replacing the URI host IP to SBC WAN IP in the CONTACT header
14 SIP manipulaton rule developed for replacing the Contact Port to SBC port numier in the CONTACT header
15 SIP manipulaton rule developed for adding the valid FROM header digits in the URI User part of CONTACT
header


match-val-type any
comparison-type case-sensitive
match-value
new-value $FROM_USER.$0
header-rule
name nexmooptions
header-name FROM
action manipulate
comparison-type case-sensitive
msg-type any
methods OPTIONS
match-value
new-value
element-rule
name nexmooptions^16
parameter-name
type uri-host
action replace
match-val-type any
comparison-type case-sensitive
match-value
new-value $LOCAL_IP
header-rule
name nexmosipoptions^17
header-name TO
action manipulate
comparison-type case-sensitive
msg-type any
methods OPTIONS
match-value
new-value
element-rule
name nexmosipoptions
parameter-name
type uri-host
action replace
match-val-type any
comparison-type case-sensitive
match-value
new-value sip.nexmo.com
header-rule
name nexmtoheader^18
header-name TO
action manipulate
comparison-type case-sensitive

16 SIP manipulaton rule developed for replacing the URI host IP to SBC WAN IP in the FROM header in the OPTIONS
message
17 SIP manipulaton rule developed for replacing the URI host IP to Nexmo FQDN in the TO header in the OPTIONS
message
18 SIP manipulaton rule developed for replacing the URI host IP to Nexmo FQDN in the TO header


msg-type request
methods
match-value
new-value
element-rule
name nexmotoheader
parameter-name
type uri-host
action replace
match-val-type any
comparison-type case-sensitive
match-value
new-value sip.nexmo.com
```

### 4.4 Nexmo Configuration

#### 4.4.1 Configure Numbers in Nexmo Account

1. Login to the Nexmo account using the credentials provided at the time of registration. A
    **Key** and **Secret** will be displayed on the dashboard and this can be used as the
    username and password for Registration SIP Trunks.

    ![](/images/sip-config/vonage-dashboard/dashboard-key-secret.png)

2. In order to provide the URL to which the call has to be routed from Nexmo, navigate to
    the **Numbers** tab
3. Click **Edit** against each number as shown below

    ![](/images/sip-config/vonage-dashboard/numbers-dashboard.png)

4. A pop-up will be displayed
5. Select the "**Forward to**" and provide the URL to which the calls route
6. Click **Update** to save the changes

    ![](/images/sip-config/vonage-dashboard/edit-number.png)

## 5. Summary of Tests and Results

*N/S = Not Supported N/T= Not Tested N/A= Not Applicable*

| Test Case | Test Case Description                     | Result  | Notes
| ----------| ----------------------------------------- | ------- | ------------------------------------------------------------ |
| 1         | Calling Party Disconnects Before Answer   | PASS    |                                                       |
| 2         | Calling Party Disconnects After Answer    | PASS    |                                                              |
| 3         | Called Party Disconnects After Answer    | PASS    |                                                              |
| 4         | Three Way Calling                         | PASS    |                                                                    |
| 5         | Calling Party Presentation Restricted     | PASS    |                                                              |
| 6         | Calling Party Disconnects Before Answer   | PASS    |                                | 
| 7         | Calling Party Disconnects After Answer    | PASS    |                                                              |
| 8         | Called Party Disconnects After Answer    | PASS    |                                                              |
| 9         | Calling Party Receives Busy               | PASS    |                                                              |
| 10        | International Outbound Dialing            | PASS    |  |
| 11        | Outbound Call Forward Always              | PASS    |                                                                |
| 12        | Outbound Call Forward Not Available (Ring No Answer) | PASS    |                                                   |
| 13        | Outbound Consultative Call Transfer       | PASS     |                                                   |
| 14        | Outbound Semi-Attended/Blind Call Transfer | PASS    |                                                   |
| 15        | Outbound Call Hold | PASS    |                                                   |
| 16        | Terminate Early Media Outbound Call Before Answer | PASS    |                                                   |
| 17        | Early Media Forward Call | PASS    |                                                   |
| 18        | Outbound, Wait for Session Audit | PASS    | No Session Audit message is sent by Nexmo. HMR rule is applied in E-SBC to initiate Nexmo to send Session refresh at specified interval. |
| 19        | Inbound, Wait for Session Audit | PASS    |                                                   |
| 20        | Outbound DTMF (`RTPevent`) | PASS    |                                                   |
| 21        | Inbound DTMF (`RTPevent`) | PASS    |                                                   |
