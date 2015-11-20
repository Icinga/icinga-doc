[Prev](monitoring-windows.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](monitoring-netware.md)

* * * * *

2.14. Monitoring Linux/Unix Machines
------------------------------------

2.14.1. [Introduction](monitoring-linux.md#introduction_linux)

2.14.2. [Overview](monitoring-linux.md#overview)

### 2.14.1. Introduction

This document describes how you can monitor "private" services and
attributes of Linux/UNIX servers, such as:







Publicly available services that are provided by Linux servers (HTTP,
FTP, SSH, SMTP, etc.) can be monitored easily by following the
documentation on [monitoring publicly available
services](monitoring-publicservices.md "2.18. Monitoring Publicly Available Services").

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

### 2.14.2. Overview

![[Note]](../images/note.png)

Note

This document has not been completed. We would recommend you read the
documentation on the [NRPE addon](addons.md#addons-nrpe) for
instructions on how to monitor a remote Linux/Unix server.

There are several different ways to monitor attributes or remote
Linux/Unix servers. One is by using shared SSH keys and the
*check\_by\_ssh* plugin to execute plugins on remote servers. This
method will not be covered here, but can result in high load on your
monitoring server if you are monitoring hundreds or thousands of
services. The overhead of setting up/destroying SSH connections is the
cause of this.

![](../images/nrpe.png)

Another common method of monitoring remote Linux/Unix hosts is to use
the [NRPE addon](addons.md#addons-nrpe). NRPE allows you to execute
plugins on remote Linux/Unix hosts. This is useful if you need to
monitor local resources/attributes like disk usage, CPU load, memory
usage, etc. on a remote host.

* * * * *

[Prev](monitoring-windows.md) | [Up](ch02.md) | [Next](monitoring-netware.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
