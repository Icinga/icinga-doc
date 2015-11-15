![Icinga](../images/logofullsize.png "Icinga")

1.1. About Icinga

[Prev](ch01.md) 

Chapter 1. About

 [Next](whatsnew.md)

* * * * *

1.1. About Icinga
-----------------

1.1.1. [What is Icinga?](about.md#whatsicinga)

1.1.2. [System requirements](about.md#system_requirements)

1.1.3. [Licensing](about.md#licensing)

1.1.4. [Acknowledgements](about.md#acknowledgements)

1.1.5. [Downloading The Latest Version](about.md#downloading)

1.1.6. [Compatibility](about.md#compatibility)

### 1.1.1. What is Icinga?

Icinga is a monitoring system checking hosts and services you specify
and notifying you when things go wrong and when they recover. It runs on
multiple Linux distributions (including
[Fedora](http://fedoraproject.org/), [Ubuntu](http://www.ubuntu.com/),
and [openSuSE](http://www.opensuse.org/)) as well as several Unix
platforms (including [Solaris](http://www.sun.com/software/solaris/) and
[HP](http://www.hp.com)). The systems to be monitored can be nearly
anything connected to a network.

Some of the many features of Icinga include:

-   Monitoring of network services (SMTP, POP3, HTTP, NNTP, PING, etc.)

-   Monitoring of host resources (CPU load, disk usage, etc.)

-   Simple plugin design that allows users to easily develop their own
    service checks

-   Parallelized service checks

-   Ability to define network host hierarchy using "parent" hosts,
    allowing detection of and distinction between hosts that are down
    and those that are unreachable

-   Contact notifications when service or host problems occur and get
    resolved (via email, pager, or user-defined method)

-   Ability to define event handlers to be run during service or host
    events for proactive problem resolution

-   Automatic log file rotation

-   Support for implementing redundant monitoring hosts

-   Optional classic web interface for viewing current network status,
    notification and problem history, log file, etc.

-   Optional new Icinga web interface based on Icinga Core, IDOUtils,
    API using a modern and refreshed web 2.0 GUI showing current states,
    historical information, using cronks and filters, creating reports
    with multilanguage support

### 1.1.2. System requirements

As mentioned above you'll need a machine running Linux or a Unix
variant. If there is no precompiled version or if you want to compile
from source you need a C compiler like gcc.

![[Note]](../images/note.png)

Note

Some compilers may not be suitable. That includes the C compiler on
HP-UX which is used to compile a new kernel.

You may also want to have TCP/IP configured as most checks will require
access via the network.

You are not required to use one of the web interfaces included with
Icinga. However, if you do decide to use them, you will need additional
software:

1.  A Web-Server (preferrably [Apache](http://www.apache.org))

2.  Thomas Boutells [gd library](http://www.boutell.com/gd) Version
    1.6.3 or higher (required by the
    [statusmap](cgis.md#cgis-statusmap_cgi)- and
    [trends](cgis.md#cgis-trends_cgi)-CGIs)

3.  PHP

### 1.1.3. Licensing

Icinga is licensed under the terms of the GNU General Public License
Version 2 as published by the Free Software Foundation. This gives you
legal permission to copy, distribute and/or modify Icinga under certain
conditions. Read the 'LICENSE' file in the Icinga distribution or read
the online version of the license for more details. Icinga is provided
AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN,
MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.

### 1.1.4. Acknowledgements

Several people have contributed to Icinga by either reporting bugs,
suggesting improvements, writing plugins, etc. A list of some of the
many contributors to the development of Icinga can be found at
[https://www.icinga.org/](http://www.icinga.org/team).

### 1.1.5. Downloading The Latest Version

You can check for new versions of Icinga at
[https://www.icinga.org/](http://www.icinga.org/).

### 1.1.6. Compatibility

Icinga is a fork of the well-known monitoring system
[Nagios](http://www.nagios.org/). Being 100% compatible with the
internal structures of the latter Icinga enables you to use all plugins
and add-ons which were/are developed by several companies and the large
community.

* * * * *

  -------------------- -------------------- ---------------------------------
  [Prev](ch01.md)    [Up](ch01.md)       [Next](whatsnew.md)
  Chapter 1. About     [Home](index.md)    1.2. What's New in Icinga 1.13
  -------------------- -------------------- ---------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
