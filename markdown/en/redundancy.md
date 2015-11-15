![Icinga](../images/logofullsize.png "Icinga")

7.7. Redundant and Failover Network Monitoring

[Prev](distributed.md) 

Chapter 7. Advanced Topics

 [Next](flapping.md)

* * * * *

7.7. Redundant and Failover Network Monitoring
----------------------------------------------

7.7.1. [Introduction](redundancy.md#introduction)

7.7.2. [Prerequisites](redundancy.md#redprerequisites)

7.7.3. [Sample Scripts](redundancy.md#samplescripts)

7.7.4. [Scenario 1 - Redundant
Monitoring](redundancy.md#redundantmonitoring)

7.7.5. [Scenario 2 - Failover
Monitoring](redundancy.md#failovermonitoring)

### 7.7.1. Introduction

This section describes a few scenarios for implementing redundant
monitoring hosts an various types of network layouts. With redundant
hosts, you can maintain the ability to monitor your network when the
primary host that runs Icinga fails or when portions of your network
become unreachable.

![[Note]](../images/note.png)

Note

If you are just learning how to use Icinga, we would suggest not trying
to implement redundancy until you have becoming familiar with the
[prerequisites](redundancy.md#redprerequisites "7.7.2. Prerequisites")
that have been laid out. Redundancy is a relatively complicated issue to
understand, and even more difficult to implement properly.

### 7.7.2. Prerequisites

Before you can even think about implementing redundancy with Icinga, you
need to be familiar with the following...

-   Implementing [event
    handlers](eventhandlers.md "7.3. Event Handlers") for hosts and
    services

-   Issuing [external
    commands](extcommands.md "7.1. External Commands") to Icinga via
    shell scripts

-   Executing plugins on remote hosts using either the [NRPE
    addon](addons.md#addons-nrpe) or some other method

-   Checking the status of the Icinga process with the *check\_nagios*
    plugin

### 7.7.3. Sample Scripts

All of the sample scripts that we use in this documentation can be found
in the *eventhandlers/* subdirectory of the Icinga distribution. You'll
probably need to modify them to work on your system...

### 7.7.4. Scenario 1 - Redundant Monitoring

7.7.4.1.
[Introduction](redundancy.md#redundantmonitoring-introduction)

7.7.4.2. [Goals](redundancy.md#redundantmonitoring-goals)

7.7.4.3. [Network Layout
Diagram](redundancy.md#redundantmonitoring-networklayoutdiagram)

7.7.4.4. [Initial Program
Settings](redundancy.md#redundantmonitoring-initialprogramsettings)

7.7.4.5. [Initial
Configuration](redundancy.md#redundantmonitoring-initialconfig)

7.7.4.6. [Event Handler Command
Definitions](redundancy.md#redundantmonitoring-eventhandlercmddefinition)

7.7.4.7. [Event Handler
Scripts](redundancy.md#redundantmonitoring-eventhandlerscript)

7.7.4.8. [What This Does For
Us](redundancy.md#redundantmonitoring-usage)

7.7.4.9. [Time Lags](redundancy.md#redundantmonitoring-timelags)

7.7.4.10. [Special
Cases](redundancy.md#redundantmonitoring-specialcases)

#### 7.7.4.1. Introduction

This is an easy (and naive) method of implementing redundant monitoring
hosts on your network and it will only protect against a limited number
of failures. More complex setups are necessary in order to provide
smarter redundancy, better redundancy across different network segments,
etc.

#### 7.7.4.2. Goals

The goal of this type of redundancy implementation is simple. Both the
"master" and "slave" hosts monitor the same hosts and service on the
network. Under normal circumstances only the "master" host will be
sending out notifications to contacts about problems. We want the
"slave" host running Icinga to take over the job of notifying contacts
about problems if:

1.  The "master" host that runs Icinga is down or..

2.  The Icinga process on the "master" host stops running for some
    reason

#### 7.7.4.3. Network Layout Diagram

The diagram below shows a very simple network setup. For this scenario
we will be assuming that hosts A and E are both running Icinga and are
monitoring all the hosts shown. Host A will be considered the "master"
host and host E will be considered the "slave" host.

![](../images/redundancy.png)

#### 7.7.4.4. Initial Program Settings

The slave host (host E) has its initial
[enable\_notifications](configmain.md#configmain-enable_notifications)
directive disabled, thereby preventing it from sending out any host or
service notifications. You also want to make sure that the slave host
has its
[check\_external\_commands](configmain.md#configmain-check_external_commands)
directive enabled. That was easy enough...

#### 7.7.4.5. Initial Configuration

Next we need to consider the differences between the [object
configuration
file(s)](configobject.md "3.3. Object Configuration Overview") on the
master and slave hosts...

We will assume that you have the master host (host A) setup to monitor
services on all hosts shown in the diagram above. The slave host (host
E) should be setup to monitor the same services and hosts, with the
following additions in the configuration file...

-   The host definition for host A (in the host E configuration file)
    should have a host [event
    handler](eventhandlers.md "7.3. Event Handlers") defined. Lets say
    the name of the host event handler is handle-master-host-event.

-   The configuration file on host E should have a service defined to
    check the status of the Icinga process on host A. Lets assume that
    you define this service check to run the *check\_nagios* plugin on
    host A. This can be done by using one of the methods described in
    **this FAQ** (update this!).

-   The service definition for the Icinga process check on host A should
    have an [event handler](eventhandlers.md "7.3. Event Handlers")
    defined. Lets say the name of the service event handler is
    handle-master-proc-event.

It is important to note that host A (the master host) has no knowledge
of host E (the slave host). In this scenario it simply doesn't need to.
Of course you may be monitoring services on host E from host A, but that
has nothing to do with the implementation of redundancy...

#### 7.7.4.6. Event Handler Command Definitions

We need to stop for a minute and describe what the command definitions
for the event handlers on the slave host look like. Here is an
example...

~~~~ {.screen}
 define command{
     command_name handle-master-host-event
     command_line /usr/local/icinga/libexec/eventhandlers/handle-master-host-event $HOSTSTATE$ $HOSTSTATETYPE$
 } 

 define command{
     command_name handle-master-proc-event 
     command_line /usr/local/icinga/libexec/eventhandlers/handle-master-proc-event $SERVICESTATE$ $SERVICESTATETYPE$
 }
~~~~

This assumes that you have placed the event handler scripts in the
*/usr/local/icinga/libexec/eventhandlers* directory. You may place them
anywhere you wish, but you'll need to modify the examples that are given
here.

#### 7.7.4.7. Event Handler Scripts

Okay, now lets take a look at what the event handler scripts look
like...

Host Event Handler (handle-master-host-event):

~~~~ {.screen}
#!/bin/sh

# Only take action on hard host states...
case "$2" in
HARD)
        case "$1" in
        DOWN)
                # The master host has gone down!
                # We should now become the master host and take
                # over the responsibilities of monitoring the 
                # network, so enable notifications...
                /usr/local/icinga/libexec/eventhandlers/enable_notifications
                ;;
        UP)
                # The master host has recovered!
                # We should go back to being the slave host and
                # let the master host do the monitoring, so 
                # disable notifications...
                /usr/local/icinga/libexec/eventhandlers/disable_notifications
                ;;
        esac
        ;;
esac
exit 0
~~~~

Service Event Handler (handle-master-proc-event):

~~~~ {.screen}
#!/bin/sh

# Only take action on hard service states...
case "$2" in
HARD)
        case "$1" in
        CRITICAL)
                # The master Icinga process is not running!
                # We should now become the master host and
                # take over the responsibility of monitoring
                # the network, so enable notifications...
                /usr/local/icinga/libexec/eventhandlers/enable_notifications
                ;;
        WARNING)
        UNKNOWN)
                # The master Icinga process may or may not
                # be running.. We won't do anything here, but
                # to be on the safe side you may decide you 
                # want the slave host to become the master in
                # these situations...
                ;;
        OK)
                # The master Icinga process running again!
                # We should go back to being the slave host, 
                # so disable notifications...
                /usr/local/icinga/libexec/eventhandlers/disable_notifications
                ;;
        esac
        ;;
