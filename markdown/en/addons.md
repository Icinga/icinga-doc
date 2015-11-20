[Prev](ch10.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](nrpe.md)

* * * * *

10.1. Icinga Addons
-------------------

10.1.1. [Introduction](addons.md#introduction_addons)

### 10.1.1. Introduction

There are a lot of "addon" software packages that are available for
Icinga. Addons can be used to extend Icinga's functionality or integrate
Icinga with other applications.

Addons are available for:

















You can find many addons for Icinga by visiting:


First we'll give a brief introduction to a few of the addons that Ethan
Galstad developed for Nagios...

**NRPE**

![](../images/nrpe.png)

NRPE is an addon that allows you to execute
[plugins](plugins.md "5.1. Icinga Plugins") on remote Linux/Unix
hosts. This is useful if you need to monitor local resources/attributes
like disk usage, CPU load, memory usage, etc. on a remote host. Similiar
functionality can be accomplished by using the *check\_by\_ssh* plugin,
especially if you are monitoring hundreds or thousands of hosts.

The NRPE addon can be found at
[http://sourceforge.net/projects/nagios/files/nrpe-2.x/](http://sourceforge.net/projects/nagios/files/nrpe-2.x/).
You will find some [documentation](nrpe.md "10.2. NRPE") in the next
section.

**NSCA-ng**

![](../images/nsca.png)

NSCA-ng (a replacement for NSCA) is an addon that allows you to send
[passive check](passivechecks.md "5.7. Passive Checks") results from
remote Linux/Unix hosts to the Icinga daemon running on the monitoring
server. This is very useful in
[distributed](distributed.md "7.6. Distributed Monitoring") and
[redundant/failover](redundancy.md "7.7. Redundant and Failover Network Monitoring")
monitoring setups.

The NSCA-ng addon can be found at
[http://www.nsca-ng.org/](http://www.nsca-ng.org/). Apart from that you
will find some [documentation](nsca.md "10.3. NSCA") on NSCA in the
next section.

**IDOUtils**

![](../images/idoutils.png)

IDOUtils is an addon that allows you to store all status information
from Icinga in a database. Multiple instances of Icinga can all store
their information in a central database for centralized reporting. In
the future it will probably be used as a basis for a PHP based web
interface.

The IDOUtils addon install instructions can be found in the
[Quickstart-Idoutils](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")
and more documentation can be found at
[http://docs.icinga.org/](http://docs.icinga.org/latest/en/).

* * * * *

[Prev](ch10.md) | [Up](ch10.md) | [Next](nrpe.md)

Chapter 10. Additional software  |<=== [Index](index.md) ===>|  10.2. NRPE

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
