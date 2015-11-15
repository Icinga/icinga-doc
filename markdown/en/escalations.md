![Icinga](../images/logofullsize.png "Icinga")

7.9. Notification Escalations

[Prev](flapping.md) 

Chapter 7. Advanced Topics

 [Next](escalation_condition.md)

* * * * *

7.9. Notification Escalations
-----------------------------

7.9.1. [Introduction](escalations.md#introduction)

7.9.2. [When Are Notifications
Escalated?](escalations.md#notificationsescalated)

7.9.3. [Contact Groups](escalations.md#contactgroups)

7.9.4. [Overlapping Escalation
Ranges](escalations.md#overlappingranges)

7.9.5. [Recovery Notifications](escalations.md#recoverynotifications)

7.9.6. [Notification Intervals](escalations.md#notificationintervals)

7.9.7. [Time Period
Restrictions](escalations.md#timeperiodrestrictions)

7.9.8. [State Restrictions](escalations.md#staterestrictions)

### 7.9.1. Introduction

![](../images/objects-contacts.png)

Icinga supports optional escalation of contact notifications for hosts
and services. Escalation of host and service notifications is
accomplished by defining [host
escalations](objectdefinitions.md#objectdefinitions-hostescalation)
and [service
escalations](objectdefinitions.md#objectdefinitions-serviceescalation)
in your [object configuration
file(s)](configobject.md "3.3. Object Configuration Overview").

![[Note]](../images/note.png)

Note

The examples we provide below all make use of service escalation
definitions, but host escalations work the same way. Except, of course,
that they're for hosts instead of services. :-)

### 7.9.2. When Are Notifications Escalated?

Notifications are escalated *if and only if* one or more escalation
definitions matches the current notification that is being sent out. If
a host or service notification *does not* have any valid escalation
definitions that applies to it, the contact group(s) specified in either
the host group or service definition will be used for the notification.
Look at the example below:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   90
        contact_groups          nt-admins,managers
        }

 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      6
        last_notification       10
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

Notice that there are "holes" in the notification escalation
definitions. In particular, notifications 1 and 2 are not handled by the
escalations, nor are any notifications beyond 10. For the first and
second notification, as well as all notifications beyond the tenth one,
the *default* contact groups specified in the service definition are
used. For all the examples we'll be using, we'll be assuming that the
default contact groups for the service definition is called *nt-admins*.

### 7.9.3. Contact Groups

When defining notification escalations, it is important to keep in mind
that any contact groups that were members of "lower" escalations (i.e.
those with lower notification number ranges) should also be included in
"higher" escalation definitions. This should be done to ensure that
anyone who gets notified of a problem *continues* to get notified as the
problem is escalated. Example:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   90
        contact_groups          nt-admins,managers
        }

 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      6
        last_notification       0
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

The first (or "lowest") escalation level includes both the *nt-admins*
and *managers* contact groups. The last (or "highest") escalation level
includes the *nt-admins*, *managers*, and *everyone* contact groups.
Notice that the *nt-admins* contact group is included in both escalation
definitions. This is done so that they continue to get paged if there
are still problems after the first two service notifications are sent
out. The *managers* contact group first appears in the "lower"
escalation definition - they are first notified when the third problem
notification gets sent out. We want the *managers* group to continue to
be notified if the problem continues past five notifications, so they
are also included in the "higher" escalation definition.

### 7.9.4. Overlapping Escalation Ranges

Notification escalation definitions can have notification ranges that
overlap. Take the following example:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   20
        contact_groups          nt-admins,managers
        }

 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       0
        notification_interval   30
        contact_groups          on-call-support
        }
~~~~

In the example above:

-   The *nt-admins* and *managers* contact groups get notified on the
    third notification

-   All three contact groups get notified on the fourth and fifth
    notifications

-   Only the *on-call-support* contact group gets notified on the sixth
    (or higher) notification

### 7.9.5. Recovery Notifications

Recovery notifications are slightly different than problem notifications
when it comes to escalations. Take the following example:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   20
        contact_groups          nt-admins,managers
        }

 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       0
        notification_interval   30
        contact_groups          on-call-support
        }
~~~~

If, after three problem notifications, a recovery notification is sent
out for the service, who gets notified? The recovery is actually the
fourth notification that gets sent out. However, the escalation code is
smart enough to realize that only those people who were notified about
the problem on the third notification should be notified about the
recovery. In this case, the *nt-admins* and *managers* contact groups
would be notified of the recovery.

### 7.9.6. Notification Intervals

You can change the frequency at which escalated notifications are sent
out for a particular host or service by using the
*notification\_interval* option of the hostgroup or service escalation
definition. Example:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   45
        contact_groups          nt-admins,managers
        }

 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      6
        last_notification       0
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

In this example we see that the default notification interval for the
services is 240 minutes (this is the value in the service definition).
When the service notification is escalated on the 3rd, 4th, and 5th
notifications, an interval of 45 minutes will be used between
notifications. On the 6th and subsequent notifications, the notification
interval will be 60 minutes, as specified in the second escalation
definition.

Since it is possible to have overlapping escalation definitions for a
particular hostgroup or service, and the fact that a host can be a
member of multiple hostgroups, Icinga has to make a decision on what to
do as far as the notification interval is concerned when escalation
definitions overlap. In any case where there are multiple valid
escalation definitions for a particular notification, Icinga will choose
the smallest notification interval. Take the following example:

~~~~ {.screen}
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   45
        contact_groups          nt-admins,managers
        }

 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       0
        notification_interval   60
        contact_groups          nt-admins,managers,everyone
        }
~~~~

We see that the two escalation definitions overlap on the 4th and 5th
notifications. For these notifications, Icinga will use a notification
interval of 45 minutes, since it is the smallest interval present in any
valid escalation definitions for those notifications.

One last note about notification intervals deals with intervals of 0. An
interval of 0 means that Icinga should only sent a notification out for
the first valid notification during that escalation definition. All
subsequent notifications for the hostgroup or service will be
suppressed. Take this example:

~~~~ {.screen}
define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      3
        last_notification       5
        notification_interval   45
        contact_groups          nt-admins,managers
        }

 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      4
        last_notification       6
        notification_interval   0
        contact_groups          nt-admins,managers,everyone
        }
        
 define serviceescalation{
        host_name               webserver
        service_description     HTTP
        first_notification      7
        last_notification       0
        notification_interval   30
        contact_groups          nt-admins,managers
        }
