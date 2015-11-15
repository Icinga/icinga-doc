![Icinga](../images/logofullsize.png "Icinga")

7.19. Adaptive Monitoring

[Prev](embeddedperl.md) 

Chapter 7. Advanced Topics

 [Next](dependencychecks.md)

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

-   Check command (and command arguments)

-   Check interval

-   Max check attempts

-   Check timeperiod

-   Event handler command (and command arguments)

The following host check attributes can be changed during runtime:

-   Check command (and command arguments)

-   Check interval

-   Max check attempts

-   Check timeperiod

-   Event handler command (and command arguments)

The following global attributes can be changed during runtime:

-   Global host event handler command (and command arguments)

-   Global service event handler command (and command arguments)

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

-   When changing check commands, check timeperiods, or event handler
    commands, it is important to note that the new values for these
    options must have been defined before Icinga was started. Any
    request to change a command or timeperiod to one which had not been
    defined when Icinga was started is ignored.

-   You can specify command arguments along with the actual command name
    - just separate individual arguments from the command name (and from
    each other) using bang (!) characters. More information on how
    arguments in command definitions are processed during runtime can be
    found in the documentation on
    [macros](macros.md "5.2. Understanding Macros and How They Work").

* * * * *

  -------------------------------------------- -------------------- -------------------------------------
  [Prev](embeddedperl.md)                    [Up](ch07.md)       [Next](dependencychecks.md)
  7.18. Using The Embedded Perl Interpreter    [Home](index.md)    7.20. Predictive Dependency Checks
  -------------------------------------------- -------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
