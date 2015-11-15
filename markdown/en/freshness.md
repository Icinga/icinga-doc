![Icinga](../images/logofullsize.png "Icinga")

7.5. Service and Host Freshness Checks

[Prev](volatileservices.md) 

Chapter 7. Advanced Topics

 [Next](distributed.md)

* * * * *

7.5. Service and Host Freshness Checks
--------------------------------------

7.5.1. [Introduction](freshness.md#introduction)

7.5.2. [How Does Freshness Checking Work?](freshness.md#howitworks)

7.5.3. [Enabling Freshness Checking](freshness.md#enable)

7.5.4. [Example](freshness.md#example)

7.5.5. ["Check results ... are stale. Forcing an immediate check
...](freshness.md#stale)

### 7.5.1. Introduction

Icinga supports a feature that does "freshness" checking on the results
of host and service checks. The purpose of freshness checking is to
ensure that host and service checks are being provided passively by
external applications on a regular basis.

Freshness checking is useful when you want to ensure that [passive
checks](passivechecks.md "5.7. Passive Checks") are being received as
frequently as you want. This can be very useful in
[distributed](distributed.md "7.6. Distributed Monitoring") and
[failover](redundancy.md "7.7. Redundant and Failover Network Monitoring")
monitoring environments.

![](../images/freshness.png)

### 7.5.2. How Does Freshness Checking Work?

Icinga periodically checks the freshness of the results for all hosts
services that have freshness checking enabled.

-   A freshness threshold is calculated for each host or service.

-   For each host/service, the age of its last check result is compared
    with the freshness threshold.

-   If the age of the last check result is greater than the freshness
    threshold, the check result is considered "stale".

-   If the check results is found to be stale, Icinga will force an
    [active check](activechecks.md "5.6. Active Checks") of the host
    or service by executing the command specified by in the host or
    service definition.

![[Tip]](../images/tip.png)

Tip

An active check is executed even if active checks are disabled on a
program-wide or host- or service-specific basis.

For example, if you have a freshness threshold of 60 for one of your
services, Icinga will consider that service to be stale if its last
check result is older than 60 seconds.

### 7.5.3. Enabling Freshness Checking

Here's what you need to do to enable freshness checking...

-   Enable freshness checking on a program-wide basis with the
    [check\_service\_freshness](configmain.md#configmain-check_service_freshness)
    and
    [check\_host\_freshness](configmain.md#configmain-check_host_freshness)
    directives.

-   Use
    [service\_freshness\_check\_interval](configmain.md#configmain-service_freshness_check_interval)
    and
    [host\_freshness\_check\_interval](configmain.md#configmain-host_freshness_check_interval)
    options to tell Icinga how often in should check the freshness of
    service and host results.

-   Enable freshness checking on a host- and service-specific basis by
    setting the *check\_freshness* option in your host and service
    definitions to a value of 1.

-   Configure freshness thresholds by setting the *freshness\_threshold*
    option in your host and service definitions.

-   Configure the *check\_command* option in your host or service
    definitions to reflect a valid command that should be used to
    actively check the host or service when it is detected as stale.

-   The *check\_period* option in your host and service definitions is
    used when Icinga determines when a host or service can be checked
    for freshness, so make sure it is set to a valid timeperiod.

![[Tip]](../images/tip.png)

Tip

If you do not specify a host- or service-specific *freshness\_threshold*
value (or you set it to zero), Icinga will automatically calculate a
threshold automatically, based on a how often you monitor that
particular host or service. We would recommend that you explicitly
specify a freshness threshold, rather than let Icinga pick one for you.

### 7.5.4. Example

An example of a service that might require freshness checking might be
one that reports the status of your nightly backup jobs. Perhaps you
have a external script that submit the results of the backup job to
Icinga once the backup is completed. In this case, all of the
checks/results for the service are provided by an external application
using passive checks. In order to ensure that the status of the backup
job gets reported every day, you may want to enable freshness checking
for the service. If the external script doesn't submit the results of
the backup job, you can have Icinga fake a critical result by doing
something like this...

Here's what the definition for the service might look like (some
required options are omitted)...

~~~~ {.programlisting}
 define service{
        host_name               backup-server
        service_description     ArcServe Backup Job
        active_checks_enabled   0               ; active checks are NOT enabled
        passive_checks_enabled  1               ; passive checks are enabled (this is how results are reported)
        check_freshness         1
        freshness_threshold     93600           ; 26 hour threshold, since backups may not always finish at the same time
        check_command           no-backup-report        ; this command is run only if the service results are "stale"
        ...other options...
        }
~~~~

Notice that active checks are disabled for the service. This is because
the results for the service are only made by an external application
using passive checks. Freshness checking is enabled and the freshness
threshold has been set to 26 hours. This is a bit longer than 24 hours
because backup jobs sometimes run late from day to day (depending on how
much data there is to backup, how much network traffic is present,
etc.). The *no-backup-report* command is executed only if the results of
the service are determined to be stale. The definition of the
*no-backup-report* command might look like this...

~~~~ {.programlisting}
 define command{
        command_name    no-backup-report
        command_line    /usr/local/icinga/libexec/check_dummy 2 "CRITICAL: Results of backup job were not reported!"
        }
~~~~

If Icinga detects that the service results are stale, it will run the
*no-backup-report* command as an active service check. This causes the
*check\_dummy* plugin to be executed, which returns a critical state to
Icinga. The service will then go into to a critical state (if it isn't
already there) and someone will probably get notified of the problem.

### 7.5.5. "Check results ... are stale. Forcing an immediate check ...

Sometimes you might find messages like the following in
`icinga.log`{.filename}:

~~~~ {.screen}
 Check results for service x on host y are stale by 0d 0h 0m 10s (threshold=0d 0h 10m 0s).
 Forcing an immediate check of the service...
~~~~

This means that the service was checked in the past and the threshold
time (e.g. 10m) has passed without any new check results so a check is
forced by the core.

The message results from the code fragment in `base/checks.c`{.filename}
(lines folded for better readability)

~~~~ {.programlisting}
 /* the results for the last check of this service are stale */
    if (expiration_time < current_time) {

       get_time_breakdown((current_time - expiration_time), &days, &hours, &minutes, &seconds);
       get_time_breakdown(freshness_threshold, &tdays, &thours, &tminutes, &tseconds);

       /* log a warning */
       if (log_this == TRUE)
          logit(NSLOG_RUNTIME_WARNING, TRUE,
             "Warning: The results of service '%s' on host '%s' are stale by %dd %dh %dm %ds (threshold=%dd %dh %dm %ds).
             I'm forcing an immediate check of the service.\n",
             temp_service->description, temp_service->host_name,
             days, hours, minutes, seconds, tdays, thours, tminutes, tseconds
          );

       log_debug_info(DEBUGL_CHECKS, 1,
          "Check results for service '%s' on host '%s' are stale by %dd %dh %dm %ds (threshold=%dd %dh %dm %ds).
          Forcing an immediate check of the service...\n",
          temp_service->description, temp_service->host_name,
          days, hours, minutes, seconds, tdays, thours, tminutes, tseconds
       );

       return FALSE;
    }
~~~~

By default, the following applies

-   `expiration_time`{.literal} = last\_check + freshness threshold
    (e.g. 10m)

-   expiration\_time is in the past (`< current_time`{.literal}) ==
    stale

-   the difference between now and expiration time is shown in the log
    (e.g. 10s)

If the service has not been checked now, but in the past (event\_start
\> last\_check) and its freshness threshold is 0,
max\_service\_check\_spread multiplied by the interval is added as
additional offset (happens during startup, in order to detect how fast
the initial service check (and state + output) must happen).

* * * * *

  -------------------------------- -------------------- ------------------------------
  [Prev](volatileservices.md)    [Up](ch07.md)       [Next](distributed.md)
  7.4. Volatile Services           [Home](index.md)    7.6. Distributed Monitoring
  -------------------------------- -------------------- ------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
