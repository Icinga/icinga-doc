[Prev](icingastats.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](temp_data.md)

* * * * *

8.7. Graphing Performance Info With PNP4Nagios
----------------------------------------------

8.7.1. [Introduction](perfgraphs.md#introduction)

8.7.2. [Prerequisites](perfgraphs.md#prerequisites)

8.7.3. [Average Host / Service Check
Latency](perfgraphs.md#avghostsvcchecklatency)

8.7.4. [Service Statistics](perfgraphs.md#servicestatistics)

8.7.5. [Host Statistics](perfgraphs.md#hoststatistics)

8.7.6. [Average Execution Times](perfgraphs.md#avgexecutiontimes)

8.7.7. [External Commands](perfgraphs.md#externalcommands)

8.7.8. [External Command
Buffers](perfgraphs.md#externalcommandbuffers)

8.7.9. [Cached Host and Service Checks](perfgraphs.md#idp15978528)

8.7.10. [Average State Changes](perfgraphs.md#avgstatechanges)

### 8.7.1. Introduction

The [icingastats](icingastats.md "8.6. Using The Icingastats Utility")
utility allows you to graph various Icinga performance statistics over
time using [PNP4Nagios](http://docs.pnp4nagios.org/pnp-0.6/start). This
is important because it can help you to:




### 8.7.2. Prerequisites

PNP4Nagios is one of the most popular addons due to easy installation
and little maintenance during operation. The documentation along with
further links to download the software can be found at
[http://docs.pnp4nagios.org/pnp-0.6/start](http://docs.pnp4nagios.org/pnp-0.6/start).

[check\_nagiostats](https://www.monitoringexchange.org/inventory/Check-Plugins/Software/Nagios/check_nagiostats)
was published by [Jochen
Bern](http://www.nagios-portal.org/wbb/index.php?page=User&userID=7773)
and can be called as an active service check or via crontab to submit
passive check results. Despite its name it can be used for Icinga as
well.
























**Example Graphs**

We'll describe what the graphs produced by `check_nagiostats`
mean and what they can be used for...

### 8.7.3. Average Host / Service Check Latency

**Figure 8.1. Average Host / Service Check Latency**

![Average Host / Service Check Latency](../images/perfdata_lat.png)

\

This graph shows the average latency times of hosts and services over
time for both active and passive checks, respectively. Useful for
understanding:






Consistently high latencies can be an indication that one or more of the
following variables need tweaking:




### 8.7.4. Service Statistics

**Figure 8.2. Service Statistics**

![Service Statistics](../images/perfdata_svc.png)

\

This graph shows the values for the several service states along with
the average number of services being checked actively/passively within
the timeperiod you specified. Useful for understanding:





### 8.7.5. Host Statistics

**Figure 8.3. Host Statistics**

![Host Statistics](../images/perfdata_host.png)

\

This graph shows the values for the several host states along with the
average number of hosts being checked actively/passively within the
timeperiod you specified. Useful for understanding:





### 8.7.6. Average Execution Times

**Figure 8.4. Average Execution Times**

![Average Execution Times](../images/perfdata_exec.png)

\

This graph shows the average execution times of hosts and services over
time. Useful for understanding:




![[Note]](../images/note.png)

Note

To be honest: We tweaked the graphs a bit, meaning the colours. Yellow
is sometimes hard to distinguish from the background so we changed some
lines in the PNP4Nagios template file
`template.dist/nagiostats.php` from `$i=0;` to
`$i=1;`.

**Additional graphs**

Well, we tweaked the template a bit more because the plugin delivers the
data but there aren't appropriate graphs (but looking at the template
file it is very easy to add the lines if you really need the following
graphs).

### 8.7.7. External Commands

**Figure 8.5. External Commands**

![External Commands](../images/perfdata_extcmd.png)

\

This graph shows how may external commands have been processed by the
Icinga daemon over time. Unless you're processing a large number of
external commands (as in the case with distributed monitoring setups),
this graph may appear mostly empty. Monitoring external commands can be
useful for understanding the impacts of:




### 8.7.8. External Command Buffers

**Figure 8.6. External Command Buffers**

![External Command Buffers](../images/perfdata_cmdbuf.png)

\

This graph shows how many external command buffer slots are in use over
time. If the number of used buffers is near the number of available
buffers on a regular basis, it is likely you need to increase the
available [external command buffer
slots](configmain.md#configmain-external_command_buffer_slots). Each
buffer slot can hold one external command. Buffers are used for
temporarily holding external commands from the time they are read from
the [external command file](configmain.md#configmain-command_file) to
the time they are processed by the Icinga daemon.

As you can see just one buffer is used and that's the one for the graphs
as mentioned above.

### 8.7.9. Cached Host and Service Checks

**Figure 8.7. Cached Host and Service Checks**

![Cached Host and Service Checks](../images/perfdata_cached.png)

\

This graph shows how may cached host and service checks have occurred
over time. Useful for understanding:



### 8.7.10. Average State Changes

**Figure 8.8. Average State Changes**

![Average State Changes](../images/perfdata_state_chg.png)

\

This graph shows the average percent state change (a measure of
volatility) over time, broken down by hosts and services that were last
checked either actively or passively. Useful for understanding:


* * * * *

[Prev](icingastats.md) | [Up](ch08.md) | [Next](temp_data.md)

8.6. Using The Icingastats Utility  |<=== [Index](index.md) ===>|  8.8. Temporary Data

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