esac
exit 0
~~~~

#### 7.7.4.8. What This Does For Us

The slave host (host E) initially has notifications disabled, so it
won't send out any host or service notifications while the Icinga
process on the master host (host A) is still running.

The Icinga process on the slave host (host E) becomes the master host
when...

-   The master host (host A) goes down and the
    *handle-master-host-event* host event handler is executed.

-   The Icinga process on the master host (host A) stops running and the
    *handle-master-proc-event* service event handler is executed.

When the Icinga process on the slave host (host E) has notifications
enabled, it will be able to send out notifications about any service or
host problems or recoveries. At this point host E has effectively taken
over the responsibility of notifying contacts of host and service
problems!

The Icinga process on host E returns to being the slave host when...

-   Host A recovers and the *handle-master-host-event* host event
    handler is executed.

-   The Icinga process on host A recovers and the
    *handle-master-proc-event* service event handler is executed.

When the Icinga process on host E has notifications disabled, it will
not send out notifications about any service or host problems or
recoveries. At this point host E has handed over the responsibilities of
notifying contacts of problems to the Icinga process on host A.
Everything is now as it was when we first started!

#### 7.7.4.9. Time Lags

Redundancy in Icinga is by no means perfect. One of the more obvious
problems is the lag time between the master host failing and the slave
host taking over. This is affected by the following...

