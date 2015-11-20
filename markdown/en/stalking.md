[Prev](dependencies.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](perfdata.md)

* * * * *

7.14. State Stalking
--------------------

7.14.1. [Introduction](stalking.md#introduction)

7.14.2. [How Does It Work?](stalking.md#howitworks)

7.14.3. [Should I Enable Stalking?](stalking.md#whyenable)

7.14.4. [How Do I Enable Stalking?](stalking.md#howenable)

7.14.5. [How Does Stalking Differ From Volatile
Services?](stalking.md#differtovolatile)

7.14.6. [Caveats](stalking.md#caveats)

### 7.14.1. Introduction

State "stalking" is a feature which is probably not going to used by
most users. When enabled, it allows you to log changes in the output
service and host checks even if the state of the host or service does
not change. When stalking is enabled for a particular host or service,
Icinga will watch that host or service very carefully and log any
changes it sees in the output of check results. As you'll see, it can be
very helpful to you in later analysis of the log files.

### 7.14.2. How Does It Work?

Under normal circumstances, the result of a host or service check is
only logged if the host or service has changed state since it was last
checked. There are a few exceptions to this, but for the most part,
that's the rule.

If you enable stalking for one or more states of a particular host or
service, Icinga will log the results of the host or service check if the
output from the check differs from the output from the previous check.
Take the following example of eight consecutive checks of a service:

**Service Check \#:**

**Service State:**

**Service Check Output:**

**Logged Normally**

**Logged With Stalking**

x

OK

RAID array optimal

-

-

x+1

OK

RAID array optimal

-

-

x+2

WARNING

RAID array degraded (1 drive bad, 1 hot spare rebuilding)

![](../images/checkmark.png)

![](../images/checkmark.png)

x+3

CRITICAL

RAID array degraded (2 drives bad, 1 host spare online, 1 hot spare
rebuilding)

![](../images/checkmark.png)

![](../images/checkmark.png)

x+4

CRITICAL

RAID array degraded (3 drives bad, 2 hot spares online)

-

![](../images/checkmark.png)

x+5

CRITICAL

RAID array failed

-

![](../images/checkmark.png)

x+6

CRITICAL

RAID array failed

-

-

x+7

CRITICAL

RAID array failed

-

-

Given this sequence of checks, you would normally only see two log
entries for this catastrophe. The first one would occur at service check
x+2 when the service changed from an OK state to a WARNING state. The
second log entry would occur at service check x+3 when the service
changed from a WARNING state to a CRITICAL state.

For whatever reason, you may like to have the complete history of this
catastrophe in your log files. Perhaps to help explain to your manager
how quickly the situation got out of control, perhaps just to laugh at
it over a couple of drinks at the local pub...

Well, if you had enabled stalking of this service for CRITICAL states,
you would have events at x+4 and x+5 logged in addition to the events at
x+2 and x+3. Why is this? With state stalking enabled, Icinga would have
examined the output from each service check to see if it differed from
the output of the previous check. If the output differed and the state
of the service didn't change between the two checks, the result of the
newer service check would get logged.

A similiar example of stalking might be on a service that checks your
web server. If the check\_http plugin first returns a WARNING state
because of a 404 error and on subsequent checks returns a WARNING state
because of a particular pattern not being found, you might want to know
that. If you didn't enable state stalking for WARNING states of the
service, only the first WARNING state event (the 404 error) would be
logged and you wouldn't have any idea (looking back in the archived
logs) that future WARNING states were not due to a 404, but rather some
text pattern that could not be found in the returned web page.

### 7.14.3. Should I Enable Stalking?

First, you must decide if you have a real need to analyze archived log
data to find the exact cause of a problem. You may decide you need this
feature for some hosts or services, but not for all. You may also find
that you only have a need to enable stalking for some host or service
states, rather than all of them. For example, you may decide to enable
stalking for WARNING and CRITICAL states of a service, but not for OK
and UNKNOWN states.

The decision to to enable state stalking for a particular host or
service will also depend on the plugin that you use to check that host
or service. If the plugin always returns the same text output for a
particular state, there is no reason to enable stalking for that state.

### 7.14.4. How Do I Enable Stalking?

You can enable state stalking for hosts and services by using the
*stalking\_options* directive in [host and service
definitions](configobject.md "3.3. Object Configuration Overview").

### 7.14.5. How Does Stalking Differ From Volatile Services?

[Volatile services](volatileservices.md "7.4. Volatile Services") are
similar, but will cause notifications and event handlers to run.
Stalking is purely for logging purposes.

### 7.14.6. Caveats

You should be aware that there are some potential pitfalls with enabling
stalking. These all relate to the reporting functions found in various
[CGIs](cgis.md "6.1. Icinga Classic UI: Information On The Modules")
(histogram, alert summary, etc.). Because state stalking will cause
additional alert entries to be logged, the data produced by the reports
will show evidence of inflated numbers of alerts.

As a general rule, I would suggest that you *not* enable stalking for
hosts and services without thinking things through. Still, it's there if
you need and want it.

* * * * *

[Prev](dependencies.md) | [Up](ch07.md) | [Next](perfdata.md)

7.13. Host and Service Dependencies  |<=== [Index](index.md) ===>|  7.15. Performance Data

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
