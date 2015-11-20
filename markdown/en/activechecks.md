[Prev](servicechecks.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](passivechecks.md)

* * * * *

5.6. Active Checks
------------------

5.6.1. [Introduction](activechecks.md#introduction_activechecks)

5.6.2. [How Are Active Checks Performed?](activechecks.md#performed)

5.6.3. [When Are Active Checks Executed?](activechecks.md#executed)

### 5.6.1. Introduction

Icinga is capable of monitoring hosts and services in two ways: actively
and passively. Passive checks are described
[elsewhere](passivechecks.md "5.7. Passive Checks"), so we'll focus on
active checks here. Active checks are the most common method for
monitoring hosts and services. The main features of actives checks as as
follows:



![](../images/activechecks.png)

### 5.6.2. How Are Active Checks Performed?

Active checks are initiated by the check logic in the Icinga daemon.
When Icinga needs to check the status of a host or service it will
execute a plugin and pass it information about what needs to be checked.
The plugin will then check the operational state of the host or service
and report the results back to the Icinga daemon. Icinga will process
the results of the host or service check and take appropriate action as
necessary (e.g. send notifications, run event handlers, etc).

More information on how plugins work can be found
[here](plugins.md "5.1. Icinga Plugins").

### 5.6.3. When Are Active Checks Executed?

Active check are executed:



Regularly scheduled checks occur at intervals equaling either the
*check\_interval* or the *retry\_interval* in your host or service
definitions, depending on what [type of
state](statetypes.md "5.8. State Types") the host or service is in. If
a host or service is in a HARD state, it will be actively checked at
intervals equal to the *check\_interval* option. If it is in a SOFT
state, it will be checked at intervals equal to the *retry\_interval*
option.

On-demand checks are performed whenever Icinga sees a need to obtain the
latest status information about a particular host or service. For
example, when Icinga is determining the
[reachability](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts")
of a host, it will often perform on-demand checks of parent and child
hosts to accurately determine the status of a particular network
segment. On-demand checks also occur in the [predictive dependency
check](dependencychecks.md "7.20. Predictive Dependency Checks") logic
in order to ensure Icinga has the most accurate status information.

* * * * *

[Prev](servicechecks.md) | [Up](ch05.md) | [Next](passivechecks.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
