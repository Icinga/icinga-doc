[Prev](config.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](configobject.md)

* * * * *

3.2. Main Configuration File Options
------------------------------------

**Notes**

When creating and/or editing configuration files, keep the following in
mind:




**Sample Configuration File**

![[Tip]](../images/tip.png)

Tip

A sample main configuration file (*/usr/local/icinga/etc/icinga.cfg*) is
installed for you when you follow the [quickstart installation
guide](quickstart.md "2.3. Quickstart Installation Guides").

**Config File Location**

The main configuration file is usually named *icinga.cfg* and located in
the */usr/local/icinga/etc/* directory.

**Configuration File Variables**









































































































































Below you will find descriptions of each main Icinga configuration file
option...

**Log File**

Format:

**log\_file=\<file\_name\>**

Example:

**log\_file=/usr/local/icinga/var/icinga.log**

This variable specifies where Icinga should create its main log file.
This should be the first variable that you define in your configuration
file, as Icinga will try to write errors that it finds in the rest of
your configuration data to this file. If you have [log
rotation](configmain.md#configmain-log_rotation_method) enabled, this
file will automatically be rotated every hour, day, week, or month.

**Object Configuration File**

Format:

**cfg\_file=\<file\_name\>**

Example:

**cfg\_file=/usr/local/icinga/etc/conf.d/hosts.cfg**

**cfg\_file=/usr/local/icinga/etc/conf.d/services.cfg**

**cfg\_file=/usr/local/icinga/etc/conf.d/commands.cfg**

This directive is used to specify an [object configuration
file](configobject.md "3.3. Object Configuration Overview") containing
object definitions that Icinga should use for monitoring. Object
configuration files contain definitions for hosts, host groups,
contacts, contact groups, services, commands, etc. You can separate your
configuration information into several files and specify multiple
*cfg\_file=* statements to have each of them processed.

![[Note]](../images/note.png)

Note

Using `cfg_file=.../foo/bar.cfg` for a file in the same
directory which is specified in a `cfg_dir=.../foo` directive
will result in the file being processed twice and lead to config
verification errors.

**Object Configuration Directory**

Format:

**cfg\_dir=\<directory\_name\>**

Example:

**cfg\_dir=/usr/local/icinga/etc/conf.d**

This directive is used to specify a directory which contains [object
configuration
files](configobject.md "3.3. Object Configuration Overview") that
Icinga should use for monitoring. All files in the directory with a
*.cfg* extension are processed as object config files. Additionally,
Icinga will recursively process all config files in subdirectories of
the directory you specify here. You can separate your configuration
files into different directories and specify multiple *cfg\_dir=*
statements to have all config files in each directory processed.

![[Note]](../images/note.png)

Note

Using `cfg_file=.../foo/bar.cfg` for a file in the same
directory which is specified in a `cfg_dir=.../foo` directive
will result in the file being processed twice and lead to config
verification errors.

**Object Cache File**

Format:

**object\_cache\_file=\<file\_name\>**

Example:

**object\_cache\_file=/usr/local/icinga/var/objects.cache**

This directive is used to specify a file in which a cached copy of
[object
definitions](configobject.md "3.3. Object Configuration Overview")
should be stored. The cache file is (re)created every time Icinga is
(re)started and is used by the CGIs. It is intended to speed up config
file caching in the CGIs and allow you to edit the source [object config
files](configmain.md#configmain-cfg_file) while Icinga is running
without affecting the output displayed in the CGIs.

**Precached Object File**

Format:

**precached\_object\_file=\<file\_name\>**

Example:

**precached\_object\_file=/usr/local/icinga/var/objects.precache**

This directive is used to specify a file in which a pre-processed,
pre-cached copy of [object
definitions](configobject.md "3.3. Object Configuration Overview")
should be stored. This file can be used to drastically improve startup
times in large/complex Icinga installations. Read more information on
how to speed up start times
[here](faststartup.md "8.4. Fast Startup Options").

**Resource File**

Format:

**resource\_file=\<file\_name\>**

Example:

**resource\_file=/usr/local/icinga/etc/resource.cfg**

This is used to specify an optional resource file that can contain
\$USERn\$
[macro](macros.md "5.2. Understanding Macros and How They Work")
definitions. \$USERn\$ macros are useful for storing usernames,
passwords, and items commonly used in command definitions (like
directory paths). The CGIs will *not* attempt to read resource files, so
you can set restrictive permissions (600 or 660) on them to protect
sensitive information. You can include multiple resource files by adding
process them all. See the sample resource.cfg file in the
*sample-config/* subdirectory of the Icinga distribution for an example
of how to define \$USERn\$ macros.

**Temp File**

Format:

**temp\_file=\<file\_name\>**

Example:

**temp\_file=/usr/local/icinga/var/icinga.tmp**

This is a temporary file that Icinga periodically creates to use when
updating comment data, status data, etc. The file is deleted when it is
no longer needed.

**Temp Path**

Format:

**temp\_path=\<dir\_name\>**

Example:

**temp\_path=/tmp**

This is a directory that Icinga can use as scratch space for creating
temporary files used during the monitoring process. You should run
*tmpwatch*, or a similiar utility, on this directory occassionally to
delete files older than 24 hours.

**Status File**

Format:

**status\_file=\<file\_name\>**

Example:

**status\_file=/usr/local/icinga/var/status.dat**

This is the file that Icinga uses to store the current status, comment,
and downtime information. This file is used by the CGIs so that current
monitoring status can be reported via a web interface. The CGIs must
have read access to this file in order to function properly. This file
is deleted every time Icinga stops and recreated when it starts.

**Status File Update Interval**

Format:

**status\_update\_interval=\<seconds\>**

Example:

**status\_update\_interval=15**

This setting determines how often (in seconds) that Icinga will update
status data in the [status
file](configmain.md#configmain-status_file). The minimum update
interval is 1 second.

**Icinga User**

Format:

**icinga\_user=\<username/UID\>**

Example:

**icinga\_user=icinga**

This is used to set the effective user that the Icinga process should
run as. After initial program startup and before starting to monitor
anything, Icinga will drop its effective privileges and run as this
user. You may specify either a username or a UID.

**Icinga Group**

Format:

**icinga\_group=\<groupname/GID\>**

Example:

**icinga\_group=icinga**

This is used to set the effective group that the Icinga process should
run as. After initial program startup and before starting to monitor
anything, Icinga will drop its effective privileges and run as this
group. You may specify either a groupname or a GID.

**Notifications Option**

Format:

**enable\_notifications=\<0/1\>**

Example:

**enable\_notifications=1**

This option determines whether or not Icinga will send out
[notifications](notifications.md "5.11. Notifications") when it
initially (re)starts. If this option is disabled, Icinga will not send
out notifications for any host or service.

![[Note]](../images/note.png)

Note

If you have [state
retention](configmain.md#configmain-retain_state_information) enabled,
Icinga will ignore this setting when it (re)starts and use the last
known setting for this option (as stored in the [state retention
file](configmain.md#configmain-state_retention_file)), *unless* you
disable the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
option. If you want to change this option when state retention is active
(and the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
is enabled), you'll have to use the appropriate [external
command](extcommands.md "7.1. External Commands") or change it via the
web interface.

Values are as follows:



**Service Check Execution Option**

Format:

**execute\_service\_checks=\<0/1\>**

Example:

**execute\_service\_checks=1**

This option determines whether or not Icinga will execute service checks
when it initially (re)starts. If this option is disabled, Icinga will
not actively execute any service checks and will remain in a sort of
"sleep" mode (it can still accept [passive
checks](passivechecks.md "5.7. Passive Checks") unless you've
[disabled
them](configmain.md#configmain-accept_passive_service_checks)). This
option is most often used when configuring backup monitoring servers, as
described in the documentation on
[redundancy](redundancy.md "7.7. Redundant and Failover Network Monitoring"),
or when setting up a
[distributed](distributed.md "7.6. Distributed Monitoring") monitoring
environment.

![[Note]](../images/note.png)

Note

If you have [state
retention](configmain.md#configmain-retain_state_information) enabled,
Icinga will ignore this setting when it (re)starts and use the last
known setting for this option (as stored in the [state retention
file](configmain.md#configmain-state_retention_file)), *unless* you
disable the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
option. If you want to change this option when state retention is active
(and the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
is enabled), you'll have to use the appropriate [external
command](extcommands.md "7.1. External Commands") or change it via the
web interface.

Values are as follows:



**Passive Service Check Acceptance Option**

Format:

**accept\_passive\_service\_checks=\<0/1\>**

Example:

**accept\_passive\_service\_checks=1**

This option determines whether or not Icinga will accept [passive
service checks](passivechecks.md "5.7. Passive Checks") when it
initially (re)starts. If this option is disabled, Icinga will not accept
any passive service checks.

![[Note]](../images/note.png)

Note

If you have [state
retention](configmain.md#configmain-retain_state_information) enabled,
Icinga will ignore this setting when it (re)starts and use the last
known setting for this option (as stored in the [state retention
file](configmain.md#configmain-state_retention_file)), *unless* you
disable the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
option. If you want to change this option when state retention is active
(and the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
is enabled), you'll have to use the appropriate [external
command](extcommands.md "7.1. External Commands") or change it via the
web interface.

Values are as follows:



**Host Check Execution Option**

Format:

**execute\_host\_checks=\<0/1\>**

Example:

**execute\_host\_checks=1**

This option determines whether or not Icinga will execute on-demand and
regularly scheduled host checks when it initially (re)starts. If this
option is disabled, Icinga will not actively execute any host checks,
although it can still accept [passive host
checks](passivechecks.md "5.7. Passive Checks") unless you've
[disabled them](configmain.md#configmain-accept_passive_host_checks)).
This option is most often used when configuring backup monitoring
servers, as described in the documentation on
[redundancy](redundancy.md "7.7. Redundant and Failover Network Monitoring"),
or when setting up a
[distributed](distributed.md "7.6. Distributed Monitoring") monitoring
environment.

![[Note]](../images/note.png)

Note

If you have [state
retention](configmain.md#configmain-retain_state_information) enabled,
Icinga will ignore this setting when it (re)starts and use the last
known setting for this option (as stored in the [state retention
file](configmain.md#configmain-state_retention_file)), *unless* you
disable the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
option. If you want to change this option when state retention is active
(and the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
is enabled), you'll have to use the appropriate [external
command](extcommands.md "7.1. External Commands") or change it via the
web interface.

Values are as follows:



**Passive Host Check Acceptance Option**

Format:

**accept\_passive\_host\_checks=\<0/1\>**

Example:

**accept\_passive\_host\_checks=1**

This option determines whether or not Icinga will accept [passive host
checks](passivechecks.md "5.7. Passive Checks") when it initially
(re)starts. If this option is disabled, Icinga will not accept any
passive host checks.

![[Note]](../images/note.png)

Note

If you have [state
retention](configmain.md#configmain-retain_state_information) enabled,
Icinga will ignore this setting when it (re)starts and use the last
known setting for this option (as stored in the [state retention
file](configmain.md#configmain-state_retention_file)), *unless* you
disable the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
option. If you want to change this option when state retention is active
(and the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
is enabled), you'll have to use the appropriate [external
command](extcommands.md "7.1. External Commands") or change it via the
web interface.

Values are as follows:



**Event Handler Option**

Format:

**enable\_event\_handlers=\<0/1\>**

Example:

**enable\_event\_handlers=1**

This option determines whether or not Icinga will run [event
handlers](eventhandlers.md "7.3. Event Handlers") when it initially
(re)starts. If this option is disabled, Icinga will not run any host or
service event handlers.

![[Note]](../images/note.png)

Note

If you have [state
retention](configmain.md#configmain-retain_state_information) enabled,
Icinga will ignore this setting when it (re)starts and use the last
known setting for this option (as stored in the [state retention
file](configmain.md#configmain-state_retention_file)), *unless* you
disable the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
option. If you want to change this option when state retention is active
(and the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
is enabled), you'll have to use the appropriate [external
command](extcommands.md "7.1. External Commands") or change it via the
web interface.

Values are as follows:



**Log Rotation Method**

Format:

**log\_rotation\_method=\<n/h/d/w/m\>**

Example:

**log\_rotation\_method=d**

This is the rotation method that you would like Icinga to use for your
log file. Values are as follows:






**Log Archive Path**

Format:

**log\_archive\_path=\<path\>**

Example:

**log\_archive\_path=/usr/local/icinga/var/archives/**

This is the directory where Icinga should place log files that have been
rotated. This option is ignored if you choose to not use the [log
rotation](configmain.md#configmain-log_rotation_method) functionality.

**Logging Options for Daemon**

Format:

**use\_daemon\_log=\<0/1\>**

Example:

**use\_daemon\_log=1**

This option determines if the log daemon writes to the log file (usually
icinga.log).



**External Command Check Option**

Format:

**check\_external\_commands=\<0/1\>**

Example:

**check\_external\_commands=1**

This option determines whether or not Icinga will check the [command
file](configmain.md#configmain-command_file) for commands that should
be executed. This option must be enabled if you plan on using the
[command CGI](cgis.md#cgis-cmd_cgi) to issue commands via the web
interface. Icinga Web and other addons like NagVis, Nagios Checker,
Nagstamon and NagiosQL also use this file to issue commands to Icinga.
More information on external commands can be found
[here](extcommands.md "7.1. External Commands").



**External Command Check Interval**

Format:

**command\_check\_interval=\<xxx\>[s]**

Example:

**command\_check\_interval=1**

If you specify a number with an "s" appended to it (i.e. 30s), this is
the number of *seconds* to wait between external command checks. If you
leave off the "s", this is the number of "time units" to wait between
external command checks. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) value (as
defined below) from the default value of 60, this number will mean
minutes.

![[Note]](../images/note.png)

Note

Icinga will also check for external commands after event handlers are
executed.

![[Note]](../images/note.png)

Note

By setting this value to **-1**, Icinga will check for external commands
as often as possible. Each time Icinga checks for external commands it
will read and process all commands present in the [command
file](configmain.md#configmain-command_file) before continuing on with
its other duties. More information on external commands can be found
[here](extcommands.md "7.1. External Commands").

**External Command File**

Format:

**command\_file=\<file\_name\>**

Example:

**command\_file=/usr/local/icinga/var/rw/icinga.cmd**

This is the file that Icinga will check for external commands to
process. The [command CGI](cgis.md#cgis-cmd_cgi), Icinga Web and other
addons write commands to this file. The external command file is
implemented as a named pipe (FIFO), which is created when Icinga starts
and removed when it shuts down. If the file exists when Icinga starts,
the Icinga process will terminate with an error message. More
information on external commands can be found
[here](extcommands.md "7.1. External Commands").

**External Command Buffer Slots**

Format:

**external\_command\_buffer\_slots=\<\#\>**

Example:

**external\_command\_buffer\_slots=512**

![[Note]](../images/note.png)

Note

This is an advanced feature. This option determines how many buffer
slots Icinga will reserve for caching external commands that have been
read from the external command file by a worker thread, but have not yet
been processed by the main thread of the Icinga deamon. Each slot can
hold one external command, so this option essentially determines how
many commands can be buffered. For installations where you process a
large number of passive checks (e.g. [distributed
setups](distributed.md "7.6. Distributed Monitoring")), you may need
to increase this number. You should consider using PNP4Nagios to graph
Icinga's usage of external command buffers. You can read more on how to
configure graphing
[here](perfgraphs.md "8.7. Graphing Performance Info With PNP4Nagios").

**Lock File**

Format:

**lock\_file=\<file\_name\>**

Example:

**lock\_file=/tmp/icinga.lock**

This option specifies the location of the lock file that Icinga should
create when it runs as a daemon (when started with the -d command line
argument). This file contains the process id (PID) number of the running
Icinga process.

**State Retention Option**

Format:

**retain\_state\_information=\<0/1\>**

Example:

**retain\_state\_information=1**

This option determines whether or not Icinga will retain state
information for hosts and services between program restarts. If you
enable this option, you should supply a value for the
[state\_retention\_file](configmain.md#configmain-state_retention_file)
variable. When enabled, Icinga will save all state information for hosts
and service before it shuts down (or restarts) and will read in
previously saved state information when it starts up again.



**State Retention File**

Format:

**state\_retention\_file=\<file\_name\>**

Example:

**state\_retention\_file=/usr/local/icinga/var/retention.dat**

This is the file that Icinga will use for storing status, downtime, and
comment information before it shuts down. When Icinga is restarted it
will use the information stored in this file for setting the initial
states of services and hosts before it starts monitoring anything. In
order to make Icinga retain state information between program restarts,
you must enable the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
option.

**Sync Retention File**

Format:

**sync\_retention\_file=\<file\_name\>**

Example:

**sync\_retention\_file=/usr/local/icinga/var/sync.dat**

This is an advanced option which works like the state\_retention\_file
so that you can load a subset of retention information such as status ,
acknowledgements, downtimes, and comments (you will have to create the
contents of this file outside of Icinga). When Icinga is restarted, it
reads the information in the sync\_retention\_file and will update the
host or service specified *if the last\_update time in the sync file is
newer* than in the state\_retention\_file, otherwise information will be
discarded for that host or service. After the sync file has been read,
it will be removed. To disable, comment out the option.

**Automatic State Retention Update Interval**

Format:

**retention\_update\_interval=\<minutes\>**

Example:

**retention\_update\_interval=60**

This setting determines how often (in minutes) that Icinga will
automatically save retention data during normal operation. If you set
this value to 0, Icinga will not save retention data at regular
intervals, but it will still save retention data before shutting down or
restarting. If you have disabled state retention (with the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
option), this option has no effect.

**Use Retained Program State Option**

Format:

**use\_retained\_program\_state=\<0/1\>**

Example:

**use\_retained\_program\_state=1**

This setting determines whether or not Icinga will set various
program-wide state variables based on the values saved in the retention
file. Some of these program-wide state variables that are normally saved
across program restarts if state retention is enabled include the
[enable\_notifications](configmain.md#configmain-enable_notifications),
[enable\_flap\_detection](configmain.md#configmain-enable_flap_detection),
[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers),
[execute\_service\_checks](configmain.md#configmain-execute_service_checks),
and
[accept\_passive\_service\_checks](configmain.md#configmain-accept_passive_service_checks)
options. If you do not have [state
retention](configmain.md#configmain-retain_state_information) enabled,
this option has no effect.



**Dump Retained Host Service States To Neb**

Format:

**dump\_retained\_host\_service\_states\_to\_neb=\<0/1\>**

Example:

**dump\_retained\_host\_service\_states\_to\_neb=0**

This setting determines whether or not Icinga will dump host and service
states based on the values saved in the [retention
file](configmain.md#configmain-state_retention_file) to the neb
modules. If you don't want that, use at your own risk and disable it.



**Use Retained Scheduling Info Option**

Format:

**use\_retained\_scheduling\_info=\<0/1\>**

Example:

**use\_retained\_scheduling\_info=1**

This setting determines whether or not Icinga will retain scheduling
info (next check times) for hosts and services when it restarts. If you
are adding a large number (or percentage) of hosts and services, we
would recommend disabling this option when you first restart Icinga, as
it can adversely skew the spread of initial checks. Otherwise you will
probably want to leave it enabled.



**Retained Host and Service Attribute Masks**

Format:

**retained\_host\_attribute\_mask=\<number\>**

**retained\_service\_attribute\_mask=\<number\>**

Example:

**retained\_host\_attribute\_mask=0**

**retained\_service\_attribute\_mask=0**

WARNING: This is an advanced feature. You'll need to read the Icinga
source code to use this option effectively.

These options determine which host or service attributes are NOT
retained across program restarts. The values for these options are a
bitwise AND of values specified by the "MODATTR\_" definitions in the
include/common.h source code file. By default, all host and service
attributes are retained.

**Retained Process Attribute Masks**

Format:

**retained\_process\_host\_attribute\_mask=\<number\>**

**retained\_process\_service\_attribute\_mask=\<number\>**

Example:

**retained\_process\_host\_attribute\_mask=0**

**retained\_process\_service\_attribute\_mask=0**

WARNING: This is an advanced feature. You'll need to read the Icinga
source code to use this option effectively.

These options determine which process attributes are NOT retained across
program restarts. There are two masks because there are often separate
host and service process attributes that can be changed. For example,
host checks can be disabled at the program level, while service checks
are still enabled. The values for these options are a bitwise AND of
values specified by the "MODATTR\_" definitions in the include/common.h
source code file. By default, all process attributes are retained.

**Retained Contact Attribute Masks**

Format:

**retained\_contact\_host\_attribute\_mask=\<number\>**

**retained\_contact\_service\_attribute\_mask=\<number\>**

Example:

**retained\_contact\_host\_attribute\_mask=0**

**retained\_contact\_service\_attribute\_mask=0**

WARNING: This is an advanced feature. You'll need to read the Icinga
source code to use this option effectively.

These options determine which contact attributes are NOT retained across
program restarts. There are two masks because there are often separate
host and service contact attributes that can be changed. The values for
these options are a bitwise AND of values specified by the "MODATTR\_"
definitions in the include/common.h source code file. By default, all
process attributes are retained.

**Syslog Logging Option**

Format:

**use\_syslog=\<0/1\>**

Example:

**use\_syslog=1**

This variable determines whether messages are logged to the syslog
facility on your local host. Values are as follows:



**Local Syslog Facility Option**

Format:

**use\_syslog\_local\_facility=\<0/1\>**

Example:

**use\_syslog\_local\_facility=1**

If you enabled use\_syslog you can set Icinga to use a local facility
instead of the default. Values are as follows:



**Syslog Local Facility Value**

Format:

**syslog\_local\_facility=\<0|1|2|3|4|5|6|7\>**

Example:

**syslog\_local\_facility=1**

If you enabled use\_syslog\_local\_facility you can choose which local
facility to use. Valid values are from 0 to 7.

**Notification Logging Option**

Format:

**log\_notifications=\<0/1\>**

Example:

**log\_notifications=1**

This variable determines whether or not notification messages are
logged. If you have a lot of contacts or regular service failures your
log file will grow relatively quickly. Use this option to keep contact
notifications from being logged.



**Service Check Retry Logging Option**

Format:

**log\_service\_retries=\<0/1\>**

Example:

**log\_service\_retries=1**

This variable determines whether or not service check retries are
logged. Service check retries occur when a service check results in a
non-OK state, but you have configured Icinga to retry the service more
than once before responding to the error. Services in this situation are
considered to be in "soft" states. Logging service check retries is
mostly useful when attempting to debug Icinga or test out service [event
handlers](eventhandlers.md "7.3. Event Handlers").



**Host Check Retry Logging Option**

Format:

**log\_host\_retries=\<0/1\>**

Example:

**log\_host\_retries=1**

This variable determines whether or not host check retries are logged.
Logging host check retries is mostly useful when attempting to debug
Icinga or test out host [event
handlers](eventhandlers.md "7.3. Event Handlers").



**Event Handler Logging Option**

Format:

**log\_event\_handlers=\<0/1\>**

Example:

**log\_event\_handlers=1**

This variable determines whether or not service and host [event
handlers](eventhandlers.md "7.3. Event Handlers") are logged. Event
handlers are optional commands that can be run whenever a service or
hosts changes state. Logging event handlers is most useful when
debugging Icinga or first trying out your event handler scripts.



**Initial States Logging Option**

Format:

**log\_initial\_states=\<0/1\>**

Example:

**log\_initial\_states=1**

This variable determines whether or not Icinga will force all initial
host and service states to be logged, even if they result in an OK
state. Initial service and host states are normally only logged when
there is a problem on the first check. Enabling this option is useful if
you are using an application that scans the log file to determine
long-term state statistics for services and hosts.



**External Command Logging Option**

Format:

**log\_external\_commands=\<0/1\>**

Example:

**log\_external\_commands=1**

This variable determines whether or not Icinga will log [external
commands](extcommands.md "7.1. External Commands") that it receives
from the [external command
file](configmain.md#configmain-command_file).

![[Note]](../images/note.png)

Note

This option does not control whether or not [passive service
checks](passivechecks.md "5.7. Passive Checks") (which are a type of
external command) get logged. To enable or disable logging of passive
checks, use the
[log\_passive\_checks](configmain.md#configmain-log_passive_checks)
option.



**External Commands User Logging Option**

Format:

**log\_external\_commands\_user=\<0/1\>**

Example:

**log\_external\_commands\_user=1**

This option allows you to enable the logging of the current user of
external commands. The syntax will be CMD;username;cmdargs instead of
CMD;cmdargs written to the logs, if the external application sends that
correctly. Since this will break compatibility with existing log
parsers, it is intentionally disabled by default.

![[Note]](../images/note.png)

Note

This option is deprecated starting with Icinga 1.4 because you can use
the directive [use\_logging](configcgi.md#configcgi-use_logging) to
enable logging of CGI commands.



**Passive Check Logging Option**

Format:

**log\_passive\_checks=\<0/1\>**

Example:

**log\_passive\_checks=1**

This variable determines whether or not Icinga will log [passive host
and service checks](passivechecks.md "5.7. Passive Checks") that it
receives from the [external command
file](configmain.md#configmain-command_file). If you are setting up a
[distributed monitoring
environment](distributed.md "7.6. Distributed Monitoring") or plan on
handling a large number of passive checks on a regular basis, you may
wish to disable this option so your log file doesn't get too large.



**Current State Logging Option**

Format:

**log\_current\_states=\<0/1\>**

Example:

**log\_current\_states=1**

This variable determines whether or not Icinga will log the current
states of hosts and services after a log rotation. If you set the value
of log\_current\_states to 0 the current states will not be written to
the main log file after a log rotation.



**Long Plugin Output Logging Option**

Format:

**log\_long\_plugin\_output=\<0/1\>**

Example:

**log\_long\_plugin\_output=1**

This variable determines whether or not Icinga will log the complete
output of a plugin (not only the first line). If you set the value of
log\_long\_plugin\_output to 1 the complete plugin output will be
logged.



**Global Host Event Handler Option**

Format:

**global\_host\_event\_handler=\<command\>**

Example:

**global\_host\_event\_handler=log-host-event-to-db**

This option allows you to specify a host event handler command that is
to be run for every host state change. The global event handler is
executed immediately prior to the event handler that you have optionally
specified in each host definition. The *command* argument is the short
name of a command that you define in your [object configuration
file](configobject.md "3.3. Object Configuration Overview"). The
maximum amount of time that this command can run is controlled by the
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)
option. More information on event handlers can be found
[here](eventhandlers.md "7.3. Event Handlers").

**Global Service Event Handler Option**

Format:

**global\_service\_event\_handler=\<command\>**

Example:

**global\_service\_event\_handler=log-service-event-to-db**

This option allows you to specify a service event handler command that
is to be run for every service state change. The global event handler is
executed immediately prior to the event handler that you have optionally
specified in each service definition. The *command* argument is the
short name of a command that you define in your [object configuration
file](configobject.md "3.3. Object Configuration Overview"). The
maximum amount of time that this command can run is controlled by the
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)
option. More information on event handlers can be found
[here](eventhandlers.md "7.3. Event Handlers").

**Event handlers for stalked hosts**

**Event handlers for stalked services**

Format:

**stalking\_event\_handlers\_for\_hosts=\<0|1\>**

**stalking\_event\_handlers\_for\_services=\<0|1\>**

Example:

**stalking\_event\_handlers\_for\_hosts=1**

These options allow you to specify whether or not Icinga executes event
handlers for stalked hosts or services, respectively. This way it is
possible to forward status information changes to external systems.



**Notifications for stalked hosts**

**Notifications for stalked services**

Format:

**stalking\_notification\_for\_hosts=\<0|1\>**

**stalking\_notifications\_for\_services=\<0|1\>**

Example:

**stalking\_notifications\_for\_hosts=1**

These options specify globally for all contacts whether or not Icinga
sends notifications for stalked hosts/services.

![[Note]](../images/note.png)

Note

Unless there are no stalking\_options defined on a host/service, the
global definitions above won't affect anything.



**Inter-Check Sleep Time**

Format:

**sleep\_time=\<seconds\>**

Example:

**sleep\_time=1**

This is the number of seconds that Icinga will sleep before checking to
see if the next service or host check in the scheduling queue should be
executed. Note that Icinga will only sleep after it "catches up" with
queued service checks that have fallen behind.

**Service Inter-Check Delay Method**

Format:

**service\_inter\_check\_delay\_method=\<n/d/s/x.xx\>**

Example:

**service\_inter\_check\_delay\_method=s**

This option allows you to control how service checks are initially
"spread out" in the event queue. Using a "smart" delay calculation (the
default) will cause Icinga to calculate an average check interval and
spread initial checks of all services out over that interval, thereby
helping to eliminate CPU load spikes. Using no delay is generally *not*
recommended, as it will cause all service checks to be scheduled for
execution at the same time. This means that you will generally have
large CPU spikes when the services are all executed in parallel. More
information on how to estimate how the inter-check delay affects service
check scheduling can be found
[here](checkscheduling.md#serviceintercheckdelay "7.23.4. Inter-Check Delay").
Values are as follows:





**Maximum Service Check Spread**

Format:

**max\_service\_check\_spread=\<minutes\>**

Example:

**max\_service\_check\_spread=30**

This option determines the maximum number of minutes from when Icinga
starts that all services (that are scheduled to be regularly checked)
are checked. This option will automatically adjust the [service
inter-check delay
method](configmain.md#configmain-service_inter_check_delay_method) (if
necessary) to ensure that the initial checks of all services occur
within the timeframe you specify. In general, this option will not have
an affect on service check scheduling if scheduling information is being
retained using the
[use\_retained\_scheduling\_info](configmain.md#configmain-use_retained_scheduling_info)
option. Default value is **30** (minutes).

**Service Interleave Factor**

Format:

**service\_interleave\_factor=\<s|x\>**

Example:

**service\_interleave\_factor=s**

This variable determines how service checks are interleaved.
Interleaving allows for a more even distribution of service checks,
reduced load on remote hosts, and faster overall detection of host
problems. Setting this value to 1 is equivalent to not interleaving the
service checks (this is how versions of Icinga previous to 0.0.5
worked). Set this value to **s** (smart) for automatic calculation of
the interleave factor unless you have a specific reason to change it.
The best way to understand how interleaving works is to watch the
[status CGI](cgis.md#cgis-status_cgi) (detailed view) when Icinga is
just starting. You should see that the service check results are spread
out as they begin to appear. More information on how interleaving works
can be found
[here](checkscheduling.md#serviceinterleaving "7.23.5. Service Interleaving").



**Maximum Concurrent Service Checks**

Format:

**max\_concurrent\_checks=\<max\_checks\>**

Example:

**max\_concurrent\_checks=20**

This option allows you to specify the maximum number of service checks
that can be run in parallel at any given time. Specifying a value of 1
for this variable essentially prevents any service checks from being run
in parallel. Specifying a value of 0 (the default) does not place any
restrictions on the number of concurrent checks. You'll have to modify
this value based on the system resources you have available on the
machine that runs Icinga, as it directly affects the maximum load that
will be imposed on the system (processor utilization, memory, etc.).
More information on how to estimate how many concurrent checks you
should allow can be found
[here](checkscheduling.md#maxconcurrentchecks "7.23.6. Maximum Concurrent Service Checks").

**Check Result Reaper Frequency**

Format:

**check\_result\_reaper\_frequency=\<frequency\_in\_seconds\>**

Example:

**check\_result\_reaper\_frequency=5**

This option allows you to control the frequency *in seconds* of check
result "reaper" events. "Reaper" events process the results from host
and service checks that have finished executing. These events consitute
the core of the monitoring logic in Icinga.

**Maximum Check Result Reaper Time**

Format:

**max\_check\_result\_reaper\_time=\<seconds\>**

Example:

**max\_check\_result\_reaper\_time=30**

This option allows you to control the maximum amount of time *in
seconds* that host and service check result "reaper" events are allowed
to run. "Reaper" events process the results from host and service checks
that have finished executing. If there are a lot of results to process,
reaper events may take a long time to finish, which might delay timely
execution of new host and service checks. This variable allows you to
limit the amount of time that an individual reaper event will run before
it hands control back over to Icinga for other portions of the
monitoring logic.

**Check Result Path**

Format:

**check\_result\_path=\<path\>**

Example:

**check\_result\_path=/var/spool/icinga/checkresults**

This options determines which directory Icinga will use to temporarily
store host and service check results before they are processed. This
directory should not be used to store any other files, as Icinga will
periodically clean this directory of old file (see the
[max\_check\_result\_file\_age](configmain.md#configmain-max_check_result_file_age)
option for more information).

![[Note]](../images/note.png)

Note

Make sure that only a single instance of Icinga has access to the check
result path. If multiple instances of Icinga have their check result
path set to the same directory, you will run into problems with check
results being processed (incorrectly) by the wrong instance of Icinga!

**Max Check Result File Age**

Format:

**max\_check\_result\_file\_age=\<seconds\>**

Example:

**max\_check\_result\_file\_age=3600**

This options determines the maximum age in seconds that Icinga will
consider check result files found in the
[check\_result\_path](configmain.md#configmain-check_result_path)
directory to be valid. Check result files that are older that this
threshold will be deleted by Icinga and the check results they contain
will not be processed. By using a value of zero (0) with this option,
your hardware :-).

**Host Inter-Check Delay Method**

Format:

**host\_inter\_check\_delay\_method=\<n/d/s/x.xx\>**

Example:

**host\_inter\_check\_delay\_method=s**

This option allows you to control how host checks *that are scheduled to
be checked on a regular basis* are initially "spread out" in the event
queue. Using a "smart" delay calculation (the default) will cause Icinga
to calculate an average check interval and spread initial checks of all
hosts out over that interval, thereby helping to eliminate CPU load
spikes. Using no delay is generally *not* recommended. Using no delay
will cause all host checks to be scheduled for execution at the same
time. More information on how to estimate how the inter-check delay
affects host check scheduling can be found
[here](checkscheduling.md#hostintercheckdelay). Values are as follows:





**Maximum Host Check Spread**

Format:

**max\_host\_check\_spread=\<minutes\>**

Example:

**max\_host\_check\_spread=30**

This option determines the maximum number of minutes from when Icinga
starts that all hosts (that are scheduled to be regularly checked) are
checked. This option will automatically adjust the [host inter-check
delay method](configmain.md#configmain-host_inter_check_delay_method)
(if necessary) to ensure that the initial checks of all hosts occur
within the timeframe you specify. In general, this option will not have
an affect on host check scheduling if scheduling information is being
retained using the
[use\_retained\_scheduling\_info](configmain.md#configmain-use_retained_scheduling_info)
option. Default value is **30** (minutes).

**Timing Interval Length**

Format:

**interval\_length=\<seconds\>**

Example:

**interval\_length=60**

This is the number of seconds per "unit interval" used for timing in the
scheduling queue, re-notifications, etc. "Units intervals" are used in
the object configuration file to determine how often to run a service
check, how often to re-notify a contact, etc.

**Important:** The default value for this is set to 60, which means that
a "unit value" of 1 in the object configuration file will mean 60
seconds (1 minute). We have not really tested other values for this
variable, so proceed at your own risk if you decide to do so!

**Auto-Rescheduling Option**

Format:

**auto\_reschedule\_checks=\<0/1\>**

Example:

**auto\_reschedule\_checks=1**

This option determines whether or not Icinga will attempt to
automatically reschedule active host and service checks to "smooth" them
out over time. This can help to balance the load on the monitoring
server, as it will attempt to keep the time between consecutive checks
consistent, at the expense of executing checks on a more rigid schedule.

**WARNING:** THIS IS AN EXPERIMENTAL FEATURE AND MAY BE REMOVED IN

**Auto-Rescheduling Interval**

Format:

**auto\_rescheduling\_interval=\<seconds\>**

Example:

**auto\_rescheduling\_interval=30**

This option determines how often (in seconds) Icinga will attempt to
automatically reschedule checks. This option only has an effect if the
[auto\_reschedule\_checks](configmain.md#configmain-auto_reschedule_checks)
option is enabled. Default is 30 seconds.

**WARNING:** THIS IS AN EXPERIMENTAL FEATURE AND MAY BE REMOVED IN
FUTURE VERSIONS. ENABLING THE AUTO-RESCHEDULING OPTION CAN DEGRADE

**Auto-Rescheduling Window**

Format:

**auto\_rescheduling\_window=\<seconds\>**

Example:

**auto\_rescheduling\_window=180**

This option determines the "window" of time (in seconds) that Icinga
will look at when automatically rescheduling checks. Only host and
service checks that occur in the next X seconds (determined by this
variable) will be rescheduled. This option only has an effect if the
[auto\_reschedule\_checks](configmain.md#configmain-auto_reschedule_checks)
option is enabled. Default is 180 seconds (3 minutes).

**WARNING:** THIS IS AN EXPERIMENTAL FEATURE AND MAY BE REMOVED IN
FUTURE VERSIONS. ENABLING THE AUTO-RESCHEDULING OPTION CAN DEGRADE

**Aggressive Host Checking Option**

Format:

**use\_aggressive\_host\_checking=\<0/1\>**

Example:

**use\_aggressive\_host\_checking=0**

Icinga tries to be smart about how and when it checks the status of
hosts. In general, disabling this option will allow Icinga to make some
smarter decisions and check hosts a bit faster. Enabling this option
will increase the amount of time required to check hosts, but may
improve reliability a bit. Unless you have problems with Icinga not
recognizing that a host recovered, we would suggest **not** enabling
this option.



**Translate Passive Host Checks Option**

Format:

**translate\_passive\_host\_checks=\<0/1\>**

Example:

**translate\_passive\_host\_checks=1**

This option determines whether or not Icinga will translate
DOWN/UNREACHABLE passive host check results to their "correct" state
from the viewpoint of the local Icinga instance. This can be very useful
in distributed and failover monitoring installations. More information
on passive check state translation can be found
[here](passivestatetranslation.md "7.22. Passive Host State Translation").



**Passive Host Checks Are SOFT Option**

Format:

**passive\_host\_checks\_are\_soft=\<0/1\>**

Example:

**passive\_host\_checks\_are\_soft=1**

This option determines whether or not Icinga will treat [passive host
checks](passivechecks.md "5.7. Passive Checks") as HARD states or SOFT
states. By default, a passive host check result will put a host into a
[HARD state type](statetypes.md "5.8. State Types"). You can change
this behavior by enabling this option.



**Predictive Host Dependency Checks Option**

Format:

**enable\_predictive\_host\_dependency\_checks=\<0/1\>**

Example:

**enable\_predictive\_host\_dependency\_checks=1**

This option determines whether or not Icinga will execute predictive
checks of hosts that are being depended upon (as defined in [host
dependencies](objectdefinitions.md#objectdefinitions-hostdependency))
for a particular host when it changes state. Predictive checks help
ensure that the dependency logic is as accurate as possible. More
information on how predictive checks work can be found
[here](dependencychecks.md "7.20. Predictive Dependency Checks").



**Predictive Service Dependency Checks Option**

Format:

**enable\_predictive\_service\_dependency\_checks=\<0/1\>**

Example:

**enable\_predictive\_service\_dependency\_checks=1**

This option determines whether or not Icinga will execute predictive
checks of services that are being depended upon (as defined in [service
dependencies](objectdefinitions.md#objectdefinitions-servicedependency))
for a particular service when it changes state. Predictive checks help
ensure that the dependency logic is as accurate as possible. More
information on how predictive checks work can be found
[here](dependencychecks.md "7.20. Predictive Dependency Checks").



**Cached Host Check Horizon**

Format:

**cached\_host\_check\_horizon=\<seconds\>**

Example:

**cached\_host\_check\_horizon=15**

This option determines the maximum amount of time (in seconds) that the
state of a previous host check is considered current. Cached host states
(from host checks that were performed more recently than the time
specified by this value) can improve host check performance immensely.
Too high of a value for this option may result in (temporarily)
inaccurate host states, while a low value may result in a performance
hit for host checks. Use a value of 0 if you want to disable host check
caching. More information on cached checks can be found
[here](cachedchecks.md "7.21. Cached Checks").

**Cached Service Check Horizon**

Format:

**cached\_service\_check\_horizon=\<seconds\>**

Example:

**cached\_service\_check\_horizon=15**

This option determines the maximum amount of time (in seconds) that the
state of a previous service check is considered current. Cached service
states (from service checks that were performed more recently than the
time specified by this value) can improve service check performance when
a lot of [service
dependencies](objectdefinitions.md#objectdefinitions-servicedependency)
are used. Too high of a value for this option may result in inaccuracies
in the service dependency logic. Use a value of 0 if you want to disable
service check caching. More information on cached checks can be found
[here](cachedchecks.md "7.21. Cached Checks").

**Large Installation Tweaks Option**

Format:

**use\_large\_installation\_tweaks=\<0/1\>**

Example:

**use\_large\_installation\_tweaks=0**

This option determines whether or not the Icinga daemon will take
several shortcuts to improve performance. These shortcuts result in the
loss of a few features, but larger installations will likely see a lot
of benefit from doing so. More information on what optimizations are
taken when you enable this option can be found
[here](largeinstalltweaks.md "8.5. Large Installation Tweaks").



**Child Process Memory Option**

Format:

**free\_child\_process\_memory=\<0/1\>**

Example:

**free\_child\_process\_memory=0**

This option determines whether or not Icinga will free memory in child
processes when they are fork()ed off from the main process. By default,
Icinga frees memory. However, if the
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)
option is enabled, it will not. By defining this option in your
configuration file, you are able to override things to get the behavior
you want.



**Child Processes Fork Twice**

Format:

**child\_processes\_fork\_twice=\<0/1\>**

Example:

**child\_processes\_fork\_twice=0**

This option determines whether or not Icinga will fork() child processes
twice when it executes host and service checks. By default, Icinga
fork()s twice. However, if the
[use\_large\_installation\_tweaks](configmain.md#configmain-use_large_installation_tweaks)
option is enabled, it will only fork() once. By defining this option in
your configuration file, you are able to override things to get the
behavior you want.



**Environment Macros Option**

Format:

**enable\_environment\_macros=\<0/1\>**

Example:

**enable\_environment\_macros=0**

This option determines whether or not the Icinga daemon will make all
standard [macros](macrolist.md "5.3. Standard Macros in Icinga")
available as environment variables to your check, notification, event
hander, etc. commands. In large Icinga installations this can be
problematic because it takes additional memory and (more importantly)
CPU to compute the values of all macros and make them available to the
environment.



**Flap Detection Option**

Format:

**enable\_flap\_detection=\<0/1\>**

Example:

**enable\_flap\_detection=0**

This option determines whether or not Icinga will try and detect hosts
and services that are "flapping". Flapping occurs when a host or service
changes between states too frequently, resulting in a barrage of
notifications being sent out. When Icinga detects that a host or service
is flapping, it will temporarily suppress notifications for that
host/service until it stops flapping. Flap detection is very
experimental at this point, so use this feature with caution! More
information on how flap detection and handling works can be found
[here](flapping.md "7.8. Detection and Handling of State Flapping").

![[Note]](../images/note.png)

Note

If you have [state
retention](configmain.md#configmain-retain_state_information) enabled,
Icinga will ignore this setting when it (re)starts and use the last
known setting for this option (as stored in the [state retention
file](configmain.md#configmain-state_retention_file)), *unless* you
disable the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
option. If you want to change this option when state retention is active
(and the
[use\_retained\_program\_state](configmain.md#configmain-use_retained_program_state)
is enabled), you'll have to use the appropriate [external
command](extcommands.md "7.1. External Commands") or change it via the
web interface.



**Low Service Flap Threshold**

Format:

**low\_service\_flap\_threshold=\<percent\>**

Example:

**low\_service\_flap\_threshold=25.0**

This option is used to set the low threshold for detection of service
flapping. For more information on how flap detection and handling works
(and how this option affects things) read
[this](flapping.md "7.8. Detection and Handling of State Flapping").

**High Service Flap Threshold**

Format:

**high\_service\_flap\_threshold=\<percent\>**

Example:

**high\_service\_flap\_threshold=50.0**

This option is used to set the high threshold for detection of service
flapping. For more information on how flap detection and handling works
(and how this option affects things) read
[this](flapping.md "7.8. Detection and Handling of State Flapping").

**Low Host Flap Threshold**

Format:

**low\_host\_flap\_threshold=\<percent\>**

Example:

**low\_host\_flap\_threshold=25.0**

This option is used to set the low threshold for detection of host
flapping. For more information on how flap detection and handling works
(and how this option affects things) read
[this](flapping.md "7.8. Detection and Handling of State Flapping").

**High Host Flap Threshold**

Format:

**high\_host\_flap\_threshold=\<percent\>**

Example:

**high\_host\_flap\_threshold=50.0**

This option is used to set the high threshold for detection of host
flapping. For more information on how flap detection and handling works
(and how this option affects things) read
[this](flapping.md "7.8. Detection and Handling of State Flapping").

**Soft State Dependencies Option**

Format:

**soft\_state\_dependencies=\<0/1\>**

Example:

**soft\_state\_dependencies=0**

This option determines whether or not Icinga will use soft state
information when checking [host and service
dependencies](dependencies.md "7.13. Host and Service Dependencies").
Normally Icinga will only use the latest hard host or service state when
checking dependencies. If you want it to use the latest state
(regardless of whether its a soft or hard [state
type](statetypes.md "5.8. State Types")), enable this option.



**Time Change Threshold**

Format:

**time\_change\_threshold=(seconds)**

Example:

**time\_change\_threshold=900**

These option determines when Icinga will react to detected changes in
system time (just forward).

**Service Check Timeout**

Format:

**service\_check\_timeout=\<seconds\>**

Example:

**service\_check\_timeout=60**

This is the maximum number of seconds that Icinga will allow service
checks to run. If checks exceed this limit, they are killed and a
CRITICAL state is returned. A timeout error will also be logged.

There is often widespread confusion as to what this option really does.
It is meant to be used as a last ditch mechanism to kill off plugins
which are misbehaving and not exiting in a timely manner. It should be
set to something high (like 60 seconds or more), so that each service
check normally finishes executing within this time limit. If a service
check runs longer than this limit, Icinga will kill it off thinking it
is a runaway processes.

**Service Check Timeout State**

Format:

**service\_check\_timeout\_state=\<c/u/w/o\>**

Example:

**service\_check\_timeout\_state=u**

This setting determines the state Icinga will report when a service
service\_check\_timeout seconds. This can be useful if a machine is
running at too high a load and you do not want to consider a failed
service check to be critical. The default was changed to
service\_check\_timeout\_state=u in Icinga1.0.1

**Host Check Timeout**

Format:

**host\_check\_timeout=\<seconds\>**

Example:

**host\_check\_timeout=60**

This is the maximum number of seconds that Icinga will allow host checks
to run. If checks exceed this limit, they are killed and a CRITICAL
state is returned and the host will be assumed to be DOWN. A timeout
error will also be logged.

There is often widespread confusion as to what this option really does.
It is meant to be used as a last ditch mechanism to kill off plugins
which are misbehaving and not exiting in a timely manner. It should be
set to something high (like 60 seconds or more), so that each host check
normally finishes executing within this time limit. If a host check runs
longer than this limit, Icinga will kill it off thinking it is a runaway
processes.

**Event Handler Timeout**

Format:

**event\_handler\_timeout=\<seconds\>**

Example:

**event\_handler\_timeout=60**

This is the maximum number of seconds that Icinga will allow [event
handlers](eventhandlers.md "7.3. Event Handlers") to be run. If an
event handler exceeds this time limit it will be killed and a warning
will be logged.

There is often widespread confusion as to what this option really does.
It is meant to be used as a last ditch mechanism to kill off commands
which are misbehaving and not exiting in a timely manner. It should be
set to something high (like 60 seconds or more), so that each event
handler command normally finishes executing within this time limit. If
an event handler runs longer than this limit, Icinga will kill it off
thinking it is a runaway processes.

**Notification Timeout**

Format:

**notification\_timeout=\<seconds\>**

Example:

**notification\_timeout=60**

This is the maximum number of seconds that Icinga will allow
notification commands to be run. If a notification command exceeds this
time limit it will be killed and a warning will be logged.

There is often widespread confusion as to what this option really does.
It is meant to be used as a last ditch mechanism to kill off commands
which are misbehaving and not exiting in a timely manner. It should be
set to something high (like 60 seconds or more), so that each
notification command finishes executing within this time limit. If a
notification command runs longer than this limit, Icinga will kill it
off thinking it is a runaway processes.

**Obsessive Compulsive Service Processor Timeout**

Format:

**ocsp\_timeout=\<seconds\>**

Example:

**ocsp\_timeout=5**

This is the maximum number of seconds that Icinga will allow an
[obsessive compulsive service processor
command](configmain.md#configmain-ocsp_command) to be run. If a
command exceeds this time limit it will be killed and a warning will be
logged.

**Obsessive Compulsive Host Processor Timeout**

Format:

**ochp\_timeout=\<seconds\>**

Example:

**ochp\_timeout=5**

This is the maximum number of seconds that Icinga will allow an
[obsessive compulsive host processor
command](configmain.md#configmain-ochp_command) to be run. If a
command exceeds this time limit it will be killed and a warning will be
logged.

**Performance Data Processor Command Timeout**

Format:

**perfdata\_timeout=\<seconds\>**

Example:

**perfdata\_timeout=5**

This is the maximum number of seconds that Icinga will allow a [host
performance data processor
command](configmain.md#configmain-host_perfdata_command) or [service
performance data processor
command](configmain.md#configmain-service_perfdata_command) to be run.
If a command exceeds this time limit it will be killed and a warning
will be logged.

**Obsess Over Services Option**

Format:

**obsess\_over\_services=\<0/1\>**

Example:

**obsess\_over\_services=1**

This value determines whether or not Icinga will "obsess" over service
checks results and run the [obsessive compulsive service processor
funny name, but it was all Ethan could think of. This option is useful
for performing [distributed
monitoring](distributed.md "7.6. Distributed Monitoring"). If you're
not doing distributed monitoring, don't enable this option.



**Obsessive Compulsive Service Processor Command**

Format:

**ocsp\_command=\<command\>**

Example:

**ocsp\_command=obsessive\_service\_handler**

This option allows you to specify a command to be run after *every*
service check, which can be useful in [distributed
monitoring](distributed.md "7.6. Distributed Monitoring"). This
command is executed after any [event
handler](eventhandlers.md "7.3. Event Handlers") or
[notification](notifications.md "5.11. Notifications") commands. The
*command* argument is the short name of a [command
definition](objectdefinitions.md#objectdefinitions-command) that you
define in your object configuration file. The maximum amount of time
that this command can run is controlled by the
[ocsp\_timeout](configmain.md#configmain-ocsp_timeout) option. More
information on distributed monitoring can be found
[here](distributed.md "7.6. Distributed Monitoring"). This command is
only executed if the
[obsess\_over\_services](configmain.md#configmain-obsess_over_services)
option is enabled globally and if the *obsess\_over\_service* directive
in the [service
definition](objectdefinitions.md#objectdefinitions-service) is
enabled.

**Obsess Over Hosts Option**

Format:

**obsess\_over\_hosts=\<0/1\>**

Example:

**obsess\_over\_hosts=1**

This value determines whether or not Icinga will "obsess" over host
checks results and run the [obsessive compulsive host processor
funny name, but it was all Ethan could think of. This option is useful
for performing [distributed
monitoring](distributed.md "7.6. Distributed Monitoring"). If you're
not doing distributed monitoring, don't enable this option.



**Obsessive Compulsive Host Processor Command**

Format:

**ochp\_command=\<command\>**

Example:

**ochp\_command=obsessive\_host\_handler**

This option allows you to specify a command to be run after *every* host
check, which can be useful in [distributed
monitoring](distributed.md "7.6. Distributed Monitoring"). This
command is executed after any [event
handler](eventhandlers.md "7.3. Event Handlers") or
[notification](notifications.md "5.11. Notifications") commands. The
*command* argument is the short name of a [command
definition](objectdefinitions.md#objectdefinitions-command) that you
define in your object configuration file. The maximum amount of time
that this command can run is controlled by the
[ochp\_timeout](configmain.md#configmain-ochp_timeout) option. More
information on distributed monitoring can be found
[here](distributed.md "7.6. Distributed Monitoring"). This command is
only executed if the
[obsess\_over\_hosts](configmain.md#configmain-obsess_over_hosts)
option is enabled globally and if the *obsess\_over\_host* directive in
the [host definition](objectdefinitions.md#objectdefinitions-host) is
enabled.

**Performance Data Processing Option**

Format:

**process\_performance\_data=\<0/1\>**

Example:

**process\_performance\_data=1**

This value determines whether or not Icinga will process host and
service check [performance
data](perfdata.md "7.15. Performance Data").



**Host Performance Data Processing Command**

Format:

**host\_perfdata\_command=\<command\>**

Example:

**host\_perfdata\_command=process-host-perfdata**

This option allows you to specify a command to be run after *every* host
check to process host [performance
data](perfdata.md "7.15. Performance Data") that may be returned from
the check. The *command* argument is the short name of a [command
definition](objectdefinitions.md#objectdefinitions-command) that you
define in your object configuration file. This command is only executed
if the
[process\_performance\_data](configmain.md#configmain-process_performance_data)
option is enabled globally and if the *process\_perf\_data* directive in
the [host definition](objectdefinitions.md#objectdefinitions-host) is
enabled.

**Service Performance Data Processing Command**

Format:

**service\_perfdata\_command=\<command\>**

Example:

**service\_perfdata\_command=process-service-perfdata**

This option allows you to specify a command to be run after *every*
service check to process service [performance
data](perfdata.md "7.15. Performance Data") that may be returned from
the check. The *command* argument is the short name of a [command
definition](objectdefinitions.md#objectdefinitions-command) that you
define in your object configuration file. This command is only executed
if the
[process\_performance\_data](configmain.md#configmain-process_performance_data)
option is enabled globally and if the *process\_perf\_data* directive in
the [service
definition](objectdefinitions.md#objectdefinitions-service) is
enabled.

**Host Performance Data File**

Format:

**host\_perfdata\_file=\<file\_name\>**

Example:

**host\_perfdata\_file=/usr/local/icinga/var/host-perfdata.dat**

This option allows you to specify a file to which host [performance
data](perfdata.md "7.15. Performance Data") will be written after
every host check. Data will be written to the performance file as
specified by the
[host\_perfdata\_file\_template](configmain.md#configmain-host_perfdata_file_template)
option. Performance data is only written to this file if the
[process\_performance\_data](configmain.md#configmain-process_performance_data)
option is enabled globally and if the *process\_perf\_data* directive in
the [host definition](objectdefinitions.md#objectdefinitions-host) is
enabled.

**Service Performance Data File**

Format:

**service\_perfdata\_file=\<file\_name\>**

Example:

**service\_perfdata\_file=/usr/local/icinga/var/service-perfdata.dat**

This option allows you to specify a file to which service [performance
data](perfdata.md "7.15. Performance Data") will be written after
every service check. Data will be written to the performance file as
specified by the
[service\_perfdata\_file\_template](configmain.md#configmain-service_perfdata_file_template)
option. Performance data is only written to this file if the
[process\_performance\_data](configmain.md#configmain-process_performance_data)
option is enabled globally and if the *process\_perf\_data* directive in
the [service
definition](objectdefinitions.md#objectdefinitions-service) is
enabled.

**Host Performance Data File Template**

Format:

**host\_perfdata\_file\_template=\<template\>**

Example:

**host\_perfdata\_file\_template=[HOSTPERFDATA]\\t\$TIMET\$\\t\$HOSTNAME\$
\\ \\t\$HOSTEXECUTIONTIME\$\\t\$HOSTOUTPUT\$\\t\$HOSTPERFDATA\$**

This option determines what (and how) data is written to the [host
performance data file](configmain.md#configmain-host_perfdata_file).
The template may contain
[macros](macros.md "5.2. Understanding Macros and How They Work"),
special characters (\\t for tab, \\r for carriage return, \\n for
newline) and plain text. A newline is automatically added after each
write to the performance data file.

**Service Performance Data File Template**

Format:

**service\_perfdata\_file\_template=\<template\>**

Example:

**service\_perfdata\_file\_template=[SERVICEPERFDATA]\\t\$TIMET\$\\t\$HOSTNAME\$
\\ \\t\$SERVICEDESC\$\\t\$SERVICEEXECUTIONTIME\$\\t\$SERVICELATENCY\$ \\
\\t\$SERVICEOUTPUT\$\\t\$SERVICEPERFDATA\$**

This option determines what (and how) data is written to the [service
performance data
file](configmain.md#configmain-service_perfdata_file). The template
may contain
[macros](macros.md "5.2. Understanding Macros and How They Work"),
special characters (\\t for tab, \\r for carriage return, \\n for
newline) and plain text. A newline is automatically added after each
write to the performance data file.

**Host Performance Data File Mode**

Format:

**host\_perfdata\_file\_mode=\<mode\>**

Example:

**host\_perfdata\_file\_mode=a**

This option determines how the [host performance data
file](configmain.md#configmain-host_perfdata_file) is opened. Unless
the file is a named pipe you'll probably want to use the default mode of
append.




**Service Performance Data File Mode**

Format:

**service\_perfdata\_file\_mode=\<mode\>**

Example:

**service\_perfdata\_file\_mode=a**

This option determines how the [service performance data
file](configmain.md#configmain-service_perfdata_file) is opened.
Unless the file is a named pipe you'll probably want to use the default
mode of append.




**Host Performance Data File Processing Interval**

Format:

**host\_perfdata\_file\_processing\_interval=\<seconds\>**

Example:

**host\_perfdata\_file\_processing\_interval=0**

This option allows you to specify the interval (in seconds) at which the
[host performance data
file](configmain.md#configmain-host_perfdata_file) is processed using
the [host performance data file processing
command](configmain.md#configmain-host_perfdata_file_processing_command).
A value of 0 indicates that the performance data file should not be
processed at regular intervals.

**Service Performance Data File Processing Interval**

Format:

**service\_perfdata\_file\_processing\_interval=\<seconds\>**

Example:

**service\_perfdata\_file\_processing\_interval=0**

This option allows you to specify the interval (in seconds) at which the
[service performance data
file](configmain.md#configmain-service_perfdata_file) is processed
using the [service performance data file processing
command](configmain.md#configmain-service_perfdata_file_processing_command).
A value of 0 indicates that the performance data file should not be
processed at regular intervals.

**Host Performance Data File Processing Command**

Format:

**host\_perfdata\_file\_processing\_command=\<command\>**

Example:

**host\_perfdata\_file\_processing\_command=process-host-perfdata-file**

This option allows you to specify the command that should be executed to
process the [host performance data
file](configmain.md#configmain-host_perfdata_file). The *command*
argument is the short name of a [command
definition](objectdefinitions.md#objectdefinitions-command) that you
define in your object configuration file. The interval at which this
command is executed is determined by the
[host\_perfdata\_file\_processing\_interval](configmain.md#configmain-host_perfdata_file_processing_interval)
directive.

**Service Performance Data File Processing Command**

Format:

**service\_perfdata\_file\_processing\_command=\<command\>**

Example:

**service\_perfdata\_file\_processing\_command=process-service-perfdata-file**

This option allows you to specify the command that should be executed to
process the [service performance data
file](configmain.md#configmain-service_perfdata_file). The *command*
argument is the short name of a [command
definition](objectdefinitions.md#objectdefinitions-command) that you
define in your object configuration file. The interval at which this
command is executed is determined by the
[service\_perfdata\_file\_processing\_interval](configmain.md#configmain-service_perfdata_file_processing_interval)
directive.

**Orphaned Service Check Option**

Format:

**check\_for\_orphaned\_services=\<0/1\>**

Example:

**check\_for\_orphaned\_services=1**

This option allows you to enable or disable checks for orphaned service
checks. Orphaned service checks are checks which have been executed and
have been removed from the event queue, but have not had any results
reported in a long time. Since no results have come back in for the
service, it is not rescheduled in the event queue. This can cause
service checks to stop being executed. Normally it is very rare for this
the process that was being used to execute a service check. If this
option is enabled and Icinga finds that results for a particular service
check have not come back, it will log an error message and reschedule
the service check. If you start seeing service checks that never seem to
get rescheduled, enable this option and see if you notice any log
messages about orphaned services.



**Orphaned Host Check Option**

Format:

**check\_for\_orphaned\_hosts=\<0/1\>**

Example:

**check\_for\_orphaned\_hosts=1**

This option allows you to enable or disable checks for orphaned hoste
checks. Orphaned host checks are checks which have been executed and
have been removed from the event queue, but have not had any results
reported in a long time. Since no results have come back in for the
host, it is not rescheduled in the event queue. This can cause host
checks to stop being executed. Normally it is very rare for this to
process that was being used to execute a host check. If this option is
enabled and Icinga finds that results for a particular host check have
not come back, it will log an error message and reschedule the host
check. If you start seeing host checks that never seem to get
rescheduled, enable this option and see if you notice any log messages
about orphaned hosts.



**Service Freshness Checking Option**

Format:

**check\_service\_freshness=\<0/1\>**

Example:

**check\_service\_freshness=0**

This option determines whether or not Icinga will periodically check the
"freshness" of service checks. Enabling this option is useful for
helping to ensure that [passive service
checks](passivechecks.md "5.7. Passive Checks") are received in a
timely manner. More information on freshness checking can be found
[here](freshness.md "7.5. Service and Host Freshness Checks").



**Service Freshness Check Interval**

Format:

**service\_freshness\_check\_interval=\<seconds\>**

Example:

**service\_freshness\_check\_interval=60**

This setting determines how often (in seconds) Icinga will periodically
check the "freshness" of service check results. If you have disabled
service freshness checking (with the
[check\_service\_freshness](configmain.md#configmain-check_service_freshness)
option), this option has no effect. More information on freshness
checking can be found
[here](freshness.md "7.5. Service and Host Freshness Checks").

**Host Freshness Checking Option**

Format:

**check\_host\_freshness=\<0/1\>**

Example:

**check\_host\_freshness=0**

This option determines whether or not Icinga will periodically check the
"freshness" of host checks. Enabling this option is useful for helping
to ensure that [passive host
checks](passivechecks.md "5.7. Passive Checks") are received in a
timely manner. More information on freshness checking can be found
[here](freshness.md "7.5. Service and Host Freshness Checks").



**Host Freshness Check Interval**

Format:

**host\_freshness\_check\_interval=\<seconds\>**

Example:

**host\_freshness\_check\_interval=60**

This setting determines how often (in seconds) Icinga will periodically
check the "freshness" of host check results. If you have disabled host
freshness checking (with the
[check\_host\_freshness](configmain.md#configmain-check_host_freshness)
option), this option has no effect. More information on freshness
checking can be found
[here](freshness.md "7.5. Service and Host Freshness Checks").

**Additional Freshness Threshold Latency Option**

Format:

**additional\_freshness\_latency=\<\#\>**

Example:

**additional\_freshness\_latency=15**

This option determines the number of seconds Icinga will add to any host
or services freshness threshold it automatically calculates (e.g. those
not specified explicity by the user). More information on freshness
checking can be found
[here](freshness.md "7.5. Service and Host Freshness Checks").

**P1.PL File Location**

Format:

**p1\_file=@P1FILELOC@/p1.pl**

This value determines where the p1.pl perl script (used by the embedded
Perl interpreter) is located. If you didn't compile Icinga with embedded
Perl support, this option has no effect.

**Embedded Perl Interpreter Option**

Format:

**enable\_embedded\_perl=\<0/1\>**

Example:

**enable\_embedded\_perl=0**

This setting determines whether or not the embedded Perl interpreter is
enabled on a program-wide basis. Icinga must be compiled with support
for embedded Perl for this option to have an effect. More information on
the embedded Perl interpreter can be found
[here](embeddedperl.md "7.18. Using The Embedded Perl Interpreter").



**Embedded Perl Implicit Use Option**

Format:

**use\_embedded\_perl\_implicitly=\<0/1\>**

Example:

**use\_embedded\_perl\_implicitly=1**

This setting determines whether or not the embedded Perl interpreter
should be used for Perl plugins/scripts that do not explicitly
enable/disable it. Icinga must be compiled with support for embedded
Perl for this option to have an effect. More information on the embedded
Perl interpreter and the effect of this setting can be found
[here](embeddedperl.md "7.18. Using The Embedded Perl Interpreter").

**Date Format**

Format:

**date\_format=\<option\>**

Example:

**date\_format=us**

This option allows you to specify what kind of date/time format Icinga
should use in the web interface and date/time
[macros](macros.md "5.2. Understanding Macros and How They Work").
Possible options (along with example output) include:

**Option**

**Output Format**

**Sample Output**

us

MM-DD-YYYY HH:MM:SS

06-30-2002 03:15:00

euro

DD-MM-YYYY HH:MM:SS

30-06-2002 03:15:00

iso8601

YYYY-MM-DD HH:MM:SS

2002-06-30 03:15:00

strict-iso8601

YYYY-MM-DDTHH:MM:SS

2002-06-30T03:15:00

**Timezone Option**

Format:

**use\_timezone=\<tz\>**

Example:

**use\_timezone=US/Mountain**

This option allows you to override the default timezone that this
instance of Icinga runs in. Useful if you have multiple instances of
Icinga that need to run from the same server, but have different local
times associated with them. If not specified, Icinga will use the system
configured timezone.

![[Note]](../images/note.png)

Note

If you use this option to specify a custom timezone, you will also need
to alter the Apache configuration directives for the CGIs to specify the
timezone you want. Example:

\<Directory "/usr/local/icinga/sbin/"\>

SetEnv TZ "US/Mountain"

...

\</Directory\>

![[Note]](../images/note.png)

Note

Depending on your OS it might be necessary to add a colon before the
timezone to work as expected

`use_timezone=:US/Mountain`

**Illegal Object Name Characters**

Format:

**illegal\_object\_name\_chars=\<chars...\>**

Example:

**illegal\_object\_name\_chars=\`\~!\$%\^&\*"|'\<\>?,()=**

This option allows you to specify illegal characters that cannot be used
in host names, service descriptions, or names of other object types.
Icinga will allow you to use most characters in object definitions, but
we recommend not using the characters shown in the example above. Doing
may give you problems in the web interface, notification commands, etc.

**Illegal Macro Output Characters**

Format:

**illegal\_macro\_output\_chars=\<chars...\>**

Example:

**illegal\_macro\_output\_chars=\`\~\$&"|'\<\>**

This option allows you to specify illegal characters that should be
stripped from
[macros](macros.md "5.2. Understanding Macros and How They Work")
before being used in notifications, event handlers, and other commands.
This ALSO affects macros used in service or host check commands. You can
choose to not strip out the characters shown in the example above, but
we recommend you do not do this. Some of these characters are
interpreted by the shell (i.e. the backtick) and can lead to security
problems. The following macros are stripped of the characters you
specify:

**\$HOSTOUTPUT\$**, **\$HOSTPERFDATA\$**, **\$HOSTACKAUTHOR\$**,
**\$HOSTACKCOMMENT\$**, **\$SERVICEOUTPUT\$**, **\$SERVICEPERFDATA\$**,
**\$SERVICEACKAUTHOR\$**, and **\$SERVICEACKCOMMENT\$**

**Keep Unknown Marcos Option**

Format:

**keep\_unknown\_macros=\<0/1\>**

Example:

**keep\_unknown\_macros=0**

This option can be used to keep unknown macros within the output, e.g.
check\_proc -C \$foo\$ will remain on the commandline. This was the
default in versions older than Icinga 1.8, but now the default is to
remove those macros from the output, causing the shell to interpret
\$foo and leaving a single \$ there. See
[\#2291](https://dev.icinga.org/issues/2291)for further information.
Make sure to escape single dollar signs with another '\$', as the docs
describe. Other than that, enable this setting to revert to the old
behaviour.

**Regular Expression Matching Option**

Format:

**use\_regexp\_matching=\<0/1\>**

Example:

**use\_regexp\_matching=0**

This option determines whether or not various directives in your [object
definitions](configobject.md "3.3. Object Configuration Overview")
will be processed as regular expressions. More information on how this
works can be found
[here](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions").



**True Regular Expression Matching Option**

Format:

**use\_true\_regexp\_matching=\<0/1\>**

Example:

**use\_true\_regexp\_matching=0**

If you've enabled regular expression matching of various object
directives using the
[use\_regexp\_matching](configmain.md#configmain-use_regexp_matching)
option, this option will determine when object directives are treated as
regular expressions. If this option is disabled (the default),
directives will only be treated as regular expressions if they contain
**\***, **?**, **\$**, **+**, or **\\.**(POSIX ERE). If this option is
enabled, all appropriate directives will be treated as regular
works can be found
[here](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions").



**Administrator Email Address**

Format:

**admin\_email=\<email\_address\>**

Example:

**admin\_email=root@localhost.localdomain**

This is the email address for the administrator of the local machine
(i.e. the one that Icinga is running on). This value can be used in
notification commands by using the **\$ADMINEMAIL\$**
[macro](macros.md "5.2. Understanding Macros and How They Work").

**Administrator Pager**

Format:

**admin\_pager=\<pager\_number\_or\_pager\_email\_gateway\>**

Example:

**admin\_pager=pageroot@localhost.localdomain**

This is the pager number (or pager email gateway) for the administrator
of the local machine (i.e. the one that Icinga is running on). The pager
number/address can be used in notification commands by using the
**\$ADMINPAGER\$**
[macro](macros.md "5.2. Understanding Macros and How They Work").

**Daemon Core Dump Option**

Format:

**daemon\_dumps\_core=\<0/1\>**

Example:

**daemon\_dumps\_core=1**

This option determines whether or not Icinga is allowed to create a core
dump when it runs as a daemon. Note that it is generally considered bad
form to allow this, but it may be useful for debugging purposes.
Enabling this option doesn't guarantee that a core file will be
produced, but that's just life.



**Event Broker Options**

Format:

**event\_broker\_options=\<\#\>**

Example:

**event\_broker\_options=-1**

This option controls what (if any) data gets sent to the event broker
and, in turn, to any loaded event broker modules. This is an advanced
option. When in doubt, either broker nothing (if not using event broker
modules) or broker everything (if using event broker modules). Possible
values are shown below.




**Event Broker Modules**

Format:

**broker\_module=\<modulepath\> [moduleargs]**

Example:

**broker\_module=/usr/local/icinga/lib/idomod.so \\
cfg\_file=/usr/local/icinga/etc/idomod.cfg**

This directive is used to specify an event broker module that should by
loaded by Icinga at startup. Use multiple directives if you want to load
more than one module. Arguments that should be passed to the module at
startup are separated from the module path by a space.

![[Note]](../images/note.png)

Note

This option is deprecated starting with Icinga 1.13 because you must use
the [module object
definition](objectdefinitions.md#objectdefinitions-module) instead.

**Debug File**

Format:

**debug\_file=\<file\_name\>**

Example:

**debug\_file=/usr/local/icinga/var/icinga.debug**

This option determines where Icinga should write debugging information.
What (if any) information is written is determined by the
[debug\_level](configmain.md#configmain-debug_level) and
[debug\_verbosity](configmain.md#configmain-debug_verbosity) options.
You can have Icinga automaticaly rotate the debug file when it reaches a
certain size by using the
[max\_debug\_file\_size](configmain.md#configmain-max_debug_file_size)
option.

**Debug Level**

Format:

**debug\_level=\<\#\>**

Example:

**debug\_level=24**

This option determines what type of information Icinga should write to
the [debug\_file](configmain.md#configmain-debug_file). This value is
a logical OR of the values below.















**Debug Verbosity**

Format:

**debug\_verbosity=\<\#\>**

Example:

**debug\_verbosity=1**

This option determines how much debugging information Icinga should
write to the [debug\_file](configmain.md#configmain-debug_file).




**Maximum Debug File Size**

Format:

**max\_debug\_file\_size=\<\#\>**

Example:

**max\_debug\_file\_size=1000000**

This option determines the maximum size (in bytes) of the [debug
file](configmain.md#configmain-debug_file). If the file grows larger
than this size, it will be renamed with a .old extension. If a file
already exists with a .old extension it will automatically be deleted.
This helps ensure your disk space usage doesn't get out of control when
debugging Icinga.

**Event Profiling**

Format:

**event\_profiling\_enabled=\<0/1\>**

Example:

**event\_profiling\_enabled=1**

This option enables or disables event profiling for stats of event
counts and time taken for events. This option can't be used on Solaris
with gcc3.

**Allow Empty Hostgroup Assignment**

Format:

**allow\_empty\_hostgroup\_assignment=\<0|1\>**

Example:

**allow\_empty\_hostgroup\_assignment=1**

This boolean option determines whether services, service dependencies,
or host dependencies assigned to empty host groups (host groups with no
host members) will cause Icinga to exit with error on startup (or during
a configuration check) or not. The default behaviour if the option is
not present (or set to "0") in the main configuration file is for Icinga
to exit with error if any of these objects are associated with host
groups whose hostgroup definitions have no host\_members associated with
them.

Enabling this option can be useful when:




**Process empty performance results**

Format:

**host\_perfdata\_process\_empty\_results=\<0|1\>**

**service\_perfdata\_process\_empty\_results=\<0|1\>**

Example:

**host\_perfdata\_process\_empty\_results=1**

**service\_perfdata\_process\_empty\_results=1**

These options determine whether the core will process empty perfdata
results or not. This is needed for distributed monitoring, and
intentionally turned on by default. If you don't require empty perfdata
that off. Be careful!



**Limit number of items in check result list**

Format:

**max\_check\_result\_list\_items=\<n\>**

Example:

**max\_check\_result\_list\_items=1024**

This **experimental** option allows you to set the max number of items
the checkresult reaper will put onto the checkresult list for further
processing by the core. If there are too many, the reaping will be
terminated early, allowing the core to process the results sooner. On
larger setups, that list might grow too much, and decrease performance
on processing. You might experiment with that value, the inner core
default is set to 0, disabling that feature. Values: 0 = Disable max
check result list items number = set max check result list items

![[Note]](../images/note.png)

Note

These options are available starting with Icinga 1.8

* * * * *

[Prev](config.md) | [Up](ch03.md) | [Next](configobject.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
