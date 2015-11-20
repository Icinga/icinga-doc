[Prev](embeddedperl.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](dependencychecks.md)

* * * * *

7.19. Adaptive Monitoring
-------------------------

7.19.1. [Introduction](adaptive.md#introduction_adaptive)

7.19.2. [What Can Be Changed?](adaptive.md#changed)

7.19.3. [External Commands For Adaptive
Monitoring](adaptive.md#extcommandsadaptive)

### 7.19.1. Introduction

Icinga allows you to change certain commands and host and service check
attributes during runtime. I'll refer to this feature as "adaptive
monitoring". Please note that the adaptive monitoring features found in
Icinga will probably not be of much use to 99% of users, but they do
allow you to do some neat things.

### 7.19.2. What Can Be Changed?

The following service check attributes can be changed during runtime:






The following host check attributes can be changed during runtime:






The following global attributes can be changed during runtime:



### 7.19.3. External Commands For Adaptive Monitoring

In order to change global or host- or service-specific attributes during
runtime, you must submit the appropriate [external
command](extcommands.md "7.1. External Commands") to Icinga via the
[external command file](configmain.md#configmain-command_file). The
table below lists the different attributes that may be changed during
runtime, along with the external command to accomplish the job.

A full listing of external commands that can be used for adaptive
monitoring can be found in the [list of external
commands](extcommands2.md "7.2. List of External Commands").

![[Note]](../images/note.png)

Note



* * * * *

[Prev](embeddedperl.md) | [Up](ch07.md) | [Next](dependencychecks.md)

7.18. Using The Embedded Perl Interpreter  |<=== [Index](index.md) ===>|  7.20. Predictive Dependency Checks

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
