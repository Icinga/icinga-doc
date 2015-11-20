[Prev](monitoring-printers.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](monitoring-publicservices.md)

* * * * *

2.17. Monitoring Routers and Switches
-------------------------------------

2.17.1. [Introduction](monitoring-routers.md#introduction_routers)

2.17.2. [Overview](monitoring-routers.md#overview)

2.17.3. [Steps](monitoring-routers.md#steps)

2.17.4. [What's Already Done For You](monitoring-routers.md#whatsdone)

2.17.5. [Prerequisites](monitoring-routers.md#prereuisites)

2.17.6. [Configuring Icinga](monitoring-routers.md#configicinga)

2.17.7. [Restarting Icinga](monitoring-routers.md#restarticinga)

### 2.17.1. Introduction

![](../images/switch.png)

This document describes how you can monitor the status of network
switches and routers. Some cheaper "unmanaged" switches and hubs don't
have IP addresses and are essentially invisible on your network, so
there's not any way to monitor them. More expensive switches and routers
have addresses assigned to them and can be monitored by pinging them or
using SNMP to query status information.

We'll describe how you can monitor the following things on managed
switches, hubs, and routers:




![[Note]](../images/note.png)

Note

These instructions assume that you've installed Icinga according to the
[quickstart
guide](quickstart.md "2.3. Quickstart Installation Guides"). The
sample configuration entries below reference objects that are defined in
the sample config files (*commands.cfg*, *templates.cfg*, etc.) that are
installed when you follow the quickstart.

If you installed a package then the sample files might be missing. The
contents is listed
[here](sample-config.md "13.1. Sample configuration files and definitions")
for reference.

### 2.17.2. Overview

![](../images/monitoring-routers.png)

depending on what equipment you have and what you want to monitor. As
they are critical infrastructure components, you'll no doubt want to
monitor them in at least some basic manner.

Switches and routers can be monitored easily by "pinging" them to
determine packet loss, RTA, etc. If your switch supports SNMP, you can
monitor port status, etc. with the *check\_snmp* plugin and bandwidth
(if you're using MRTG) with the *check\_mrtgtraf* plugin.

The *check\_snmp* plugin will only get compiled and installed if you
have the net-snmp and net-snmp-utils packages installed on your system.
Make sure the plugin exists in */usr/local/icinga/libexec* before you
continue. If it doesn't, install net-snmp and net-snmp-utils and
recompile/reinstall the Icinga plugins.

### 2.17.3. Steps

There are several steps you'll need to follow in order to monitor a new
router or switch. They are:




### 2.17.4. What's Already Done For You

To make your life a bit easier, a few configuration tasks have already
been done for you:



The above-mentioned config files can be found in the
*/usr/local/icinga/etc/objects/* directory. You can modify the
definitions in these and other definitions to suit your needs better if
you'd like. However, we'd recommend waiting until you're more familiar
with configuring Icinga before doing so. For the time being, just follow
the directions outlined below and you'll be monitoring your network
routers/switches in no time.

### 2.17.5. Prerequisites

The first time you configure Icinga to monitor a network switch, you'll
need to do a bit of extra work. Remember, you only need to do this for
the \*first\* switch you monitor.

Edit the main Icinga config file.

#> vi /usr/local/icinga/etc/icinga.cfg
</code></pre>

Remove the leading hash (\#) sign from the following line in the main
configuration file:

<pre><code>
 #cfg_file=/usr/local/icinga/etc/objects/switch.cfg
</code></pre>

Save the file and exit.

What did you just do? You told Icinga to look to the
*/usr/local/icinga/etc/objects/switch.cfg* to find additional object
definitions. That's where you'll be adding host and service definitions
for routers and switches. That configuration file already contains some
sample host, hostgroup, and service definitions. For the \*first\*
router/switch you monitor, you can simply modify the sample host and
service definitions in that file, rather than creating new ones.

### 2.17.6. Configuring Icinga

You'll need to create some [object
definitions](objectdefinitions.md "3.4. Object Definitions") in order
to monitor a new router/switch.

Open the *switch.cfg* file for editing.

#> vi /usr/local/icinga/etc/objects/switch.cfg
</code></pre>

Add a new [host](objectdefinitions.md#objectdefinitions-host)
definition for the switch that you're going to monitor. If this is the
\*first\* switch you're monitoring, you can simply modify the sample
host definition in *switch.cfg*. Change the *host\_name*, *alias*, and
*address* fields to appropriate values for the switch.

<pre><code>
 define host{
</code></pre>

**Monitoring Services**

Now you can add some service definitions (to the same configuration
file) to monitor different aspects of the switch. If this is the
\*first\* switch you're monitoring, you can simply modify the sample
service definition in *switch.cfg*.

![[Note]](../images/note.png)

Note

Replace "*linksys-srw224p*" in the example definitions below with the
name you specified in the *host\_name* directive of the host definition
you just added.

























Save the file.

### 2.17.7. Restarting Icinga

Once you've added the new host and service definitions to the
*switch.cfg* file, you're ready to start monitoring the router/switch.
To do this, you'll need to [verify your
configuration](verifyconfig.md "4.1. Verifying Your Configuration")
and [restart
Icinga](startstop.md "4.2. Starting and Stopping Icinga").

If the verification process produces any errors messages, fix your
configuration file before continuing. Make sure that you don't (re)start
Icinga until the verification process completes without any errors!

* * * * *

[Prev](monitoring-printers.md) | [Up](ch02.md) | [Next](monitoring-publicservices.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
