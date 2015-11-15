![Icinga](../images/logofullsize.png "Icinga")

8.6. Using The Icingastats Utility

[Prev](largeinstalltweaks.md) 

Chapter 8. Security and Performance Tuning

 [Next](perfgraphs.md)

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

~~~~ {.screen}
[icinga@monitoring ~]# /usr/local/icinga/bin/icingastats -c /usr/local/icinga/etc/icinga.cfg

Icinga Stats 1.13
Copyright (c) 2009 Nagios Core Development Team and Community Contributors
Copyright (c) 1999-2009 Ethan Galstad
Last Modified: 02-16-2011
License: GPL

CURRENT STATUS DATA
------------------------------------------------------
Status File:                            /usr/local/icinga/var/status.dat
Status File Age:                        0d 0h 0m 27s
Status File Version:                    1.3.0

Program Running Time:                   0d 14h 28m 16s
Icinga PID:                             21182
Used/High/Total Command Buffers:        0 / 3 / 4096

Total Services:                         1001
Services Checked:                       945
Services Scheduled:                     950
Services Actively Checked:              1000
Services Passively Checked:             1
Total Service State Change:             0.000 / 100.000 / 1.881 %
Active Service Latency:                 0.000 / 285.165 / 25.045 sec
Active Service Execution Time:          0.000 / 304.925 / 0.834 sec
Active Service State Change:            0.000 / 100.000 / 1.883 %
Active Services Last 1/5/15/60 min:     20 / 191 / 471 / 926
Passive Service Latency:                0.862 / 0.862 / 0.862 sec
Passive Service State Change:           0.000 / 0.000 / 0.000 %
Passive Services Last 1/5/15/60 min:    1 / 1 / 1 / 1
Services Ok/Warn/Unk/Crit:              816 / 56 / 51 / 78
Services Flapping:                      39
Services In Downtime:                   0

Total Hosts:                            111
Hosts Checked:                          104
Hosts Scheduled:                        104
Hosts Actively Checked:                 111
Host Passively Checked:                 0
Total Host State Change:                0.000 / 100.000 / 10.574 %
Active Host Latency:                    0.000 / 279.257 / 21.700 sec
Active Host Execution Time:             0.000 / 6.405 / 0.432 sec
Active Host State Change:               0.000 / 100.000 / 10.574 %
Active Hosts Last 1/5/15/60 min:        17 / 50 / 74 / 104
Passive Host Latency:                   0.000 / 0.000 / 0.000 sec
Passive Host State Change:              0.000 / 0.000 / 0.000 %
Passive Hosts Last 1/5/15/60 min:       0 / 0 / 0 / 0
Hosts Up/Down/Unreach:                  89 / 7 / 15
Hosts Flapping:                         22
Hosts In Downtime:                      0

Active Host Checks Last 1/5/15 min:     73 / 97 / 246
   Scheduled:                           13 / 21 / 50
   On-demand:                           60 / 76 / 196
   Parallel:                            45 / 63 / 171
   Serial:                              0 / 0 / 0
   Cached:                              28 / 34 / 75
Passive Host Checks Last 1/5/15 min:    0 / 0 / 0
Active Service Checks Last 1/5/15 min:  142 / 192 / 501
   Scheduled:                           142 / 192 / 500
   On-demand:                           0 / 0 / 1
   Cached:                              0 / 0 / 0
Passive Service Checks Last 1/5/15 min: 6 / 6 / 15

External Commands Last 1/5/15 min:      6 / 6 / 15

[icinga@monitoring ~]#
~~~~

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

  ---------------------------------- -------------------- -------------------------------------------------
  [Prev](largeinstalltweaks.md)    [Up](ch08.md)       [Next](perfgraphs.md)
  8.5. Large Installation Tweaks     [Home](index.md)    8.7. Graphing Performance Info With PNP4Nagios
  ---------------------------------- -------------------- -------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
