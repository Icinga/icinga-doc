![Icinga](../images/logofullsize.png "Icinga")

9.1. Integration Overview

[Prev](ch09.md) 

Chapter 9. Integration With Other Software

 [Next](int-snmptrap.md)

* * * * *

9.1. Integration Overview
-------------------------

9.1.1. [Introduction](integration.md#introduction)

9.1.2. [Integration Points](integration.md#points)

9.1.3. [Integration Examples](integration.md#examples)

### 9.1.1. Introduction

Icinga can be easily integrated in your existing infrastructure. There
are several methods of integrating Icinga with the management software
you're already using and you can monitor almost any type of new or
custom hardware, service, or application that you might have.

### 9.1.2. Integration Points

![](../images/integrationoverview.png)

To monitor new hardware, services, or applications, check out the docs
on:

-   [Plugins](plugins.md "5.1. Icinga Plugins")

-   [Plugin API](pluginapi.md "11.1. Icinga Plugin API")

-   [Passive Checks](passivechecks.md "5.7. Passive Checks")

-   [Event Handlers](eventhandlers.md "7.3. Event Handlers")

To get data into Icinga from external applications, check out the docs
on:

-   [Passive Checks](passivechecks.md "5.7. Passive Checks")

-   [External Commands](extcommands.md "7.1. External Commands")

To send status, performance, or notification information from Icinga to
external applications, check out the docs on:

-   [Event Handlers](eventhandlers.md "7.3. Event Handlers")

-   [OCSP](configmain.md#configmain-ocsp_command) and
    [OCHP](configmain.md#configmain-ochp_command) Commands

-   [Performance Data](perfdata.md "7.15. Performance Data")

-   [Notifications](notifications.md "5.11. Notifications")

### 9.1.3. Integration Examples

The following documents show some examples on how to integrate Icinga
with external applications:

-   [TCP Wrappers](int-tcpwrappers.md "9.3. TCP Wrapper Integration")
    (security alerts)

-   [SNMP Traps](int-snmptrap.md "9.2. SNMP Trap Integration")
    (Arcserve backup job status)

-   [mklivestatus](int-mklivestatus.md "9.4. MKLiveStatus Integration")
    (interface from Icinga to several addons like
    [NagVis](http://www.nagvis.org) and [Thruk](http://www.thruk.org))

* * * * *

  --------------------------------------------- -------------------- -----------------------------
  [Prev](ch09.md)                             [Up](ch09.md)       [Next](int-snmptrap.md)
  Chapter 9. Integration With Other Software    [Home](index.md)    9.2. SNMP Trap Integration
  --------------------------------------------- -------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
