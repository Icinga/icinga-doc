[Prev](ch11.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](epnplugins.md)

* * * * *

11.1. Icinga Plugin API
-----------------------

11.1.1. [Other Resources](pluginapi.md#otherresources)

11.1.2. [Plugin Overview](pluginapi.md#overview)

11.1.3. [Return Code](pluginapi.md#returncode)

11.1.4. [Plugin Output Spec](pluginapi.md#outputspec)

11.1.5. [Plugin Output Examples](pluginapi.md#outputexamples)

11.1.6. [Plugin Output Length
Restrictions](pluginapi.md#outputlengthrestrictions)

11.1.7. [Examples](pluginapi.md#examples)

11.1.8. [Perl Plugins](pluginapi.md#perlplugins)

### 11.1.1. Other Resources

If you're looking at writing your own plugins for Icinga, please make
sure to visit these other resources:



### 11.1.2. Plugin Overview

Scripts and executables must do two things (at a minimum) in order to
function as Icinga plugins:



The inner workings of your plugin are unimportant to Icinga. Your plugin
could check the status of a TCP port, run a database query, check disk
free space, or do whatever else it needs to check something. The details

### 11.1.3. Return Code

Icinga determines the status of a host or service by evaluating the
return code from plugins. The following tables shows a list of valid
return codes, along with their corresponding service or host states.

**Plugin Return Code**

**Service State**

**Host State**

0

OK

UP

1

WARNING

UP or DOWN/UNREACHABLE\*

2

CRITICAL

DOWN/UNREACHABLE

3

UNKNOWN

DOWN/UNREACHABLE

![](../images/note.gif) Note: If the option
[use\_aggressive\_host\_checking](configmain.md#configmain-use_aggressive_host_checking)
is enabled a return code of 1 results in a host state of "DOWN" or
"UNREACHABLE". Otherwise a return code of 1 results in a host state of
"UP". The process used by Icinga to determine if a host is DOWN or
UNREACHABLE is explained
[here](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts").

### 11.1.4. Plugin Output Spec

At a minimum, plugins should return at least one of text output but they
can optionally return multiple lines of output. Plugins may also return
optional performance data that can be processed by external
applications. The basic format for plugin output is shown below:

TEXT OUTPUT | OPTIONAL PERFDATA

LONG TEXT LINE 1

LONG TEXT LINE 2

...

LONG TEXT LINE N | PERFDATA LINE 2

PERFDATA LINE 3

...

PERFDATA LINE N

The performance data (shown in orange) is optional. If a plugin returns
performance data in its output, it must separate the performance data
from the other text output using a pipe (|) symbol. Additional lines of
long text output (shown in blue) are also optional.

### 11.1.5. Plugin Output Examples

Let's see some examples of possible plugin output...




























With regards to multiple lines of output, you have the following options
for returning performance data:





### 11.1.6. Plugin Output Length Restrictions

Icinga will only read the first 8 KB of data that a plugin returns. This
is done in order to prevent runaway plugins from dumping megs or gigs of
data back to Icinga. This 8 KB output limit is fairly easy to change if
you need. Simply edit the value of the MAX\_PLUGIN\_OUTPUT\_LENGTH
definition in the *include/icinga.h.in* file of the source code
distribution and recompile Icinga. If you increase the 8k cap by
modifying this value make sure that you also increase the value of
MAX\_EXTERNAL\_COMMAND\_LENGTH in include/common.h before you compile to
allow for passive checks results of this length to be received through
the external command file.

### 11.1.7. Examples

If you're looking for some example plugins to study, we would recommend
that you download the official Nagios plugins and look through the code
for various C, Perl, and shell script plugins. Information on obtaining
the official Nagios plugins can be found
[here](plugins.md "5.1. Icinga Plugins").

### 11.1.8. Perl Plugins

Icinga features an optional [embedded Perl
interpreter](embeddedperl.md "7.18. Using The Embedded Perl Interpreter")
which can speed up the execution of Perl plugins. More information on
developing Perl plugins for use with the embedded Perl interpreter can
be found
[here](embeddedperl.md "7.18. Using The Embedded Perl Interpreter").

* * * * *

[Prev](ch11.md) | [Up](ch11.md) | [Next](epnplugins.md)

Chapter 11. Development  |<=== [Index](index.md) ===>|  11.2. Developing Plugins For Use With Embedded Perl

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
