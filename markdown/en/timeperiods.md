![Icinga](../images/logofullsize.png "Icinga")

5.9. Time Periods

[Prev](statetypes.md) 

Chapter 5. The Basics

 [Next](networkreachability.md)

* * * * *

5.9. Time Periods
-----------------

5.9.1. [Introduction](timeperiods.md#introduction)

5.9.2. [Precedence in Time Periods](timeperiods.md#precedence)

5.9.3. [How Time Periods Work With Host and Service
Checks](timeperiods.md#hostservicechecks)

5.9.4. [How Time Periods Work With Contact
Notifications](timeperiods.md#contactnotifications)

5.9.5. [How Time Periods Work With Notification
Escalations](timeperiods.md#notificationescalations)

5.9.6. [How Time Periods Work With
Dependencies](timeperiods.md#dependenciestimeperiods)

### 5.9.1. Introduction

![](../images/objects-timeperiods.png)

[Timeperiod](objectdefinitions.md#objectdefinitions-timeperiod)
definitions allow you to control when various aspects of the monitoring
and alerting logic can operate. For instance, you can restrict:

-   When regularly scheduled host and service checks can be performed

-   When notifications can be sent out

-   When notification escalations can be used

-   When dependencies are valid

### 5.9.2. Precedence in Time Periods

Timeperiod
[definitions](objectdefinitions.md#objectdefinitions-timeperiod) may
contain multiple types of directives, including weekdays, days of the
month, and calendar dates. Different types of directives have different
precendence levels and may override other directives in your timeperiod
definitions. The order of precedence for different types of directives
(in descending order) is as follows:

-   Calendar date (2008-01-01)

-   Specific month date (January 1st)

-   Generic month date (Day 15)

-   Offset weekday of specific month (2nd Tuesday in December)

-   Offset weekday (3rd Monday)

-   Normal weekday (Tuesday)

Examples of different timeperiod directives can be found
[here](objectdefinitions.md#objectdefinitions-timeperiod).

### 5.9.3. How Time Periods Work With Host and Service Checks

Host and service definitions have an optional *check\_period* directive
that allows you to specify a timeperiod that should be used to restrict
when regularly scheduled, active checks of the host or service can be
made.

If you do not use the *check\_period* directive to specify a timeperiod,
Icinga will be able to schedule active checks of the host or service
anytime it needs to. This is essentially a 24x7 monitoring scenario.

Specifying a timeperiod in the *check\_period* directive allows you to
restrict the time that Icinga perform regularly scheduled, active checks
of the host or service. When Icinga attempts to reschedule a host or
service check, it will make sure that the next check falls within a
valid time range within the defined timeperiod. If it doesn't, Icinga
will adjust the next check time to coincide with the next "valid" time
in the specified timeperiod. This means that the host or service may not
get checked again for another hour, day, or week, etc.

![[Note]](../images/note.png)

Note

On-demand checks and passive checks are not restricted by the timeperiod
you specify in the *check\_period* directive. Only regularly scheduled
active checks are restricted.

Unless you have a good reason not to do so, I would recommend that you
monitor all your hosts and services using timeperiods that cover a 24x7
time range. If you don't do this, you can run into some problems during
"blackout" times (times that are not valid in the timeperiod
definition):

1.  The status of the host or service will appear unchanged during the
    blackout time.

2.  Contacts will mostly likely not get re-notified of problems with a
    host or service during blackout times.

3.  If a host or service recovers during a blackout time, contacts will
    not be immediately notified of the recovery.

### 5.9.4. How Time Periods Work With Contact Notifications

By specifying a timeperiod in the *notification\_period* directive of a
host or service definition, you can control when Icinga is allowed to
send notifications out regarding problems or recoveries for that host or
service. When a host notification is about to get sent out, Icinga will
make sure that the current time is within a valid range in the
*notification\_period* timeperiod. If it is a valid time, then Icinga
will attempt to notify each contact of the problem or recovery.

You can also use timeperiods to control when notifications can be sent
out to individual contacts. By using the *service\_notification\_period*
and *host\_notification\_period* directives in [contact
definitions](objectdefinitions.md#objectdefinitions-contact), you're
able to essentially define an "on call" period for each contact.
Contacts will only receive host and service notifications during the
times you specify in the notification period directives.

Examples of how to create timeperiod definitions for use for on-call
rotations can be found
[here](oncallrotation.md "7.11. On-Call Rotations").

### 5.9.5. How Time Periods Work With Notification Escalations

Service and host [notification
escalations](escalations.md "7.9. Notification Escalations") have an
optional *escalation\_period* directive that allows you to specify a
timeperiod when the escalation is valid and can be used. If you do not
use the *escalation\_period* directive in an escalation definition, the
escalation is considered valid at all times. If you specify a timeperiod
in the *escalation\_period* directive, Icinga will only use the
escalation definition during times that are valid in the timeperiod
definition.

### 5.9.6. How Time Periods Work With Dependencies

Service and host
[dependencies](dependencies.md "7.13. Host and Service Dependencies")
have an optional *dependency\_period* directive that allows you to
specify a timeperiod when the dependendies are valid and can be used. If
you do not use the *dependency\_period* directive in a dependency
definition, the dependency can be used at any time. If you specify a
timeperiod in the *dependency\_period* directive, Icinga will only use
the dependency definition during times that are valid in the timeperiod
definition.

* * * * *

  -------------------------- -------------------- -------------------------------------------------------------
  [Prev](statetypes.md)    [Up](ch05.md)       [Next](networkreachability.md)
  5.8. State Types           [Home](index.md)    5.10. Determining Status and Reachability of Network Hosts
  -------------------------- -------------------- -------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
