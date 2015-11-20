[Prev](stalking.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](downtime.md)

* * * * *

7.15. Performance Data
----------------------

7.15.1. [Introduction](perfdata.md#introduction)

7.15.2. [Types of Performance Data](perfdata.md#typesperfdata)

7.15.3. [Plugin Performance Data](perfdata.md#pluginperfdata)

7.15.4. [Processing Performance Data](perfdata.md#processing)

7.15.5. [Processing Performance Data Using
Commands](perfdata.md#processingcommands)

7.15.6. [Writing Performance Data To
Files](perfdata.md#writingtofiles)

7.15.7. [Performance Data Format](perfdata.md#formatperfdata)

### 7.15.1. Introduction

Icinga is designed to allow
[plugins](plugins.md "5.1. Icinga Plugins") to return optional
performance data in addition to normal status data, as well as allow you
to pass that performance data to external applications for processing. A
description of the different types of performance data, as well as
information on how to go about processing that data is described
below...

### 7.15.2. Types of Performance Data

There are two basic categories of performance data that can be obtained
from Icinga:



Check performance data is internal data that relates to the actual
execution of a host or service check. This might include things like
service check latency (i.e. how "late" was the service check from its
scheduled execution time) and the number of seconds a host or service
check took to execute. This type of performance data is available for
all checks that are performed. The
[\$HOSTEXECUTIONTIME\$](macrolist.md#macrolist-hostexecutiontime) and
[\$SERVICEEXECUTIONTIME\$](macrolist.md#macrolist-serviceexecutiontime)
[macros](macros.md "5.2. Understanding Macros and How They Work") can
be used to determine the number of seconds a host or service check was
running and the [\$HOSTLATENCY\$](macrolist.md#macrolist-hostlatency)
and [\$SERVICELATENCY\$](macrolist.md#macrolist-servicelatency) macros
can be used to determine how "late" a regularly-scheduled host or
service check was.

Plugin performance data is external data specific to the plugin used to
perform the host or service check. Plugin-specific data can include
things like percent packet loss, free disk space, processor load, number
measuring when it executes. Plugin-specific performance data is optional
and may not be supported by all plugins. Plugin-specific performance
data (if available) can be obtained by using the
[\$HOSTPERFDATA\$](macrolist.md#macrolist-hostperfdata) and
[\$SERVICEPERFDATA\$](macrolist.md#macrolist-serviceperfdata)
[macros](macros.md "5.2. Understanding Macros and How They Work").
Read on for more information on how plugins can return performance data
to Icinga for inclusion in the \$HOSTPERFDATA\$ and \$SERVICEPERFDATA\$
macros.

### 7.15.3. Plugin Performance Data

At a minimum, Icinga plugins must return a single line of human-readable
text that indicates the status of some type of measurable data. For
example, the check\_ping plugin might return a line of text like the
following:

</code></pre> 
</code></pre>

With this simple type of output, the entire line of text is available in
the \$HOSTOUTPUT\$ or \$SERVICEOUTPUT\$
[macros](macros.md "5.2. Understanding Macros and How They Work")
(depending on whether this plugin was used as a host check or service
check).

Plugins can return optional performance data in their output by sending
the normal, human-readable text string that they usually would, followed
by a pipe character (|), and then a string containing one or more
performance data metrics. Let's take the check\_ping plugin as an
example and assume that it has been enhanced to return percent packet
loss and average round trip time as performance data metrics. Sample
output from the plugin might look like this:

</code></pre> 
</code></pre>

When Icinga sees this plugin output format it will split the output into
two parts:



In the example above, the \$HOSTOUTPUT\$ or \$SERVICEOUTPUT\$ macro
quotes) and the \$HOSTPERFDATA\$ or \$SERVICEPERFDATA\$ macro would
contain "*percent\_packet\_loss=0 rta=0.80*" (without quotes).

Multiple lines of performance data (as well as normal text output) can
be obtained from plugins, as described in the [plugin API
documentation](pluginapi.md "11.1. Icinga Plugin API").

![[Note]](../images/note.png)

Note

The Icinga daemon doesn't directly process plugin performance data, so
it doesn't really care what the performance data looks like. The
developer guidelines contain several rules (see [performance data
format](perfdata.md#perfdata-format) below for details). However, if
you are using an external addon to process the performance data (i.e.
PerfParse), the addon may be expecting that the plugin returns
performance data in a specific format. Check the documentation that
comes with the addon for more information.

### 7.15.4. Processing Performance Data

If you want to process the performance data that is available from
Icinga and the plugins, you'll need to do the following:



Read on for information on how to process performance data by writing to
files or executing commands.

### 7.15.5. Processing Performance Data Using Commands

The most flexible way to process performance data is by having Icinga
execute commands (that you specify) to process or redirect the data for
later processing by external applications. The commands that Icinga
executes to process host and service performance data are determined by
the
[host\_perfdata\_command](configmain.md#configmain-host_perfdata_command)
and
[service\_perfdata\_command](configmain.md#configmain-service_perfdata_command)
options, respectively.

An example command definition that redirects service check performance
data to a text file for later processing by another application is shown
below:

<pre><code>
 define command{
</code></pre>

![[Tip]](../images/tip.png)

Tip

This method, while flexible, comes with a relatively high CPU overhead.
If you're processing performance data for a large number of hosts and
services, you'll probably want Icinga to write performance data to files
instead. This method is described in the next section.

### 7.15.6. Writing Performance Data To Files

You can have Icinga write all host and service performance data directly
to text files using the
[host\_perfdata\_file](configmain.md#configmain-host_perfdata_file)
and
[service\_perfdata\_file](configmain.md#configmain-service_perfdata_file)
options. The format in which host and service performance data is
written to those files is determined by the
[host\_perfdata\_file\_template](configmain.md#configmain-host_perfdata_file_template)
and
[service\_perfdata\_file\_template](configmain.md#configmain-service_perfdata_file_template)
options.

An example file format template for service performance data might look
like this:

<pre><code>
 service_perfdata_file_template=[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$
</code></pre>

![[Note]](../images/note.png)

Note

The above is just one example of how to define a template. This
definition will NOT work for PNP!

By default, the text files will be opened in "append" mode. If you need
to change the modes to "write" or "non-blocking read/write" (useful when
writing to pipes), you can use the
[host\_perfdata\_file\_mode](configmain.md#configmain-host_perfdata_file_mode)
and
[service\_perfdata\_file\_mode](configmain.md#configmain-service_perfdata_file_mode)
options.

Additionally, you can have Icinga periodically execute commands to
periocially process the performance data files (e.g. rotate them) using
the
[host\_perfdata\_file\_processing\_command](configmain.md#configmain-host_perfdata_file_processing_command)
and
[service\_perfdata\_file\_processing\_command](configmain.md#configmain-service_perfdata_file_processing_command)
options. The interval at which these commands are executed are governed
by the
[host\_perfdata\_file\_processing\_interval](configmain.md#configmain-host_perfdata_file_processing_interval)
and
[service\_perfdata\_file\_processing\_interval](configmain.md#configmain-service_perfdata_file_processing_interval)
options, respectively.

### 7.15.7. Performance Data Format

The Monitoring Plugins Developer Guidelines
([https://www.monitoring-plugins.org/doc/guidelines.md](https://www.monitoring-plugins.org/doc/guidelines.md))
contain in [section
2.6](https://www.monitoring-plugins.org/doc/guidelines.md#AEN200) the
specification and an explanation of the format of performance data. It
is repeated below for your convenience:


*2.6.Performance data*

Nagios 3 and newer will concatenate the parts following a "|" in a) the
first line output by the plugin, and b) in the second to last line, into
a string it passes to whatever performance data processing it has
configured. (Note that it currently does not insert additional
whitespace between both, so the plugin needs to provide some to prevent
the last pair of a) and the first of b) getting run together.) Please
refer to the Nagios documentation for information on how to configure
such processing. However, it is the responsibility of the plugin writer
to ensure the performance data is in a "Nagios Plugins" format. This is
the expected format:

'label'=value[UOM];[warn];[crit];[min];[max]

Notes:










10. UOM (unit of measurement) is one of:






It is up to third party programs to convert the Nagios plugins
performance data into graphs.


Every now and then people are curious if their performance data is valid
so we'll give some examples showing the data following the pipe symbol:

</code></pre> 
 'disk usage'=78%;80;90;;; # invalid (trailing semicolon after max value)
</code></pre>

![[Note]](../images/note.png)

Note

\*1: Having a decimal comma instead of a decimal point may be a result
of using your local language settings. It might be fixed internally by
your graphing tool but don't rely on it.

\*2: Having "pages" or other non-standard UOMs (e.g. °C/°F) will
probably result in errors or discarded performance data when using addon
like [PNP4Nagios](http://docs.pnp4nagios.org/) or other tools which try
to graph your performance data.

* * * * *

[Prev](stalking.md) | [Up](ch07.md) | [Next](downtime.md)

7.14. State Stalking  |<=== [Index](index.md) ===>|  7.16. Scheduled Downtime

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
