[Prev](distributed.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](flapping.md)

* * * * *

7.7. Redundant and Failover Network Monitoring
----------------------------------------------

7.7.1. [Introduction](redundancy.md#introduction)

7.7.2. [Prerequisites](redundancy.md#redprerequisites)

7.7.3. [Sample Scripts](redundancy.md#samplescripts)

Monitoring](redundancy.md#redundantmonitoring)

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





### 7.7.3. Sample Scripts

All of the sample scripts that we use in this documentation can be found
in the *eventhandlers/* subdirectory of the Icinga distribution. You'll
probably need to modify them to work on your system...


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




It is important to note that host A (the master host) has no knowledge
of host E (the slave host). In this scenario it simply doesn't need to.
Of course you may be monitoring services on host E from host A, but that
has nothing to do with the implementation of redundancy...

#### 7.7.4.6. Event Handler Command Definitions

We need to stop for a minute and describe what the command definitions
for the event handlers on the slave host look like. Here is an
example...

 define command{

 define command{
 }
</code></pre>

This assumes that you have placed the event handler scripts in the
*/usr/local/icinga/libexec/eventhandlers* directory. You may place them
anywhere you wish, but you'll need to modify the examples that are given
here.

#### 7.7.4.7. Event Handler Scripts

Okay, now lets take a look at what the event handler scripts look
like...

Host Event Handler (handle-master-host-event):

#!/bin/sh

# Only take action on hard host states...
case "$2" in
HARD)
esac
exit 0
</code></pre>

Service Event Handler (handle-master-proc-event):

#!/bin/sh

# Only take action on hard service states...
case "$2" in
HARD)
esac
exit 0
</code></pre>

#### 7.7.4.8. What This Does For Us

The slave host (host E) initially has notifications disabled, so it
won't send out any host or service notifications while the Icinga
process on the master host (host A) is still running.

The Icinga process on the slave host (host E) becomes the master host
when...



When the Icinga process on the slave host (host E) has notifications
enabled, it will be able to send out notifications about any service or
host problems or recoveries. At this point host E has effectively taken
over the responsibility of notifying contacts of host and service
problems!

The Icinga process on host E returns to being the slave host when...



When the Icinga process on host E has notifications disabled, it will
not send out notifications about any service or host problems or
recoveries. At this point host E has handed over the responsibilities of
notifying contacts of problems to the Icinga process on host A.
Everything is now as it was when we first started!

#### 7.7.4.9. Time Lags

Redundancy in Icinga is by no means perfect. One of the more obvious
problems is the lag time between the master host failing and the slave
host taking over. This is affected by the following...




You can minimize this lag by...




When Icinga recovers on the host A, there is also some lag time before
host E returns to being a slave host. This is affected by the
following...



The exact lag times between the transfer of monitoring responsibilities
will vary depending on how many services you have defined, the interval
at which services are checked, and a lot of pure chance. At any rate,
its definitely better than nothing.

#### 7.7.4.10. Special Cases

Here is one thing you should be aware of... If host A goes down, host E
will have notifications enabled and take over the responsibilities of
notifying contacts of problems. When host A recovers, host E will have
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

#### 7.7.5.2. Goals

The basic goal of failover monitoring is to have the Icinga process on
the slave host sit idle while the Icinga process on the master host is
running. If the process on the master host stops running (or if the host
goes down), the Icinga process on the slave host starts monitoring
everything.

While the method described in [scenario
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

[Prev](distributed.md) | [Up](ch07.md) | [Next](flapping.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
