[Prev](eventhandlers.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](freshness.md)

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



### 7.4.3. What's So Special About Volatile Services?

Volatile services differ from "normal" services in three important ways.
*Each time* they are checked when they are in a
[hard](statetypes.md "5.8. State Types") non-OK state, and the check
returns a non-OK state (i.e. no state change has occurred)...







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






### 7.4.6. PortSentry Configuration:

Edit your PortSentry configuration file (portsentry.conf) and define a
command for the *KILL\_RUN\_CMD* directive as follows:

<pre><code>
</code></pre>

Make sure to replace *host\_name* with the short name of the host that
the service is associated with.

### 7.4.7. Port Scan Script:

Create a shell script in the */usr/local/icinga/libexec/eventhandlers*
directory named *submit\_check\_result*. The contents of the shell
script should be something similiar to the following...

<pre><code>
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
</code></pre>

What will happen when PortSentry detects a port scan on the machine in
the future?





Pretty neat, huh?

* * * * *

[Prev](eventhandlers.md) | [Up](ch07.md) | [Next](freshness.md)

7.3. Event Handlers  |<=== [Index](index.md) ===>|  7.5. Service and Host Freshness Checks

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