-   The time between a failure of the master host and the first time the
    slave host detects a problem

-   The time needed to verify that the master host really does have a
    problem (using service or host check retries on the slave host)

-   The time between the execution of the event handler and the next
    time that Icinga checks for external commands

You can minimize this lag by...

-   Ensuring that the Icinga process on host E (re)checks one or more
    services at a high frequency. This is done by using the
    *check\_interval* and *retry\_interval* arguments in each service
    definition.

-   Ensuring that the number of host rechecks for host A (on host E)
    allow for fast detection of host problems. This is done by using the
    *max\_check\_attempts* argument in the host definition.

-   Increase the frequency of [external
    command](extcommands.md "7.1. External Commands") checks on host
    E. This is done by modifying the
    [command\_check\_interval](configmain.md#configmain-command_check_interval)
    option in the main configuration file.

When Icinga recovers on the host A, there is also some lag time before
host E returns to being a slave host. This is affected by the
following...

-   The time between a recovery of host A and the time the Icinga
    process on host E detects the recovery

-   The time between the execution of the event handler on host B and
    the next time the Icinga process on host E checks for external
    commands

The exact lag times between the transfer of monitoring responsibilities
will vary depending on how many services you have defined, the interval
at which services are checked, and a lot of pure chance. At any rate,
its definitely better than nothing.

#### 7.7.4.10. Special Cases

Here is one thing you should be aware of... If host A goes down, host E
will have notifications enabled and take over the responsibilities of
notifying contacts of problems. When host A recovers, host E will have
notifications disabled. If - when host A recovers - the Icinga process
on host A does not start up properly, there will be a period of time
when neither host is notifying contacts of problems! Fortunately, the
service check logic in Icinga accounts for this. The next time the
Icinga process on host E checks the status of the Icinga process on host
A, it will find that it is not running. Host E will then have
notifications enabled again and take over all responsibilities of
notifying contacts of problems.

The exact amount of time that neither host is monitoring the network is
hard to determine. Obviously, this period can be minimized by increasing
the frequency of service checks (on host E) of the Icinga process on
host A. The rest is up to pure chance, but the total "blackout" time
shouldn't be too bad.

### 7.7.5. Scenario 2 - Failover Monitoring

7.7.5.1. [Introduction](redundancy.md#failovermonitoring-introduction)

7.7.5.2. [Goals](redundancy.md#failovermonitoring-goals)

7.7.5.3. [Initial Program
Settings](redundancy.md#failovermonitoring-initialprogramsettings)

7.7.5.4. [Master Process
Check](redundancy.md#failovermonitoring-masterprocesscheck)

7.7.5.5. [Additional
Issues](redundancy.md#failovermonitoring-additionalissues)

#### 7.7.5.1. Introduction

Failover monitoring is similiar to, but slightly different than
redundant monitoring (as discussed above in [scenario
1](redundancy.md#redundantmonitoring "7.7.4. Scenario 1 - Redundant Monitoring")).

#### 7.7.5.2. Goals

The basic goal of failover monitoring is to have the Icinga process on
the slave host sit idle while the Icinga process on the master host is
running. If the process on the master host stops running (or if the host
goes down), the Icinga process on the slave host starts monitoring
everything.

While the method described in [scenario
1](redundancy.md#redundantmonitoring "7.7.4. Scenario 1 - Redundant Monitoring")
will allow you to continue receive notifications if the master
monitoring hosts goes down, it does have some pitfalls. The biggest
problem is that the slave host is monitoring the same hosts and servers
as the master *at the same time as the master*! This can cause problems
with excessive traffic and load on the machines being monitored if you
have a lot of services defined. Here's how you can get around that
problem...

#### 7.7.5.3. Initial Program Settings

Disable active service checks and notifications on the slave host using
the
[execute\_service\_checks](configmain.md#configmain-execute_service_checks)
and
[enable\_notifications](configmain.md#configmain-enable_notifications)
directives. This will prevent the slave host from monitoring hosts and
services and sending out notifications while the Icinga process on the
master host is still up and running. Make sure you also have the
[check\_external\_commands](configmain.md#configmain-check_external_commands)
directive enabled on the slave host.

#### 7.7.5.4. Master Process Check

Set up a cron job on the slave host that periodically (say every minute)
runs a script that checks the status of the Icinga process on the master
host (using the *check\_nrpe* plugin on the slave host and the [nrpe
daemon](addons.md#addons-nrpe) and *check\_nagios* plugin on the
master host). The script should check the return code of the
*check\_nrpe plugin* . If it returns a non-OK state, the script should
send the appropriate commands to the [external command
file](configmain.md#configmain-command_file) to enable both
notifications and active service checks. If the plugin returns an OK
state, the script should send commands to the external command file to
disable both notifications and active checks.

By doing this you end up with only one process monitoring hosts and
services at a time, which is much more efficient that monitoring
everything twice.

Also of note, you *don't* need to define host and service handlers as
mentioned in [scenario
1](redundancy.md#redundantmonitoring "7.7.4. Scenario 1 - Redundant Monitoring")
because things are handled differently.

#### 7.7.5.5. Additional Issues

At this point, you have implemented a very basic failover monitoring
setup. However, there is one more thing you should consider doing to
make things work smoother.

The big problem with the way things have been setup thus far is the fact
that the slave host doesn't have the current status of any services or
hosts at the time it takes over the job of monitoring. One way to solve
this problem is to enable the [ocsp
command](configmain.md#configmain-ocsp_command) on the master host and
have it send all service check results to the slave host using the [nsca
addon](addons.md#addons-nsca). The slave host will then have
up-to-date status information for all services at the time it takes over
the job of monitoring things. Since active service checks are not
enabled on the slave host, it will not actively run any service checks.
However, it will execute host checks if necessary. This means that both
the master and slave hosts will be executing host checks as needed,
which is not really a big deal since the majority of monitoring deals
with service checks.

That's pretty much it as far as setup goes.

* * * * *

  ------------------------------ -------------------- ------------------------------------------------
  [Prev](distributed.md)       [Up](ch07.md)       [Next](flapping.md)
  7.6. Distributed Monitoring    [Home](index.md)    7.8. Detection and Handling of State Flapping
  ------------------------------ -------------------- ------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
