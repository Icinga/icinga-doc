[Prev](hostchecks.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](activechecks.md)

* * * * *

5.5. Service Checks
-------------------

5.5.1. [Introduction](servicechecks.md#introduction)

5.5.2. [When Are Service Checks Performed?](servicechecks.md#when)

5.5.3. [Cached Service Checks](servicechecks.md#caching)

5.5.4. [Dependencies and Checks](servicechecks.md#dependencieschecks)

5.5.5. [Parallelization of Service
Checks](servicechecks.md#parallelization)

5.5.6. [Service States](servicechecks.md#servicestates)

5.5.7. [Service State
Determination](servicechecks.md#servicestatedetermination)

5.5.8. [Service State Changes](servicechecks.md#servicestatechanges)

5.5.9. [Service State is "stale"](servicechecks.md#servicestatestale)

### 5.5.1. Introduction

The basic workings of service checks are described here...

### 5.5.2. When Are Service Checks Performed?

Services are checked by the Icinga daemon:



On-demand checks are performed as part of the [predictive service
dependency
check](dependencychecks.md "7.20. Predictive Dependency Checks")
logic. These checks help ensure that the dependency logic is as accurate
as possible. If you don't make use of [service
dependencies](objectdefinitions.md#objectdefinitions-servicedependency),
Icinga won't perform any on-demand service checks.

### 5.5.3. Cached Service Checks

The performance of on-demand service checks can be significantly
improved by implementing the use of cached checks, which allow Icinga to
forgo executing a service check if it determines a relatively recent
check result will do instead. Cached checks will only provide a
performance increase if you are making use of [service
dependencies](objectdefinitions.md#objectdefinitions-servicedependency).
More information on cached checks can be found
[here](cachedchecks.md "7.21. Cached Checks").

### 5.5.4. Dependencies and Checks

You can define [service execution
dependencies](objectdefinitions.md#objectdefinitions-servicedependency)
that prevent Icinga from checking the status of a service depending on
the state of one or more other services. More information on
dependencies can be found
[here](dependencies.md "7.13. Host and Service Dependencies").

### 5.5.5. Parallelization of Service Checks

Scheduled service checks are run in parallel. When Icinga needs to run a
scheduled service check, it will initiate the service check and then
return to doing other work (running host checks, etc). The service check
runs in a child process that was fork()ed from the main Icinga daemon.
When the service check has completed, the child process will inform the
main Icinga process (its parent) of the check results. The main Icinga
process then handles the check results and takes appropriate action
(running event handlers, sending notifications, etc.).

On-demand service checks are also run in parallel if needed. As
mentioned earlier, Icinga can forgo the actual execution of an on-demand
service check if it can use the cached results from a relatively recent
service check.

### 5.5.6. Service States

Services that are checked can be in one of four different states:





### 5.5.7. Service State Determination

Service checks are performed by
[plugins](plugins.md "5.1. Icinga Plugins"), which can return a state
of OK, WARNING, UNKNOWN, or CRITICAL. These plugin states directly
translate to service states. For example, a plugin which returns a
WARNING state will cause a service to have a WARNING state.

### 5.5.8. Service State Changes

When Icinga checks the status of services, it will be able to detect
when a service changes between OK, WARNING, UNKNOWN, and CRITICAL states
and take appropriate action. These state changes result in different
[state types](statetypes.md "5.8. State Types") (HARD or SOFT), which
can trigger [event handlers](eventhandlers.md "7.3. Event Handlers")
to be run and [notifications](notifications.md "5.11. Notifications")
to be sent out. Service state changes can also trigger on-demand [host
checks](hostchecks.md "5.4. Host Checks"). Detecting and dealing with
state changes is what Icinga is all about.

When services change state too frequently they are considered to be
"flapping". Icinga can detect when services start flapping, and can
suppress notifications until flapping stops and the service's state
stabilizes. More information on the flap detection logic can be found
[here](flapping.md "7.8. Detection and Handling of State Flapping").

### 5.5.9. Service State is "stale"

For an explanation please take a look at
["freshness"](freshness.md#stale "7.5.5. "Check results ... are stale. Forcing an immediate check ...").

* * * * *

[Prev](hostchecks.md) | [Up](ch05.md) | [Next](activechecks.md)

5.4. Host Checks  |<=== [Index](index.md) ===>|  5.6. Active Checks

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
