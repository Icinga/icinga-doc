[Prev](escalations.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](oncallrotation.md)

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



*This should be achieved without reloading or restarting the Icinga
service.*

### 7.10.2. Syntax

The escalation\_condition option is completely optional and can be
defined for host escalations as well as for service escalations. The
syntax is:

`escalation_condition <condition> ( [ & / | ] <condition> )*`

where \<condition\> is either: `host hostname = [u,d,o]` or

As you can see, the escalation\_condition accepts a list of one or more
conditions separated by "&" (logical AND) or "|" (logical OR). The
meanings of [w,u,c,o,d] differ a bit from the ones used for
escalation\_options:






### 7.10.3. Example

<pre><code>
define serviceescalation {
</code></pre>

This example escalation would be escalated if the HOST 'linux' is DOWN
or the Service 'linux.SSH' is WARNING or CRITICAL.

[ Thanks to: Vitali Voroth, DECOIT GmbH \* http://www.decoit.de ]

* * * * *

[Prev](escalations.md) | [Up](ch07.md) | [Next](oncallrotation.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
