![Icinga](../images/logofullsize.png "Icinga")

7.3. Event Handlers

[Prev](extcommands2.md) 

Chapter 7. Advanced Topics

 [Next](volatileservices.md)

* * * * *

7.3. Event Handlers
-------------------

7.3.1. [Introduction](eventhandlers.md#introduction)

7.3.2. [When Are Event Handlers Executed?](eventhandlers.md#execution)

7.3.3. [Event Handler Types](eventhandlers.md#types)

7.3.4. [Enabling Event Handlers](eventhandlers.md#enable)

7.3.5. [Event Handler Execution
Order](eventhandlers.md#executionorder)

7.3.6. [Writing Event Handler
Commands](eventhandlers.md#writingcommands)

7.3.7. [Permissions For Event Handler
Commands](eventhandlers.md#commandpermissions)

7.3.8. [Service Event Handler
Example](eventhandlers.md#serviceexample)

### 7.3.1. Introduction

![](../images/eventhandlers.png)

Event handlers are optional system commands (scripts or executables)
that are run whenever a host or service state change occurs. They are
executed on the system where the check is scheduled (initiated).

An obvious use for event handlers is the ability for Icinga to
proactively fix problems before anyone is notified. Some other uses for
event handlers include:

-   Restarting a failed service

-   Entering a trouble ticket into a helpdesk system

-   Logging event information to a database

-   Cycling power on a host\*

-   etc.

\* Cycling power on a host that is experiencing problems with an
auomated script should not be implemented lightly. Consider the
consequences of this carefully before implementing automatic reboots.
:-)

### 7.3.2. When Are Event Handlers Executed?

Event handlers are executed when a service or host:

-   Is in a SOFT problem state

-   Initially goes into a HARD problem state

-   Initially recovers from a SOFT or HARD problem state

SOFT and HARD states are described in detail
[here](statetypes.md "5.8. State Types") .

### 7.3.3. Event Handler Types

There are different types of optional event handlers that you can define
to handle host and state changes:

-   Global host event handler

-   Global service event handler

-   Host-specific event handlers

-   Service-specific event handlers

Global host and service event handlers are run for *every* host or
service state change that occurs, immediately prior to any host- or
service-specific event handler that may be run. You can specify global
event handler commands by using the
[global\_host\_event\_handler](configmain.md#configmain-global_host_event_handler)
and
[global\_service\_event\_handler](configmain.md#configmain-global_service_event_handler)
options in your main configuration file.

Individual hosts and services can have their own event handler command
that should be run to handle state changes. You can specify an event
handler that should be run by using the *event\_handler* directive in
your [host](objectdefinitions.md#objectdefinitions-host) and
[service](objectdefinitions.md#objectdefinitions-service) definitions.
These host- and service-specific event handlers are executed immediately
after the (optional) global host or service event handler is executed.

### 7.3.4. Enabling Event Handlers

Event handlers can be enabled or disabled on a program-wide basis by
using the
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)
in your main configuration file.

Host- and service-specific event handlers can be enabled or disabled by
using the *event\_handler\_enabled* directive in your
[host](objectdefinitions.md#objectdefinitions-host) and
[service](objectdefinitions.md#objectdefinitions-service) definitions.
Host- and service-specific event handlers will not be executed if the
global
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)
option is disabled.

### 7.3.5. Event Handler Execution Order

As already mentioned, global host and service event handlers are
executed immediately before host- or service-specific event handlers.

Event handlers are executed for HARD problem and recovery states
immediately after notifications are sent out.

### 7.3.6. Writing Event Handler Commands

Event handler commands will likely be shell or perl scripts, but they
can be any type of executable that can run from a command prompt. At a
minimum, the scripts should take the following
[macros](macros.md "5.2. Understanding Macros and How They Work") as
arguments:

For Services:
[**\$SERVICESTATE\$**](macrolist.md#macrolist-servicestate) ,
[**\$SERVICESTATETYPE\$**](macrolist.md#macrolist-servicestatetype) ,
[**\$SERVICEATTEMPT\$**](macrolist.md#macrolist-serviceattempt)

For Hosts: [**\$HOSTSTATE\$**](macrolist.md#macrolist-hoststate) ,
[**\$HOSTSTATETYPE\$**](macrolist.md#macrolist-hoststatetype) ,
[**\$HOSTATTEMPT\$**](macrolist.md#macrolist-hostattempt)

The scripts should examine the values of the arguments passed to it and
take any necessary action based upon those values. The best way to
understand how event handlers work is to see an example. Lucky for you,
one is provided [below](eventhandlers.md#eventhandlers-example).

![[Tip]](../images/tip.png)

Tip

Additional sample event handler scripts can be found in the
*contrib/eventhandlers/* subdirectory of the Icinga distribution. Some
of these sample scripts demonstrate the use of [external
commands](extcommands.md "7.1. External Commands") to implement a
[redundant](redundancy.md "7.7. Redundant and Failover Network Monitoring")
and [distributed](distributed.md "7.6. Distributed Monitoring")
monitoring environments.

### 7.3.7. Permissions For Event Handler Commands

Event handler commands will normally execute with the same permissions
as the user under which Icinga is running on your machine. This can
present a problem if you want to write an event handler that restarts
system services, as root privileges are generally required to do these
sorts of tasks.

Ideally you should evaluate the types of event handlers you will be
implementing and grant just enough permissions to the Icinga user for
executing the necessary system commands. You might want to try using
[sudo](http://www.courtesan.com/sudo/sudo) to accomplish this.

### 7.3.8. Service Event Handler Example

The example below assumes that you are monitoring the HTTP server on the
local machine and have specified *restart-httpd* as the event handler
command for the HTTP service definition. Also, I will be assuming that
you have set the *max\_check\_attempts* option for the service to be a
value of 4 or greater (i.e. the service is checked 4 times before it is
considered to have a real problem). An abbreviated example service
definition might look like this...

~~~~ {.programlisting}
 define service{
        host_name               somehost
        service_description     HTTP
        max_check_attempts      4
        event_handler           restart-httpd
        ...
        }
~~~~

Once the service has been defined with an event handler, we must define
that event handler as a command. An example command definition for
*restart-httpd* is shown below. Notice the macros in the command line
that I am passing to the event handler script - these are important!

~~~~ {.programlisting}
 define command{
        command_name    restart-httpd
        command_line    /usr/local/icinga/libexec/eventhandlers/restart-httpd  $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$
        }
~~~~

Now, let's actually write the event handler script (this is the
*/usr/local/icinga/libexec/eventhandlers/restart-httpd* script).

~~~~ {.programlisting}
#!/bin/sh
#
# Event handler script for restarting the web server on the local machine
#
# Note: This script will only restart the web server if the service is
#       retried 3 times (in a "soft" state) or if the web service somehow
#       manages to fall into a "hard" error state.
#


# What state is the HTTP service in?
case "$1" in
OK)
        # The service just came back up, so don't do anything...
        ;;
WARNING)
        # We don't really care about warning states, since the service is probably still running...
        ;;
UNKNOWN)
        # We don't know what might be causing an unknown error, so don't do anything...
        ;;
CRITICAL)
        # Aha!  The HTTP service appears to have a problem - perhaps we should restart the server...

        # Is this a "soft" or a "hard" state?
        case "$2" in
                
        # We're in a "soft" state, meaning that Icinga is in the middle of retrying the
        # check before it turns into a "hard" state and contacts get notified...
        SOFT)
                        
                # What check attempt are we on?  We don't want to restart the web server on the first
                # check, because it may just be a fluke!
                case "$3" in
                                
                # Wait until the check has been tried 3 times before restarting the web server.
                # If the check fails on the 4th time (after we restart the web server), the state
                # type will turn to "hard" and contacts will be notified of the problem.
                # Hopefully this will restart the web server successfully, so the 4th check will
                # result in a "soft" recovery.  If that happens no one gets notified because we
                # fixed the problem!
                3)
                        echo -n "Restarting HTTP service (3rd soft critical state)..."
                        # Call the init script to restart the HTTPD server
                        /etc/rc.d/init.d/httpd restart
                        ;;
                        esac
                ;;
                                
        # The HTTP service somehow managed to turn into a hard error without getting fixed.
        # It should have been restarted by the code above, but for some reason it didn't.
        # Let's give it one last try, shall we?  
        # Note: Contacts have already been notified of a problem with the service at this
        # point (unless you disabled notifications for this service)
        HARD)
                echo -n "Restarting HTTP service..."
                # Call the init script to restart the HTTPD server
                /etc/rc.d/init.d/httpd restart
                ;;
        esac
        ;;
esac
exit 0
~~~~

The sample script provided above will attempt to restart the web server
on the local machine in two different instances:

-   After the service has been rechecked for the 3rd time and is in a
    SOFT CRITICAL state

-   After the service first goes into a HARD CRITICAL state

The script should theoretically restart and web server and fix the
problem before the service goes into a HARD problem state, but we
include a fallback case in the event it doesn't work the first time. It
should be noted that the event handler will only be executed the first
time that the service falls into a HARD problem state. This prevents
Icinga from continuously executing the script to restart the web server
if the service remains in a HARD problem state. You don't want that. :-)

That's all there is to it! Event handlers are pretty simple to write and
implement, so give it a try and see what you can do.

* * * * *

  --------------------------------- -------------------- --------------------------------
  [Prev](extcommands2.md)         [Up](ch07.md)       [Next](volatileservices.md)
  7.2. List of External Commands    [Home](index.md)    7.4. Volatile Services
  --------------------------------- -------------------- --------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
