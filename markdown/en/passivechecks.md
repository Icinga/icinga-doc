![Icinga](../images/logofullsize.png "Icinga")

5.7. Passive Checks

[Prev](activechecks.md) 

Chapter 5. The Basics

 [Next](statetypes.md)

* * * * *

5.7. Passive Checks
-------------------

5.7.1. [Introduction](passivechecks.md#introduction)

5.7.2. [Uses For Passive Checks](passivechecks.md#usecases)

5.7.3. [How Passive Checks Work](passivechecks.md#howitworks)

5.7.4. [Enabling Passive Checks](passivechecks.md#enable)

5.7.5. [Submitting Passive Service Check
Results](passivechecks.md#servicecheckresults)

5.7.6. [Submitting Passive Host Check
Results](passivechecks.md#hostcheckresults)

5.7.7. [Passive Checks and Host States](passivechecks.md#hoststates)

5.7.8. [Submitting Passive Check Results From Remote
Hosts](passivechecks.md#checkresultsfromremotehosts)

### 5.7.1. Introduction

In most cases you'll use Icinga to monitor your hosts and services using
regularly scheduled [active
checks](activechecks.md "5.6. Active Checks"). Active checks can be
used to "poll" a device or service for status information every so
often. Icinga also supports a way to monitor hosts and services
passively instead of actively. They key features of passive checks are
as follows:

-   Passive checks are initiated and performed external
    applications/processes

-   Passive check results are submitted to Icinga for processing

The major difference between active and passive checks is that active
checks are initiated and performed by Icinga, while passive checks are
performed by external applications.

### 5.7.2. Uses For Passive Checks

Passive checks are useful for monitoring services that are:

-   Asynchronous in nature and cannot be monitored effectively by
    polling their status on a regularly scheduled basis

-   Located behind a firewall and cannot be checked actively from the
    monitoring host

Examples of asynchronous services that lend themselves to being
monitored passively include SNMP traps and security alerts. You never
know how many (if any) traps or alerts you'll receive in a given time
frame, so it's not feasible to just monitor their status every few
minutes.

Passive checks are also used when configuring
[distributed](distributed.md "7.6. Distributed Monitoring") or
[redundant](redundancy.md "7.7. Redundant and Failover Network Monitoring")
monitoring installations.

### 5.7.3. How Passive Checks Work

![](../images/passivechecks.png)

Here's how passive checks work in more detail...

1.  An external application checks the status of a host or service.

2.  The external application writes the results of the check to the
    [external command file](configmain.md#configmain-command_file).

3.  The next time Icinga reads the external command file it will place
    the results of all passive checks into a queue for later processing.
    The same queue that is used for storing results from active checks
    is also used to store the results from passive checks.

4.  Icinga will periodically execute a [check result reaper
    event](configmain.md#configmain-check_result_reaper_frequency) and
    scan the check result queue. Each service check result that is found
    in the queue is processed in the same manner - regardless of whether
    the check was active or passive. Icinga may send out notifications,
    log alerts, etc. depending on the check result information.

The processing of active and passive check results is essentially
identical. This allows for seamless integration of status information
from external applications with Icinga.

### 5.7.4. Enabling Passive Checks

In order to enable passive checks in Icinga, you'll need to do the
following:

-   Set
    [accept\_passive\_service\_checks](configmain.md#configmain-accept_passive_service_checks)
    directive is set to 1.

-   Set the *passive\_checks\_enabled* directive in your host and
    service definitions is set to 1.

If you want to disable processing of passive checks on a global basis,
set the
[accept\_passive\_service\_checks](configmain.md#configmain-accept_passive_service_checks)
directive to 0.

If you would like to disable passive checks for just a few hosts or
services, use the *passive\_checks\_enabled* directive in the host
and/or service definitions to do so.

### 5.7.5. Submitting Passive Service Check Results

External applications can submit passive service check results to Icinga
by writing a PROCESS\_SERVICE\_CHECK\_RESULT [external
command](extcommands.md "7.1. External Commands") to the external
command file.

The format of the command is as follows:

~~~~ {.screen}
 [<timestamp>] PROCESS_SERVICE_CHECK_RESULT;<host_name>;<svc_description>;<return_code>;<plugin_output>
~~~~

where...

-   *timestamp* is the time in time\_t format (seconds since the UNIX
    epoch) that the service check was perfomed (or submitted). Please
    note the single space after the right bracket.

-   *host\_name* is the short name of the host associated with the
    service in the service definition

-   *svc\_description* is the description of the service as specified in
    the service definition

-   *return\_code* is the return code of the check (0=OK, 1=WARNING,
    2=CRITICAL, 3=UNKNOWN)

-   *plugin\_output* is the text output of the service check (i.e. the
    plugin output)

![[Note]](../images/note.png)

Note

A service must be defined in Icinga before you can submit passive check
results for it! Icinga will ignore all check results for services that
had not been configured before it was last (re)started.

![[Tip]](../images/tip.png)

Tip

An example shell script of how to submit passive service check results
to Icinga can be found in the documentation on [volatile
services](volatileservices.md "7.4. Volatile Services").

### 5.7.6. Submitting Passive Host Check Results

External applications can submit passive host check results to Icinga by
writing a PROCESS\_HOST\_CHECK\_RESULT external command to the external
command file.

The format of the command is as follows:

~~~~ {.screen}
 [<timestamp>] PROCESS_HOST_CHECK_RESULT;<host_name>;<host_status>;<plugin_output>
~~~~

where...

-   *timestamp* is the time in time\_t format (seconds since the UNIX
    epoch) that the host check was perfomed (or submitted). Please note
    the single space after the right bracket.

-   *host\_name* is the short name of the host (as defined in the host
    definition)

-   *host\_status* is the status of the host (0=UP, 1=DOWN,
    2=UNREACHABLE)

-   *plugin\_output* is the text output of the host check

![[Note]](../images/note.png)

Note

A host must be defined in Icinga before you can submit passive check
results for it! Icinga will ignore all check results for hosts that had
not been configured before it was last (re)started.

### 5.7.7. Passive Checks and Host States

Unlike with active host checks, Icinga does not (by default) attempt to
determine whether or host is DOWN or UNREACHABLE with passive checks.
Rather, Icinga takes the passive check result to be the actual state the
host is in and doesn't try to determine the host's actual state using
the [reachability
logic](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts").
This can cause problems if you are submitting passive checks from a
remote host or you have a [distributed monitoring
setup](distributed.md "7.6. Distributed Monitoring") where the
parent/child host relationships are different.

You can tell Icinga to translate DOWN/UNREACHABLE passive check result
states to their "proper" state by using the
[translate\_passive\_host\_checks](configmain.md#configmain-translate_passive_host_checks)
variable. More information on how this works can be found
[here](passivestatetranslation.md "7.22. Passive Host State Translation").

![[Note]](../images/note.png)

Note

Passive host checks are normally treated as [HARD
states](statetypes.md "5.8. State Types"), unless the
[passive\_host\_checks\_are\_soft](configmain.md#configmain-passive_host_checks_are_soft)
option is enabled.

### 5.7.8. Submitting Passive Check Results From Remote Hosts

![](../images/nsca.png)

If an application that resides on the same host as Icinga is sending
passive host or service check results, it can simply write the results
directly to the external command file as outlined above. However,
applications on remote hosts can't do this so easily.

In order to allow remote hosts to send passive check results to the
monitoring host, the [NSCA](addons.md#addons-nsca) addon was
developed. The NSCA addon consists of a daemon that runs on the Icinga
hosts and a client that is executed from remote hosts. The daemon will
listen for connections from remote clients, perform some basic
validation on the results being submitted, and then write the check
results directly into the external command file (as described above).
More information on the NSCA addon can be found
[here](addons.md#addons-nsca).

* * * * *

  ---------------------------- -------------------- --------------------------
  [Prev](activechecks.md)    [Up](ch05.md)       [Next](statetypes.md)
  5.6. Active Checks           [Home](index.md)    5.8. State Types
  ---------------------------- -------------------- --------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
