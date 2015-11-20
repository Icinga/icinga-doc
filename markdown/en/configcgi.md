[Prev](customobjectvars.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch04.md)

* * * * *

3.6. CGI Configuration File Options
-----------------------------------

**Notes**

When creating and/or editing configuration files, keep the following in
mind:




**Sample Configuration**

![[Tip]](../images/tip.png)

Tip

A sample CGI configuration file (*/usr/local/icinga/etc/cgi.cfg*) is
installed for you when you follow the [quickstart installation
guide](quickstart.md "2.3. Quickstart Installation Guides").

**Config File Location**

By default, Icinga expects the CGI configuration file to be named
**cgi.cfg** and located in the config file directory along with the
[main config
file](configmain.md "3.2. Main Configuration File Options"). If you
need to change the name of the file or its location, you can configure
Apache to pass an environment variable named ICINGA\_CGI\_CONFIG (which
points to the correct location) to the CGIs. See the Apache
documentation for information on how to do this.

**Configuration File Variables**

Below you will find descriptions of each main Icinga configuration file
option...

**Main Configuration File Location**

Format:

**main\_config\_file=\<file\_name\>**

Example:

**main\_config\_file=/usr/local/icinga/etc/icinga.cfg**

This specifies the location of your [main configuration
file](configmain.md "3.2. Main Configuration File Options"). The CGIs
need to know where to find this file in order to get information about
configuration information, current host and service status, etc.

**Physical HTML Path**

Format:

**physical\_html\_path=\<path\>**

Example:

**physical\_html\_path=/usr/local/icinga/share**

This is the *physical* path where the HTML files for Icinga are kept on
your workstation or server. Icinga assumes that the documentation and
images files (used by the CGIs) are stored in subdirectories called
*docs/* and *images/*, respectively.

**URL HTML Path**

Format:

**url\_html\_path=\<path\>**

Example:

**url\_html\_path=/icinga**

If, when accessing Icinga via a web browser, you point to an URL like
**http://www.myhost.com/icinga**, this value should be */icinga*.
Basically, its the path portion of the URL that is used to access the
Icinga HTML pages.

**URL CGI Path**

Format:

**url\_cgi\_path=\<path\>**

Example:

**url\_cgi\_path=/icinga/cgi-bin**

This is the path portion of the URL that corresponds to the *physical*
location of the Icinga CGI files. It is evaluated by the cmd.cgi CSRF
protection. This value should be changed if the CGI files are accessible
under a different path than the default installation path. If not set,
the default location will be used
(url\_cgi\_path=url\_html\_path/cgi-bin).

**URL Stylesheet Path**

Format:

**url\_stylesheet\_path=\<path\>/stylesheets**

Example:

**url\_stylesheet\_path=/icinga/stylesheets**

This option allows to define an url stylesheet path other than the
default. This will be useful when adding custom stylesheets in another
location. If not set, the default location will be used
(url\_stylesheets\_path=url\_html\_path/stylesheets).

**Authentication Usage**

Format:

**use\_authentication=[0/1]**

Example:

**use\_authentication=1**

