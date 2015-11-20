[Prev](volatileservices.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](distributed.md)

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





![[Tip]](../images/tip.png)

Tip

An active check is executed even if active checks are disabled on a
program-wide or host- or service-specific basis.

For example, if you have a freshness threshold of 60 for one of your
services, Icinga will consider that service to be stale if its last
check result is older than 60 seconds.

### 7.5.3. Enabling Freshness Checking

Here's what you need to do to enable freshness checking...







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

<pre><code>
 define service{
</code></pre>

Notice that active checks are disabled for the service. This is because
the results for the service are only made by an external application
using passive checks. Freshness checking is enabled and the freshness
threshold has been set to 26 hours. This is a bit longer than 24 hours
because backup jobs sometimes run late from day to day (depending on how
much data there is to backup, how much network traffic is present,
etc.). The *no-backup-report* command is executed only if the results of
the service are determined to be stale. The definition of the
*no-backup-report* command might look like this...

<pre><code>
 define command{
</code></pre>

If Icinga detects that the service results are stale, it will run the
*no-backup-report* command as an active service check. This causes the
*check\_dummy* plugin to be executed, which returns a critical state to
Icinga. The service will then go into to a critical state (if it isn't
already there) and someone will probably get notified of the problem.

### 7.5.5. "Check results ... are stale. Forcing an immediate check ...

Sometimes you might find messages like the following in
`icinga.log`:

 Check results for service x on host y are stale by 0d 0h 0m 10s (threshold=0d 0h 10m 0s).
 Forcing an immediate check of the service...
</code></pre>

This means that the service was checked in the past and the threshold
time (e.g. 10m) has passed without any new check results so a check is
forced by the core.

The message results from the code fragment in `base/checks.c`
(lines folded for better readability)

<pre><code>
 /* the results for the last check of this service are stale */




</code></pre>

By default, the following applies




If the service has not been checked now, but in the past (event\_start
\> last\_check) and its freshness threshold is 0,
max\_service\_check\_spread multiplied by the interval is added as
additional offset (happens during startup, in order to detect how fast
the initial service check (and state + output) must happen).

* * * * *

[Prev](volatileservices.md) | [Up](ch07.md) | [Next](distributed.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
