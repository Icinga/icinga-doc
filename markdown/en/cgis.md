[Prev](ch06.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](cgiauth.md)

* * * * *

6.1. Icinga Classic UI: Information On The Modules
--------------------------------------------------

**Introduction of the Icinga Classic UI**

The various Classic UI modules (CGIs) distributed with Icinga core are
described here, along with the authorization requirements for accessing
and using each module. By default the Classic UI requires that you have
authenticated to the web server and are authorized to view any
information you are requesting. More information on configuring
authorization can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").

The Classic UI may be controlled using several parameters. More
information can be found
[here](cgiparams.md "6.3. Information On Classic UI parameters").

**Index**

[Status module](cgis.md#cgis-status_cgi)

[Status map module](cgis.md#cgis-statusmap_cgi)

[Tactical overview module](cgis.md#cgis-tac_cgi)

[Network outages module](cgis.md#cgis-outages_cgi)

[Configuration module](cgis.md#cgis-config_cgi)

[Command module](cgis.md#cgis-cmd_cgi)

[Extended information module](cgis.md#cgis-extinfo_cgi)

[Event log module](cgis.md#cgis-showlog_cgi)

[Alert history module](cgis.md#cgis-history_cgi)

[Notifications module](cgis.md#cgis-notifications_cgi)

[Trends module](cgis.md#cgis-trends_cgi)

[Availability reporting module](cgis.md#cgis-avail_cgi)

[Alert histogram module](cgis.md#cgis-histogram_cgi)

[Alert summary module](cgis.md#cgis-summary_cgi)

[Changes in the Classic module](cgis.md#cgis-changes)

**Status module**

![](../images/cgi-status-a.png)

![](../images/cgi-status-b.png)

![](../images/cgi-status-c.png)

![](../images/cgi-status-d.png)

File Name:

**status.cgi**

**Description:**

This is the most important Classic UI module included with Icinga. It
allows you to view the current status of all hosts and services that are
being monitored. The status module can produce two main types of output
- a status overview of all host groups (or a particular host group) and
a detailed view of all services (or those associated with a particular
host).

**Authorization Requirements:**




**Status Map module**

![](../images/cgi-statusmap.png)

File Name:

**statusmap.cgi**

**Description:**

This Classic UI module creates a map of all hosts that you have defined
on your network. The CGI uses Thomas Boutell's
[gd](http://www.boutell.com/gd/) library (version 1.6.3 or higher) to
create a PNG image of your network layout. The coordinates used when
drawing each host (along with the optional pretty icons) are taken from
[host](objectdefinitions#host) definitions. If you'd prefer to let the
module automatically generate drawing coordinates for you, use the
[default\_statusmap\_layout](configcgi-default_statusmap_layout)
directive to specify a layout algorithm that should be used.

**Authorization Requirements:**



![[Note]](../images/note.png)

Note

Users who are not authorized to view specific hosts will see *unknown*
nodes in those positions. I realize that they really shouldn't see
*anything* there, but it doesn't make sense to even generate the map if
you can't see all the host dependencies...

**Tactical Overview module**

![](../images/cgi-tac.png)

File Name:

**tac.cgi**

**Description:**

This Classic UI module is designed to server as a "birds-eye view" of
all network monitoring activity. It allows you to quickly see network
outages, host status, and service status. It distinguishes between
problems that have been "handled" in some way (i.e. been acknowledged,
had notifications disabled, etc.) and those which have not been handled,
and thus need attention. Very useful if you've got a lot of
hosts/services you're monitoring and you need to keep a single screen up
to alert you of problems.

**Authorization Requirements:**




**Network Outages module**

![](../images/cgi-outages.png)

File Name:

**outages.cgi**

**Description:**

This Classic UI module will produce a listing of "problem" hosts on your
network that are causing network outages. This can be particularly
useful if you have a large network and want to quickly identify the
source of the problem. Hosts are sorted based on the severity of the
outage they are causing.

**Authorization Requirements:**



**Configuration module**

![](../images/cgi-config.png)

File Name:

**config.cgi**

**Description:**

This Classic UI module allows you to view objects (i.e. hosts, host
groups, contacts, contact groups, time periods, services, etc.) that you
have defined in your [object configuration file(s)](configobject).

**Authorization Requirements:**


**Command module**

![](../images/cgi-cmd.png)

File Name:

**cmd.cgi**

**Description:**

This Classic UI module allows you to send commands to the Icinga
process. Although this module has several arguments, you would be better
to leave them alone. Most will change between different revisions of
Icinga. Use the [extended information
module](cgis.md#cgis-extinfo_cgi) as a starting point for issuing
commands.

**Authorization Requirements:**





![[Note]](../images/note.png)

Note


**Extended Information module**

![](../images/cgi-extinfo-a.png)

![](../images/cgi-extinfo-b.png)

![](../images/cgi-extinfo-c.png)

![](../images/cgi-extinfo-d.png)

File Name:

**extinfo.cgi**

**Description:**

This Classic UI module allows you to view Icinga process information,
host and service state statistics, host and service comments, and more.
It also serves as a launching point for sending commands to Icinga via
the [command module](cgis.md#cgis-cmd_cgi). Although this module has
likely to change between different releases of Icinga. You can access
this module by clicking on the 'Network Health' and 'Process
Information' links on the side navigation bar, or by clicking on a host
or service link in the output of the [status
module](cgis.md#cgis-status_cgi).

**Authorization Requirements:**





**Event Log module**

![](../images/cgi-showlog.png)

File Name:

**showlog.cgi**

**Description:**

This Classic UI module will display the [log file](configmain#log_file).
If you have [log rotation](configmain#log_rotation_method) enabled, you
can browse notifications present in archived log files by using the
navigational links near the top of the page.

**Authorization Requirements:**


**Alert History module**

![](../images/cgi-history.png)

File Name:

**history.cgi**

**Description:**

This Classic UI module is used to display the history of problems with
either a particular host or all hosts. The output is basically a subset
of the information that is displayed by the [log file
module](cgis.md#cgis-showlog_cgi). You have the ability to filter the
output to display only the specific types of problems you wish to see
(i.e. hard and/or soft alerts, various types of service and host alerts,
all types of alerts, etc.). If you have [log
rotation](configmain#log_rotation_method) enabled, you can browse
history information present in archived log files by using the
navigational links near the top of the page.

**Authorization Requirements:**




**Notifications module**

![](../images/cgi-notifications.png)

File Name:

**notifications.cgi**

**Description:**

This Classic UI module is used to display host and service notifications
that have been sent to various contacts. The output is basically a
subset of the information that is displayed by the [log file
module](cgis.md#cgis-showlog_cgi). You have the ability to filter the
output to display only the specific types of notifications you wish to
see (i.e. service notifications, host notifications, notifications sent
to specific contacts, etc). If you have [log
rotation](configmain#log_rotation_method) enabled, you can browse
notifications present in archived log files by using the navigational
links near the top of the page.

**Authorization Requirements:**




**Trends module**

![](../images/cgi-trends.png)

File Name:

**trends.cgi**

**Description:**

This Classic UI module is used to create a graph of host or service
states over an arbitrary period of time. In order for this module to be
of much use, you should enable [log
rotation](configmain#log_rotation_method) and keep archived logs in the
path specified by the [log\_archive\_path](configmain#log_archive_path)
directive. The module uses Thomas Boutell's
[gd](http://www.boutell.com/gd/) library (version 1.6.3 or higher) to
create the trends image.

**Authorization Requirements:**




**Availability Reporting module**

![](../images/cgi-avail-a.png)

![](../images/cgi-avail-b.png)

File Name:

**avail.cgi**

**Description:**

This Classic UI module is used to report on the availability of hosts
and services over a user-specified period of time. In order for this
module to be of much use, you should enable [log
rotation](configmain#log_rotation_method) and keep archived logs in the
path specified by the [log\_archive\_path](configmain#log_archive_path)
directive.

**Authorization Requirements:**




**Alert Histogram module**

![](../images/cgi-histogram.png)

File Name:

**histogram.cgi**

**Description:**

This Classic UI module is used to report on the availability of hosts
and services over a user-specified period of time. In order for this
module to be of much use, you should enable [log
rotation](configmain#log_rotation_method) and keep archived logs in the
path specified by the [log\_archive\_path](configmain#log_archive_path)
directive. The module uses Thomas Boutell's
[gd](http://www.boutell.com/gd/) library (version 1.6.3 or higher) to
create the histogram image.

**Authorization Requirements:**




**Alert Summary module**

![](../images/cgi-summary.png)

File Name:

**summary.cgi**

**Description:**

This Classic UI module provides some generic reports about host and
service alert data, including alert totals, top alert producers, etc.

**Authorization Requirements:**




**Changes in the Classic UI**

These changes appeared over time so they might not be available in your
version of Icinga.



































* * * * *

[Prev](ch06.md) | [Up](ch06.md) | [Next](cgiauth.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
