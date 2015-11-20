[Prev](largeinstalltweaks.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](perfgraphs.md)

* * * * *

8.6. Using The Icingastats Utility
----------------------------------

8.6.1. [Introduction](icingastats.md#introduction)

8.6.2. [Usage Information](icingastats.md#usageinfo)

8.6.3. [Human-Readable Output](icingastats.md#output)

8.6.4. [PNP4Nagios Integration](icingastats.md#integration)

### 8.6.1. Introduction

A utility called **icingastats** is included in the Icinga distribution.
It is compiled and installed along with the main Icinga daemon. The
icingastats utility allows you to obtain various information about a
running Icinga process that can be very helpful in [tuning
performance](tuning.md "8.3. Tuning Icinga For Maximum Performance").
You can obtain information either in human-readable or performance data
compatible format.

### 8.6.2. Usage Information

You can run the *icingastats* utility with the **--help** option to get
usage information.

### 8.6.3. Human-Readable Output

To obtain human-readable information on the performance of a running
Icinga process, run the *icingastats* utility with the **-c** command
line argument to specify your main configuration file location like
such:

[icinga@monitoring ~]# /usr/local/icinga/bin/icingastats -c /usr/local/icinga/etc/icinga.cfg

Icinga Stats 1.13
Copyright (c) 2009 Nagios Core Development Team and Community Contributors
Copyright (c) 1999-2009 Ethan Galstad
Last Modified: 02-16-2011
License: GPL

CURRENT STATUS DATA
------------------------------------------------------




Passive Service Checks Last 1/5/15 min: 6 / 6 / 15


[icinga@monitoring ~]#
</code></pre>

As you can see, the utility displays a number of different metrics
pertaining to the Icinga process. Metrics which have multiple values are
(unless otherwise specified) min, max and average values for that
particular metric.

### 8.6.4. PNP4Nagios Integration

You can use the *icingastats* utility to display various Icinga metrics
using PNP4Nagios (or other compatible programmes). To do so, run the
*icingastats* utility using the **--mrtg** and **--data** arguments. The
**--data** argument is used to specify what statistics should be
graphed. Possible values for the **--data** argument can be found by
running the *icingastats* utility with the **--help** option.

![[Note]](../images/note.png)

Note

Information on using the *icingastats* utility to generate PNP4Nagios
graphs for Icinga performance statistics can be found
[here](perfgraphs.md "8.7. Graphing Performance Info With PNP4Nagios").

* * * * *

[Prev](largeinstalltweaks.md) | [Up](ch08.md) | [Next](perfgraphs.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
