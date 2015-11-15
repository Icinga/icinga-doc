![Icinga](../images/logofullsize.png "Icinga")

7.4. Volatile Services

[Prev](eventhandlers.md) 

Chapter 7. Advanced Topics

 [Next](freshness.md)

* * * * *

7.4. Volatile Services
----------------------

7.4.1. [Introduction](volatileservices.md#introduction)

7.4.2. [What Are They Useful For?](volatileservices.md#usage)

7.4.3. [What's So Special About Volatile
Services?](volatileservices.md#speciality)

7.4.4. [The Power Of Two](volatileservices.md#poweroftwo)

7.4.5. [Icinga Configuration:](volatileservices.md#configvolatile)

7.4.6. [PortSentry
Configuration:](volatileservices.md#portsentryconfig)

7.4.7. [Port Scan Script:](volatileservices.md#portscanscript)

### 7.4.1. Introduction

Icinga has the ability to distinguish between "normal" services and
"volatile" services. The *is\_volatile* option in each service
definition allows you to specify whether a specific service is volatile
or not. For most people, the majority of all monitored services will be
non-volatile (i.e. "normal"). However, volatile services can be very
useful when used properly...

### 7.4.2. What Are They Useful For?

Volatile services are useful for monitoring...

-   Things that automatically reset themselves to an "OK" state each
    time they are checked

-   Events such as security alerts which require attention every time
    there is a problem (and not just the first time)

### 7.4.3. What's So Special About Volatile Services?

Volatile services differ from "normal" services in three important ways.
*Each time* they are checked when they are in a
[hard](statetypes.md "5.8. State Types") non-OK state, and the check
returns a non-OK state (i.e. no state change has occurred)...

-   The non-OK service state is logged

-   Contacts are notified about the problem (if that's [what should be
    done](notifications.md "5.11. Notifications")).

    ![[Note]](../images/note.png)

    Note

    Notification intervals are ignored for volatile services.

-   The [event handler](eventhandlers.md "7.3. Event Handlers") for
    the service is run (if one has been defined)

These events normally only occur for services when they are in a non-OK
state and a hard state change has just occurred. In other words, they
only happen the first time that a service goes into a non-OK state. If
future checks of the service result in the same non-OK state, no hard
state change occurs and none of the events mentioned take place again.

![[Tip]](../images/tip.png)

Tip

If you are only interested in logging, consider using
[stalking](stalking.md "7.14. State Stalking") options instead.

### 7.4.4. The Power Of Two

If you combine the features of volatile services and [passive service
checks](passivechecks.md "5.7. Passive Checks"), you can do some very
useful things. Examples of this include handling SNMP traps, security
alerts, etc.

How about an example... Let's say you're running
[PortSentry](http://sourceforge.net/projects/sentrytools/) to detect
port scans on your machine and automatically firewall potential
intruders. If you want to let Icinga know about port scans, you could do
the following...

### 7.4.5. Icinga Configuration:

-   Create a service definition called *Port Scans* and associate it
    with the host that PortSentry is running on.

-   Set the *max\_check\_attempts* directive in the service definition
    to 1. This will tell Icinga to immediate force the service into a
    [hard state](statetypes.md "5.8. State Types") when a non-OK state
    is reported.

-   Set the *active\_checks\_enabled* directive in the service
    definition to 0. This prevents Icinga from actively checking the
    service.

-   Set the *passive\_checks\_enabled* directive in the service
    definition to 1. This enables passive checks for the service.

-   Set this *is\_volatile* directive in the service definition to 1.

### 7.4.6. PortSentry Configuration:

Edit your PortSentry configuration file (portsentry.conf) and define a
command for the *KILL\_RUN\_CMD* directive as follows:

~~~~ {.programlisting}
 KILL_RUN_CMD="/usr/local/Icinga/libexec/eventhandlers/submit_check_result host_name 'Port Scans' 2 'Port scan from host $TARGET$ on port $PORT$.  Host has been firewalled.'"
~~~~

Make sure to replace *host\_name* with the short name of the host that
the service is associated with.

### 7.4.7. Port Scan Script:

Create a shell script in the */usr/local/icinga/libexec/eventhandlers*
directory named *submit\_check\_result*. The contents of the shell
script should be something similiar to the following...

~~~~ {.programlisting}
#!/bin/sh

# Write a command to the Icinga command file to cause
# it to process a service check result
 
echocmd="/bin/echo"
 
CommandFile="/usr/local/icinga/var/rw/nagios.cmd"

# get the current date/time in seconds since UNIX epoch
datetime=`date +%s`
 
# create the command line to add to the command file
cmdline="[$datetime] PROCESS_SERVICE_CHECK_RESULT;$1;$2;$3;$4"
 
# append the command to the end of the command file
`$echocmd $cmdline >> $CommandFile`
~~~~

What will happen when PortSentry detects a port scan on the machine in
the future?

-   PortSentry will firewall the host (this is a function of the
    PortSentry software)

-   PortSentry will execute the *submit\_check\_result* shell script and
    send a passive check result to Icinga

-   Icinga will read the external command file and see the passive
    service check submitted by PortSentry

-   Icinga will put the *Port Scans* service in a hard CRITICAL state
    and send notifications to contacts

Pretty neat, huh?

* * * * *

  ----------------------------- -------------------- -----------------------------------------
  [Prev](eventhandlers.md)    [Up](ch07.md)       [Next](freshness.md)
  7.3. Event Handlers           [Home](index.md)    7.5. Service and Host Freshness Checks
  ----------------------------- -------------------- -----------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
