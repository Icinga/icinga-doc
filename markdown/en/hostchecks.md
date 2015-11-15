![Icinga](../images/logofullsize.png "Icinga")

5.4. Host Checks

[Prev](macrolist.md) 

Chapter 5. The Basics

 [Next](servicechecks.md)

* * * * *

5.4. Host Checks
----------------

5.4.1. [Introduction](hostchecks.md#introduction)

5.4.2. [When Are Host Checks Performed?](hostchecks.md#whenrun)

5.4.3. [Cached Host Checks](hostchecks.md#caching)

5.4.4. [Dependencies and Checks](hostchecks.md#dependencieschecks)

5.4.5. [Parallelization of Host Checks](hostchecks.md#parallelization)

5.4.6. [Host States](hostchecks.md#hoststates)

5.4.7. [Host State
Determination](hostchecks.md#hoststatedetermination)

5.4.8. [Host State Changes](hostchecks.md#hoststatechanges)

### 5.4.1. Introduction

The basic workings of host checks are described here...

### 5.4.2. When Are Host Checks Performed?

Hosts are checked by the Icinga daemon:

-   At regular intervals, as defined by the *check\_interval* and
    *retry\_interval* options in your [host
    definitions](objectdefinitions.md#objectdefinitions-host).

-   On-demand when a service associated with the host changes state.

-   On-demand as needed as part of the [host
    reachability](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts")
    logic.

-   On-demand as needed for [predictive host dependency
    checks](dependencychecks.md "7.20. Predictive Dependency Checks").

Regularly scheduled host checks are optional. If you set the
*check\_interval* option in your host definition to zero (0), Icinga
will not perform checks of the hosts on a regular basis. It will,
however, still perform on-demand checks of the host as needed for other
parts of the monitoring logic.

On-demand checks are made when a service associated with the host
changes state because Icinga needs to know whether the host has also
changed state. Services that change state are often an indicator that
the host may have also changed state. For example, if Icinga detects
that the HTTP service associated with a host just changed from a
CRITICAL to an OK state, it may indicate that the host just recovered
from a reboot and is now back up and running.

On-demand checks of hosts are also made as part of the [host
reachability](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts")
logic. Icinga is designed to detect network outages as quickly as
possible, and distinguish between DOWN and UNREACHABLE host states.
These are very different states and can help an admin quickly locate the
cause of a network outage.

On-demand checks are also performed as part of the [predictive host
dependency
check](dependencychecks.md "7.20. Predictive Dependency Checks")
logic. These checks help ensure that the dependency logic is as accurate
as possible.

### 5.4.3. Cached Host Checks

The performance of on-demand host checks can be significantly improved
by implementing the use of cached checks, which allow Icinga to forgo
executing a host check if it determines a relatively recent check result
will do instead. More information on cached checks can be found
[here](cachedchecks.md "7.21. Cached Checks").

### 5.4.4. Dependencies and Checks

You can define [host execution
dependencies](objectdefinitions.md#objectdefinitions-hostdependency)
that prevent Icinga from checking the status of a host depending on the
state of one or more other hosts. More information on dependencies can
be found
[here](dependencies.md "7.13. Host and Service Dependencies").

### 5.4.5. Parallelization of Host Checks

Scheduled host checks are run in parallel. When Icinga needs to run a
scheduled host check, it will initiate the host check and then return to
doing other work (running service checks, etc). The host check runs in a
child process that was fork()ed from the main Icinga daemon. When the
host check has completed, the child process will inform the main Icinga
process (its parent) of the check results. The main Icinga process then
handles the check results and takes appropriate action (running event
handlers, sending notifications, etc.).

On-demand host checks are also run in parallel if needed. As mentioned
earlier, Icinga can forgo the actual execution of an on-demand host
check if it can use the cached results from a relatively recent host
check.

When Icinga processes the results of scheduled and on-demand host
checks, it may initiate (secondary) checks of other hosts. These checks
can be initated for two reasons: [predictive dependency
checks](dependencychecks.md "7.20. Predictive Dependency Checks") and
to determining the status of the host using the [network
reachability](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts")
logic. The secondary checks that are initiated are usually run in
parallel. However, there is one big exception that you should be aware
of, as it can have negative effect on performance...

![[Note]](../images/note.png)

Note

Hosts which have their *max\_check\_attempts* value set to **1** can
cause serious performance problems. The reason? If Icinga needs to
determine their true state using the [network
reachability](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts")
logic (to see if they're DOWN or UNREACHABLE), it will have to launch
**serial** checks of all of the host's immediate parents. Just to
reiterate, those checks are run *serially*, rather than in parallel, so
it can cause a big performance hit. For this reason, we would recommend
that you always use a value greater than 1 for the
*max\_check\_attempts* directives in your host definitions.

### 5.4.6. Host States

Hosts that are checked can be in one of three different states:

-   UP

-   DOWN

-   UNREACHABLE

### 5.4.7. Host State Determination

Host checks are performed by
[plugins](plugins.md "5.1. Icinga Plugins"), which can return a state
of OK, WARNING, UNKNOWN, or CRITICAL. How does Icinga translate these
plugin return codes into host states of UP, DOWN, or UNREACHABLE? Lets
see...

The table below shows how plugin return codes correspond with
preliminary host states. Some post-processing (which is described later)
is done which may then alter the final host state.

**Plugin Result**

**Preliminary Host State**

OK

UP

WARNING

UP or DOWN^\*^

UNKNOWN

DOWN

CRITICAL

DOWN

![[Note]](../images/note.png)

Note

WARNING results usually means the host is UP. However, WARNING results
are interpreted to mean the host is DOWN if the
[use\_aggressive\_host\_checking](configmain.md#configmain-use_aggressive_host_checking)
option is enabled.

If the preliminary host state is DOWN, Icinga will attempt to see if the
host is really DOWN or if it is UNREACHABLE. The distinction between
DOWN and UNREACHABLE host states is important, as it allows admins to
determine root cause of network outages faster. The following table
shows how Icinga makes a final state determination based on the state of
the hosts parent(s). A host's parents are defined in the *parents*
directive in host definition.

**Preliminary Host State**

**Parent Host State**

**Final Host State**

DOWN

At least one parent is UP

DOWN

DOWN

All parents are either DOWN or UNREACHABLE

UNREACHABLE

More information on how Icinga distinguishes between DOWN and
UNREACHABLE states can be found
[here](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts").

### 5.4.8. Host State Changes

As you are probably well aware, hosts don't always stay in one state.
Things break, patches get applied, and servers need to be rebooted. When
Icinga checks the status of hosts, it will be able to detect when a host
changes between UP, DOWN, and UNREACHABLE states and take appropriate
action. These state changes result in different [state
types](statetypes.md "5.8. State Types") (HARD or SOFT), which can
trigger [event handlers](eventhandlers.md "7.3. Event Handlers") to be
run and [notifications](notifications.md "5.11. Notifications") to be
sent out. Detecting and dealing with state changes is what Icinga is all
about.

When hosts change state too frequently they are considered to be
"flapping". A good example of a flapping host would be server that keeps
spontaneously rebooting as soon as the operating system loads. That's
always a fun scenario to have to deal with. Icinga can detect when hosts
start flapping, and can suppress notifications until flapping stops and
the host's state stabilizes. More information on the flap detection
logic can be found
[here](flapping.md "7.8. Detection and Handling of State Flapping").

* * * * *

  --------------------------------- -------------------- -----------------------------
  [Prev](macrolist.md)            [Up](ch05.md)       [Next](servicechecks.md)
  5.3. Standard Macros in Icinga    [Home](index.md)    5.5. Service Checks
  --------------------------------- -------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
