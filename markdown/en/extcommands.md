[Prev](ch07.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](extcommands2.md)

* * * * *

7.1. External Commands
----------------------

7.1.1. [Introduction](extcommands.md#introduction)

7.1.2. [Enabling External Commands](extcommands.md#enable)

7.1.3. [When Does Icinga Check For External
Commands?](extcommands.md#whenchecked)

7.1.4. [Using External Commands](extcommands.md#usage)

7.1.5. [Command Format](extcommands.md#format)

7.1.6. [External Commands List](extcommands.md#externalcommandslist)

### 7.1.1. Introduction

Icinga can process commands from external applications (including the
CGIs) and alter various aspects of its monitoring functions based on the
commands it receives. External applications can submit commands by
writing to the [command file](configmain.md#configmain-command_file),
which is periodically processed by the Icinga daemon.

![](../images/externalcommands.png)

### 7.1.2. Enabling External Commands

In order to have Icinga process external commands, make sure you do the
following:





### 7.1.3. When Does Icinga Check For External Commands?



### 7.1.4. Using External Commands

External commands can be used to accomplish a variety of things while
Icinga is running. Example of what can be done include temporarily
disabling notifications for services and hosts, temporarily disabling
service checks, forcing immediate service checks, adding comments to
hosts and services, etc.

### 7.1.5. Command Format

External commands that are written to the [command
file](configmain.md#configmain-command_file) have the following
format...

</code></pre> 
</code></pre>

...where *time* is the time (in *time\_t* format) that the external
application submitted the external command to the command file. The
values for the *command\_id* and *command\_arguments* arguments will
depend on what command is being submitted to Icinga.

### 7.1.6. External Commands List

A full listing of external commands that can be used can be found in the
[list of external
commands](extcommands2.md "7.2. List of External Commands") in the
development section.

* * * * *

[Prev](ch07.md) | [Up](ch07.md) | [Next](extcommands2.md)

Chapter 7. Advanced Topics  |<=== [Index](index.md) ===>|  7.2. List of External Commands

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