This option controls whether or not the CGIs will use the authentication
and authorisation functionality when determining what information and
commands users have access to. We would strongly suggest that you use
the authentication functionality for the CGIs. If you decide not to use
authentication, make sure to remove the [command
CGI](cgis.md#cgis-cmd_cgi) to prevent unauthorised users from issuing
commands to Icinga. The CGI will not issue commands to Icinga if
authentication is disabled, but we would suggest removing it altogether
just to be on the safe side. More information on how to setup
authentication and configure authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").



**Use Client Certificates**

Format:

**use\_ssl\_authentication=[0/1]**

Example:

**use\_ssl\_authentication=0**

This option controls whether the value of the web server environment
variable `REMOTE_USER` or `SSL_CLIENT_S_DN_CN` will
be used. The name of the directive is a bit misleading because unless
you set up the use of client certificates the value has to be set to
zero (0). Setting the value to one (1) requires
in your web server config. Please consult your web server configuration
documentation for details.



**Default User Name**

Format:

**default\_user\_name=\<username\>**

Example:

**default\_user\_name=guest**

Setting this variable will define a default username that can access the
CGIs. This allows people within a secure domain (i.e., behind a
firewall) to access the CGIs without necessarily having to authenticate
to the web server. You may want to use this to avoid having to use basic
authentication if you are not using a secure server, as basic
authentication transmits passwords in clear text over the Internet.

**Important:** Do *not* define a default username unless you are running
a secure web server and are sure that everyone who has access to the
CGIs has been authenticated in some manner! If you define this variable,
anyone who has not authenticated to the web server will inherit all
rights you assign to this user!

**System/Process Information Access**

Format:

**authorized\_for\_system\_information=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_system\_information=icingaadmin,theboss**

This is a comma-delimited list of names of *authenticated users* who can
view system/process information in the [extended information
CGI](cgis.md#cgis-extinfo_cgi). Users in this list are *not*
automatically authorised to issue system/process commands. If you want
users to be able to issue system/process commands as well, you must add
them to the
[authorized\_for\_system\_commands](configcgi.md#configcgi-authorized_for_system_commands)
variable. More information on how to setup authentication and configure
authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_system_information` to authorise
a contactgroup instead of a contact.

**System/Process Command Access**

Format:

**authorized\_for\_system\_commands=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_system\_commands=icingaadmin**

This is a comma-delimited list of names of *authenticated users* who can
issue system/process commands via the [command
CGI](cgis.md#cgis-cmd_cgi). Users in this list are *not* automatically
authorised to view system/process information. If you want users to be
able to view system/process information as well, you must add them to
the
[authorized\_for\_system\_information](configcgi.md#configcgi-authorized_for_system_information)
variable. More information on how to setup authentication and configure
authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_system_commands` to authorise a
contactgroup instead of a contact.

**Configuration Information Access**

Format:

**authorized\_for\_configuration\_information=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_configuration\_information=icingaadmin**

This is a comma-delimited list of names of *authenticated users* who can
view configuration information in the [configuration
CGI](cgis.md#cgis-config_cgi). Users in this list can view information
on all configured hosts, host groups, services, contacts, contact
groups, time periods, and commands. More information on how to setup
authentication and configure authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_configuration_information` to
authorise a contactgroup instead of a contact.

**Global Host Information Access**

Format:

**authorized\_for\_all\_hosts=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_all\_hosts=icingaadmin,theboss**

This is a comma-delimited list of names of *authenticated users* who can
view status and configuration information for all hosts. Users in this
list are also automatically authorised to view information for all
services. Users in this list are *not* automatically authorised to issue
commands for all hosts or services. If you want users able to issue
commands for all hosts and services as well, you must add them to the
[authorized\_for\_all\_host\_commands](configcgi.md#configcgi-authorized_for_all_host_commands)
variable. More information on how to setup authentication and configure
authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_all_hosts` to authorise a
contactgroup instead of a contact.

**Global Host Command Access**

Format:

**authorized\_for\_all\_host\_commands=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_all\_host\_commands=icingaadmin**

This is a comma-delimited list of names of *authenticated users* who can
issue commands for all hosts via the [command
CGI](cgis.md#cgis-cmd_cgi). Users in this list are also automatically
authorised to issue commands for all services. Users in this list are
*not* automatically authorised to view status or configuration
information for all hosts or services. If you want users able to view
status and configuration information for all hosts and services as well,
you must add them to the
[authorized\_for\_all\_hosts](configcgi.md#configcgi-authorized_for_all_hosts)
variable. More information on how to setup authentication and configure
authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_all_host_commands` to authorise a
contactgroup instead of a contact.

**Global Service Information Access**

Format:

**authorized\_for\_all\_services=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_all\_services=icingaadmin,theboss**

This is a comma-delimited list of names of *authenticated users* who can
view status and configuration information for all services. Users in
this list are *not* automatically authorised to view information for all
hosts. Users in this list are *not* automatically authorised to issue
commands for all services. If you want users able to issue commands for
all services as well, you must add them to the
[authorized\_for\_all\_service\_commands](configcgi.md#configcgi-authorized_for_all_service_commands)
variable. More information on how to setup authentication and configure
authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_all_services` to authorise a
contactgroup instead of a contact.

**Global Service Command Access**

Format:

**authorized\_for\_all\_service\_commands=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_all\_service\_commands=icingaadmin**

This is a comma-delimited list of names of *authenticated users* who can
issue commands for all services via the [command
CGI](cgis.md#cgis-cmd_cgi). Users in this list are *not* automatically
authorised to issue commands for all hosts. Users in this list are *not*
automatically authorised to view status or configuration information for
all hosts. If you want users able to view status and configuration
information for all services as well, you must add them to the
[authorized\_for\_all\_services](configcgi.md#configcgi-authorized_for_all_services)
variable. More information on how to setup authentication and configure
authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_all_service_commands` to
authorise a contactgroup instead of a contact.

**Show All Services A Host Is Authorized For**

Format:

**show\_all\_services\_host\_is\_authorized\_for=[0|1]**

Example:

**show\_all\_services\_host\_is\_authorized\_for=1**

By default, a user can see all services on a host, if the user is
authorised as contact for the host only. By disabling this option, the
user must be an authorised contact for the service too in order to view
it. Keep in mind that setting the user in authorized\_for\_all\_services
obsoletes this option.

**Deny Access To Commands And Comments**

Format:

**authorized\_for\_read\_only=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_read\_only=icingalook**

This is a comma-delimited list of names of *authenticated users* who
have read-only rights in the CGIs. This will block any host or service
commands. It will also block comments from being shown to read-only
users. Users in this list are *not* automatically authorised to view
status or configuration information for all hosts. If you want users
able to view status and configuration information for all services as
well, you must add them to the
[authorized\_for\_all\_services](configcgi.md#configcgi-authorized_for_all_services)
variable. More information on how to setup authentication and configure
authorisation for the CGIs can be found
[here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
You can alternatively specify
`authorized_contactgroup_for_read_only` to authorise a
contactgroup instead of a contact.

**Read-Only For Comments**

Format:

**authorized\_for\_comments\_read\_only=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

**authorized\_contactgroup\_for\_comments\_read\_only=\<contactgroup1\>,\<contactgroup2\>,...\<contactgroupn\>**

Example:

**authorized\_for\_comments\_read\_only=icingalook**

**authorized\_contactgroup\_for\_comments\_read\_only=readonlyusers**

This is comma-delimited list of usernames or contactgroups that have
rights to view comments in the CGIs. If the user/contactgroup is defined
as read-only and you add the same user/contactgroup to this option, then
the user/contactgroup can see the comments. If the user is NOT read-only
then the options to delete comments in extinfo.cgi are not displayed as
well.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.8

**Read-Only For Downtimes**

Format:

**authorized\_for\_downtimes\_read\_only=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

**authorized\_contactgroup\_for\_downtimes\_read\_only=\<contactgroup1\>,\<contactgroup2\>,...\<contactgroupn\>**

Example:

**authorized\_for\_downtimes\_read\_only=icingalook**

**authorized\_contactgroup\_for\_downtimes\_read\_only=readonlyusers**

This is a comma-delimited list of usernames or contactgroups that have
rights to view downtimes in the CGIs. If the user is defined as
read-only and you add the same user/contactgroup to this options, then
the user/contactgroup can still see downtimes. If the user is NOT
read-only then the options to delete downtimes in extinfo.cgi are not
displayed as well.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.8

**Lock Author Names**

Format:

**lock\_author\_names=[0/1]**

Example:

**lock\_author\_names=1**

This option allows you to restrict users from changing the author name
when submitting comments, acknowledgements, and scheduled downtime from
the web interface. If this option is enabled, users will be unable to
change the author name associated with the command request.



**Default Expiring Disabled Notifications Duration**

Format:

**default\_expiring\_disabled\_notifications\_duration=[seconds]**

Example:

****default\_expiring\_disabled\_notifications\_duration=86400****

This option defines the default duration (in seconds) of an expiring for
global disabled notifications. Default is 86400 seconds (1 day).

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.8

**Status Show Long Plugin Output**

Format:

**status\_show\_long\_plugin\_output=[0/1]**

Example:

**status\_show\_long\_plugin\_output=1**

This option allows you to specify the length of status information in
output of status.cgi. If you set the value to 1 it shows the full plugin
output instead of the first line only. Default value is 0.



**Statusmap CGI Background Image**

Format:

**statusmap\_background\_image=\<image\_file\>**

Example:

**statusmap\_background\_image=smbackground.gd2**

This option allows you to specify an image to be used as a background in
the [statusmap CGI](cgis.md#cgis-statusmap_cgi) if you use the
user-supplied coordinates layout method. The background image is not be
available in any other layout methods. It is assumed that the image
resides in the HTML images path (i.e. /usr/local/icinga/share/images).
This path is automatically determined by appending "/images" to the path
specified by the
[physical\_html\_path](configcgi.md#configcgi-physical_html_path)
directive.

![[Note]](../images/note.png)

Note

The image file can be in GIF, JPEG, PNG, or GD2 format. However, GD2
format (preferably in uncompressed format) is recommended, as it will
reduce the CPU load when the CGI generates the map image.

**Statusmap Transparency Index Colour**

Format:

**color\_transparency\_index\_r=\<0...255\>**

**color\_transparency\_index\_g=\<0...255\>**

**color\_transparency\_index\_b=\<0...255\>**

Example:

**color\_transparency\_index\_r=255**

These options set the r,g,b values of the background colour used for the
statusmap CGI, so normal browsers that can't show real png transparency
set the desired colour as a background colour instead (to make it look
pretty). Defaults to white: (R,G,B) = (255,255,255).

**Default Statusmap Layout Method**

Format:

**default\_statusmap\_layout=\<layout\_number\>**

Example:

**default\_statusmap\_layout=4**

This option allows you to specify the default layout method used by the
[statusmap CGI](cgis.md#cgis-statusmap_cgi). Valid options are:

**\<layout\_number\> Value**

**Layout Method**

0

User-defined coordinates

1

Depth layers

2

Collapsed tree

3

Balanced tree

4

Circular

5

Circular (Marked Up)

6

Circular (Balloon)

**CGI Refresh Rate**

Format:

**refresh\_rate=\<rate\_in\_seconds\>**

Example:

**refresh\_rate=90**

This option allows you to specify the number of seconds between page
refreshes for the [status](cgis.md#cgis-status_cgi),
[statusmap](cgis.md#cgis-statusmap_cgi), and
[extinfo](cgis.md#cgis-extinfo_cgi) CGIs.

**CGI Refresh Type**

Format:

**refresh\_type=\<0|1\>**

Example:

**refresh\_type=1**

This option determines what type of refresh should be used. You can
choose between http header and javascript. By default javascript (1) is
activated. If you have trouble using javascript then try refresh via
http header (0).

**Audio Alerts**

Formats:

**host\_unreachable\_sound=\<sound\_file\>**

**host\_down\_sound=\<sound\_file\>**

**service\_critical\_sound=\<sound\_file\>**

**service\_warning\_sound=\<sound\_file\>**

**service\_unknown\_sound=\<sound\_file\>**

**normal\_sound=\<sound\_file\>**

Examples:

**host\_unreachable\_sound=hostu.wav**

**host\_down\_sound=hostd.wav**

**service\_critical\_sound=critical.wav**

**service\_warning\_sound=warning.wav**

**service\_unknown\_sound=unknown.wav**

**normal\_sound=noproblem.wav**

These options allow you to specify an audio file that should be played
in your browser if there are problems when you are viewing the [status
CGI](cgis.md#cgis-status_cgi). If there are problems, the audio file
for the most critical type of problem will be played. The most critical
type of problem is on or more unreachable hosts, while the least
critical is one or more services in an unknown state (see the order in
the example above). Audio files are assumed to be in the **media/**
subdirectory in your HTML directory (i.e.
*/usr/local/icinga/share/media*).

**Escape HTML Tags Option**

Format:

**escape\_html\_tags=[0/1]**

Example:

**escape\_html\_tags=1**

This option determines whether or not HTML tags in host and service
(plugin) output is escaped in the CGIs. If you enable this option, your
plugin output will not be able to contain clickable hyperlinks.

**Notes URL Target**

Format:

**notes\_url\_target=[target]**

Example:

**notes\_url\_target=\_blank**

This option determines the name of the frame target that notes URLs
should be displayed in. Valid options include *\_blank*, *\_self*,
*\_top*, *\_parent*, or any other valid target name.

**Action URL Target**

Format:

**action\_url\_target=[target]**

Example:

**action\_url\_target=\_blank**

This option determines the name of the frame target that action URLs
should be displayed in. Valid options include *\_blank*, *\_self*,
*\_top*, *\_parent*, or any other valid target name.

**Tac Show Only Hard State**

Format:

**tac\_show\_only\_hard\_state=[0/1]**

Example:

**tac\_show\_only\_hard\_state=1**

This option allows you to specify if the tactical overview should only
show hard states on hosts and services. If you set this option to 1 the
tactical overview shows only states on hosts and services. By default
disabled, all states will be shown.

**Splunk Integration Option**

Format:

**enable\_splunk\_integration=[0/1]**

Example:

**enable\_splunk\_integration=1**

This option determines whether integration functionality with Splunk is
enabled in the web interface. If enabled, you'll be presented with
"Splunk It" links in various places in the CGIs (log file, alert
history, host/service detail, etc). Useful if you're trying to research
why a particular problem occurred. For more information on Splunk, visit
[http://www.splunk.com/](http://www.splunk.com/).

**Splunk URL**

Format:

**splunk\_url=\<path\>**

Example:

**splunk\_url=http://127.0.0.1:8000/**

This option is used to define the base URL to your Splunk interface.
This URL is used by the CGIs when creating links if the
[enable\_splunk\_integration](configcgi.md#configcgi-enable_splunk_integration)
option is enabled.

**Persistent Acknowledge Comments**

Format:

**persistent\_ack\_comments=\<0|1\>**

Example:

**persistent\_ack\_comments=1**

This option controls the initial state of the check box "persistent
comment" to acknowledge problem hosts or services. It can be used to
reinstate the behaviour of Nagios 2. Default is "0" to be compatible
with Nagios 3.



**Set field separator for CSV export**

Format:

**csv\_delimiter=\<char\>**

Example:

**csv\_delimiter=,**

This option determines the character which should act as field
separator. Default is a semicolon (;).

**Set field enclosure character for CSV export**

Format:

**csv\_data\_enclosure=\<char\>**

Example:

**csv\_data\_enclosure='**

This option determines the character which should be used to enclose
fields. Default is a single quote (').

**Show initial states**

Format:

**showlog\_initial\_states=\<0|1\>**

Example:

**showlog\_initial\_states=1**

This option allows you to specify if initial states of hosts and
services should be shown in showlog.cgi.

![[Note]](../images/note.png)

Note

This option only works if the option "log\_initial\_states" in
icinga.cfg is set to 1.



**Show current states**

Format:

**showlog\_current\_states=\<0|1\>**

Example:

**showlog\_current\_states=1**

This option allows you to specify if current states of hosts and
services should be shown in showlog.cgi.

![[Note]](../images/note.png)

Note

This option only works if the option "log\_current\_states" in
icinga.cfg is set to 1.



**Show object type in tab title**

Format:

**tab\_friendly\_titles=\<0|1\>**

Example:

**tab\_friendly\_titles=1**

Activating this option changes the \<title\> of status.cgi and
extinfo.cgi when they refer to a single host, service, or group.

They will then read:





These are easier to read and find if you use (many) tabs in your
browser.



**Show service state and notification number**

Format:

**add\_notif\_num\_hard=n**

**add\_notif\_num\_soft=n**

Example:

**add\_notif\_num\_hard=28**

Set this to an OR of the service state identifiers for which status.cgi
should not only report "attempts" (e.g., "3/3" for a HARD non-OK state
with max\_check\_attempts=3) but also the current notification number
("(\#0)" if no problem notification has been sent yet, etc.). This is
helpful to identify services which switched between different non-OK
states a lot, or services which have a first\_notification\_delay set
and are "not yet officially" considered in trouble.

Relevant values from include/statusdata.h (look them up \*there\* if you
want to be \*really\* sure):

<pre><code>
</code></pre>

You'll likely want to use add\_notif\_num\_hard=0 (default) or
add\_notif\_num\_hard=28 (warn+crit+unknown).

There's an add\_notif\_num\_soft affecting services in a SOFT state for
sake of completeness, too.

**Set HTTP character set**

Format:

**http\_charset=\<char-set\>**

Example:

**http\_charset=utf-8**

This is the character set which is sent with HTTP headers. Default is
utf-8.

**Set first day of week**

Format:

**first\_day\_of\_week=\<0|1\>**

Example:

**first\_day\_of\_week=1**

This sets the first day of the week which is used in several
CGI-reports. Default is 0 = sunday. 1 = monday will be suitable for
countries adhering to ISO 8601.

**Logging of CGI commands**

Format:

**use\_logging=\<0|1\>**

Example:

**use\_logging=1**

This option enables the logging of CGI commands in a separate log file.
Default is 0 = logging disabled, 1 = logging enabled.

**CGI log file**

Format:

**cgi\_log\_file=\<file\_name\>**

Example:

**cgi\_log\_file=/usr/local/icinga/share/log/icinga-cgi.log**

This option sets the location of the CGI log file.

**CGI log file rotation method**

Format:

**log file rotation method=\<d|w|m\>**

Example:

**cgi\_log\_rotation\_method=d**

This is the rotation method that you would like Icinga to use for your
CGI log file. Values are as follows:






**CGI Log Archive Path**

Format:

**cgi\_log\_archive\_path=\<archive directory\>**

Example:

**cgi\_log\_archive\_path=/usr/local/icinga/share/log**

This is the directory where Icinga should place CGI log files that have
been rotated. This option is ignored if you choose to not use the [CGI
log rotation](configcgi.md#configcgi-cgi_log_rotation_method)
functionality.

**Enforce comments on actions**

Format:

**enforce\_comments\_on\_actions=\<0|1\>**

Example:

**enforce\_comments\_on\_actions=1**

Enforces the need to enter a comment on actions entered via the CGIs. 0
= do not enforce comment (default), 1 = enforce comment.

![[Note]](../images/note.png)

Note

The option use\_logging has to be enabled, otherwise there will be no
logging of comments.

**Show header with tactical information**

Format:

**show\_tac\_header=\<0|1\>**

Example:

**show\_tac\_header=0**

There's a new CGI driven top frame that is enabled by default. The new
view has a similar feel to the header that is in Icinga Web and includes
important tactical and monitor performance information so you can always
be informed of issues.

If you want to keep the old minimalistic look, the new CGI top view can
be disabled with the directive: `show_tac_header=0`

The layout for the display of entries for each type is "X / Y / Z"
where:

X = Active unacknowledged

Y = Passive unacknowledged

Z = Acknowledged

The X/Y/Z numbers themselves are click-able and will bring you to a list
of all the services or hosts related to the respective entry.

Colouring for these entries has the following logical flow:

<pre><code>
</code></pre>

These colours are located in `html/stylesheets/tacheader.css`
for easy customisation. For example, if your setup is distributed and
primarily depends upon passive checks then you may prefer to make
passive check issues stand out with the same colouring as active checks.

**Figure 3.1. Example of new header**

![Example of new header](../images/tac_header2.png)

\

**Show header including pending counts**

Format:

**show\_tac\_header\_pending=\<0|1\>**

Example:

**show\_tac\_header\_pending=0**

This option enables the display of pending counts in the tac header. If
your display is less than 1024x768 and this is enabled, the tactical
information may not fit well in the top frame. By default it is
disabled.

**Set default downtime duration**

Format:

**default\_downtime\_duration=n**

Example:

**default\_downtime\_duration=7200**

This option defines the default duration (in seconds) of fixed and
flexible downtimes. Default is 7200 seconds (2 hours).

**Suppress objects in maintenance/downtime state**

Format:

**suppress\_maintenance\_downtime=\<0|1\>**

Example:

**suppress\_maintenance\_downtime=0**

The current Classic UI view shows the state of hosts including attention
grabbing colours even if the host/service is scheduled for downtime.
This tends to distract from discerning which problems really exist
between those which were planned or expected. It is disabled by default
to maintain the old behaviour, however those wishing to enable it will
note that rather than displaying issues in their regular colour, they
will be grey (similar to the pending state). The status, however will
still display the actual state and this is intended behaviour. This is
so the user can use icinga to see what the state is in before the
downtime ends. A useful example for this is so it can be seen that a
host/service that was being worked on actually came back online. In
addition, hosts in scheduled downtime will be grey in the statusmap.cgi.

**Show partial hostgroups**

Format:

**show\_partial\_hostgroups=\<0|1\>**

Example:

**show\_partial\_hostgroups=1**

By default (meaning the directive is not present or disabled), a user
only sees a hostgroup and the hosts within it if they are an authorised
contact for *all* of the hosts of the group. The behaviour can be
changed using the directive `show_partial_hostgroups=1`.

When enabled, the hostgroups overview will show a partial listing of
hosts that the user is an authorised contact for within each hostgroup.

It will also add the string "(Partial Hostgroups Enabled)" to the top of
the Hostgroup Overview to help prevent any confusion over whether the
option is in use or not. However for privacy reasons, hostgroups that
are only showing a partial listing are not specifically indicated.

COMPATIBILITY NOTICE: As with any tweak made to the output of the CGIs,
enabling this option may adversely impact third party programs that rely
on 'screen scraping' to get their information. If you encounter such a
problem, turn this option back to its default of off and encourage the
developer(s) of the program to use JSON for their data needs instead.

**Highlight rows in status.cgi**

Format:

**highlight\_table\_rows=\<0|1\>**

Example:

**highlight\_table\_rows=0**

This option allows you to define if table rows in status.cgi will be
highlighted or not. Sometimes with a lot of rows or a large screen
resolution it is hard to see which rows you are working on: Values: 0 =
disables row highlighting; 1 = enables row highlighting (default).

**Select state to be shown while pending**

Format:

**use\_pending\_states=\<0|1\>**

Example:

**use\_pending\_states=0**

This option determines what states should be displayed in the web
interface for hosts/services that have not yet been checked. Values: 0 =
leave hosts/services that have not been checked yet in their original
state; 1 = mark hosts/services that have not been checked yet as PENDING
(default).

**Set expiration period of acknowledgements**

Format:

**default\_expiring\_acknowledgement\_duration=\<n\>**

Example:

**default\_expiring\_acknowledgement\_duration=86400**

This option allows you to define the period (in seconds) after which
acknowledgements will expire (meaning they will be deleted). The default
is 86,400 seconds (one day).

**Show child host(s)**

Format:

**extinfo\_show\_child\_hosts=\<0|1|2\>**

Example:

**extinfo\_show\_child\_hosts=1**

This option allows you to specify if the extended host information cgi
will show child hosts for the selected host.




![[Important]](../images/important.png)

Important

Option 2 could be a real performance killer in large installations, so
use with care.

![[Note]](../images/note.png)

Note

This option is disabled by default as it can degrade overall
performance.

**Allow user(s) for FULL command line view**

Format:

**authorized\_for\_full\_command\_resolution=\<user1\>,\<user2\>,\<user3\>,...\<usern\>**

Example:

**authorized\_for\_full\_command\_resolution=icingaadmin**

This option is a comma-delimited list of all usernames that can view a
command in config command expander as Icinga would execute it. To
resolve all MACROS it is necessary to allow read access to the web
server for `resource.cfg` as well.

Alternatively you can specify contactgroups, too.

![[Important]](../images/important.png)

Important

\$USERXX\$ vars and custom vars can contain sensitive data so access
should be strictly limited.

**Display Host/Status Status Totals**

Format:

**display\_status\_totals=0|1**

Example:

**display\_status\_totals=0**

This option allows you to specify if the Host Status Totals and Service
Status Totals should be displayed. Default value is 0.

**Limit number of page entries to be displayed**

Format:

**result\_limit=\<n\>**

Example:

**result\_limit=50**

This options specifies the number of page entries displayed by default
in various cgi's. To display all entries by default set this value to 0.
Default is 50.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.8

**Convert user name to lowercase**

Format:

**lowercase\_user\_name=0|1**

Example:

**lowercase\_user\_name=1**

This option controls whether or not the username is converted to all
lowercase letters. Can be useful if the username is stored in Active
Directory (case-insensitive). Default is 1.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.8

**Set initial state of "Send notification" checkbox**

Format:

**send\_ack\_notifications=0|1**

Example:

**send\_ack\_notifications=1**

This option controls the initial state of the "Send Notification:"
checkbox when acknowledging a problem. Set this to 1 to send
notifications by default and 0 to not. This default value may be
overridden in the CGI dialogue. The default is 1 (send notifications on
problem acknowledgement).

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.9

**Set initial state of "Set Expire time" checkbox**

Format:

**set\_expire\_ack\_by\_default=0|1**

Example:

**set\_expire\_ack\_by\_default=1**

This option controls the initial state of the "Use Expire Time:"
checkbox when acknowledging a problem. Set this to 1 to use expiry by
default and 0 to not. The default is 0 (do not use auto-expiry). This
may be overridden in the CGI dialogue.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.9

**Enable Classic UI Standalone Installation**

Format:

**standalone\_installation=0|1**

Example:

**standalone\_installation=1**

This option controls if Classic UI is used as standalone setup. This
option was mainly implemented for Icinga 2 and its compat layer, but may
be helpful in other setups as well, like for a standalone dashboard next
to the default install. Enabling this option will make Classic UI ignore
the main\_config\_file setting and require all options to be set in
cgi.cfg instead. The section "Standalone (Icinga 2)" within the sample
config holds all needed settings.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.9

**Allow viewing partial service groups**

Format:

**show\_partial\_servicegroups=0|1**

Example:

**show\_partial\_servicegroups=1**

By default (meaning the directive is not present or disabled), a user
only sees a servicegroup and the hosts and services within it if she is
an authorised contact for all of the hosts and services of the group.
The behaviour can be changed using the directive
`show_partial_servicegroups=1`. When enabled, the
servicegroups overview will show a partial listing of hosts and services
that the user is an authorised contact for within each servicegroup. It
will also add the string "(Partial Servicegroups Enabled)" to the top of
the Servicegroup Overview to help prevent any confusion over whether the
option is in use or not. However for privacy reasons, servicegroups that
are only showing a partial listing are not specifically indicated.

**Disable CSRF protection for command cgi**

Format:

**disable\_cmd\_cgi\_csrf\_protection=0|1**

Example:

**disable\_cmd\_cgi\_csrf\_protection=1**

By default (meaning the directive is not present or disabled), a command
submitted by an external program (like Nagstamon) accessing cmd.cgi
directly will be rejected to protect against CSRF attacks (Cross-Site
Request Forgery). Enable (=1) this option only if you need this
functionality.



![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.11

**Exclude display of custom variable names**

Format:

**exclude\_customvar\_name=\<name1[,name2,...]|\*\>**

Example:

**exclude\_customvar\_name=\<password\>**

Custom variables are visible in the Classic UI (as of Icinga 1.11). Due
to the fact that some names contain sensitive information it should be
possible to hide it from the user. The directive
"exclude\_customvar\_name" specifies a comma-separated list of strings.
Variable names containing these strings will not be displayed.
Specifying "\*" instead of a list will exclude all custom variable
names.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.11

**Exclude display of custom variable values**

Format:

**exclude\_customvar\_value=\<value1[,value2,...]|\*\>**

Example:

**exclude\_customvar\_value=\<secret\>**

Custom variables are visible in the Classic UI (as of Icinga 1.11). Due
to the fact that some values contain sensitive information it should be
possible to hide it from the user. The directive
"exclude\_customvar\_value" specifies a comma-separated list of strings.
Variable values containing these strings will not be displayed.
Specifying "\*" instead of a list will exclude all custom variable
values.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.11

**Sort status data by default**

Format:

**sort\_status\_data\_by\_default=\<0|1\>**

Example:

**sort\_status\_data\_by\_default=\<0\>**

This option forces status.cgi to sort status data by default. Data will
be sorted ascending. First by host name and then by service description.
This is helpful if status data in status.dat is not sorted properly.
This can occur especially if you use Icinga2. By default this options is
switched off (0) to avoid possible higher cpu load in huge environments.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.12

**State of stickiness of acknowledgements**

Format:

**set\_sticky\_acknowledgment=\<0|1\>**

Example:

**set\_sticky\_acknowledgment=\<0\>**

This option controls the initial state of the "Sticky Acknowledgment:"
checkbox when acknowledging a problem. Set this to 1 to force stickiness
by default and 0 to not. The default is 1 (ACKs are sticky). This may be
overridden in the CGI dialogue.

![[Note]](../images/note.png)

Note

This option is available starting with Icinga 1.12

* * * * *

[Prev](customobjectvars.md) | [Up](ch03.md) | [Next](ch04.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
