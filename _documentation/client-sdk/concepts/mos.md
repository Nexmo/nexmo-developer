---
title: Measuring Voice Or Video Quality
description: Information on how to measure voice and video quality.
---

# Measuring Voice Or Video Quality

The overall quality of a voice or video stream is often depicted through a metric called [*Mean Opinion Score (MOS)*](https://en.wikipedia.org/wiki/Mean_opinion_score).

It is common that MOS is represented as a rational number, or a float type variable, between 1 and 5, with the following scale:

1. Bad
2. Poor
3. Fair
4. Good
5. Excellent

Frequently, MOS higher than 4 reflects a satisfying quality. For MOS higher than 4.3, the human senses cannot usually perceive an increase in quality. On the lower side, when MOS is lower than 3.5, commonly the quality isn’t sufficient, especially for communication purposes.


### How is MOS calculated?

The MOS is [calculated using a formula](https://docs.telcobridges.com/tbwiki/MOS), which utilizes multiple features of the data stream passed over the network via the stats WebRTC exposes. Among those features, the ones with the most significant impact are:

* Packet loss - the amount of data packets that never made it from the sender to the receiver

* Latency - the time it takes a data packet to get from the sender to the receiver, and back to the sender

* Jitter - the difference between the latency of one data flow to the other. In other words, how delayed was a received data packet, comparing to the previously received data packet


An R-value is calculated based on those factors and is later used to calculate the final MOS, by the following formula:  
> MOS = 1 + 0.035R + ((R - 60) * (100 – R) * 0.000007R)

The MOS score reflects the quality of the audio or video stream that a participant receives. It is hence a direct reflection of that user's experience of the quality. It is entirely possible that in a single call, two participants can have different MOS scores since it is influenced by conditions such as the device, the local network quality (e.g. WiFi strength), the global network quality (e.g. WiFi, 3G, EDGE), or the infrastructure of any service used to connect calls.


### What a MOS can be used for

Among typical usages are

* Indicating overall call quality through a UI element

* Automatically dropping the call when MOS is insufficient

* Triggering a fallback to another communication channel. For example from in-app call via IP to a telephony call via PSTN
