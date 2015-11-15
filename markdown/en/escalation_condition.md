![Icinga](../images/logofullsize.png "Icinga")

7.10. Escalation Condition

[Prev](escalations.md) 

Chapter 7. Advanced Topics

 [Next](oncallrotation.md)

* * * * *

7.10. Escalation Condition
--------------------------

7.10.1. [Introduction](escalation_condition.md#introduction)

7.10.2. [Syntax](escalation_condition.md#syntax)

7.10.3. [Example](escalation_condition.md#example)

### 7.10.1. Introduction

An escalation\_condition is similar to escalation\_options [w,u,c,r]. An
escalation with a defined condition will only be escalated if the
current state of a particular host/service fits the condition. One
possible example of use for this could be the following scenario:

Imagine two different escalations for the same service *foo*. One of
them should only escalate when service *bar* is OK, the other should
escalate if *bar* is CRITICAL or WARNING. Now think about *foo* being
the main service offered by a company and the admin has to react
immediately if it is down. *bar* could be a service indicating if the
admin is in the office or at home and the escalation would react as
following:

-   If the admin is in the office, send an email first, after 5 minutes
    send an SMS

-   If the admin is at home, send an SMS first and after 30 minutes a
    second SMS to the admin and the head of department

*This should be achieved without reloading or restarting the Icinga
service.*

### 7.10.2. Syntax

The escalation\_condition option is completely optional and can be
defined for host escalations as well as for service escalations. The
syntax is:

`escalation_condition <condition> ( [ & / | ] <condition> )*`{.literal}

where \<condition\> is either: `host hostname = [u,d,o]`{.literal} or
`service hostname.service_description =     [w,u,c,o]`{.literal}.

As you can see, the escalation\_condition accepts a list of one or more
conditions separated by "&" (logical AND) or "|" (logical OR). The
meanings of [w,u,c,o,d] differ a bit from the ones used for
escalation\_options:

-   w = WARNING

-   u = UNKNOWN

-   c = CRITICAL

-   o = OK for services or UP for hosts (one could think of ONLINE)

-   d = Down for hosts

### 7.10.3. Example

~~~~ {.programlisting}
define serviceescalation {
   host_name               localhost
   service_description     HTTP
   first_notification      5
   contact_groups          admins, managers
   escalation_condition    host linux=d | service linux.SSH=w,c
   }
~~~~

This example escalation would be escalated if the HOST 'linux' is DOWN
or the Service 'linux.SSH' is WARNING or CRITICAL.

[ Thanks to: Vitali Voroth, DECOIT GmbH \* http://www.decoit.de ]

* * * * *

  -------------------------------- -------------------- ------------------------------
  [Prev](escalations.md)         [Up](ch07.md)       [Next](oncallrotation.md)
  7.9. Notification Escalations    [Home](index.md)    7.11. On-Call Rotations
  -------------------------------- -------------------- ------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
