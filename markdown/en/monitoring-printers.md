[Prev](monitoring-netware.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](monitoring-routers.md)

* * * * *

2.16. Monitoring Network Printers
---------------------------------

2.16.1. [Introduction](monitoring-printers.md#introduction_printers)

2.16.2. [Overview](monitoring-printers.md#overview)

2.16.3. [Steps](monitoring-printers.md#steps)

2.16.4. [What's Already Done For
You](monitoring-printers.md#whatsdone)

2.16.5. [Prerequisites](monitoring-printers.md#prerequisites)

2.16.6. [Configuring Icinga](monitoring-printers.md#configicinga)

2.16.7. [Restarting Icinga](monitoring-printers.md#restarticinga)

### 2.16.1. Introduction

![](../images/printer.png)

This document describes how you can monitor the status of networked
printers. Specifically, HP printers that have internal/external
JetDirect cards/devices, or other print servers (like the Troy PocketPro
100S or the Netgear PS101) that support the JetDirect protocol.

The *check\_hpjd* plugin (which is part of the standard Nagios plugins
distribution) allows you to monitor the status of JetDirect-capable
printers which have SNMP enabled. The plugin is capable of detecting the
following printer states:










![[Note]](../images/note.png)

Note

These instructions assume that you've installed Icinga according to the
[quickstart
guide](quickstart.md "2.3. Quickstart Installation Guides"). The
sample configuration entries below reference objects that are defined in
the sample config files (*commands.cfg*, *templates.cfg*, etc.) that are
installed if you follow the quickstart.

If you installed a package then the sample files might be missing. The
contents is listed
[here](sample-config.md "13.1. Sample configuration files and definitions")
for reference.

### 2.16.2. Overview

![](../images/monitoring-printers.png)

Monitoring the status of a networked printer is pretty simple.
JetDirect-enabled printers usually have SNMP enabled, which allows
Icinga to monitor their status using the *check\_hpjd* plugin.

![[Important]](../images/important.png)

Important

The *check\_hpjd* plugin will only get compiled and installed if you
have the net-snmp and net-snmp-utils packages installed on your system.
Make sure the plugin exists in */usr/local/icinga/libexec* before you
continue. If it doesn't, install net-snmp and net-snmp-utils and
recompile/reinstall the Nagios plugins after issuing "make clean" in the
source directory. Take a look at the [Quickstart
Guide](quickstart-icinga.md "2.4. Icinga Quickstart") for details.

### 2.16.3. Steps

There are several steps you'll need to follow in order to monitor a new
network printer. They are:




### 2.16.4. What's Already Done For You

To make your life a bit easier, a few configuration tasks have already
been done for you:



The above-mentioned config files can be found in the
*/usr/local/icinga/etc/objects/* directory. You can modify the
definitions in these and other definitions to suit your needs better if
you'd like. However, we'd recommend waiting until you're more familiar
with configuring Icinga before doing so. For the time being, just follow
the directions outlined below and you'll be monitoring your network
printers in no time.

### 2.16.5. Prerequisites

The first time you configure Icinga to monitor a network printer, you'll
need to do a bit of extra work. Remember, you only need to do this for
the \*first\* printer you monitor.

Edit the main Icinga config file.

#> vi /usr/local/icinga/etc/icinga.cfg
</code></pre>

Remove the leading hash (\#) sign from the following line in the main
configuration file:

<pre><code>
 #cfg_file=/usr/local/icinga/etc/objects/printer.cfg
</code></pre>

Save the file and exit.

What did you just do? You told Icinga to look to the
*/usr/local/icinga/etc/objects/printer.cfg* to find additional object
definitions. That's where you'll be adding host and service definitions
for the printer. That configuration file already contains some sample
host, hostgroup, and service definitions. For the \*first\* printer you
monitor, you can simply modify the sample host and service definitions
in that file, rather than creating new ones.

### 2.16.6. Configuring Icinga

You'll need to create some [object
definitions](objectdefinitions.md "3.4. Object Definitions") in order
to monitor a new printer.

Open the *printer.cfg* file for editing.

#> vi /usr/local/icinga/etc/objects/printer.cfg
</code></pre>

Add a new [host](objectdefinitions.md#objectdefinitions-host)
definition for the networked printer that you're going to monitor. If
this is the \*first\* printer you're monitoring, you can simply modify
the sample host definition in *printer.cfg*. Change the *host\_name*,
*alias*, and *address* fields to appropriate values for the printer.

<pre><code>
 define host{
</code></pre>

Now you can add some service definitions (to the same configuration
file) to monitor different aspects of the printer. If this is the
\*first\* printer you're monitoring, you can simply modify the sample
service definition in *printer.cfg*.

![[Note]](../images/note.png)

Note

Replace "*hplj2605dn*" in the example definitions below with the name
you specified in the *host\_name* directive of the host definition you
just added.

Add the following service definition to check the status of the printer.
The service uses the *check\_hpjd* plugin to check the status of the
printer every 10 minutes by default. The SNMP community string used to
query the printer is "public" in this example.

<pre><code>
 define service{
</code></pre>

Add the following service definition to ping the printer every 10
minutes by default. This is useful for monitoring RTA, packet loss, and
general network connectivity.

<pre><code>
 define service{
</code></pre>

Save the file.

### 2.16.7. Restarting Icinga

Once you've added the new host and service definitions to the
*printer.cfg* file, you're ready to start monitoring the printer. To do
this, you'll need to [verify your
configuration](verifyconfig.md "4.1. Verifying Your Configuration")
and [restart
Icinga](startstop.md "4.2. Starting and Stopping Icinga").

If the verification process produces any errors messages, fix your
configuration file before continuing. Make sure that you don't (re)start
Icinga until the verification process completes without any errors!

* * * * *

[Prev](monitoring-netware.md) | [Up](ch02.md) | [Next](monitoring-routers.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
