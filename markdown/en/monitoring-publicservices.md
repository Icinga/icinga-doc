[Prev](monitoring-routers.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch03.md)

* * * * *

2.18. Monitoring Publicly Available Services
--------------------------------------------

2.18.1.
[Introduction](monitoring-publicservices.md#introduction_publicservices)

2.18.2. [Plugins for Monitoring
Services](monitoring-publicservices.md#pluginsformonitoringservices)

2.18.3. [Creating a Host
Definition](monitoring-publicservices.md#createhostdefinition)

2.18.4. [Creating Service
Definitions](monitoring-publicservices.md#createservicedefinition)

2.18.5. [Restarting
Icinga](monitoring-publicservices.md#restarticinga)

### 2.18.1. Introduction

This document describes how you can monitor publicly available services,
applications and protocols. By "public" we mean services that are
Internet. Examples of public services include HTTP, POP3, IMAP, FTP, and
SSH. There are many more public services that you probably use on a
daily basis. These services and applications, as well as their
underlying protocols, can usually be monitored by Icinga without any
special access requirements.

Private services, in contrast, cannot be monitored with Icinga without
an intermediary agent of some kind. Examples of private services
associated with hosts are things like CPU load, memory usage, disk
usage, current user count, process information, etc. These private
services or attributes of hosts are not usually exposed to external
clients. This situation requires that an intermediary monitoring agent
be installed on any host that you need to monitor such information on.
More information on monitoring private services on different types of
hosts can be found in the documentation on:




![[Tip]](../images/tip.png)

Tip

Occasionally you will find that information on private services and
applications can be monitored with SNMP. The SNMP agent allows you to
remotely monitor otherwise private (and inaccessible) information about
the host. For more information about monitoring services using SNMP,
check out the documentation on [monitoring switches and
routers](monitoring-routers.md "2.17. Monitoring Routers and Switches").

![[Note]](../images/note.png)

Note

These instructions assume that you've installed Icinga according to the
[quickstart
guide](quickstart.md "2.3. Quickstart Installation Guides"). The
sample configuration entries below reference objects that are defined in
the sample *commands.cfg* and *localhost.cfg* config files.

If you installed a package then the sample files might be missing. The
contents is listed
[here](sample-config.md "13.1. Sample configuration files and definitions")
for reference.

### 2.18.2. Plugins for Monitoring Services

When you find yourself needing to monitor a particular application,
service, or protocol, chances are good that a
[plugin](plugins.md "5.1. Icinga Plugins") exists to monitor it. The
official Nagios plugins distribution comes with plugins that can be used
to monitor a variety of services and protocols. There are also a large
number of contributed plugins that can be found in the *contrib/*
subdirectory of the plugin distribution. The [Icinga
Exchange](https://exchange.icinga.org) website hosts a number of
additional plugins that have been written by users, so check it out when
you have a chance.

If you don't happen to find an appropriate plugin for monitoring what
you need, you can always write your own. Plugins are easy to write, so
don't let this thought scare you off. Read the documentation on
[developing plugins](pluginapi.md "11.1. Icinga Plugin API") for more
information.

We'll walk you through monitoring some basic services that you'll
probably use sooner or later. Each of these services can be monitored
using one of the plugins that gets installed as part of the Nagios
plugins distribution. Let's get started...

### 2.18.3. Creating a Host Definition

Before you can monitor a service, you first need to define a
[host](objectdefinitions.md#objectdefinitions-host) that is associated
with the service. You can place host definitions in any object
configuration file specified by a
[cfg\_file](configmain.md#configmain-cfg_file) directive or placed in
a directory specified by a
[cfg\_dir](configmain.md#configmain-cfg_dir) directive. If you have
already created a host definition, you can skip this step.

For this example, lets say you want to monitor a variety of services on
a remote host. Let's call that host *remotehost*. The host definition
can be placed in its own file or added to an already exiting object
configuration file. Here's what the host definition for *remotehost*
might look like:

<pre><code>
 define host{
</code></pre>

Now that a definition has been added for the host that will be
monitored, we can start defining services that should be monitored. As
with host definitions, service definitions can be placed in any object
configuration file.

### 2.18.4. Creating Service Definitions

For each service you want to monitor, you need to define a
[service](objectdefinitions.md#objectdefinitions-service) in Icinga
that is associated with the host definition you just created. You can
place service definitions in any object configuration file specified by
a [cfg\_file](configmain.md#configmain-cfg_file) directive or placed
in a directory specified by a
[cfg\_dir](configmain.md#configmain-cfg_dir) directive.

Some example service definitions for monitoring common public service
(HTTP, FTP, etc) are given below.





















































### 2.18.5. Restarting Icinga

Once you've added the new host and service definitions to your object
configuration file(s), you're ready to start monitoring them. To do
this, you'll need to [verify your
configuration](verifyconfig.md "4.1. Verifying Your Configuration")
and [restart
Icinga](startstop.md "4.2. Starting and Stopping Icinga").

If the verification process produces any errors messages, fix your
configuration file before continuing. Make sure that you don't (re)start
Icinga until the verification process completes without any errors!

* * * * *

[Prev](monitoring-routers.md) | [Up](ch02.md) | [Next](ch03.md)

2.17. Monitoring Routers and Switches  |<=== [Index](index.md) ===>|  Chapter 3. Configuring Icinga

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
