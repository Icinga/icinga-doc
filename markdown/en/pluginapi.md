![Icinga](../images/logofullsize.png "Icinga")

11.1. Icinga Plugin API

[Prev](ch11.md) 

Chapter 11. Development

 [Next](epnplugins.md)

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

-   The official [Monitoring Plugins project
    website](https://www.monitoring-plugins.org)

-   The official [Monitoring Plugins development
    guidelines](https://www.monitoring-plugins.org/doc/guidelines.md)

### 11.1.2. Plugin Overview

Scripts and executables must do two things (at a minimum) in order to
function as Icinga plugins:

-   Exit with one of several possible return values

-   Return at least one line of text output to STDOUT

The inner workings of your plugin are unimportant to Icinga. Your plugin
could check the status of a TCP port, run a database query, check disk
free space, or do whatever else it needs to check something. The details
will depend on what needs to be checked - that's up to you.

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

-   **Case 1: One line of output (text only)**

    Assume we have a plugin that returns one line of output that looks
    like this:

    DISK OK - free space: / 3326 MB (56%); If this plugin was used to
    perform a service check, the entire line of output will be stored in
    the [\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput)
    macro.

-   **Case 2: One line of output (text and perfdata)**

    A plugin can return optional performance data for use by external
    applications. To do this, the performance data must be separated
    from the text output with a pipe (|) symbol like such:

    DISK OK - free space: / 3326 MB (56%); | /=2643MB;5948;5958;0;5968

    If this plugin was used to perform a service check, the red portion
    of output (left of the pipe separator) will be stored in the
    [\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput) macro
    and the  orange portion of output (right of the pipe separator) will
    be stored in the
    [\$SERVICEPERFDATA\$](macrolist.md#macrolist-serviceperfdata)
    macro.

-   **Case 3: Multiple lines of output (text and perfdata)**

    A plugin optionally returns multiple lines of both text output and
    perfdata, like such:

    DISK OK - free space: / 3326 MB (56%);

     | /=2643MB;5948;5958;0;5968

    / 15272 MB (77%);

    /boot 68 MB (69%);

    /home 69357 MB (27%);

    /var/log 819 MB (84%); | /boot=68MB;88;93;0;98

    /home=69357MB;253404;253409;0;253414

    /var/log=818MB;970;975;0;980

    If this plugin was used to perform a service check, the red portion
    of first line of output (left of the pipe separator) will be stored
    in the [\$SERVICEOUTPUT\$](macrolist.md#macrolist-serviceoutput)
    macro. The orange portions of the first and subsequent lines are
    concatenated (with spaces) are stored in the
    [\$SERVICEPERFDATA\$](macrolist.md#macrolist-serviceperfdata)
    macro. The blue portions of the 2nd - 5th lines of output will be
    concatenated (with escaped newlines) and stored in the
    [\$LONGSERVICEOUTPUT\$](macrolist.md#macrolist-longserviceoutput)
    macro.

    The final contents of each macro are listed below:

    **Macro**

    **Value**

    \$SERVICEOUTPUT\$

    DISK OK - free space: / 3326 MB (56%);

    \$SERVICEPERFDATA\$

    /=2643MB;5948;5958;0;5968 /boot=68MB;88;93;0;98 /home=69357MB;253404;253409;0;253414 /var/log=818MB;970;975;0;980

    \$LONGSERVICEOUTPUT\$

    / 15272 MB (77%);\\n/boot 68 MB (69%);\\n/var/log 819 MB (84%);

With regards to multiple lines of output, you have the following options
for returning performance data:

-   You can choose to return no performance data whatsoever

-   You can return performance data on the first line only

-   You can return performance data only in subsequent lines (after the
    first)

-   You can return performance data in both the first line and
    subsequent lines (as shown above)

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

  -------------------------- -------------------- ------------------------------------------------------
  [Prev](ch11.md)          [Up](ch11.md)       [Next](epnplugins.md)
  Chapter 11. Development    [Home](index.md)    11.2. Developing Plugins For Use With Embedded Perl
  -------------------------- -------------------- ------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
