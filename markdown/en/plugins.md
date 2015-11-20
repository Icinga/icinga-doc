[Prev](ch05.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](macros.md)

* * * * *

5.1. Icinga Plugins
-------------------

5.1.1. [Introduction](plugins.md#introduction_plugins)

5.1.2. [What Are Plugins?](plugins.md#plugins-overview)

5.1.3. [Plugins As An Abstraction Layer](plugins.md#abstractionlayer)

5.1.4. [What Plugins Are Available?](plugins.md#plugins-available)

5.1.5. [Obtaining Plugins](plugins.md#plugins-obtaining)

5.1.6. [Switch to the Icinga user](plugins.md#plugins-hints)

5.1.7. [Extending the environment](plugins.md#plugins-extending)

5.1.8. [How Do I Use Plugin X?](plugins.md#plugins-howto)

5.1.9. [Integrating a new plugin](plugins.md#plugins-new_plugin)

5.1.10. [Raw command line](plugins.md#plugins-rawcommandline)

5.1.11. [Threshold and ranges](plugins.md#plugins-thresholdranges)

5.1.12. [Activating the definition](plugins.md#plugins-errors)

5.1.13. [Plugin API](plugins.md#pluginsapi)

### 5.1.1. Introduction

Unlike many other monitoring tools, Icinga does not include any internal
mechanisms for checking the status of hosts and services on your
network. Instead, Icinga relies on external programs (called plugins) to
do all the dirty work.

### 5.1.2. What Are Plugins?

Plugins are compiled executables or scripts (Perl scripts, shell
scripts, etc.) that can be run from a command line to check the status
or a host or service. Icinga uses the results from plugins to determine
the current status of hosts and services on your network.

Icinga will execute a plugin whenever there is a need to check the
status of a service or host. The plugin does *something* (notice the
very general term) to perform the check and then simply returns the
results to Icinga. Icinga will process the results that it receives from
the plugin and take any necessary actions (running [event
handlers](eventhandlers.md "7.3. Event Handlers"), sending out
[notifications](notifications.md "5.11. Notifications"), etc).

### 5.1.3. Plugins As An Abstraction Layer

![](../images/plugins.png)

Plugins act as an abstraction layer between the monitoring logic present
in the Icinga daemon and the actual services and hosts that are being
monitored.

The upside of this type of plugin architecture is that you can monitor
just about anything you can think of. If you can automate the process of
checking something, you can monitor it with Icinga. There are already a
lot of plugins that have been created in order to monitor basic
resources such as processor load, disk usage, ping rates, etc. If you
want to monitor something else, take a look at the documentation on
[writing plugins](pluginapi.md "11.1. Icinga Plugin API") and roll
your own. It's simple!

The downside to this type of plugin architecture is the fact that Icinga
has absolutely no idea what it is that you're monitoring. You could be
monitoring network traffic statistics, data error rates, room
temperature, CPU voltage, fan speed, processor load, disk space, or the
ability of your super-fantastic toaster to properly brown your bread in
the morning... Icinga doesn't understand the specifics of what's being
Only the plugins themselves know exactly what they're monitoring and how
to perform the actual checks.

### 5.1.4. What Plugins Are Available?

There are plugins currently available to monitor many different kinds of
devices and services, including:






### 5.1.5. Obtaining Plugins

Plugins are not distributed with Icinga, but you can download the
official Nagios plugins and many additional plugins created and
maintained by Nagios and Icinga users from the following locations:




After downloading you have to install the plugin(s). Please check the
accompanied documentation on how to do that. It may contain important
information about the prerequisites like additional packages, (perl)
modules and on how to install the plugin together with hints for your
distribution.

Sometimes you have to compile the plugin preparing the compile process
using "`./configure`" with or without options. Please check the
file `config.log` for errors regarding missing (devel)
packages before issuing the actual compile command (mostly "make" or
"make all"). In most cases the plugin is copied to the plugins directory
(i.e. `/usr/local/icinga/libexec`) during "make install".

Sometimes you have to alter the plugin to reflect your environment (i.e.
path to "utils.pm", ...). You may create a logical link pointing to the
plugin directory instead so you don't have to change the plugin to
circumvent this issue easing plugin updates later on doing something
like

<pre><code>
 $> mkdir /usr/local/nagios
 $> ln -s /usr/local/icinga/libexec /usr/local/nagios/libexec
</code></pre>

![[Note]](../images/note.png)

Note

Using packages the path to the plugins directory might be different
(e.g. `/usr/lib/plugins`) so please change that accordingly.

### 5.1.6. Switch to the Icinga user

![[Important]](../images/important.png)

Important

Always execute the plugin using the Icinga user (specified using the
directive icinga\_user in `icinga.cfg`) because some plugins
will create temporary files. If you're testing plugins with another user
then the Icinga user may not have the permissions to overwrite existing
files later on. Using another user you will not be able to find out if
the Icinga user is allowed to access several files (e.g. shared
libraries) at all.

When testing it don't call the plugin using relative paths (i.e
`./check_test_plugin`). Always use absolute paths because
that's the way Icinga does it (i.e.
`/usr/local/icinga/libexec/check_test_plugin`).

Please note that the Icinga *user* has a different environment than the
Icinga *process*. Using the first the logins script have been executed
and there is a terminal connected to the user session so successfully
running the plugin from the command line doesn't (necessarly) mean that
it will run when executed by the process. Furthermore the process will
not use a shell per default but execute calls to popen/execvp instead
depending on the command (popen in case the command line contains meta
characters meaningful to the shell like
`!$^&*()~[]\|{};<>?'"`, execvp if no meta characters are
present).

Switch to the Icinga user as defined in `icinga.cfg` unless
already done and clear the environment

 #> env -i
</code></pre>

If you are logged in now then skip to "Extending the environment"

Due to security awareness of the packager / sys admin this might fail
because the account is not allowed to login. Please ask your sys admin
to change that temporarily or do one of the following








### 5.1.7. Extending the environment

Several checks (like check\_oracle\_health) depend on various
environment variables to be set. Don't put these in `.bashrc`
or similar user dependent files but choose a central location. The
default init script sources the file `/etc/sysconfig/icinga`
so that would be an ideal place. Don't use the init script itself
because your changes might be lost during updates.

Example of `/etc/sysconfig/icinga`

<pre><code>
 export ORACLE_HOME=/usr/lib/oracle/11.2/client64
 export LD_LIBRARY_PATH=$ORACLE_HOME/lib
 export PATH=$PATH:$ORACLE_HOME
</code></pre>

After you logged in these variables are not set but doing so is pretty
easy

 $> . /etc/sysconfig/icinga
</code></pre>

Please verify the settings

 $> echo $ORACLE_HOME
 $> echo $LD_LIBRARY_PATH
 $> echo $PATH
</code></pre>

### 5.1.8. How Do I Use Plugin X?

Nearly all plugins will display basic usage information when you execute
them using '`-h`' or '`--help`' on the command line. For
example, if you want to know how the check\_http plugin works or what
options it accepts, you should try executing the following command:

 $> ./check_http --help
</code></pre>

### 5.1.9. Integrating a new plugin

After the installation of the plugin (see "[Obtaining
plugins](plugins.md#plugins-obtaining "5.1.5. Obtaining Plugins")")
call it from the command line using the appropriate options. If this
works then you can integrate it into Icinga.

Let's imagine you used the following call on the command line

<pre><code>
 $> /usr/local/icinga/libexec/sample-plugin.pl -H 192.168.1.2 -a argument1 -p parameter -n 5
</code></pre>

The command definition has to contain two directives



<pre><code>
 define command{
</code></pre>

Then we have to define the check\_command directive which is part of the
host/service definition starting with the short name followed by the
arguments separated by exclamation marks (!):

<pre><code>
 check_command check_sample!argument1!parameter!5
</code></pre>

As you can see the IP-address is not specified because it is taken from
the host definition.

Putting it all together in reverse order shows how Icinga will process
the information:

<pre><code>
 check_command check_sample!argument1!parameter!5

results in:

 /usr/local/icinga/libexec/sample-plugin.pl -H 192.168.1.2 -a argument1 -p parameter -n 5
</code></pre>

In addition to the
[macros](macros.md "5.2. Understanding Macros and How They Work")
already mentioned there are a lot of others making life easier. Please
note:





**NRPE and "dont\_blame\_nrpe=1"**

Using NRPE with arguments requires some attention. Given that you have
enabled argument processing on the remote server in
`nrpe.cfg` using "dont\_blame\_nrpe=1" (or
"allow\_arguments=1" in `nsc.ini`) you can pass parameters
from the Icinga server to the remote machine. Let us assume some
definitions

On the Icinga server

<pre><code>
 define command{

 define service{
</code></pre>

on the remote server in the NRPE config file

<pre><code>
...
command[check_process]=your_plugin "$ARG1$"
</code></pre>

The Icinga process will resolve the definitions as follows

<pre><code>
 check_command check_nrpe!check_process!cupsd

results in:

 /usr/local/icinga/libexec/check_nrpe -H 192.168.1.2 -c check_process -a cupsd
</code></pre>

On the remote machine the NRPE process receives a call providing two
parameters: "check\_process" and "cupsd". The first is stripped to
determine the command to be executed so only **one** argument is passed
to the command!

![[Note]](../images/note.png)

Note

\$ARG1\$ on the remote machine is **not** the same as on the Icinga
server!

### 5.1.10. Raw command line

The classic UI allows to inspect the raw command line including values
from `resource.cfg`. Clicking on "ACTIVE" next to "Check
type" within host/service check details will give access to this
information. If you don't have defined a check yet choose "View Config"
from the main menu on the left, then "Command expansion". Please note
that the user has to be permitted explicitly using the directive
[authorized\_for\_full\_command\_resolution](configcgi.md#configcgi-authorized_for_full_command_resolution)
in `cgi.cfg` to see the values of variables from
`resource.cfg`. The user running the web server must have
read access on this file, too.

If you intend to log the raw command line then change some directives in
`icinga.cfg` to the following values

<pre><code>
 # 256 = Commands
 debug_level=272
 debug_verbosity=2
 max_debug_file_size=1000000000
</code></pre>

### 5.1.11. Threshold and ranges

Some plugins support specifying ranges for the warning and critical
values. Please check the documentation if this is the case for the
plugin you want to use. The following is an excerpt from the [developer
guidelines](https://www.monitoring-plugins.org/doc/guidelines.md#THRESHOLDFORMAT):

A range is defined as a start and end point (inclusive) on a numeric
scale (possibly negative or positive infinity).

A threshold is a range with an alert level (either warning or critical).

The theory is that the plugin will do some sort of check which returns
back a numerical value, or metric, which is then compared to the warning
and critical thresholds.

This is the generalised format for ranges:

`[@]start:end`

Notes:







![[Note]](../images/note.png)

Note

Not all plugins are coded to expect ranges in this format yet.

Example ranges

**Range definition**

**Generate an alert if x...**

10

\< 0 or \> 10, (outside the range of {0 .. 10})

10:

\< 10, (outside {10 .. infinity})

\~:10

\> 10, (outside the range of {-infinity .. 10})

10:20

\< 10 or \> 20, (outside the range of {10 .. 20})

@10:20

\>= 10 and \<= 20, (inside the range of {10 .. 20})

Command line examples

**Command line**

**Meaning**

check\_stuff -w10 -c20

Critical if "stuff" is over 20, else warn if over 10 (will be critical
if "stuff" is less than 0)

check\_stuff -w\~:10 -c\~:20

Same as above. Negative "stuff" is OK

check\_stuff -w10: -c20

Critical if "stuff" is over 20, else warn if "stuff" is below 10 (will
be critical if "stuff" is less than 0)

check\_stuff -c1:

Critical if "stuff" is less than 1

check\_stuff -w\~:0 -c10

Critical if "stuff" is above 10; Warn if "stuff" is above zero

check\_stuff -c5:6

The only noncritical range is 5:6

check\_stuff -c@10:20

Critical if "stuff" is 10 to 20 **[1]**

check\_stuff -w20:30 -c10:40

Warning if "stuff" below 20 or above 30, critical if "stuff" is below 10
or above 40 **[2]**

![[Note]](../images/note.png)

Note

[1]: The command line of the developer guidelines seems to be lacking
"@" otherwise the meaning would be wrong (and there wouldn't be an
example for the @ notation)

[2]: Please note that the last example shows nested ranges. This might
not even work with every plugin supporting ranges. It was tested using
check\_snmp.

### 5.1.12. Activating the definition

Check the configuration using "/etc/init.d/icinga show-errors" and
resolve any errors before issuing "/etc/init.d/icinga restart". Wait
until the object is checked and look at the status details. There might
be errors.









### 5.1.13. Plugin API

You can find information on the technical aspects of plugins, as well as
how to go about creating your own custom plugins
[here](pluginapi.md "11.1. Icinga Plugin API").

* * * * *

[Prev](ch05.md) | [Up](ch05.md) | [Next](macros.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
