[Prev](configobject.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](customobjectvars.md)

* * * * *

3.4. Object Definitions
-----------------------

3.4.1. [Host definition](objectdefinitions.md#host)

3.4.2. [Hostgroup Definition](objectdefinitions.md#hostgroup)

3.4.3. [Service Definition](objectdefinitions.md#service)

3.4.4. [Servicegroup Definition](objectdefinitions.md#servicegroup)

3.4.5. [Contact Definition](objectdefinitions.md#contact)

3.4.6. [Contactgroup Definition](objectdefinitions.md#contactgroup)

3.4.7. [Timeperiod Definition](objectdefinitions.md#timeperiod)

3.4.8. [Command Definition](objectdefinitions.md#command)

3.4.9. [Servicedependency
Definition](objectdefinitions.md#servicedepdency)

3.4.10. [Serviceescalation
Definition](objectdefinitions.md#serviceescalation)

3.4.11. [Hostdependency
Definition](objectdefinitions.md#hostdependency)

3.4.12. [Hostescalation
Definition](objectdefinitions.md#hostescalation)

3.4.13. [Hostextinfo Definition](objectdefinitions.md#hostextinfo)

3.4.14. [Serviceextinfo
Definition](objectdefinitions.md#serviceextinfo)

3.4.15. [Module Definition](objectdefinitions.md#module)

**Introduction**

One of the features of Icingas object configuration format is that you
can create object definitions that inherit properties from other object
definitions. An explanation of how object inheritence works can be found
[here](objectinheritance.md "7.26. Object Inheritance"). We strongly
suggest that you familiarise yourself with object inheritence once you
read over the documentation presented below, as it will make the job of
creating and maintaining object definitions much easier than it
otherwise would be. Also, read up on the [object
tricks](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions")
that offer shortcuts for otherwise tedious configuration tasks.

![[Note]](../images/note.png)

Note

When creating and/or editing configuration files, keep the following in
mind:




![[Note]](../images/note.png)

Note

Please try to avoid special characters in the object definitions.

**Retention Notes**

It is important to point out that several directives in host, service,
and contact definitions may not be picked up by Icinga when you change
them in your configuration files. Object directives that can exhibit
this behaviour are marked with an asterisk
([\*](objectdefinitions.md#objectdefinitions-retention_notes)). The
reason for this behaviour is due to the fact that Icinga chooses to
honour values stored in the [state retention
file](configmain.md#configmain-state_retention_file) over values found
in the config files, assuming you have [state
retention](configmain.md#configmain-retain_state_information) enabled
on a program-wide basis *and* the value of the directive is changed
during runtime with an [external
command](configmain.md#configmain-check_external_commands).

One way to get around this problem is to disable the retention of
non-status information using the *retain\_nonstatus\_information*
directive in the host, service, and contact definitions. Disabling this
directive will cause Icinga to take the initial values for these
directives from your config files, rather than from the state retention
file when it (re)starts.

**Sample Configuration Files**

![[Note]](../images/note.png)

Note

Sample object configuration files are installed in the
*/usr/local/icinga/etc/* directory when you follow the [quickstart
installation
guide](quickstart.md "2.3. Quickstart Installation Guides").

If you installed a package then the sample files might be missing. The
contents is listed
[here](sample-config.md "13.1. Sample configuration files and definitions")
for reference.

**Object Types**

[Host definitions](objectdefinitions.md#objectdefinitions-host)

[Host group
definitions](objectdefinitions.md#objectdefinitions-hostgroup)

[Service definitions](objectdefinitions.md#objectdefinitions-service)

[Service group
definitions](objectdefinitions.md#objectdefinitions-servicegroup)

[Contact definitions](objectdefinitions.md#objectdefinitions-contact)

[Contact group
definitions](objectdefinitions.md#objectdefinitions-contactgroup)

[Time period
definitions](objectdefinitions.md#objectdefinitions-timeperiod)

[Command definitions](objectdefinitions.md#objectdefinitions-command)

[Service dependency
definitions](objectdefinitions.md#objectdefinitions-servicedependency)

[Service escalation
definitions](objectdefinitions.md#objectdefinitions-serviceescalation)

[Host dependency
definitions](objectdefinitions.md#objectdefinitions-hostdependency)

[Host escalation
definitions](objectdefinitions.md#objectdefinitions-hostescalation)

[Extended host information
definitions](objectdefinitions.md#objectdefinitions-hostextinfo)

[Extended service information
definitions](objectdefinitions.md#objectdefinitions-serviceextinfo)

[Module definitions](objectdefinitions.md#objectdefinitions-module)

### 3.4.1. Host definition

![[Note]](../images/note.png)

Note

vrml\_image and 3d\_coords have been deprecated since 1.8 and removal of
the 3d statusmap.

*Description:*

A host definition is used to define a physical server, workstation,
device, etc. that resides on your network.

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional. Please make
sure that you read the notes on the "address", "contacts", and
"contact\_groups" directive.

define host{

host\_name

host\_name

alias

alias

display\_name

display\_name

address

address

address6

address6

parents

host\_names

hostgroups

hostgroup\_names

check\_command

command\_name

initial\_state

[o,d,u]

max\_check\_attempts

\#

check\_interval

\#

retry\_interval

\#

active\_checks\_enabled

[0/1]

passive\_checks\_enabled

[0/1]

check\_period

timeperiod\_name

obsess\_over\_host

[0/1]

check\_freshness

[0/1]

freshness\_threshold

\#

event\_handler

command\_name

event\_handler\_enabled

[0/1]

low\_flap\_threshold

\#

high\_flap\_threshold

\#

flap\_detection\_enabled

[0/1]

flap\_detection\_options

[o,d,u,n]

failure\_prediction\_enabled

[0/1]

process\_perf\_data

[0/1]

retain\_status\_information

[0/1]

retain\_nonstatus\_information

[0/1]

contacts

contacts

contact\_groups

contact\_groups

*notification\_interval*

\#

first\_notification\_delay

\#

*notification\_period*

timeperiod\_name

notification\_options

[d,u,r,f,s,n]

notifications\_enabled

[0/1]

stalking\_options

[o,d,u,n]

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

statusmap\_image

image\_file

2d\_coords

x\_coord,y\_coord

   

}

*Example Definition:*

 define host{
</code></pre>

*Directive Descriptions:*

**host\_name**:

This directive is used to define a short name used to identify the host.
It is used in host group and service definitions to reference this
particular host. Hosts can have multiple services (which are monitored)
associated with them. When used properly, the \$HOSTNAME\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this short name.

**alias**:

This directive is used to define a longer name or description used to
identify the host. It is provided in order to allow you to more easily
identify a particular host. When used properly, the \$HOSTALIAS\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this alias/description.

**address**:

This directive is used to define the address of the host. Normally, this
is an IP address, although it could really be anything you want (so long
as it can be used to check the status of the host). You can use a FQDN
to identify the host instead of an IP address, but if DNS services are
not available this could cause problems. When used properly, the
\$HOSTADDRESS\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this address.

![[Note]](../images/note.png)

Note

If you do not specify an address directive in a host definition, the
name of the host will be used as its address. A word of caution about
fail because the plugins will be unable to resolve the host name.

**address6**:

This directive is used to define a second address for the host.
Normally, this is an IPv6 address, although it could really be anything
you want (so long as it can be used to check the status of the host).
You can use a FQDN to identify the host instead of an IP address, but if
DNS services are not available this could cause problems. When used
properly, the \$HOSTADDRESS6\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this address.

![[Note]](../images/note.png)

Note

If you do not specify an address6 directive in a host definition, the
name of the host will be used as its address. A word of caution about
fail because the plugins will be unable to resolve the host name.

**display\_name**:

This directive is used to define an alternate name that should be
displayed in the web interface for this host. If not specified, this
defaults to the value you specify for the *host\_name* directive.

![[Note]](../images/note.png)

Note

The CGIs up to Icinga 1.0.1 do not use this option.

**parents**:

This directive is used to define a comma-delimited list of short names
of the "parent" hosts for this particular host. Parent hosts are
typically routers, switches, firewalls, etc. that lie between the
monitoring host and a remote hosts. A router, switch, etc. which is
closest to the remote host is considered to be that host's "parent".
Read the "Determining Status and Reachability of Network Hosts" document
located
[here](networkreachability.md "5.10. Determining Status and Reachability of Network Hosts")
for more information. If this host is on the same network segment as the
host doing the monitoring (without any intermediate routers, etc.) the
host is considered to be on the local network and will not have a parent
host. Leave this value blank if the host does not have a parent host
(i.e. it is on the same segment as the Icinga host). The order in which
you specify parent hosts has no effect on how things are monitored.

**hostgroups**:

This directive is used to identify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-hostgroup) that
the host belongs to. Multiple hostgroups should be separated by commas.
This directive may be used as an alternative to (or in addition to)
using the *members* directive in
[hostgroup](objectdefinitions.md#objectdefinitions-hostgroup)
definitions.

**check\_command**:

This directive is used to specify the *short name* of the
[command](objectdefinitions.md#objectdefinitions-command) that should
be used to check if the host is up or down. Typically, this command
would try and ping the host to see if it is "alive". The command must
return a status of OK (0) or Icinga will assume the host is down. If you
leave this argument blank, the host will *not* be actively checked.
Thus, Icinga will likely always assume the host is up (it may show up as
being in a "PENDING" state in the web interface). This is useful if you
are monitoring printers or other devices that are frequently turned off.
The maximum amount of time that the notification command can run is
controlled by the
[host\_check\_timeout](configmain.md#configmain-host_check_timeout)
option.

**initial\_state**:

By default Icinga will assume that all hosts are in UP states when in
starts. You can override the initial state for a host by using this
directive. Valid options are: **o** = UP, **d** = DOWN, and **u** =
UNREACHABLE. Default: o.

**max\_check\_attempts**:

This directive is used to define the number of times that Icinga will
retry the host check command if it returns any state other than an OK
state. This value will cause Icinga to generate an alert without
retrying the host check again.

![[Note]](../images/note.png)

Note

If you do not want to check the status of the host, you must still set
this to a minimum value of 1. To bypass the host check, just leave the
*check\_command* option blank.

**check\_interval**:

This directive is used to define the number of "time units" between
regularly scheduled checks of the host. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. More
information on this value can be found in the [check
scheduling](checkscheduling.md "7.23. Service and Host Check Scheduling")
documentation. Floating point values are allowed. Default: 5.

**retry\_interval**:

This directive is used to define the number of "time units" to wait
before scheduling a re-check of the hosts. Hosts are rescheduled at the
retry interval when they have changed to a non-UP state. Once the host
has been retried **max\_check\_attempts** times without a change in its
status, it will revert to being scheduled at its "normal" rate as
defined by the **check\_interval** value. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. More
information on this value can be found in the [check
scheduling](checkscheduling.md "7.23. Service and Host Check Scheduling")
documentation. Floating point values are allowed. Default: 1.

**active\_checks\_enabled \***:

This directive is used to determine whether or not active checks (either
regularly scheduled or on-demand) of this host are enabled. Values: 0 =
disable active host checks, 1 = enable active host checks. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[execute\_host\_checks](configmain.md#configmain-execute_host_checks)=0".

**passive\_checks\_enabled \***:

This directive is used to determine whether or not passive checks are
enabled for this host. Values: 0 = disable passive host checks, 1 =
enable passive host checks. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[accept\_passive\_host\_checks](configmain.md#configmain-accept_passive_host_checks)=0".

**check\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which active checks of this host can be made.

**obsess\_over\_host \***:

This directive determines whether or not checks for the host will be
"obsessed" over using the
[ochp\_command](configmain.md#configmain-ochp_command). Default: 1.

**check\_freshness \***:

This directive is used to determine whether or not [freshness
checks](freshness.md "7.5. Service and Host Freshness Checks") are
enabled for this host. Values: 0 = disable freshness checks, 1 = enable
freshness checks. Default: 0.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[check\_host\_freshness](configmain.md#configmain-check_host_freshness)=0".

**freshness\_threshold**:

This directive is used to specify the freshness threshold (in seconds)
for this host. If you set this directive to a value of 0, Icinga will
determine a freshness threshold to use automatically. Default: 0.

**event\_handler**:

This directive is used to specify the *short name* of the
[command](objectdefinitions.md#objectdefinitions-command) that should
be run whenever a change in the state of the host is detected (i.e.
whenever it goes down or recovers). Read the documentation on [event
handlers](eventhandlers.md "7.3. Event Handlers") for a more detailed
explanation of how to write scripts for handling events. The maximum
amount of time that the event handler command can run is controlled by
the
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)
option.

**event\_handler\_enabled \***:

This directive is used to determine whether or not the event handler for
this host is enabled. Values: 0 = disable host event handler, 1 = enable
host event handler. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)=0".

**low\_flap\_threshold**:

This directive is used to specify the low state change threshold used in
flap detection for this host. More information on flap detection can be
found
[here](flapping.md "7.8. Detection and Handling of State Flapping").
If you set this directive to a value of 0, the program-wide value
specified by the
[low\_host\_flap\_threshold](configmain.md#configmain-low_host_flap_threshold)
directive will be used. Floating point values are allowed. Default: 0.

**high\_flap\_threshold**:

This directive is used to specify the high state change threshold used
in flap detection for this host. More information on flap detection can
be found
[here](flapping.md "7.8. Detection and Handling of State Flapping").
If you set this directive to a value of 0, the program-wide value
specified by the
[high\_host\_flap\_threshold](configmain.md#configmain-high_host_flap_threshold)
directive will be used. Floating point values are allowed. Default: 0.

**flap\_detection\_enabled \***:

This directive is used to determine whether or not flap detection is
enabled for this host. More information on flap detection can be found
[here](flapping.md "7.8. Detection and Handling of State Flapping").
Values: 0 = disable host flap detection, 1 = enable host flap detection.
Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[flap\_detection](configmain.md#configmain-enable_flap_detection)=0".

**flap\_detection\_options**:

This directive is used to determine what host states the [flap detection
logic](flapping.md "7.8. Detection and Handling of State Flapping")
will use for this host. Valid options are a combination of one or more
of the following: **o** = UP states, **d** = DOWN states, **u** =
UNREACHABLE states. Default: o,d,u.

**failure\_prediction\_enabled**:

This directive is used to determine whether or not failure prediction is
enabled for this host. Values: 0 = disable host failure prediction, 1 =
enable host failure prediction. Default: 1.

**process\_perf\_data \***:

This directive is used to determine whether or not the processing of
performance data is enabled for this host. Values: 0 = disable
performance data processing, 1 = enable performance data processing.
Default: 1

![[Note]](../images/note.png)

Note

This value will have no effect if
"[process\_performance\_data](configmain.md#configmain-process_performance_data)=0".

**retain\_status\_information**:

This directive is used to determine whether or not status-related
information about the host is retained across program restarts. This is
only useful if you have enabled state retention using the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
directive. Value: 0 = disable status information retention, 1 = enable
status information retention. Default: 1.

**retain\_nonstatus\_information**:

This directive is used to determine whether or not non-status
information about the host is retained across program restarts. This is
only useful if you have enabled state retention using the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
directive. Value: 0 = disable non-status information retention, 1 =
enable non-status information retention. Default: 1.

**contacts**:

This is a list of the *short names* of the
[contacts](objectdefinitions.md#objectdefinitions-contact) that should
be notified whenever there are problems (or recoveries) with this host.
Multiple contacts should be separated by commas. Useful if you want
notifications to go to just a few people and don't want to configure
[contact groups](objectdefinitions.md#objectdefinitions-contactgroup).
You must specify at least one contact or contact group in each host
definition or nobody at all will be notified.

**contact\_groups**:

This is a list of the *short names* of the [contact
groups](objectdefinitions.md#objectdefinitions-contactgroup) that
should be notified whenever there are problems (or recoveries) with this
host. Multiple contact groups should be separated by commas. You must
specify at least one contact or contact group in each host definition or
nobody at all will be notified.

**notification\_interval**:

This directive is used to define the number of "time units" to wait
before re-notifying a contact that this host is *still* down or
unreachable. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. If you set
this value to 0, Icinga will *not* re-notify contacts about problems for
point values are allowed. Default: 30.

**first\_notification\_delay**:

This directive is used to define the number of "time units" to wait
before sending out the first problem notification when this host enters
a non-UP state. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. If you set
this value to 0, Icinga will start sending out notifications
immediately. Floating point values are allowed. Default: 0.

**notification\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which notifications of events for this host can be sent out to contacts.
If a host goes down, becomes unreachable, or recoveries during a time
which is not covered by the time period, no notifications will be sent
out.

**notification\_options**:

This directive is used to determine when notifications for the host
should be sent out. Valid options are a combination of one or more of
the following: **d** = send notifications on a DOWN state, **u** = send
notifications on an UNREACHABLE state, **r** = send notifications on
recoveries (OK state), **f** = send notifications when the host starts
and stops
[flapping](flapping.md "7.8. Detection and Handling of State Flapping"),
and **s** = send notifications when [scheduled
downtime](downtime.md "7.16. Scheduled Downtime") starts and ends. If
you specify **n** (none) as an option, no host notifications will be
sent out. If you do not specify any notification options, Icinga will
assume that you want notifications to be sent out for all possible
states. Example: If you specify **d,r** in this field, notifications
will only be sent out when the host goes DOWN and when it recovers from
a DOWN state. Default: d,u,r,f,s.

**notifications\_enabled \***:

This directive is used to determine whether or not notifications for
this host are enabled. Values: 0 = disable host notifications, 1 =
enable host notifications. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[enable\_notifications](configmain.md#configmain-enable_notifications)=0".

**stalking\_options**:

This directive determines which host states "stalking" is enabled for.
Valid options are a combination of one or more of the following: **o** =
stalk on UP states, **d** = stalk on DOWN states, and **u** = stalk on
UNREACHABLE states. More information on state stalking can be found
[here](stalking.md "7.14. State Stalking"). Default: n.

**notes**:

This directive is used to define an optional string of notes pertaining
to the host. If you specify a note here, you will see the it in the
[extended information](cgis.md#cgis-extinfo_cgi) CGI (when you are
viewing information about the specified host).

**notes\_url**:

This variable is used to define an optional URL that can be used to
provide more information about the host. If you specify an URL, you will
see a red folder icon in the CGIs (when you are viewing host
information) that links to the URL you specify here. Any valid URL can
be used. If you plan on using relative paths, the base path will the the
same as what is used to access the CGIs (i.e. */cgi-bin/icinga/*). This
can be very useful if you want to make detailed information on the host,
emergency contact methods, etc. available to other support staff.

**action\_url**:

This directive is used to define an optional URL that can be used to
provide more actions to be performed on the host. If you specify an URL,
you will see a red "splat" icon in the CGIs (when you are viewing host
information) that links to the URL you specify here. Any valid URL can
be used. If you plan on using relative paths, the base path will the the
same as what is used to access the CGIs (i.e. */cgi-bin/icinga/*).

![[Note]](../images/note.png)

Note

Since Icinga 1.0.2 you can use multiple urls for action\_url and
notes\_url for host and service object definitions. The syntax is as
follows:

<pre><code>
notes_url|action_url 'firstURL' 'secondURL' 'thirdURL'
</code></pre>

<pre><code>
notes_url|action_url onlyoneURL
</code></pre>

Please keep in mind that using multiple urls also mean multiple icon
images. Those are hardcoded and e.g. action|notes.gif changes to
you'll have them in place when using multiple action\_url|notes\_url. If
you are using multiple urls with different icons (1-action.gif e.g.) you
can still define the last urls without single quotes. It will then be
used like a single url and is referring to the normal icon (action.gif
e.g.)

**icon\_image**:

This variable is used to define the name of a GIF, PNG, or JPG image
that should be associated with this host. This image will be displayed
in the various places in the CGIs. The image will look best if it is
40x40 pixels in size. Images for hosts are assumed to be in the
**logos/** subdirectory in your HTML images directory (i.e.
*/usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

This variable is used to define an optional string that is used in the
ALT tag of the image specified by the *\<icon\_image\>* argument.

**statusmap\_image**:

This variable is used to define the name of an image that should be
associated with this host in the
[statusmap](cgis.md#cgis-statusmap_cgi) CGI. You can specify a JPEG,
PNG, and GIF image if you want, although we would strongly suggest using
a GD2 format image, as other image formats will result in a lot of
wasted CPU time when the statusmap image is generated. GD2 images can be
created from PNG images by using the **pngtogd2** utility supplied with
Thomas Boutell's [gd library](http://www.boutell.com/gd/). The GD2
images should be created in *uncompressed* format in order to minimize
CPU load when the statusmap CGI is generating the network map image. The
image will look best if it is 40x40 pixels in size. You can leave these
option blank if you are not using the statusmap CGI. Images for hosts
are assumed to be in the **logos/** subdirectory in your HTML images
directory (i.e. */usr/local/icinga/share/images/logos*).

**2d\_coords**:

This variable is used to define coordinates to use when drawing the host
in the [statusmap](cgis.md#cgis-statusmap_cgi) CGI. Coordinates should
be given in positive integers, as they correspond to physical pixels in
the generated image. The origin for drawing (0,0) is in the upper left
hand corner of the image and extends in the positive x direction (to the
right) along the top of the image and in the positive y direction (down)
along the left hand side of the image. For reference, the size of the
icons drawn is usually about 40x40 pixels (text takes a little extra
space). The coordinates you specify here are for the upper left hand
corner of the host icon that is drawn.

![[Note]](../images/note.png)

Note

Don't worry about what the maximum x and y coordinates that you can use
are. The CGI will automatically calculate the maximum dimensions of the
image it creates based on the largest x and y coordinates you specify.

### 3.4.2. Hostgroup Definition

*Description:*

A host group definition is used to group one or more hosts together for
simplifying configuration with [object
tricks](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions")
or display purposes in the
[CGIs](cgis.md "6.1. Icinga Classic UI: Information On The Modules").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define hostgroup{

hostgroup\_name

hostgroup\_name

alias

alias

members

hosts

hostgroup\_members

hostgroups

notes

note\_string

notes\_url

url

action\_url

url

   

}

*Example Definition:*

 define hostgroup{
</code></pre>

*Directive Descriptions:*

**hostgroup\_name**:

This directive is used to define a short name used to identify the host
group.

**alias**:

This directive is used to define is a longer name or description used to
identify the host group. It is provided in order to allow you to more
easily identify a particular host group.

**members**:

This is a list of the *short names* of
[hosts](objectdefinitions.md#objectdefinitions-host) that should be
included in this group. Multiple host names should be separated by
commas. This directive may be used as an alternative to (or in addition
to) the *hostgroups* directive in [host
definitions](objectdefinitions.md#objectdefinitions-host).

**hostgroup\_members**:

This optional directive can be used to include hosts from other "sub"
host groups in this host group. Specify a comma-delimited list of short
names of other host groups whose members should be included in this
group.

**notes**:

This directive is used to define an optional string of notes pertaining
to the host. If you specify a note here, you will see the it in the
[extended information](cgis.md#cgis-extinfo_cgi) CGI (when you are
viewing information about the specified host).

**notes\_url**:

This variable is used to define an optional URL that can be used to
provide more information about the host group. If you specify an URL,
you will see a red folder icon in the CGIs (when you are viewing
hostgroup information) that links to the URL you specify here. Any valid
URL can be used. If you plan on using relative paths, the base path will
the the same as what is used to access the CGIs (i.e.
*/cgi-bin/icinga/*). This can be very useful if you want to make
detailed information on the host group, emergency contact methods, etc.
available to other support staff.

**action\_url**:

This directive is used to define an optional URL that can be used to
provide more actions to be performed on the host group. If you specify
an URL, you will see a red "splat" icon in the CGIs (when you are
viewing hostgroup information) that links to the URL you specify here.
Any valid URL can be used. If you plan on using relative paths, the base
path will the the same as what is used to access the CGIs (i.e.
*/cgi-bin/icinga/*).

### 3.4.3. Service Definition

*Description:*

A service definition is used to identify a "service" that runs on a
host. The term "service" is used very loosely. It can mean an actual
service that runs on the host (POP, SMTP, HTTP, etc.) or some other type
of metric associated with the host (response to a ping, number of logged
in users, free disk space, etc.). The different arguments to a service
definition are outlined below.

![[Note]](../images/note.png)

Note

Please note that some directives may be inherited from the host
definition. For details refer to [implied
inheritance](objectinheritance.md#objectinheritance-implied_inheritance "7.26.9. Implied Inheritance").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional. Please make
sure that you read the notes on the "contacts", and "contact\_groups"
directive.

define service{

host\_name

host\_name

hostgroup\_name

hostgroup\_name

service\_description

service\_description

display\_name

display\_name

servicegroups

servicegroup\_names

is\_volatile

[0|1|2]

check\_command

command\_name

initial\_state

[o,w,u,c]

max\_check\_attempts

\#

check\_interval

\#

retry\_interval

\#

active\_checks\_enabled

[0/1]

passive\_checks\_enabled

[0/1]

check\_period

timeperiod\_name

obsess\_over\_service

[0/1]

check\_freshness

[0/1]

freshness\_threshold

\#

event\_handler

command\_name

event\_handler\_enabled

[0/1]

low\_flap\_threshold

\#

high\_flap\_threshold

\#

flap\_detection\_enabled

[0/1]

flap\_detection\_options

[o,w,c,u,n]

failure\_prediction\_enabled

[0/1]

process\_perf\_data

[0/1]

retain\_status\_information

[0/1]

retain\_nonstatus\_information

[0/1]

notification\_interval

\#

first\_notification\_delay

\#

notification\_period

timeperiod\_name

notification\_options

[w,u,c,r,f,s,n]

notifications\_enabled

[0/1]

contacts

contacts

contact\_groups

contact\_groups

stalking\_options

[o,w,u,c,n]

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

   

}

*Example Definition:*

 define service{
</code></pre>

*Directive Descriptions:*

**host\_name**:

This directive is used to specify the *short name(s)* of the
[host(s)](objectdefinitions.md#objectdefinitions-host) that the
service "runs" on or is associated with. Multiple hosts should be
separated by commas.

**hostgroup\_name**:

This directive is used to specify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-hostgroup) that
the service "runs" on or is associated with. Multiple hostgroups should
be separated by commas. The hostgroup\_name may be used instead of, or
in addition to, the host\_name directive.

**service\_description;**:

This directive is used to define the description of the service, which
may contain spaces, dashes, and colons (semicolons, apostrophes, and
quotation marks should be avoided). No two services associated with the
same host can have the same description. Services are uniquely
identified with their *host\_name* and *service\_description*
directives.

**display\_name**:

This directive is used to define an alternate name that should be
displayed in the web interface for this service. If not specified, this
defaults to the value you specify for the *service\_description*
directive.

![[Note]](../images/note.png)

Note

The CGIs up to Icinga 1.0.1 do not use this option.

**servicegroups**:

This directive is used to identify the *short name(s)* of the
[servicegroup(s)](objectdefinitions.md#objectdefinitions-servicegroup)
that the service belongs to. Multiple servicegroups should be separated
by commas. This directive may be used as an alternative to using the
*members* directive in
[servicegroup](objectdefinitions.md#objectdefinitions-servicegroup)
definitions.

**is\_volatile**:

This directive is used to denote whether the service is "volatile".
Services are normally *not* volatile. More information on volatile
service and how they differ from normal services can be found
[here](volatileservices.md "7.4. Volatile Services"). Value: 0 =
service is not volatile, 1 = service is volatile, 2 = service is
volatile but will respect the re-notification interval for notifications
(option "2" was introduced in Icinga 1.0.2). Default: 0.

**check\_command**:

This directive is used to specify the *short name* of the
[command](objectdefinitions.md#objectdefinitions-command) that Icinga
will run in order to check the status of the service. The maximum amount
of time that the service check command can run is controlled by the
[service\_check\_timeout](configmain.md#configmain-service_check_timeout)
option.

**initial\_state**:

By default Icinga will assume that all services are in OK states when in
starts. You can override the initial state for a service by using this
directive. Valid options are: **o** = OK, **w** = WARNING, **u** =
UNKNOWN, and **c** = CRITICAL. Default: o.

**max\_check\_attempts**:

This directive is used to define the number of times that Icinga will
retry the service check command if it returns any state other than an OK
state. This value will cause Icinga to generate an alert without
retrying the service check again.

**check\_interval**:

This directive is used to define the number of "time units" to wait
before scheduling the next "regular" check of the service. "Regular"
checks are those that occur when the service is in an OK state or when
the service is in a non-OK state, but has already been rechecked
**max\_check\_attempts** number of times. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. More
information on this value can be found in the [check
scheduling](checkscheduling.md "7.23. Service and Host Check Scheduling")
documentation. Floating point values are allowed. Default: 5.

**retry\_interval**:

This directive is used to define the number of "time units" to wait
before scheduling a re-check of the service. Services are rescheduled at
the retry interval when they have changed to a non-OK state. Once the
service has been retried **max\_check\_attempts** times without a change
in its status, it will revert to being scheduled at its "normal" rate as
defined by the **check\_interval** value. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. More
information on this value can be found in the [check
scheduling](checkscheduling.md "7.23. Service and Host Check Scheduling")
documentation. Floating point values are allowed. Default: 1.

**active\_checks\_enabled \***:

This directive is used to determine whether or not active checks of this
service are enabled. Values: 0 = disable active service checks, 1 =
enable active service checks. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[execute\_service\_checks](configmain.md#configmain-execute_service_checks)=0".

**passive\_checks\_enabled \***:

This directive is used to determine whether or not passive checks of
this service are enabled. Values: 0 = disable passive service checks, 1
= enable passive service checks. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[accept\_passive\_service\_checks](configmain.md#configmain-accept_passive_service_checks)=0".

**check\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which active checks of this service can be made.

**obsess\_over\_service \***:

This directive determines whether or not checks for the service will be
"obsessed" over using the
[ocsp\_command](configmain.md#configmain-ocsp_command).

**check\_freshness \***:

This directive is used to determine whether or not [freshness
checks](freshness.md "7.5. Service and Host Freshness Checks") are
enabled for this service. Values: 0 = disable freshness checks, 1 =
enable freshness checks. Default: 0.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[check\_service\_freshness](configmain.md#configmain-check_service_freshness)=0".

**freshness\_threshold**:

This directive is used to specify the freshness threshold (in seconds)
for this service. If you set this directive to a value of 0, Icinga will
determine a freshness threshold to use automatically. Default: 0.

**event\_handler**:

This directive is used to specify the *short name* of the
[command](objectdefinitions.md#objectdefinitions-command) that should
be run whenever a change in the state of the service is detected (i.e.
whenever it goes down or recovers). Read the documentation on [event
handlers](eventhandlers.md "7.3. Event Handlers") for a more detailed
explanation of how to write scripts for handling events. The maximum
amount of time that the event handler command can run is controlled by
the
[event\_handler\_timeout](configmain.md#configmain-event_handler_timeout)
option.

**event\_handler\_enabled \***:

This directive is used to determine whether or not the event handler for
this service is enabled. Values: 0 = disable service event handler, 1 =
enable service event handler. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[enable\_event\_handlers](configmain.md#configmain-enable_event_handlers)=0".

**low\_flap\_threshold**:

This directive is used to specify the low state change threshold used in
flap detection for this service. More information on flap detection can
be found
[here](flapping.md "7.8. Detection and Handling of State Flapping").
If you set this directive to a value of 0, the program-wide value
specified by the
[low\_service\_flap\_threshold](configmain.md#configmain-low_service_flap_threshold)
directive will be used. Default: 0.

**high\_flap\_threshold**:

This directive is used to specify the high state change threshold used
in flap detection for this service. More information on flap detection
can be found
[here](flapping.md "7.8. Detection and Handling of State Flapping").
If you set this directive to a value of 0, the program-wide value
specified by the
[high\_service\_flap\_threshold](configmain.md#configmain-high_service_flap_threshold)
directive will be used. Default: 0.

**flap\_detection\_enabled \***:

This directive is used to determine whether or not flap detection is
enabled for this service. More information on flap detection can be
found
[here](flapping.md "7.8. Detection and Handling of State Flapping").
Values: 0 = disable service flap detection, 1 = enable service flap
detection. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[enable\_flap\_detection](configmain.md#configmain-enable_flap_detection)=0".

**flap\_detection\_options**:

This directive is used to determine what service states the [flap
detection
logic](flapping.md "7.8. Detection and Handling of State Flapping")
will use for this service. Valid options are a combination of one or
more of the following: **o** = OK states, **w** = WARNING states, **c**
= CRITICAL states, **u** = UNKNOWN states. Default: o,w,u,c.

**failure\_prediction\_enabled**:

This directive is used to determine whether or not failure prediction is
enabled for this service. Values: 0 = disable service failure
prediction, 1 = enable service failure prediction.

**process\_perf\_data \***:

This directive is used to determine whether or not the processing of
performance data is enabled for this service. Values: 0 = disable
performance data processing, 1 = enable performance data processing.
Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[process\_performance\_data](configmain.md#configmain-process_performance_data)=0".

**retain\_status\_information**:

This directive is used to determine whether or not status-related
information about the service is retained across program restarts. This
is only useful if you have enabled state retention using the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
directive. Value: 0 = disable status information retention, 1 = enable
status information retention. Default: 1.

**retain\_nonstatus\_information**:

This directive is used to determine whether or not non-status
information about the service is retained across program restarts. This
is only useful if you have enabled state retention using the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
directive. Value: 0 = disable non-status information retention, 1 =
enable non-status information retention. Default: 1.

**notification\_interval**:

This directive is used to define the number of "time units" to wait
before re-notifying a contact that this service is *still* in a non-OK
state. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. If you set
this value to 0, Icinga will *not* re-notify contacts about problems for
point values are allowed. Default: 30.

**first\_notification\_delay**:

This directive is used to define the number of "time units" to wait
before sending out the first problem notification when this service
enters a non-OK state. Unless you've changed the
[interval\_length](configmain.md#configmain-interval_length) directive
from the default value of 60, this number will mean minutes. If you set
this value to 0, Icinga will start sending out notifications
immediately.Floating point values are allowed. Default: 0.

**notification\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which notifications of events for this service can be sent out to
contacts. No service notifications will be sent out during times which
is not covered by the time period.

**notification\_options**:

This directive is used to determine when notifications for the service
should be sent out. Valid options are a combination of one or more of
the following: **w** = send notifications on a WARNING state, **u** =
send notifications on an UNKNOWN state, **c** = send notifications on a
CRITICAL state, **r** = send notifications on recoveries (OK state),
**f** = send notifications when the service starts and stops
[flapping](flapping.md "7.8. Detection and Handling of State Flapping"),
and **s** = send notifications when [scheduled
downtime](downtime.md "7.16. Scheduled Downtime") starts and ends. If
you specify **n** (none) as an option, no service notifications will be
sent out. If you do not specify any notification options, Icinga will
assume that you want notifications to be sent out for all possible
states. Example: If you specify **w,r** in this field, notifications
will only be sent out when the service goes into a WARNING state and
when it recovers from a WARNING state. Default: u,w,c,r,f,s

**notifications\_enabled \***:

This directive is used to determine whether or not notifications for
this service are enabled. Values: 0 = disable service notifications, 1 =
enable service notifications. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[enable\_notifications](configmain.md#configmain-enable_notifications)=0".

**contacts**:

This is a list of the *short names* of the
[contacts](objectdefinitions.md#objectdefinitions-contact) that should
be notified whenever there are problems (or recoveries) with this
service. Multiple contacts should be separated by commas. Useful if you
want notifications to go to just a few people and don't want to
configure [contact
groups](objectdefinitions.md#objectdefinitions-contactgroup). You must
specify at least one contact or contact group in each service definition
or nobody at all will be notified.

**contact\_groups**:

This is a list of the *short names* of the [contact
groups](objectdefinitions.md#objectdefinitions-contactgroup) that
should be notified whenever there are problems (or recoveries) with this
service. Multiple contact groups should be separated by commas. You must
specify at least one contact or contact group in each service definition
or nobody at all will be notified.

**stalking\_options**:

This directive determines which service states "stalking" is enabled
for. Valid options are a combination of one or more of the following:
**o** = stalk on OK states, **w** = stalk on WARNING states, **u** =
stalk on UNKNOWN states, and **c** = stalk on CRITICAL states. More
information on state stalking can be found
[here](stalking.md "7.14. State Stalking"). Default: n.

**notes**:

This directive is used to define an optional string of notes pertaining
to the service. If you specify a note here, you will see the it in the
[extended information](cgis.md#cgis-extinfo_cgi) CGI (when you are
viewing information about the specified service).

**notes\_url**:

This directive is used to define an optional URL that can be used to
provide more information about the service. If you specify an URL, you
will see a red folder icon in the CGIs (when you are viewing service
information) that links to the URL you specify here. Any valid URL can
be used. If you plan on using relative paths, the base path will the the
same as what is used to access the CGIs (i.e. */cgi-bin/icinga/*). This
can be very useful if you want to make detailed information on the
service, emergency contact methods, etc. available to other support
staff.

![[Note]](../images/note.png)

Note

Since Icinga 1.0.2 you can use multiple urls for action\_url and
notes\_url for host and service object definitions. The syntax is as
follows:

<pre><code>
notes_url|action_url 'firstURL' 'secondURL' 'thirdURL'
</code></pre>

<pre><code>
notes_url|action_url onlyoneURL
</code></pre>

Please keep in mind that using multiple urls also mean multiple icon
images. Those are hardcoded and e.g. action|notes.gif changes to
you'll have them in place when using multiple action\_url|notes\_url. If
you are using multiple urls with different icons (1-action.gif e.g.) you
can still define the last urls without single quotes. It will then be
used like a single url and is referring to the normal icon (action.gif
e.g.)

**action\_url**:

This directive is used to define an optional URL that can be used to
provide more actions to be performed on the service. If you specify an
URL, you will see a red "splat" icon in the CGIs (when you are viewing
service information) that links to the URL you specify here. Any valid
URL can be used. If you plan on using relative paths, the base path will
the the same as what is used to access the CGIs (i.e.
*/cgi-bin/icinga/*).

**icon\_image**:

This variable is used to define the name of a GIF, PNG, or JPG image
that should be associated with this service. This image will be
displayed in the [status](cgis.md#cgis-status_cgi) and [extended
information](cgis.md#cgis-extinfo_cgi) CGIs. The image will look best
if it is 40x40 pixels in size. Images for services are assumed to be in
the **logos/** subdirectory in your HTML images directory (i.e.
*/usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

This variable is used to define an optional string that is used in the
ALT tag of the image specified by the *\<icon\_image\>* argument. The
ALT tag is used in the [status](cgis.md#cgis-status_cgi), [extended
information](cgis.md#cgis-extinfo_cgi) and
[statusmap](cgis.md#cgis-statusmap_cgi) CGIs.

### 3.4.4. Servicegroup Definition

*Description:*

A service group definition is used to group one or more services
together for simplifying configuration with [object
tricks](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions")
or display purposes in the
[CGIs](cgis.md "6.1. Icinga Classic UI: Information On The Modules").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define servicegroup{

servicegroup\_name

servicegroup\_name

alias

alias

members

services

servicegroup\_members

servicegroups

notes

note\_string

notes\_url

url

action\_url

url

   

}

*Example Definition:*

 define servicegroup{
</code></pre>

*Directive Descriptions:*

**servicegroup\_name**:

This directive is used to define a short name used to identify the
service group.

**alias**:

This directive is used to define is a longer name or description used to
identify the service group. It is provided in order to allow you to more
easily identify a particular service group.

**members**:

This is a list of the *descriptions* of
[services](objectdefinitions.md#objectdefinitions-service) (and the
names of their corresponding hosts) that should be included in this
group. Host and service names should be separated by commas. This
directive may be used as an alternative to the *servicegroups* directive
in [service
definitions](objectdefinitions.md#objectdefinitions-service). The
format of the member directive is as follows (note that a host name must
precede a service name/description):

members=\<host1\>,\<service1\>,\<host2\>,\<service2\>,...,\<host*n*\>,\<service*n*\>

It is possible to use "\*" as a wildcard for all hosts. Please note that
it is NOT possible to exclude neither hosts nor services using the "!"
at the beginning of the host or service.

**servicegroup\_members**:

This optional directive can be used to include services from other "sub"
service groups in this service group. Specify a comma-delimited list of
short names of other service groups whose members should be included in
this group.

**notes**:

This directive is used to define an optional string of notes pertaining
to the service group. If you specify a note here, you will see the it in
the [extended information](cgis.md#cgis-extinfo_cgi) CGI (when you are
viewing information about the specified service group).

**notes\_url**:

This directive is used to define an optional URL that can be used to
provide more information about the service group. If you specify an URL,
you will see a red folder icon in the CGIs (when you are viewing service
group information) that links to the URL you specify here. Any valid URL
can be used. If you plan on using relative paths, the base path will the
the same as what is used to access the CGIs (i.e. */cgi-bin/icinga/*).
This can be very useful if you want to make detailed information on the
service group, emergency contact methods, etc. available to other
support staff.

**action\_url**:

This directive is used to define an optional URL that can be used to
provide more actions to be performed on the service group. If you
specify an URL, you will see a red "splat" icon in the CGIs (when you
are viewing service group information) that links to the URL you specify
here. Any valid URL can be used. If you plan on using relative paths,
the base path will the the same as what is used to access the CGIs (i.e.
*/cgi-bin/icinga/*).

### 3.4.5. Contact Definition

*Description:*

A contact definition is used to identify someone who should be contacted
in the event of a problem on your network. The different arguments to a
contact definition are described below.

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define contact{

contact\_name

contact\_name

alias

alias

contactgroups

contactgroup\_names

host\_notifications\_enabled

[0/1]

service\_notifications\_enabled

[0/1]

host\_notification\_period

timeperiod\_name

service\_notification\_period

timeperiod\_name

host\_notification\_options

[d,u,r,f,s,n]

service\_notification\_options

[w,u,c,r,f,s,n]

host\_notification\_commands

command\_name

service\_notification\_commands

command\_name

email

email\_address

pager

pager\_number or pager\_email\_gateway

address*x*

additional\_contact\_address

can\_submit\_commands

[0/1]

retain\_status\_information

[0/1]

retain\_nonstatus\_information

[0/1]

   

}

*Example Definition:*

 define contact{
</code></pre>

*Directive Descriptions:*

**contact\_name**:

This directive is used to define a short name used to identify the
contact. It is referenced in [contact
group](objectdefinitions.md#objectdefinitions-contactgroup)
definitions. Under the right circumstances, the \$CONTACTNAME\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this value.

**alias**:

This directive is used to define a longer name or description for the
contact. Under the rights circumstances, the \$CONTACTALIAS\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this value. If not specified, the *contact\_name* will be used
as the alias.

**contactgroups**:

This directive is used to identify the *short name(s)* of the
[contactgroup(s)](objectdefinitions.md#objectdefinitions-contactgroup)
that the contact belongs to. Multiple contactgroups should be separated
by commas. This directive may be used as an alternative to (or in
addition to) using the *members* directive in
[contactgroup](objectdefinitions.md#objectdefinitions-contactgroup)
definitions.

**host\_notifications\_enabled**:

This directive is used to determine whether or not the contact will
receive notifications about host problems and recoveries. Values: 0 =
don't send notifications, 1 = send notifications. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[enable\_notifications](configmain.md#configmain-enable_notifications)=0".

**service\_notifications\_enabled**:

This directive is used to determine whether or not the contact will
receive notifications about service problems and recoveries. Values: 0 =
don't send notifications, 1 = send notifications. Default: 1.

![[Note]](../images/note.png)

Note

This value will have no effect if
"[enable\_notifications](configmain.md#configmain-enable_notifications)=0".

**host\_notification\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which the contact can be notified about host problems or recoveries. You
can think of this as an "on call" time for host notifications for the
contact. Read the documentation on [time
periods](timeperiods.md "5.9. Time Periods") for more information on
how this works and potential problems that may result from improper use.

**service\_notification\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which the contact can be notified about service problems or recoveries.
You can think of this as an "on call" time for service notifications for
the contact. Read the documentation on [time
periods](timeperiods.md "5.9. Time Periods") for more information on
how this works and potential problems that may result from improper use.

**host\_notification\_commands**:

This directive is used to define a list of the *short names* of the
[commands](objectdefinitions.md#objectdefinitions-command) used to
notify the contact of a *host* problem or recovery. Multiple
notification commands should be separated by commas. All notification
commands are executed when the contact needs to be notified. The maximum
amount of time that a notification command can run is controlled by the
[notification\_timeout](configmain.md#configmain-notification_timeout)
option.

**host\_notification\_options**:

This directive is used to define the host states for which notifications
can be sent out to this contact. Valid options are a combination of one
or more of the following: **d** = notify on DOWN host states, **u** =
notify on UNREACHABLE host states, **r** = notify on host recoveries (UP
states), **f** = notify when the host starts and stops
[flapping](flapping.md "7.8. Detection and Handling of State Flapping"),
and **s** = send notifications when host or service [scheduled
downtime](downtime.md "7.16. Scheduled Downtime") starts and ends. If
you specify **n** (none) as an option, the contact will not receive any
type of host notifications. Default: **n**.

**service\_notification\_options**:

This directive is used to define the service states for which
notifications can be sent out to this contact. Valid options are a
combination of one or more of the following: **w** = notify on WARNING
service states, **u** = notify on UNKNOWN service states, **c** = notify
on CRITICAL service states, **r** = notify on service recoveries (OK
states), and **f** = notify when the service starts and stops
[flapping](flapping.md "7.8. Detection and Handling of State Flapping").
If you specify **n** (none) as an option, the contact will not receive
any type of service notifications. Default: **n**.

**service\_notification\_commands**:

This directive is used to define a list of the *short names* of the
[commands](objectdefinitions.md#objectdefinitions-command) used to
notify the contact of a *service* problem or recovery. Multiple
notification commands should be separated by commas. All notification
commands are executed when the contact needs to be notified. The maximum
amount of time that a notification command can run is controlled by the
[notification\_timeout](configmain.md#configmain-notification_timeout)
option.

**email**:

This directive is used to define an email address for the contact.
Depending on how you configure your notification commands, it can be
used to send out an alert email to the contact. Under the right
circumstances, the \$CONTACTEMAIL\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this value.

**pager**:

This directive is used to define a pager number for the contact. It can
also be an email address to a pager gateway (i.e. pagejoe@pagenet.com).
Depending on how you configure your notification commands, it can be
used to send out an alert page to the contact. Under the right
circumstances, the \$CONTACTPAGER\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this value.

**addressx**:

Address directives are used to define additional "addresses" for the
messaging addresses, etc. Depending on how you configure your
notification commands, they can be used to send out an alert to the
contact. Up to six addresses can be defined using these directives
(*address1* through *address6*). The \$CONTACTADDRESS*x*\$
[macro](macros.md "5.2. Understanding Macros and How They Work") will
contain this value.

**can\_submit\_commands**:

This directive is used to determine whether or not the contact can
submit [external commands](extcommands.md "7.1. External Commands") to
Icinga from the CGIs. Values: 0 = don't allow contact to submit
commands, 1 = allow contact to submit commands.

**retain\_status\_information**:

This directive is used to determine whether or not status-related
information about the contact is retained across program restarts. This
is only useful if you have enabled state retention using the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
directive. Value: 0 = disable status information retention, 1 = enable
status information retention. Default: 1.

**retain\_nonstatus\_information**:

This directive is used to determine whether or not non-status
information about the contact is retained across program restarts. This
is only useful if you have enabled state retention using the
[retain\_state\_information](configmain.md#configmain-retain_state_information)
directive. Value: 0 = disable non-status information retention, 1 =
enable non-status information retention. Default: 1.

### 3.4.6. Contactgroup Definition

*Description:*

A contact group definition is used to group one or more
[contacts](objectdefinitions.md#objectdefinitions-contact) together
for the purpose of sending out alert/recovery
[notifications](notifications.md "5.11. Notifications").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define contactgroup{

contactgroup\_name

contactgroup\_name

alias

alias

members

contacts

contactgroup\_members

contactgroups

   

}

*Example Definition:*

 define contactgroup{
</code></pre>

*Directive Descriptions:*

**contactgroup\_name**:

This directive is a short name used to identify the contact group.

**alias**:

This directive is used to define a longer name or description used to
identify the contact group.

**members**:

This directive is used to define a list of the *short names* of
[contacts](objectdefinitions.md#objectdefinitions-contact) that should
be included in this group. Multiple contact names should be separated by
commas. This directive may be used as an alternative to (or in addition
to) using the *contactgroups* directive in
[contact](objectdefinitions.md#objectdefinitions-contact) definitions.

**contactgroup\_members**:

This optional directive can be used to include contacts from other "sub"
contact groups in this contact group. Specify a comma-delimited list of
short names of other contact groups whose members should be included in
this group.

### 3.4.7. Timeperiod Definition

*Description:*

A time period is a list of times during various days that are considered
to be "valid" times for notifications and service checks. It consists of
time ranges for each day of the week that "rotate" once the week has
come to an end. Different types of exceptions to the normal weekly time
are supported, including: specific weekdays, days of generic months,
days of specific months, and calendar dates.

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define timeperiod{

timeperiod\_name

timeperiod\_name

alias

alias

[weekday]

timeranges

[exception]

timeranges

exclude

[timeperiod1,timeperiod2,...,timeperiodn]

   

}

*Example Definitions:*

 define timeperiod{

 define timeperiod{
 define timeperiod{

 define timeperiod{
</code></pre>

*Directive Descriptions:*

**timeperiod\_name**:

This directives is the short name used to identify the time period.

**alias**:

This directive is a longer name or description used to identify the time
period.

**[weekday]**:

The weekday directives ("*sunday*" through "*saturday*")are
comma-delimited lists of time ranges that are "valid" times for a
particular day of the week. Notice that there are seven different days
for which you can define time ranges (Sunday through Saturday). Each
time range is in the form of **HH:MM-HH:MM**, where hours are specified
on a 24 hour clock. For example, **00:15-24:00** means 12:15am in the
morning for this day until 12:00am midnight (a 23 hour, 45 minute total
time range). If you wish to exclude an entire day from the timeperiod,
simply do not include it in the timeperiod definition.

**[exception]**:

You can specify several different types of exceptions to the standard
rotating weekday schedule. Exceptions can take a number of different
forms including single days of a specific or generic month, single
weekdays in a month, or single calendar dates. You can also specify a
range of days/dates and even specify skip intervals to obtain
functionality described by "every 3 days between these dates". Rather
than list all the possible formats for exception strings, we'll let you
look at the example timeperiod definitions above to see what's possible.
:-) Weekdays and different types of exceptions all have different levels
of precedence, so its important to understand how they can affect each
other. More information on this can be found in the documentation on
[timeperiods](timeperiods.md "5.9. Time Periods").

**exclude**:

This directive is used to specify the short names of other timeperiod
definitions whose time ranges should be excluded from this timeperiod.
Multiple timeperiod names should be separated with a comma.

### 3.4.8. Command Definition

*Description:*

A command definition is just that. It defines a command. Commands that
can be defined include service checks, service notifications, service
event handlers, host checks, host notifications, and host event
handlers. Command definitions can contain
[macros](macros.md "5.2. Understanding Macros and How They Work"), but
you must make sure that you include only those macros that are "valid"
for the circumstances when the command will be used. More information on
what macros are available and when they are "valid" can be found
[here](macros.md "5.2. Understanding Macros and How They Work"). The
different arguments to a command definition are outlined below.

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define command{

command\_name

command\_name

command\_line

command\_line

   

}

*Example Definition:*

 define command{
</code></pre>

*Directive Descriptions:*

**command\_name**:

This directive is the short name used to identify the command. It is
referenced in
[contact](objectdefinitions.md#objectdefinitions-contact),
[host](objectdefinitions.md#objectdefinitions-host), and
[service](objectdefinitions.md#objectdefinitions-service) definitions
(in notification, check, and event handler directives), among other
places.

**command\_line**:

This directive is used to define what is actually executed by Icinga
when the command is used for service or host checks, notifications, or
[event handlers](eventhandlers.md "7.3. Event Handlers"). Before the
command line is executed, all valid
[macros](macros.md "5.2. Understanding Macros and How They Work") are
replaced with their respective values. See the documentation on macros
for determining when you can use different macros. Note that the command
line is *not* surrounded in quotes. Also, if you want to pass a dollar
sign (\$) on the command line, you have to escape it with another dollar
sign.

**NOTE**: You may not include a **semicolon** (;) in the *command\_line*
directive, because everything after it will be ignored as a config file
comment. You can work around this limitation by setting one of the
[**\$USER\$**](macrolist.md#macrolist-user) macros in your [resource
file](configmain.md#configmain-resource_file) to a semicolon and then
referencing the appropriate \$USER\$ macro in the *command\_line*
directive in place of the semicolon.

If you want to pass arguments to commands during runtime, you can use
[**\$ARGn\$** macros](macrolist.md#macrolist-arg) in the
*command\_line* directive of the command definition and then separate
individual arguments from the command name (and from each other) using
bang (!) characters in the object definition directive (host check
command, service event handler command, etc) that references the
command. More information on how arguments in command definitions are
processed during runtime can be found in the documentation on
[macros](macros.md "5.2. Understanding Macros and How They Work").

### 3.4.9. Servicedependency Definition

*Description:*

Service dependencies are an advanced feature of Icinga that allow you to
suppress notifications and active checks of services based on the status
of one or more other services. Service dependencies are optional and are
mainly targeted at advanced users who have complicated monitoring
setups. More information on how service dependencies work (read this!)
can be found
[here](dependencies.md "7.13. Host and Service Dependencies").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional. However, you
must supply at least one type of criteria for the definition to be of
much use.

define servicedependency{

dependent\_host\_name

host\_name

dependent\_hostgroup\_name

hostgroup\_name

dependent\_servicegroup\_name

servicegroup\_name

dependent\_service\_description

service\_description

host\_name

host\_name

hostgroup\_name

hostgroup\_name

service\_description

service\_description

inherits\_parent

[0/1]

execution\_failure\_criteria

[o,w,u,c,p,n]

notification\_failure\_criteria

[o,w,u,c,p,n]

dependency\_period

timeperiod\_name

   

}

*Example Definition:*

 define servicedependency{
</code></pre>

*Directive Descriptions:*

**dependent\_host\_name**:

This directive is used to identify the *short name(s)* of the
[host(s)](objectdefinitions.md#objectdefinitions-host) that the
*dependent* service "runs" on or is associated with. Multiple hosts
should be separated by commas. Leaving this directive blank can be used
to create ["same host"
dependencies](objecttricks.md#objecttricks-same_host_dependency).

**dependent\_hostgroup\_name**:

This directive is used to specify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-hostgroup) that
the *dependent* service "runs" on or is associated with. Multiple
hostgroups should be separated by commas. The dependent\_hostgroup may
be used instead of, or in addition to, the dependent\_host directive.

**dependent\_servicegroup\_name**:

This directive is used to specify the *short name(s)* of the
[servicegroup(s)](objectdefinitions.md#objectdefinitions-servicegroup)
that the *dependent* services belongs to. Multiple servicegroups should
be separated by commas.

**dependent\_service\_description**:

This directive is used to identify the *description* of the *dependent*
[service](objectdefinitions.md#objectdefinitions-service).

**host\_name**:

This directive is used to identify the *short name(s)* of the
[host(s)](objectdefinitions.md#objectdefinitions-host) that the
service*that is being depended upon* (also referred to as the master
service) "runs" on or is associated with. Multiple hosts should be
separated by commas.

**hostgroup\_name**:

This directive is used to identify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-host) that the
service*that is being depended upon* (also referred to as the master
service) "runs" on or is associated with. Multiple hostgroups should be
separated by commas. The hostgroup\_name may be used instead of, or in
addition to, the host\_name directive.

**service\_description**:

This directive is used to identify the *description* of the
[service](objectdefinitions.md#objectdefinitions-service)*that is
being depended upon* (also referred to as the master service).

**inherits\_parent**:

This directive indicates whether or not the dependency inherits
dependencies of the service*that is being depended upon* (also referred
to as the master service). In other words, if the master service is
dependent upon other services and any one of those dependencies fail,
this dependency will also fail. Default: 0.

**execution\_failure\_criteria**:

This directive is used to specify the criteria that determine when the
dependent service should *not* be actively checked. If the *master*
service is in one of the failure states we specify, the *dependent*
service will not be actively checked. Valid options are a combination of
one or more of the following (multiple options are separated with
commas): **o** = fail on an OK state, **w** = fail on a WARNING state,
**u** = fail on an UNKNOWN state, **c** = fail on a CRITICAL state, and
**p** = fail on a pending state (e.g. the service has not yet been
checked). If you specify **n** (none) as an option, the execution
dependency will never fail and checks of the dependent service will
always be actively checked (if other conditions allow for it to be).
Example: If you specify **o,c,u** in this field, the *dependent* service
will not be actively checked if the *master* service is in either an OK,
a CRITICAL, or an UNKNOWN state.

**notification\_failure\_criteria**:

This directive is used to define the criteria that determine when
notifications for the dependent service should *not* be sent out. If the
*master* service is in one of the failure states we specify,
notifications for the *dependent* service will not be sent to contacts.
Valid options are a combination of one or more of the following: **o** =
fail on an OK state, **w** = fail on a WARNING state, **u** = fail on an
UNKNOWN state, **c** = fail on a CRITICAL state, and **p** = fail on a
pending state (e.g. the service has not yet been checked). If you
specify **n** (none) as an option, the notification dependency will
never fail and notifications for the dependent service will always be
sent out. Example: If you specify **w** in this field, the notifications
for the *dependent* service will not be sent out if the *master* service
is in a WARNING state.

**dependency\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which this dependency is valid. If this directive is not specified, the
dependency is considered to be valid during all times.

### 3.4.10. Serviceescalation Definition

*Description:*

Service escalations are *completely optional* and are used to escalate
notifications for a particular service. More information on how
notification escalations work can be found
[here](escalations.md "7.9. Notification Escalations").

![[Note]](../images/note.png)

Note

Please note that some directives may be inherited from the service
definition. For details refer to [implied
inheritance](objectinheritance.md#objectinheritance-implied_inheritance "7.26.9. Implied Inheritance").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define serviceescalation{

host\_name

host\_name

hostgroup\_name

hostgroup\_name

servicegroup\_name

servicegroup\_name

service\_description

service\_description

contacts

contacts

contact\_groups

contactgroup\_name

first\_notification

\#

last\_notification

\#

notification\_interval

\#

escalation\_period

timeperiod\_name

escalation\_options

[w,u,c,r]

escalation\_condition

\<condition\> ( [ & / | ] \<condition\> )\*

first\_warning\_notification

\#

last\_warning\_notification

\#

first\_critical\_notification

\#

last\_critical\_notification

\#

first\_unknown\_notification

\#

last\_unknown\_notification

\#

   

}

*Example Definition:*

 define serviceescalation{
</code></pre>

*Directive Descriptions:*

**host\_name**:

This directive is used to identify the *short name(s)* of the
[host(s)](objectdefinitions.md#objectdefinitions-host) that the
[service](objectdefinitions.md#objectdefinitions-service) escalation
should apply to or is associated with.

**hostgroup\_name**:

This directive is used to specify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-hostgroup) that
the service escalation should apply to or is associated with. Multiple
hostgroups should be separated by commas. The hostgroup\_name may be
used instead of, or in addition to, the host\_name directive.

**servicegroup\_name**:

This directive is used to specify the *short name(s)* of the
[servicegroup(s)](objectdefinitions.md#objectdefinitions-servicegroup)
that the service escalation should apply to or is associated with.
Multiple servicegroups should be separated by commas. The
servicegroup\_name may be used instead of, or in addition to, the
service\_name directive.

**service\_description**:

This directive is used to identify the *description* of the
[service](objectdefinitions.md#objectdefinitions-service) the
escalation should apply to.

**first\_notification**:

This directive is a number that identifies the *first* notification for
which this escalation is effective. For instance, if you set this value
to 3, this escalation will only be used if the service is in a non-OK
state long enough for a third notification to go out.

**last\_notification**:

This directive is a number that identifies the *last* notification for
which this escalation is effective. For instance, if you set this value
to 5, this escalation will not be used if more than five notifications
are sent out for the service. Setting this value to 0 means to keep
using this escalation entry forever (no matter how many notifications go
out).

**contacts**:

This is a list of the *short names* of the
[contacts](objectdefinitions.md#objectdefinitions-contact) that should
be notified whenever there are problems (or recoveries) with this
service. Multiple contacts should be separated by commas. Useful if you
want notifications to go to just a few people and don't want to
configure [contact
groups](objectdefinitions.md#objectdefinitions-contactgroup). You must
specify at least one contact or contact group in each service escalation
definition.

**contact\_groups**:

This directive is used to identify the *short name* of the [contact
group](objectdefinitions.md#objectdefinitions-contactgroup) that
should be notified when the service notification is escalated. Multiple
contact groups should be separated by commas. You must specify at least
one contact or contact group in each service escalation definition.

**notification\_interval**:

This directive is used to determine the interval at which notifications
should be made while this escalation is valid. If you specify a value of
0 for the interval, Icinga will send the first notification when this
escalation definition is valid, but will then prevent any more problem
notifications from being sent out for the host. Notifications are sent
out again until the host recovers. This is useful if you want to stop
having notifications sent out after a certain amount of time.

![[Note]](../images/note.png)

Note

If multiple escalation entries for a host overlap for one or more
notification ranges, the smallest notification interval from all
escalation entries is used.

**escalation\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which this escalation is valid. If this directive is not specified, the
escalation is considered to be valid during all times.

**escalation\_options**:

This directive is used to define the criteria that determine when this
service escalation is used. The escalation is used only if the service
is in one of the states specified in this directive. If this directive
is not specified in a service escalation, the escalation is considered
to be valid during all service states. Valid options are a combination
of one or more of the following: **r** = escalate on an OK (recovery)
state, **w** = escalate on a WARNING state, **u** = escalate on an
UNKNOWN state, and **c** = escalate on a CRITICAL state. Example: If you
specify **w** in this field, the escalation will only be used if the
service is in a WARNING state. Default: w,u,c,r.

**escalation\_condition**:

This directive is completely optional. Details can be found
[here](escalation_condition.md "7.10. Escalation Condition").

**first\_warning\_notification**:

This directive is a number that identifies the *first**warning*
notification for which this escalation is effective. For instance, if
you set this value to 3, this escalation will only be used if the
service is in a non-OK state long enough for a third warning
notification to go out.

**last\_warning\_notification**:

This directive is a number that identifies the *last**warning*
notification for which this escalation is effective. For instance, if
you set this value to 5, this escalation will not be used if more than
five warning notifications are sent out for the service. Setting this
value to 0 means to keep using this escalation entry forever (no matter
how many notifications go out).

**first\_critical\_notification**:

This directive is a number that identifies the *first**critical*
notification for which this escalation is effective. For instance, if
you set this value to 3, this escalation will only be used if the
service is in a non-OK state long enough for a third critical
notification to go out.

**last\_critical\_notification**:

This directive is a number that identifies the *last**critical*
notification for which this escalation is effective. For instance, if
you set this value to 5, this escalation will not be used if more than
five critical notifications are sent out for the service. Setting this
value to 0 means to keep using this escalation entry forever (no matter
how many notifications go out).

**first\_unknown\_notification**:

This directive is a number that identifies the *first**unknown*
notification for which this escalation is effective. For instance, if
you set this value to 3, this escalation will only be used if the
service is in a non-OK state long enough for a third unknown
notification to go out.

**last\_unknown\_notification**:

This directive is a number that identifies the *last**unknown*
notification for which this escalation is effective. For instance, if
you set this value to 5, this escalation will not be used if more than
five unknown notifications are sent out for the service. Setting this
value to 0 means to keep using this escalation entry forever (no matter
how many notifications go out).

### 3.4.11. Hostdependency Definition

*Description:*

Host dependencies are an advanced feature of Icinga that allow you to
suppress notifications for hosts based on the status of one or more
other hosts. Host dependencies are optional and are mainly targeted at
advanced users who have complicated monitoring setups. More information
on how host dependencies work (read this!) can be found
[here](dependencies.md "7.13. Host and Service Dependencies").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define hostdependency{

dependent\_host\_name

host\_name

dependent\_hostgroup\_name

hostgroup\_name

host\_name

host\_name

hostgroup\_name

hostgroup\_name

inherits\_parent

[0/1]

execution\_failure\_criteria

[o,d,u,p,n]

notification\_failure\_criteria

[o,d,u,p,n]

dependency\_period

timeperiod\_name

   

}

*Example Definition:*

 define hostdependency{
</code></pre>

*Directive Descriptions:*

**dependent\_host\_name**:

This directive is used to identify the *short name(s)* of the
*dependent*[host(s)](objectdefinitions.md#objectdefinitions-host).
Multiple hosts should be separated by commas.

**dependent\_hostgroup\_name**:

This directive is used to identify the *short name(s)* of the
*dependent*[hostgroup(s)](objectdefinitions.md#objectdefinitions-host).
Multiple hostgroups should be separated by commas. The
dependent\_hostgroup\_name may be used instead of, or in addition to,
the dependent\_host\_name directive.

**host\_name**:

This directive is used to identify the *short name(s)* of the
[host(s)](objectdefinitions.md#objectdefinitions-host)*that is being
depended upon* (also referred to as the master host). Multiple hosts
should be separated by commas.

**hostgroup\_name**:

This directive is used to identify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-host)*that is
being depended upon* (also referred to as the master host). Multiple
hostgroups should be separated by commas. The hostgroup\_name may be
used instead of, or in addition to, the host\_name directive.

**inherits\_parent**:

This directive indicates whether or not the dependency inherits
dependencies of the host*that is being depended upon* (also referred to
as the master host). In other words, if the master host is dependent
upon other hosts and any one of those dependencies fail, this dependency
will also fail. Default: 0.

**execution\_failure\_criteria**:

This directive is used to specify the criteria that determine when the
dependent host should *not* be actively checked. If the *master* host is
in one of the failure states we specify, the *dependent* host will not
be actively checked. Valid options are a combination of one or more of
the following (multiple options are separated with commas): **o** = fail
on an UP state, **d** = fail on a DOWN state, **u** = fail on an
UNREACHABLE state, and **p** = fail on a pending state (e.g. the host
has not yet been checked). If you specify **n** (none) as an option, the
execution dependency will never fail and the dependent host will always
be actively checked (if other conditions allow for it to be). Example:
If you specify **u,d** in this field, the *dependent* host will not be
actively checked if the *master* host is in either an UNREACHABLE or
DOWN state.

**notification\_failure\_criteria**:

This directive is used to define the criteria that determine when
notifications for the dependent host should *not* be sent out. If the
*master* host is in one of the failure states we specify, notifications
for the *dependent* host will not be sent to contacts. Valid options are
a combination of one or more of the following: **o** = fail on an UP
state, **d** = fail on a DOWN state, **u** = fail on an UNREACHABLE
state, and **p** = fail on a pending state (e.g. the host has not yet
been checked). If you specify **n** (none) as an option, the
notification dependency will never fail and notifications for the
dependent host will always be sent out. Example: If you specify **d** in
this field, the notifications for the *dependent* host will not be sent
out if the *master* host is in a DOWN state.

**dependency\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which this dependency is valid. If this directive is not specified, the
dependency is considered to be valid during all times.

### 3.4.12. Hostescalation Definition

*Description:*

Host escalations are *completely optional* and are used to escalate
notifications for a particular host. More information on how
notification escalations work can be found
[here](escalations.md "7.9. Notification Escalations").

![[Note]](../images/note.png)

Note

Please note that some directives may be inherited from the host
definition. For details refer to [implied
inheritance](objectinheritance.md#objectinheritance-implied_inheritance "7.26.9. Implied Inheritance").

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define hostescalation{

host\_name

host\_name

hostgroup\_name

hostgroup\_name

contacts

contacts

contact\_groups

contactgroup\_name

first\_notification

\#

last\_notification

\#

notification\_interval

\#

escalation\_period

timeperiod\_name

escalation\_options

[d,u,r]

first\_down\_notification

\#

last\_down\_notification

\#

first\_unreachable\_notification

\#

last\_unreachable\_notification

\#

   

}

*Example Definition:*

 define hostescalation{
</code></pre>

*Directive Descriptions:*

**host\_name**:

This directive is used to identify the *short name* of the
[host](objectdefinitions.md#objectdefinitions-host) that the
escalation should apply to.

**hostgroup\_name**:

This directive is used to identify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-hostgroup) that
the escalation should apply to. Multiple hostgroups should be separated
by commas. If this is used, the escalation will apply to all hosts that
are members of the specified hostgroup(s).

**first\_notification**:

This directive is a number that identifies the *first* notification for
which this escalation is effective. For instance, if you set this value
to 3, this escalation will only be used if the host is down or
unreachable long enough for a third notification to go out.

**last\_notification**:

This directive is a number that identifies the *last* notification for
which this escalation is effective. For instance, if you set this value
to 5, this escalation will not be used if more than five notifications
are sent out for the host. Setting this value to 0 means to keep using
this escalation entry forever (no matter how many notifications go out).

**contacts**:

This is a list of the *short names* of the
[contacts](objectdefinitions.md#objectdefinitions-contact) that should
be notified whenever there are problems (or recoveries) with this host.
Multiple contacts should be separated by commas. Useful if you want
notifications to go to just a few people and don't want to configure
[contact groups](objectdefinitions.md#objectdefinitions-contactgroup).
You must specify at least one contact or contact group in each host
escalation definition.

**contact\_groups**:

This directive is used to identify the *short name* of the [contact
group](objectdefinitions.md#objectdefinitions-contactgroup) that
should be notified when the host notification is escalated. Multiple
contact groups should be separated by commas. You must specify at least
one contact or contact group in each host escalation definition.

**notification\_interval**:

This directive is used to determine the interval at which notifications
should be made while this escalation is valid. If you specify a value of
0 for the interval, Icinga will send the first notification when this
escalation definition is valid, but will then prevent any more problem
notifications from being sent out for the host. Notifications are sent
out again until the host recovers. This is useful if you want to stop
having notifications sent out after a certain amount of time.

![[Note]](../images/note.png)

Note

If multiple escalation entries for a host overlap for one or more
notification ranges, the smallest notification interval from all
escalation entries is used.

**escalation\_period**:

This directive is used to specify the short name of the [time
period](objectdefinitions.md#objectdefinitions-timeperiod) during
which this escalation is valid. If this directive is not specified, the
escalation is considered to be valid during all times.

**escalation\_options**:

This directive is used to define the criteria that determine when this
host escalation is used. The escalation is used only if the host is in
one of the states specified in this directive. If this directive is not
specified in a host escalation, the escalation is considered to be valid
during all host states. Valid options are a combination of one or more
of the following: **r** = escalate on an UP (recovery) state, **d** =
escalate on a DOWN state, and **u** = escalate on an UNREACHABLE state.
Example: If you specify **d** in this field, the escalation will only be
used if the host is in a DOWN state. Default: d,u,r.

**first\_down\_notification**:

This directive is a number that identifies the *first**down*
notification for which this escalation is effective. For instance, if
you set this value to 3, this escalation will only be used if the host
is in a non-OK state long enough for a third down notification to go
out.

**last\_down\_notification**:

This directive is a number that identifies the *first**down*
notification for which this escalation is effective. For instance, if
you set this value to 5, this escalation will not be used if more than
five down notifications are sent out for the host. Setting this value to
0 means to keep using this escalation entry forever (no matter how many
notifications go out).

**first\_unreachable\_notification**:

This directive is a number that identifies the *first**unreachable*
notification for which this escalation is effective. For instance, if
you set this value to 3, this escalation will only be used if the host
is in a non-OK state long enough for a third unreachable notification to
go out.

**last\_unreachable\_notification**:

This directive is a number that identifies the *first**unreachable*
notification for which this escalation is effective. For instance, if
you set this value to 5, this escalation will not be used if more than
five unreachable notifications are sent out for the host. Setting this
value to 0 means to keep using this escalation entry forever (no matter
how many notifications go out).

### 3.4.13. Hostextinfo Definition

![[Important]](../images/important.png)

Important

This definition type is deprecated and may be removed in the future.
Please use the directives in the host definition instead.

*Description:*

Extended host information entries are basically used to make the output
from the [status](cgis.md#cgis-status_cgi),
[statusmap](cgis.md#cgis-statusmap_cgi), and
[extinfo](cgis.md#cgis-extinfo_cgi) CGIs look pretty. They have no
effect on monitoring and are completely optional.

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional. However, you
need to supply at least one optional variable in each definition for it
to be of much use.

define hostextinfo{

host\_name

host\_name

hostgroup\_name

note\_string

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

statusmap\_image

image\_file

2d\_coords

x\_coord,y\_coord

   

}

*Example Definition:*

 define hostextinfo{
</code></pre>

*Variable Descriptions:*

**host\_name**:

This variable is used to identify the *short name* of the
[host](objectdefinitions.md#objectdefinitions-host) which the data is
associated with.

**hostgroup\_name**:

This directive is used to identify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-hostgroup) that
the definition should apply to. Multiple hostgroups should be separated
by commas. If this is used, the definition will apply to all hosts that
are members of the specified hostgroup(s).

**notes**:

This directive is used to define an optional string of notes pertaining
to the host. If you specify a note here, you will see the it in the
[extended information](cgis.md#cgis-extinfo_cgi) CGI (when you are
viewing information about the specified host).

**notes\_url**:

This variable is used to define an optional URL that can be used to
provide more information about the host. If you specify an URL, you will
see a link that says "Extra Host Notes" in the [extended
information](cgis.md#cgis-extinfo_cgi) CGI (when you are viewing
information about the specified host). Any valid URL can be used. If you
plan on using relative paths, the base path will the the same as what is
used to access the CGIs (i.e. */cgi-bin/icinga/*). This can be very
useful if you want to make detailed information on the host, emergency
contact methods, etc. available to other support staff.

**action\_url**:

This directive is used to define an optional URL that can be used to
provide more actions to be performed on the host. If you specify an URL,
you will see a link that says "Extra Host Actions" in the [extended
information](cgis.md#cgis-extinfo_cgi) CGI (when you are viewing
information about the specified host). Any valid URL can be used. If you
plan on using relative paths, the base path will the the same as what is
used to access the CGIs (i.e. */cgi-bin/icinga/*).

**icon\_image**:

This variable is used to define the name of a GIF, PNG, or JPG image
that should be associated with this host. This image will be displayed
in the [status](cgis.md#cgis-status_cgi) and [extended
information](cgis.md#cgis-extinfo_cgi) CGIs. The image will look best
if it is 40x40 pixels in size. Images for hosts are assumed to be in the
**logos/** subdirectory in your HTML images directory (i.e.
*/usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

This variable is used to define an optional string that is used in the
ALT tag of the image specified by the *\<icon\_image\>* argument. The
ALT tag is used in the [status](cgis.md#cgis-status_cgi), [extended
information](cgis.md#cgis-extinfo_cgi) and
[statusmap](cgis.md#cgis-statusmap_cgi) CGIs.

**statusmap\_image**:

This variable is used to define the name of an image that should be
associated with this host in the
[statusmap](cgis.md#cgis-statusmap_cgi) CGI. You can specify a JPEG,
PNG, and GIF image if you want, although we would strongly suggest using
a GD2 format image, as other image formats will result in a lot of
wasted CPU time when the statusmap image is generated. GD2 images can be
created from PNG images by using the **pngtogd2** utility supplied with
Thomas Boutell's [gd library](http://www.boutell.com/gd/). The GD2
images should be created in *uncompressed* format in order to minimize
CPU load when the statusmap CGI is generating the network map image. The
image will look best if it is 40x40 pixels in size. You can leave these
option blank if you are not using the statusmap CGI. Images for hosts
are assumed to be in the **logos/** subdirectory in your HTML images
directory (i.e. */usr/local/icinga/share/images/logos*).

**2d\_coords**:

This variable is used to define coordinates to use when drawing the host
in the [statusmap](cgis.md#cgis-statusmap_cgi) CGI. Coordinates should
be given in positive integers, as they correspond to physical pixels in
the generated image. The origin for drawing (0,0) is in the upper left
hand corner of the image and extends in the positive x direction (to the
right) along the top of the image and in the positive y direction (down)
along the left hand side of the image. For reference, the size of the
icons drawn is usually about 40x40 pixels (text takes a little extra
space). The coordinates you specify here are for the upper left hand
corner of the host icon that is drawn.

![[Note]](../images/note.png)

Note

Don't worry about what the maximum x and y coordinates that you can use
are. The CGI will automatically calculate the maximum dimensions of the
image it creates based on the largest x and y coordinates you specify.

### 3.4.14. Serviceextinfo Definition

![[Important]](../images/important.png)

Important

This definition type is deprecated and may be removed in the future.
Please use the directives in the service definition instead.

*Description:*

Extended service information entries are basically used to make the
output from the [status](cgis.md#cgis-status_cgi) and
[extinfo](cgis.md#cgis-extinfo_cgi) CGIs look pretty. They have no
effect on monitoring and are completely optional.

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional. However, you
need to supply at least one optional variable in each definition for it
to be of much use.

define serviceextinfo{

host\_name

host\_name

service\_description

service\_description

hostgroup\_name

hostgroup\_name

notes

note\_string

notes\_url

url

action\_url

url

icon\_image

image\_file

icon\_image\_alt

alt\_string

   

}

*Example Definition:*

 define serviceextinfo{
</code></pre>

*Directive Descriptions:*

**host\_name**:

This directive is used to identify the *short name* of the host that the
[service](objectdefinitions.md#objectdefinitions-service) is
associated with.

**service\_description**:

This directive is description of the
[service](objectdefinitions.md#objectdefinitions-service) which the
data is associated with.

**hostgroup\_name**:

This directive is used to identify the *short name(s)* of the
[hostgroup(s)](objectdefinitions.md#objectdefinitions-hostgroup) that
the definition should apply to. Multiple hostgroups should be separated
by commas. If this is used, the definition will apply to all hosts that
are members of the specified hostgroup(s).

**notes**:

This directive is used to define an optional string of notes pertaining
to the service. If you specify a note here, you will see the it in the
[extended information](cgis.md#cgis-extinfo_cgi) CGI (when you are
viewing information about the specified service).

**notes\_url**:

This directive is used to define an optional URL that can be used to
provide more information about the service. If you specify an URL, you
will see a link that says "Extra Service Notes" in the [extended
information](cgis.md#cgis-extinfo_cgi) CGI (when you are viewing
information about the specified service). Any valid URL can be used. If
you plan on using relative paths, the base path will the the same as
what is used to access the CGIs (i.e. */cgi-bin/icinga/*). This can be
very useful if you want to make detailed information on the service,
emergency contact methods, etc. available to other support staff.

**action\_url**:

This directive is used to define an optional URL that can be used to
provide more actions to be performed on the service. If you specify an
URL, you will see a link that says "Extra Service Actions" in the
[extended information](cgis.md#cgis-extinfo_cgi) CGI (when you are
viewing information about the specified service). Any valid URL can be
used. If you plan on using relative paths, the base path will the the
same as what is used to access the CGIs (i.e. */cgi-bin/icinga/*).

**icon\_image**:

This variable is used to define the name of a GIF, PNG, or JPG image
that should be associated with this host. This image will be displayed
in the [status](cgis.md#cgis-status_cgi) and [extended
information](cgis.md#cgis-extinfo_cgi) CGIs. The image will look best
if it is 40x40 pixels in size. Images for hosts are assumed to be in the
**logos/** subdirectory in your HTML images directory (i.e.
*/usr/local/icinga/share/images/logos*).

**icon\_image\_alt**:

This variable is used to define an optional string that is used in the
ALT tag of the image specified by the *\<icon\_image\>* argument. The
ALT tag is used in the [status](cgis.md#cgis-status_cgi), [extended
information](cgis.md#cgis-extinfo_cgi) and
[statusmap](cgis.md#cgis-statusmap_cgi) CGIs.

### 3.4.15. Module Definition

*Description:*

A module definition is used to specify information about a module.

*Definition Format:*

![[Note]](../images/note.png)

Note

"Directives" are required while the others are optional.

define module{

module\_name

module name

path

path

args

arguments

module\_type

neb

}

*Example Definitions:*

 define module{
</code></pre>

Based on the
[MKLiveStatus](http://mathias-kettner.de/checkmk_livestatus.md)
documentation the module definition would look like this:

 define module{
</code></pre>

*Directive Descriptions:*

**module\_name**:

This directive identifies the unique name of the module so you cannot
have two modules with the same module name. It is mandatory, otherwise
the config will not be accepted and the module will not be loaded.

**module\_type**:

This optional directive defines the type of the module, e.g. 'neb' for
event broker modules. This directive is intended to allow further
filtering on the module loading.

**path**:

This mandatory directive specifies the path to the module binary to be
loaded. For event broker modules like idomod the user running the core
must be allowed to read and load the module.

**args**:

This directive defines optional arguments passed to the module. idomod
needs config\_file=.../idomod.cfg while other modules have their own
syntax. This directive is passed as argument string to the event broker
module loader if used as neb module.

![[Note]](../images/note.png)

Note

Templating should be possible but it has not been tested extensively
with Icinga 1.4.

* * * * *

[Prev](configobject.md) | [Up](ch03.md) | [Next](customobjectvars.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
