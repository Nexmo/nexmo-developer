---
title: Google CCML Integration
description: An integration between Comms Router and Google's Contact Center APIs adds capabilities to the programmable contact center space.
tags: ["Google","AI"]
link: 
image: /assets/images/extend/google_cloud_icon.png
published: false
---

## About

For this solution, we have taken a fully programmable approach, using our Nexmo Voice API, our open source skills based routing engine (Comms Router) and CRM integration, and have integrated with both DialogFlow and the new Contact Center AI APIs from Google.

The first part of this solution, brings together the Dialogflow Virtual agent, our integration to a CRM platform and the Contact center AI, all flowing over VAPI our voice API. This allows us to pull contextual information about the caller from CRM, helping to inform the virtual agent then collect responses from the customer, giving the virtual agent all the information it needs to return a suggested answer thru the Google Contact Center AI APIs.

The Vonage Team had worked hard to foster a close relationship to be involved in key alpha product developments and we were able to show an integration live at the Google Next conference in San Francisco in July 2018.

## Usage
For the Google Next demo we produced an application that leveraged the Voice API, Comms Router and Google CC AI as well as Dialogflow.

## High-level Overview

- Customer calls Contact Center number (Nexmo Virtual Number).
- Conference created using Nexmo Voice API and connected to Google CC AI via a Google Virtual Number.
- Application looks up incoming customer number to see if it exists in the CRM file, if a match is found pulls the Customer record.
- Customer interacts with Dialogflow Intents providing greeting, responses and failovers. Google CC AI is also queried to access KB and FAQ content as well as conversation saved for transcription.
- If transfer requested by the Customer based on a specific intent, Dialogflow will transfer Customer to new conference in order to talk to a live agent.
- Google CC API session information is passed to the Agent Assist window for the live agent to view and assist with answering Customer questions.
- Customer and live Agent connected on a call



## Resources
- [How AI is Transforming Customer Care (Cloud Next '18) conference](https://www.youtube.com/watch?v=n5vMhntiReg)
- [Overview of the integration with Google CC AI](https://www.youtube.com/watch?v=q4n1bID79Zk)
