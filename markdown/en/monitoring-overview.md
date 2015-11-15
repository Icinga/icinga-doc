![Icinga](../images/logofullsize.png "Icinga")

2.12. Monitoring Overview

[Prev](upgrading_idoutils.md) 

Chapter 2. Getting Started

 [Next](monitoring-windows.md)

* * * * *

2.12. Monitoring Overview
-------------------------

**Introduction**

Icinga is intended to monitor devices (e.g. server, router, printer, and
other hardware like temperature sensors) and services (processes running
on these devices, metrics, etc.). There are several ways to do that and
different approaches for different devices depending on your needs or
the infrastructure.

-   [Active checks](activechecks.md "5.6. Active Checks")

    The checks are initiated from the monitoring server repeated at
    given intervals. The server is waiting for the check results. The
    values and thresholds are set on the monitoring server. Check
    results can be retrieved

    -   using SNMP. The remote system runs an SNMP daemon allowing to
        read the requested values. Depending on the plugin and the
        daemon SNMP v1, v2c, or v3 are supported

    -   using [NRPE](nrpe.md "10.2. NRPE"), calling an NRPE daemon on
        the remote system which executes a check and returns the results
        to NRPE which in turn delivers it to the Icinga process

    -   calling a plugin using SSH to call a check on the remote system
        which returns the data to the plugin

    -   using the plugin check\_nt to connect to a service (e.g.
        "[NSClient++](http://nsclient.org)") on the remote windows box
        and return data on several metrics

    -   using addons like [check\_multi](http://my-plugin.de) or
        [check\_mk](http://mathias-kettner.de/check_mk_overview.md)
        which call plugins on their own to decrease the performance
        impact on the monitoring process (due to parallel calls). The
        configuration of values and thresholds is mostly moved to these
        addons which might increase the time of administration

-   [Passive checks](passivechecks.md "5.7. Passive Checks")

    The checks are initiated on remote systems (not necessarily the
    system to be monitored but probably "satellite systems", aka
    "pollers", which monitor an organisational unit). The check results
    are transmitted to the monitoring server using
    [NSCA](nsca.md "10.3. NSCA") consisting of send\_nsca on the
    client system and the nsca daemon on the monitoring server and
    processed there to update the current status. Setting [freshness
    thresholds](freshness.md "7.5. Service and Host Freshness Checks")
    will notify you if results do not appear in time. Depending on the
    configuration tools used administration might be more complex but
    using firewalls or other limitations imposed by security, customers,
    and/or other means you might not have the choice. Using passive
    checks will decrease the load on your monitoring system, too,
    because it only has to process the check results instead of
    executing checks itself. You can use entries in the crontab to
    execute checks at fixed times, execute long running queries when
    necessary or execute backup jobs returning only the results.

-   A mix of both

    You might have remote systems running checks at given intervals
    providing data via a secret and secure page on a web server. The
    monitoring server is not able to check the systems directly (due to
    firewalls, customer regulations, etc.) but can access the document
    provided by the web server. It will retrieve the data using scripts
    (checks?) and injecting the results via [external
    commands](extcommands.md "7.1. External Commands").

-   SNMP-Traps

    Sometimes you don't want to check things periodically because they
    are running smoothly and it would impose unnecessary network load.
    Several devices will inform you themselves when something goes wrong
    by using SNMP traps.

![[Note]](../images/note.png)

Note

Please be sure to have read the section on
[addons](addons.md "10.1. Icinga Addons") as well because it gives
general hints on configuration tools, web interfaces, and other addons
which are available for Icinga.

* * * * *

  ------------------------------------ -------------------- ------------------------------------
  [Prev](upgrading_idoutils.md)      [Up](ch02.md)       [Next](monitoring-windows.md)
  2.11. Upgrading IDOUtils Database    [Home](index.md)    2.13. Monitoring Windows Machines
  ------------------------------------ -------------------- ------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