~~~~

In the example above, the maximum number of problem notifications that
could be sent out about the service would be four. This is because the
notification interval of 0 in the second escalation definition indicates
that only one notification should be sent out (starting with and
including the 4th notification) and all subsequent notifications should
be repressed. Because of this, the third service escalation definition
has no effect whatsoever, as there will never be more than four
notifications.

### 7.9.7. Time Period Restrictions

Under normal circumstances, escalations can be used at any time that a
notification could normally be sent out for the host or service. This
"notification time window" is determined by the *notification\_period*
directive in the [host](objectdefinitions.md#objectdefinitions-host)
or [service](objectdefinitions.md#objectdefinitions-service)
definition.

You can optionally restrict escalations so that they are only used
during specific time periods by using the *escalation\_period* directive
in the host or service escalation definition. If you use the
*escalation\_period* directive to specify a
[timeperiod](timeperiods.md "5.9. Time Periods") during which the
escalation can be used, the escalation will only be used during that
time. If you do not specify any *escalation\_period* directive, the
escalation can be used at any time within the "notification time window"
for the host or service.

![[Note]](../images/note.png)

Note

Escalated notifications are still subject to the normal time
restrictions imposed by the *notification\_period* directive in a host
or service definition, so the timeperiod you specify in an escalation
definition should be a subset of that larger "notification time window".

### 7.9.8. State Restrictions

If you would like to restrict the escalation definition so that it is
only used when the host or service is in a particular state, you can use
the *escalation\_options* directive in the host or service escalation
definition. If you do not use the *escalation\_options* directive, the
escalation can be used when the host or service is in any state.

* * * * *

  ------------------------------------------------ -------------------- ------------------------------------
  [Prev](flapping.md)                            [Up](ch07.md)       [Next](escalation_condition.md)
  7.8. Detection and Handling of State Flapping    [Home](index.md)    7.10. Escalation Condition
  ------------------------------------------------ -------------------- ------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
