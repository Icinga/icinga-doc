[Prev](extcommands.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](eventhandlers.md)

* * * * *

7.2. List of External Commands
------------------------------

Below you will find descriptions of each external command. It is quite
easy to send external commands to Icinga and you only need to change the
last line of the example code to use a different command (so we omitted
these lines in the description).

A [list of the available commands](cgiparams.md#cgiparams-commands)
can be found in the section about CGI parameters as well.

*Example:*

<pre><code>
 #!/bin/sh
 # Adjust variables to fit your environment as necessary.

 now=`date +%s`
 commandfile='/usr/local/icinga/var/rw/icinga.cmd'

 /bin/printf "[%lu] ACKNOWLEDGE_HOST_PROBLEM;Host1;1;1;1;John Doe;Some comment\n" $now > $commandfile
</code></pre>

**ACKNOWLEDGE\_HOST\_PROBLEM**

`ACKNOWLEDGE_HOST_PROBLEM;`\<host\_name\>;\<sticky\>;\<notify\>;\<persistent\>;\<author\>;\<comment\>

Allows you to acknowledge the current problem for the specified host. By
acknowledging the current problem, future notifications (for the same
host state) are disabled.

If the "sticky" option is set to two (2), the acknowledgement will
remain until the host recovers (returns to an UP state). Otherwise the
acknowledgement will automatically be removed when the host changes
state.

If the "notify" option is set to one (1), a notification will be sent
out to contacts indicating that the current host problem has been
acknowledged, if set to null (0) there will be no notification.

If the "persistent" option is set to one (1), the comment associated
with the acknowledgement will remain even after the host recovers.

**ACKNOWLEDGE\_HOST\_PROBLEM\_EXPIRE**

`ACKNOWLEDGE_HOST_PROBLEM_EXPIRE;`\<host\_name\>;\<sticky\>;\<notify\>;\<persistent\>;\<timestamp\>;\<author\>;\<comment\>

Allows you to define the time (seconds since the UNIX epoch) when the
acknowledgement will expire (will be deleted).

**ACKNOWLEDGE\_SVC\_PROBLEM**

`ACKNOWLEDGE_SVC_PROBLEM;`\<host\_name\>;\<service\_description\>;\<sticky\>;\<notify\>;\<persistent\>;\<author\>;\<comment\>

Allows you to acknowledge the current problem for the specified service.
By acknowledging the current problem, future notifications (for the same
servicestate) are disabled.

If the "sticky" option is set to two (2), the acknowledgement will
remain until the service recovers (returns to an OK state). Otherwise
the acknowledgement will automatically be removed when the service
changes state.

If the "notify" option is set to one (1), a notification will be sent
out to contacts indicating that the current service problem has been
acknowledged, if set to null (0) there will be no notification.

If the "persistent" option is set to one (1), the comment associated
with the acknowledgement will remain even after the service recovers.

**ACKNOWLEDGE\_SVC\_PROBLEM\_EXPIRE**

`ACKNOWLEDGE_SVC_PROBLEM_EXPIRE;`\<host\_name\>;\<service\_description\>;\<sticky\>;\<notify\>;\<persistent\>;\<timestamp\>;\<author\>;\<comment\>

Allows you to define the time (seconds since the UNIX epoch) when the
acknowledgement will expire (will be deleted).

**ADD\_HOST\_COMMENT**

`ADD_HOST_COMMENT;`\<host\_name\>;\<persistent\>;\<author\>;\<comment\>

Adds a comment to a particular host. If the "persistent" field is set to
zero (0), the comment will be deleted the next time Icinga is restarted.
Otherwise, the comment will persist across program restarts until it is
deleted manually.

**ADD\_SVC\_COMMENT**

`ADD_SVC_COMMENT;`\<host\_name\>;\<service\_description\>;\<persistent\>;\<author\>;\<comment\>

Adds a comment to a particular service. If the "persistent" field is set
to zero (0), the comment will be deleted the next time Icinga is
restarted. Otherwise, the comment will persist across program restarts
until it is deleted manually.

**CHANGE\_CONTACT\_HOST\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_CONTACT_HOST_NOTIFICATION_TIMEPERIOD;`\<contact\_name\>;\<notification\_timeperiod\>

Changes the host notification timeperiod for a particular contact to
what is specified by the "notification\_timeperiod" option. The
"notification\_timeperiod" option should be the short name of the
timeperiod that is to be used as the contact's host notification
timeperiod. The timeperiod must have been configured in Icinga before it
was last (re)started.

**CHANGE\_CONTACT\_MODATTR**

`CHANGE_CONTACT_MODATTR;`\<contact\_name\>;\<value\>

This command changes the modified attributes value for the specified
contact. Modified attributes values are used by Icinga to determine
which object properties should be retained across program restarts.
Thus, modifying the value of the attributes can affect data retention.
This is an advanced option and should only be used by people who are
intimately familiar with the data retention logic in Icinga.

**CHANGE\_CONTACT\_MODHATTR**

`CHANGE_CONTACT_MODHATTR;`\<contact\_name\>;\<value\>

This command changes the modified host attributes value for the
specified contact. Modified attributes values are used by Icinga to
determine which object properties should be retained across program
restarts. Thus, modifying the value of the attributes can affect data
retention. This is an advanced option and should only be used by people
who are intimately familiar with the data retention logic in Icinga.

**CHANGE\_CONTACT\_MODSATTR**

`CHANGE_CONTACT_MODSATTR;`\<contact\_name\>;\<value\>

This command changes the modified service attributes value for the
specified contact. Modified attributes values are used by Icinga to
determine which object properties should be retained across program
restarts. Thus, modifying the value of the attributes can affect data
retention. This is an advanced option and should only be used by people
who are intimately familiar with the data retention logic in Icinga.

**CHANGE\_CONTACT\_SVC\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_CONTACT_SVC_NOTIFICATION_TIMEPERIOD;`\<contact\_name\>;\<notification\_timeperiod\>

Changes the service notification timeperiod for a particular contact to
what is specified by the "notification\_timeperiod" option. The
"notification\_timeperiod" option should be the short name of the
timeperiod that is to be used as the contact's service notification
timeperiod. The timeperiod must have been configured in Icinga before it
was last (re)started.

**CHANGE\_CUSTOM\_CONTACT\_VAR**

`CHANGE_CUSTOM_CONTACT_VAR;`\<contact\_name\>;\<varname\>;\<varvalue\>

Changes the value of a custom contact variable.

**CHANGE\_CUSTOM\_HOST\_VAR**

`CHANGE_CUSTOM_HOST_VAR;`\<host\_name\>;\<varname\>;\<varvalue\>

Changes the value of a custom host variable.

**CHANGE\_CUSTOM\_SVC\_VAR**

`CHANGE_CUSTOM_SVC_VAR;`\<host\_name\>;\<service\_description\>;\<varname\>;\<varvalue\>

Changes the value of a custom service variable.

**CHANGE\_GLOBAL\_HOST\_EVENT\_HANDLER**

`CHANGE_GLOBAL_HOST_EVENT_HANDLER;`\<event\_handler\_command\>

Changes the global host event handler command to be that specified by
the "event\_handler\_command" option. The "event\_handler\_command"
option specifies the short name of the command that should be used as
the new host event handler. The command must have been configured in
Icinga before it was last (re)started.

**CHANGE\_GLOBAL\_SVC\_EVENT\_HANDLER**

`CHANGE_GLOBAL_SVC_EVENT_HANDLER;`\<event\_handler\_command\>

Changes the global service event handler command to be that specified by
the "event\_handler\_command" option. The "event\_handler\_command"
option specifies the short name of the command that should be used as
the new service event handler. The command must have been configured in
Icinga before it was last (re)started.

**CHANGE\_HOST\_CHECK\_COMMAND**

`CHANGE_HOST_CHECK_COMMAND;`\<host\_name\>;\<check\_command\>

Changes the check command for a particular host to be that specified by
the "check\_command" option. The "check\_command" option specifies the
short name of the command that should be used as the new host check
command. The command must have been configured in Icinga before it was
last (re)started.

**CHANGE\_HOST\_CHECK\_TIMEPERIOD**

`CHANGE_HOST_CHECK_TIMEPERIOD;`\<host\_name\>;\<timeperiod\>

Changes the valid check period for the specified host.

**CHANGE\_HOST\_EVENT\_HANDLER**

`CHANGE_HOST_EVENT_HANDLER;`\<host\_name\>;\<event\_handler\_command\>

Changes the event handler command for a particular host to be that
specified by the "event\_handler\_command" option. The
"event\_handler\_command" option specifies the short name of the command
that should be used as the new host event handler. The command must have
been configured in Icinga before it was last (re)started.

**CHANGE\_HOST\_MODATTR**

`CHANGE_HOST_MODATTR;`\<host\_name\>;\<value\>

This command changes the modified attributes value for the specified
host. Modified attributes values are used by Icinga to determine which
object properties should be retained across program restarts. Thus,
modifying the value of the attributes can affect data retention. This is
an advanced option and should only be used by people who are intimately
familiar with the data retention logic in Icinga.

**CHANGE\_HOST\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_HOST_NOTIFICATION_TIMEPERIOD;`\<host\_name\>;\<notification\_timeperiod\>

Changes the notification timeperiod for a particular host to what is
specified by the "notification\_timeperiod" option. The
"notification\_timeperiod" option should be the short name of the
timeperiod that is to be used as the service notification timeperiod.
The timeperiod must have been configured in Icinga before it was last
(re)started.

**CHANGE\_MAX\_HOST\_CHECK\_ATTEMPTS**

`CHANGE_MAX_HOST_CHECK_ATTEMPTS;`\<host\_name\>;\<check\_attempts\>

Changes the maximum number of check attempts (retries) for a particular
host.

**CHANGE\_MAX\_SVC\_CHECK\_ATTEMPTS**

`CHANGE_MAX_SVC_CHECK_ATTEMPTS;`\<host\_name\>;\<service\_description\>;\<check\_attempts\>

Changes the maximum number of check attempts (retries) for a particular
service.

**CHANGE\_NORMAL\_HOST\_CHECK\_INTERVAL**

`CHANGE_NORMAL_HOST_CHECK_INTERVAL;`\<host\_name\>;\<check\_interval\>

Changes the normal (regularly scheduled) check interval for a particular
host.

**CHANGE\_NORMAL\_SVC\_CHECK\_INTERVAL**

`CHANGE_NORMAL_SVC_CHECK_INTERVAL;`\<host\_name\>;\<service\_description\>;\<check\_interval\>

Changes the normal (regularly scheduled) check interval for a particular
service

**CHANGE\_RETRY\_HOST\_CHECK\_INTERVAL**

`CHANGE_RETRY_HOST_CHECK_INTERVAL;`\<host\_name\>;\<check\_interval\>

Changes the retry check interval for a particular host.

**CHANGE\_RETRY\_SVC\_CHECK\_INTERVAL**

`CHANGE_RETRY_SVC_CHECK_INTERVAL;`\<host\_name\>;\<service\_description\>;\<check\_interval\>

Changes the retry check interval for a particular service.

**CHANGE\_SVC\_CHECK\_COMMAND**

`CHANGE_SVC_CHECK_COMMAND;`\<host\_name\>;\<service\_description\>;\<check\_command\>

Changes the check command for a particular service to be that specified
by the "check\_command" option. The "check\_command" option specifies
the short name of the command that should be used as the new service
check command. The command must have been configured in Icinga before it
was last (re)started.

**CHANGE\_SVC\_CHECK\_TIMEPERIOD**

`CHANGE_SVC_CHECK_TIMEPERIOD;`\<host\_name\>;\<service\_description\>;\<check\_timeperiod\>

Changes the check timeperiod for a particular service to what is
specified by the "check\_timeperiod" option. The "check\_timeperiod"
option should be the short name of the timeperod that is to be used as
the service check timeperiod. The timeperiod must have been configured
in Icinga before it was last (re)started.

**CHANGE\_SVC\_EVENT\_HANDLER**

`CHANGE_SVC_EVENT_HANDLER;`\<host\_name\>;\<service\_description\>;\<event\_handler\_command\>

Changes the event handler command for a particular service to be that
specified by the "event\_handler\_command" option. The
"event\_handler\_command" option specifies the short name of the command
that should be used as the new service event handler. The command must
have been configured in Icinga before it was last (re)started.

**CHANGE\_SVC\_MODATTR**

`CHANGE_SVC_MODATTR;`\<host\_name\>;\<service\_description\>;\<value\>

This command changes the modified attributes value for the specified
service. Modified attributes values are used by Icinga to determine
which object properties should be retained across program restarts.
Thus, modifying the value of the attributes can affect data retention.
This is an advanced option and should only be used by people who are
intimately familiar with the data retention logic in Icinga.

**CHANGE\_SVC\_NOTIFICATION\_TIMEPERIOD**

`CHANGE_SVC_NOTIFICATION_TIMEPERIOD;`\<host\_name\>;\<service\_description\>;\<notification\_timeperiod\>

Changes the notification timeperiod for a particular service to what is
specified by the "notification\_timeperiod" option. The
"notification\_timeperiod" option should be the short name of the
timeperiod that is to be used as the service notification timeperiod.
The timeperiod must have been configured in Icinga before it was last
(re)started.

**DEL\_ALL\_HOST\_COMMENTS**

`DEL_ALL_HOST_COMMENTS;`\<host\_name\>

Deletes all comments associated with a particular host.

**DEL\_ALL\_SVC\_COMMENTS**

`DEL_ALL_SVC_COMMENTS;`\<host\_name\>;\<service\_description\>

Deletes all comments associated with a particular service.

**DEL\_HOST\_COMMENT**

`DEL_HOST_COMMENT;`\<comment\_id\>

Deletes a host comment. The id number of the comment that is to be
deleted must be specified.

**DEL\_DOWNTIME\_BY\_HOST\_NAME**

`DEL_DOWNTIME_BY_HOST_NAME;`\<host\_name\>[;\<servicedesc\>[;\<starttime\>[;\<commentstring\>]]]

Deletes the host downtime entry and associated services for the host
whose host\_name matches the "host\_name" argument. If the downtime is
currently in effect, the host will come out of scheduled downtime (as
long as there are no other overlapping active downtime entries). Please
note that you can add more (optional) "filters" to limit the scope.

![[Note]](../images/note.png)

Note

Changes provided by the [Opsview](http://www.opsview.com/) team.

**DEL\_DOWNTIME\_BY\_HOSTGROUP\_NAME**

`DEL_DOWNTIME_BY_HOSTGROUP_NAME;`\<hostgroup\_name\>[;\<hostname\>[;\<servicedesc\>[;\<starttime\>[;\<commentstring\>]]]]

Deletes the host downtime entries and associated services of all hosts
of the host group matching the "hostgroup\_name" argument. If the
downtime is currently in effect, the host will come out of scheduled
downtime (as long as there are no other overlapping active downtime
entries). Please note that you can add more (optional) "filters" to
limit the scope.

![[Note]](../images/note.png)

Note

Changes provided by the [Opsview](http://www.opsview.com/) team.

**DEL\_DOWNTIME\_BY\_START\_TIME\_COMMENT**

`DEL_DOWNTIME_BY_START_TIME_COMMENT;`\<start
time[;comment\_string]\>

Deletes downtimes with start times matching the timestamp specified by
the "start time" argument and an optional comment string.

![[Note]](../images/note.png)

Note

Changes provided by the [Opsview](http://www.opsview.com/) team.

**DEL\_HOST\_DOWNTIME**

`DEL_HOST_DOWNTIME;`\<downtime\_id\>

Deletes the host downtime entry that has an ID number matching the
"downtime\_id" argument. If the downtime is currently in effect, the
host will come out of scheduled downtime (as long as there are no other
overlapping active downtime entries).

**DEL\_SVC\_COMMENT**

`DEL_SVC_COMMENT;`\<comment\_id\>

Deletes a service comment. The id number of the comment that is to be
deleted must be specified.

**DEL\_SVC\_DOWNTIME**

`DEL_SVC_DOWNTIME;`\<downtime\_id\>

Deletes the service downtime entry that has an ID number matching the
"downtime\_id" argument. If the downtime is currently in effect, the
service will come out of scheduled downtime (as long as there are no
other overlapping active downtime entries).

**DELAY\_HOST\_NOTIFICATION**

`DELAY_HOST_NOTIFICATION;`\<host\_name\>;\<notification\_time\>

Delays the next notification for a particular host until
"notification\_time". The "notification\_time" argument is specified in
time\_t format (seconds since the UNIX epoch). Note that this will only
have an affect if the host stays in the same problem state that it is
currently in. If the host changes to another state, a new notification
may go out before the time you specify in the "notification\_time"
argument.

**DELAY\_SVC\_NOTIFICATION**

`DELAY_SVC_NOTIFICATION;`\<host\_name\>;\<service\_description\>;\<notification\_time\>

Delays the next notification for a parciular service until
"notification\_time". The "notification\_time" argument is specified in
time\_t format (seconds since the UNIX epoch). Note that this will only
have an affect if the service stays in the same problem state that it is
currently in. If the service changes to another state, a new
notification may go out before the time you specify in the
"notification\_time" argument.

**DISABLE\_ALL\_NOTIFICATIONS\_BEYOND\_HOST**

`DISABLE_ALL_NOTIFICATIONS_BEYOND_HOST;`\<host\_name\>

Disables notifications for all hosts and services "beyond" (e.g. on all
child hosts of) the specified host. The current notification setting for
the specified host is not affected.

**DISABLE\_CONTACT\_HOST\_NOTIFICATIONS**

`DISABLE_CONTACT_HOST_NOTIFICATIONS;`\<contact\_name\>

Disables host notifications for a particular contact.

**DISABLE\_CONTACT\_SVC\_NOTIFICATIONS**

`DISABLE_CONTACT_SVC_NOTIFICATIONS;`\<contact\_name\>

Disables service notifications for a particular contact.

**DISABLE\_CONTACTGROUP\_HOST\_NOTIFICATIONS**

`DISABLE_CONTACTGROUP_HOST_NOTIFICATIONS;`\<contactgroup\_name\>

Disables host notifications for all contacts in a particular
contactgroup.

**DISABLE\_CONTACTGROUP\_SVC\_NOTIFICATIONS**

`DISABLE_CONTACTGROUP_SVC_NOTIFICATIONS;`\<contactgroup\_name\>

Disables service notifications for all contacts in a particular
contactgroup.

**DISABLE\_EVENT\_HANDLERS**

`DISABLE_EVENT_HANDLERS`

Disables host and service event handlers on a program-wide basis.

**DISABLE\_FAILURE\_PREDICTION**

`DISABLE_FAILURE_PREDICTION`

Disables failure prediction on a program-wide basis.

**DISABLE\_FLAP\_DETECTION**

`DISABLE_FLAP_DETECTION`

Disables host and service flap detection on a program-wide basis.

**DISABLE\_HOST\_AND\_CHILD\_NOTIFICATIONS**

`DISABLE_HOST_AND_CHILD_NOTIFICATIONS;`\<host\_name\>

Disables notifications for the specified host, as well as all hosts
"beyond" (e.g. on all child hosts of) the specified host.

**DISABLE\_HOST\_CHECK**

`DISABLE_HOST_CHECK;`\<host\_name\>

Disables (regularly scheduled and on-demand) active checks of the
specified host.

**DISABLE\_HOST\_EVENT\_HANDLER**

`DISABLE_HOST_EVENT_HANDLER;`\<host\_name\>

Disables the event handler for the specified host.

**DISABLE\_HOST\_FLAP\_DETECTION**

`DISABLE_HOST_FLAP_DETECTION;`\<host\_name\>

Disables flap detection for the specified host.

**DISABLE\_HOST\_FRESHNESS\_CHECKS**

`DISABLE_HOST_FRESHNESS_CHECKS`

Disables freshness checks of all hosts on a program-wide basis.

**DISABLE\_HOST\_NOTIFICATIONS**

`DISABLE_HOST_NOTIFICATIONS;`\<host\_name\>

Disables notifications for a particular host.

**DISABLE\_HOST\_SVC\_CHECKS**

`DISABLE_HOST_SVC_CHECKS;`\<host\_name\>

Disables active checks of all services on the specified host.

**DISABLE\_HOST\_SVC\_NOTIFICATIONS**

`DISABLE_HOST_SVC_NOTIFICATIONS;`\<host\_name\>

Disables notifications for all services on the specified host.

**DISABLE\_HOSTGROUP\_HOST\_CHECKS**

`DISABLE_HOSTGROUP_HOST_CHECKS;`\<hostgroup\_name\>

Disables active checks for all hosts in a particular hostgroup.

**DISABLE\_HOSTGROUP\_HOST\_NOTIFICATIONS**

`DISABLE_HOSTGROUP_HOST_NOTIFICATIONS;`\<hostgroup\_name\>

Disables notifications for all hosts in a particular hostgroup. This
does not disable notifications for the services associated with the
command for that.

**DISABLE\_HOSTGROUP\_PASSIVE\_HOST\_CHECKS**

`DISABLE_HOSTGROUP_PASSIVE_HOST_CHECKS;`\<hostgroup\_name\>

Disables passive checks for all hosts in a particular hostgroup.

**DISABLE\_HOSTGROUP\_PASSIVE\_SVC\_CHECKS**

`DISABLE_HOSTGROUP_PASSIVE_SVC_CHECKS;`\<hostgroup\_name\>

Disables passive checks for all services associated with hosts in a
particular hostgroup.

**DISABLE\_HOSTGROUP\_SVC\_CHECKS**

`DISABLE_HOSTGROUP_SVC_CHECKS;`\<hostgroup\_name\>

Disables active checks for all services associated with hosts in a
particular hostgroup.

**DISABLE\_HOSTGROUP\_SVC\_NOTIFICATIONS**

`DISABLE_HOSTGROUP_SVC_NOTIFICATIONS;`\<hostgroup\_name\>

Disables notifications for all services associated with hosts in a
particular hostgroup. This does not disable notifications for the hosts
command for that.

**DISABLE\_NOTIFICATIONS**

`DISABLE_NOTIFICATIONS`

Disables host and service notifications on a program-wide basis.

**DISABLE\_NOTIFICATIONS\_EXPIRE\_TIME**

`DISABLE_NOTIFICATIONS_EXPIRE_TIME;<schedule_time>;<expire_time>`

\<schedule\_time\> has no effect currently, set it to current timestamp
in your scripts.

Disables host and service notifications on a program-wide basis, with
given expire time.

**DISABLE\_PASSIVE\_HOST\_CHECKS**

`DISABLE_PASSIVE_HOST_CHECKS;`\<host\_name\>

Disables acceptance and processing of passive host checks for the
specified host.

**DISABLE\_PASSIVE\_SVC\_CHECKS**

`DISABLE_PASSIVE_SVC_CHECKS;`\<host\_name\>;\<service\_description\>

Disables passive checks for the specified service.

**DISABLE\_PERFORMANCE\_DATA**

`DISABLE_PERFORMANCE_DATA`

Disables the processing of host and service performance data on a
program-wide basis.

**DISABLE\_SERVICE\_FRESHNESS\_CHECKS**

`DISABLE_SERVICE_FRESHNESS_CHECKS`

Disables freshness checks of all services on a program-wide basis.

**DISABLE\_SERVICEGROUP\_HOST\_CHECKS**

`DISABLE_SERVICEGROUP_HOST_CHECKS;`\<servicegroup\_name\>

Disables active checks for all hosts that have services that are members
of a particular servicegroup.

**DISABLE\_SERVICEGROUP\_HOST\_NOTIFICATIONS**

`DISABLE_SERVICEGROUP_HOST_NOTIFICATIONS;`\<servicegroup\_name\>

Disables notifications for all hosts that have services that are members
of a particular servicegroup.

**DISABLE\_SERVICEGROUP\_PASSIVE\_HOST\_CHECKS**

`DISABLE_SERVICEGROUP_PASSIVE_HOST_CHECKS;`\<servicegroup\_name\>

Disables the acceptance and processing of passive checks for all hosts
that have services that are members of a particular service group.

**DISABLE\_SERVICEGROUP\_PASSIVE\_SVC\_CHECKS**

`DISABLE_SERVICEGROUP_PASSIVE_SVC_CHECKS;`\<servicegroup\_name\>

Disables the acceptance and processing of passive checks for all
services in a particular servicegroup.

**DISABLE\_SERVICEGROUP\_SVC\_CHECKS**

`DISABLE_SERVICEGROUP_SVC_CHECKS;`\<servicegroup\_name\>

Disables active checks for all services in a particular servicegroup.

**DISABLE\_SERVICEGROUP\_SVC\_NOTIFICATIONS**

`DISABLE_SERVICEGROUP_SVC_NOTIFICATIONS;`\<servicegroup\_name\>

Disables notifications for all services that are members of a particular
servicegroup.

**DISABLE\_SVC\_CHECK**

`DISABLE_SVC_CHECK;`\<host\_name\>;\<service\_description\>

Disables active checks for a particular service.

**DISABLE\_SVC\_EVENT\_HANDLER**

`DISABLE_SVC_EVENT_HANDLER;`\<host\_name\>;\<service\_description\>

Disables the event handler for the specified service.

**DISABLE\_SVC\_FLAP\_DETECTION**

`DISABLE_SVC_FLAP_DETECTION;`\<host\_name\>;\<service\_description\>

Disables flap detection for the specified service.

**DISABLE\_SVC\_NOTIFICATIONS**

`DISABLE_SVC_NOTIFICATIONS;`\<host\_name\>;\<service\_description\>

Disables notifications for a particular service.

**ENABLE\_ALL\_NOTIFICATIONS\_BEYOND\_HOST**

`ENABLE_ALL_NOTIFICATIONS_BEYOND_HOST;`\<host\_name\>

Enables notifications for all hosts and services "beyond" (e.g. on all
child hosts of) the specified host. The current notification setting for
the specified host is not affected. Notifications will only be sent out
for these hosts and services if notifications are also enabled on a
program-wide basis.

**ENABLE\_CONTACT\_HOST\_NOTIFICATIONS**

`ENABLE_CONTACT_HOST_NOTIFICATIONS;`\<contact\_name\>

Enables host notifications for a particular contact.

**ENABLE\_CONTACT\_SVC\_NOTIFICATIONS**

`ENABLE_CONTACT_SVC_NOTIFICATIONS;`\<contact\_name\>

Disables service notifications for a particular contact.

**ENABLE\_CONTACTGROUP\_HOST\_NOTIFICATIONS**

`ENABLE_CONTACTGROUP_HOST_NOTIFICATIONS;`\<contactgroup\_name\>

Enables host notifications for all contacts in a particular
contactgroup.

**ENABLE\_CONTACTGROUP\_SVC\_NOTIFICATIONS**

`ENABLE_CONTACTGROUP_SVC_NOTIFICATIONS;`\<contactgroup\_name\>

Enables service notifications for all contacts in a particular
contactgroup.

**ENABLE\_EVENT\_HANDLERS**

`ENABLE_EVENT_HANDLERS`

Enables host and service event handlers on a program-wide basis.

**ENABLE\_FAILURE\_PREDICTION**

`ENABLE_FAILURE_PREDICTION`

Enables failure prediction on a program-wide basis.

**ENABLE\_FLAP\_DETECTION**

`ENABLE_FLAP_DETECTION`

Enables host and service flap detection on a program-wide basis.

**ENABLE\_HOST\_AND\_CHILD\_NOTIFICATIONS**

`ENABLE_HOST_AND_CHILD_NOTIFICATIONS;`\<host\_name\>

Enables notifications for the specified host, as well as all hosts
"beyond" (e.g. on all child hosts of) the specified host. Notifications
will only be sent out for these hosts if notifications are also enabled
on a program-wide basis.

**ENABLE\_HOST\_CHECK**

`ENABLE_HOST_CHECK;`\<host\_name\>

Enables (regularly scheduled and on-demand) active checks of the
specified host.

**ENABLE\_HOST\_EVENT\_HANDLER**

`ENABLE_HOST_EVENT_HANDLER;`\<host\_name\>

Enables the event handler for the specified host.

**ENABLE\_HOST\_FLAP\_DETECTION**

`ENABLE_HOST_FLAP_DETECTION;`\<host\_name\>

Enables flap detection for the specified host. In order for the flap
detection algorithms to be run for the host, flap detection must be
enabled on a program-wide basis as well.

**ENABLE\_HOST\_FRESHNESS\_CHECKS**

`ENABLE_HOST_FRESHNESS_CHECKS`

Enables freshness checks of all hosts on a program-wide basis.
Individual hosts that have freshness checks disabled will not be checked
for freshness.

**ENABLE\_HOST\_NOTIFICATIONS**

`ENABLE_HOST_NOTIFICATIONS;`\<host\_name\>

Enables notifications for a particular host. Notifications will be sent
out for the host only if notifications are enabled on a program-wide
basis as well.

**ENABLE\_HOST\_SVC\_CHECKS**

`ENABLE_HOST_SVC_CHECKS;`\<host\_name\>

Enables active checks of all services on the specified host.

**ENABLE\_HOST\_SVC\_NOTIFICATIONS**

`ENABLE_HOST_SVC_NOTIFICATIONS;`\<host\_name\>

Enables notifications for all services on the specified host. Note that
notifications will not be sent out if notifications are disabled on a
program-wide basis.

**ENABLE\_HOSTGROUP\_HOST\_CHECKS**

`ENABLE_HOSTGROUP_HOST_CHECKS;`\<hostgroup\_name\>

Enables active checks for all hosts in a particular hostgroup.

**ENABLE\_HOSTGROUP\_HOST\_NOTIFICATIONS**

`ENABLE_HOSTGROUP_HOST_NOTIFICATIONS;`\<hostgroup\_name\>

Enables notifications for all hosts in a particular hostgroup. This does
not enable notifications for the services associated with the hosts in
for that. In order for notifications to be sent out for these hosts,
notifications must be enabled on a program-wide basis as well.

**ENABLE\_HOSTGROUP\_PASSIVE\_HOST\_CHECKS**

`ENABLE_HOSTGROUP_PASSIVE_HOST_CHECKS;`\<hostgroup\_name\>

Enables passive checks for all hosts in a particular hostgroup.

**ENABLE\_HOSTGROUP\_PASSIVE\_SVC\_CHECKS**

`ENABLE_HOSTGROUP_PASSIVE_SVC_CHECKS;`\<hostgroup\_name\>

Enables passive checks for all services associated with hosts in a
particular hostgroup.

**ENABLE\_HOSTGROUP\_SVC\_CHECKS**

`ENABLE_HOSTGROUP_SVC_CHECKS;`\<hostgroup\_name\>

Enables active checks for all services associated with hosts in a
particular hostgroup.

**ENABLE\_HOSTGROUP\_SVC\_NOTIFICATIONS**

`ENABLE_HOSTGROUP_SVC_NOTIFICATIONS;`\<hostgroup\_name\>

Enables notifications for all services that are associated with hosts in
a particular hostgroup. This does not enable notifications for the hosts
command for that. In order for notifications to be sent out for these
services, notifications must be enabled on a program-wide basis as well.

**ENABLE\_NOTIFICATIONS**

`ENABLE_NOTIFICATIONS`

Enables host and service notifications on a program-wide basis.

**ENABLE\_PASSIVE\_HOST\_CHECKS**

`ENABLE_PASSIVE_HOST_CHECKS;`\<host\_name\>

Enables acceptance and processing of passive host checks for the
specified host.

**ENABLE\_PASSIVE\_SVC\_CHECKS**

`ENABLE_PASSIVE_SVC_CHECKS;`\<host\_name\>;\<service\_description\>

Enables passive checks for the specified service.

**ENABLE\_PERFORMANCE\_DATA**

`ENABLE_PERFORMANCE_DATA`

Enables the processing of host and service performance data on a
program-wide basis.

**ENABLE\_SERVICE\_FRESHNESS\_CHECKS**

`ENABLE_SERVICE_FRESHNESS_CHECKS`

Enables freshness checks of all services on a program-wide basis.
Individual services that have freshness checks disabled will not be
checked for freshness.

**ENABLE\_SERVICEGROUP\_HOST\_CHECKS**

`ENABLE_SERVICEGROUP_HOST_CHECKS;`\<servicegroup\_name\>

Enables active checks for all hosts that have services that are members
of a particular servicegroup.

**ENABLE\_SERVICEGROUP\_HOST\_NOTIFICATIONS**

`ENABLE_SERVICEGROUP_HOST_NOTIFICATIONS;`\<servicegroup\_name\>

Enables notifications for all hosts that have services that are members
of a particular servicegroup. In order for notifications to be sent out
for these hosts, notifications must also be enabled on a program-wide
basis.

**ENABLE\_SERVICEGROUP\_PASSIVE\_HOST\_CHECKS**

`ENABLE_SERVICEGROUP_PASSIVE_HOST_CHECKS;`\<servicegroup\_name\>

Enables the acceptance and processing of passive checks for all hosts
that have services that are members of a particular service group.

**ENABLE\_SERVICEGROUP\_PASSIVE\_SVC\_CHECKS**

`ENABLE_SERVICEGROUP_PASSIVE_SVC_CHECKS;`\<servicegroup\_name\>

Enables the acceptance and processing of passive checks for all services
in a particular servicegroup.

**ENABLE\_SERVICEGROUP\_SVC\_CHECKS**

`ENABLE_SERVICEGROUP_SVC_CHECKS;`\<servicegroup\_name\>

Enables active checks for all services in a particular servicegroup.

**ENABLE\_SERVICEGROUP\_SVC\_NOTIFICATIONS**

`ENABLE_SERVICEGROUP_SVC_NOTIFICATIONS;`\<servicegroup\_name\>

Enables notifications for all services that are members of a particular
servicegroup. In order for notifications to be sent out for these
services, notifications must also be enabled on a program-wide basis.

**ENABLE\_SVC\_CHECK**

`ENABLE_SVC_CHECK;`\<host\_name\>;\<service\_description\>

Enables active checks for a particular service.

**ENABLE\_SVC\_EVENT\_HANDLER**

`ENABLE_SVC_EVENT_HANDLER;`\<host\_name\>;\<service\_description\>

Enables the event handler for the specified service.

**ENABLE\_SVC\_FLAP\_DETECTION**

`ENABLE_SVC_FLAP_DETECTION;`\<host\_name\>;\<service\_description\>

Enables flap detection for the specified service. In order for the flap
detection algorithms to be run for the service, flap detection must be
enabled on a program-wide basis as well.

**ENABLE\_SVC\_NOTIFICATIONS**

`ENABLE_SVC_NOTIFICATIONS;`\<host\_name\>;\<service\_description\>

Enables notifications for a particular service. Notifications will be
sent out for the service only if notifications are enabled on a
program-wide basis as well.

**PROCESS\_FILE**

`PROCESS_FILE;`\<file\_name\>;\<delete\>

Directs Icinga to process all external commands that are found in the
file specified by the \<file\_name\> argument. If the \<delete\> option
is non-zero, the file will be deleted once it has been processes. If the
\<delete\> option is set to zero, the file is left untouched.

**PROCESS\_HOST\_CHECK\_RESULT**

`PROCESS_HOST_CHECK_RESULT;`\<host\_name\>;\<status\_code\>;\<plugin\_output\>

This is used to submit a passive check result for a particular host. The
"status\_code" indicates the state of the host check and should be one
of the following: 0=UP, 1=DOWN, 2=UNREACHABLE. The "plugin\_output"
argument contains the text returned from the host check, along with
optional performance data.

**PROCESS\_SERVICE\_CHECK\_RESULT**

`PROCESS_SERVICE_CHECK_RESULT;`\<host\_name\>;\<service\_description\>;\<return\_code\>;\<plugin\_output\>

This is used to submit a passive check result for a particular service.
The "return\_code" field should be one of the following: 0=OK,
1=WARNING, 2=CRITICAL, 3=UNKNOWN. The "plugin\_output" field contains
text output from the service check, along with optional performance
data.

**READ\_STATE\_INFORMATION**

`READ_STATE_INFORMATION`

Causes Icinga to load all current monitoring status information from the
state retention file. Normally, state retention information is loaded
when the Icinga process starts up and before it starts monitoring.
WARNING: This command will cause Icinga to discard all current
monitoring status information and use the information stored in state
retention file! Use with care.

**REMOVE\_HOST\_ACKNOWLEDGEMENT**

`REMOVE_HOST_ACKNOWLEDGEMENT;`\<host\_name\>

This removes the problem acknowledgement for a particular host. Once the
acknowledgement has been removed, notifications can once again be sent
out for the given host.

**REMOVE\_SVC\_ACKNOWLEDGEMENT**

`REMOVE_SVC_ACKNOWLEDGEMENT;`\<host\_name\>;\<service\_description\>

This removes the problem acknowledgement for a particular service. Once
the acknowledgement has been removed, notifications can once again be
sent out for the given service.

**RESTART\_PROCESS**

`RESTART_PROCESS`

Restarts the Icinga process.

**SAVE\_STATE\_INFORMATION**

`SAVE_STATE_INFORMATION`

Causes Icinga to save all current monitoring status information to the
state retention file. Normally, state retention information is saved
before the Icinga process shuts down and (potentially) at regularly
scheduled intervals. This command allows you to force Icinga to save
this information to the state retention file immediately. This does not
affect the current status information in the Icinga process.

**SCHEDULE\_AND\_PROPAGATE\_HOST\_DOWNTIME**

`SCHEDULE_AND_PROPAGATE_HOST_DOWNTIME;`\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for a specified host and all of its children (hosts).
If the "fixed" argument is set to one (1), downtime will start and end
at the times specified by the "start" and "end" arguments. Otherwise,
downtime will begin between the "start" and "end" times and last for
"duration" seconds. The "start" and "end" arguments are specified in
time\_t format (seconds since the UNIX epoch). The specified (parent)
host downtime can be triggered by another downtime entry if the
"trigger\_id" is set to the ID of another scheduled downtime entry. Set
the "trigger\_id" argument to zero (0) if the downtime for the specified
(parent) host should not be triggered by another downtime entry.

**SCHEDULE\_AND\_PROPAGATE\_TRIGGERED\_HOST\_DOWNTIME**

`SCHEDULE_AND_PROPAGATE_TRIGGERED_HOST_DOWNTIME;`\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for a specified host and all of its children (hosts).
If the "fixed" argument is set to one (1), downtime will start and end
at the times specified by the "start" and "end" arguments. Otherwise,
downtime will begin between the "start" and "end" times and last for
"duration" seconds. The "start" and "end" arguments are specified in
time\_t format (seconds since the UNIX epoch). Downtime for child hosts
are all set to be triggered by the downtime for the specified (parent)
host. The specified (parent) host downtime can be triggered by another
downtime entry if the "trigger\_id" is set to the ID of another
scheduled downtime entry. Set the "trigger\_id" argument to zero (0) if
the downtime for the specified (parent) host should not be triggered by
another downtime entry.

**SCHEDULE\_FORCED\_HOST\_CHECK**

`SCHEDULE_FORCED_HOST_CHECK;`\<host\_name\>;\<check\_time\>

Schedules a forced active check of a particular host at "check\_time".
The "check\_time" argument is specified in time\_t format (seconds since
the UNIX epoch). Forced checks are performed regardless of what time it
is (e.g. timeperiod restrictions are ignored) and whether or not active
checks are enabled on a host-specific or program-wide basis.

**SCHEDULE\_FORCED\_HOST\_SVC\_CHECKS**

`SCHEDULE_FORCED_HOST_SVC_CHECKS;`\<host\_name\>;\<check\_time\>

Schedules a forced active check of all services associated with a
particular host at "check\_time". The "check\_time" argument is
specified in time\_t format (seconds since the UNIX epoch). Forced
checks are performed regardless of what time it is (e.g. timeperiod
restrictions are ignored) and whether or not active checks are enabled
on a service-specific or program-wide basis.

**SCHEDULE\_FORCED\_SVC\_CHECK**

`SCHEDULE_FORCED_SVC_CHECK;`\<host\_name\>;\<service\_description\>;\<check\_time\>

Schedules a forced active check of a particular service at
"check\_time". The "check\_time" argument is specified in time\_t format
(seconds since the UNIX epoch). Forced checks are performed regardless
of what time it is (e.g. timeperiod restrictions are ignored) and
whether or not active checks are enabled on a service-specific or
program-wide basis.

**SCHEDULE\_HOST\_CHECK**

`SCHEDULE_HOST_CHECK;`\<host\_name\>;\<check\_time\>

Schedules the next active check of a particular host at "check\_time".
The "check\_time" argument is specified in time\_t format (seconds since
the UNIX epoch). Note that the host may not actually be checked at the
time you specify. This could occur for a number of reasons: active
checks are disabled on a program-wide or host-specific basis, the host
is already scheduled to be checked at an earlier time, etc. If you want
to force the host check to occur at the time you specify, look at the
SCHEDULE\_FORCED\_HOST\_CHECK command.

**SCHEDULE\_HOST\_DOWNTIME**

`SCHEDULE_HOST_DOWNTIME;`\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for a specified host. If the "fixed" argument is set
to one (1), downtime will start and end at the times specified by the
"start" and "end" arguments. Otherwise, downtime will begin between the
"start" and "end" times and last for "duration" seconds. The "start" and
"end" arguments are specified in time\_t format (seconds since the UNIX
epoch). The specified host downtime can be triggered by another downtime
entry if the "trigger\_id" is set to the ID of another scheduled
downtime entry. Set the "trigger\_id" argument to zero (0) if the
downtime for the specified host should not be triggered by another
downtime entry.

**SCHEDULE\_HOST\_SVC\_CHECKS**

`SCHEDULE_HOST_SVC_CHECKS;`\<host\_name\>;\<check\_time\>

Schedules the next active check of all services on a particular host at
"check\_time". The "check\_time" argument is specified in time\_t format
(seconds since the UNIX epoch). Note that the services may not actually
be checked at the time you specify. This could occur for a number of
reasons: active checks are disabled on a program-wide or
service-specific basis, the services are already scheduled to be checked
at an earlier time, etc. If you want to force the service checks to
occur at the time you specify, look at the
SCHEDULE\_FORCED\_HOST\_SVC\_CHECKS command.

**SCHEDULE\_HOST\_SVC\_DOWNTIME**

`SCHEDULE_HOST_SVC_DOWNTIME;`\<host\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for all services associated with a particular host.
If the "fixed" argument is set to one (1), downtime will start and end
at the times specified by the "start" and "end" arguments. Otherwise,
downtime will begin between the "start" and "end" times and last for
"duration" seconds. The "start" and "end" arguments are specified in
time\_t format (seconds since the UNIX epoch). The service downtime
entries can be triggered by another downtime entry if the "trigger\_id"
is set to the ID of another scheduled downtime entry. Set the
"trigger\_id" argument to zero (0) if the downtime for the services
should not be triggered by another downtime entry.

**SCHEDULE\_HOSTGROUP\_HOST\_DOWNTIME**

`SCHEDULE_HOSTGROUP_HOST_DOWNTIME;`\<hostgroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for all hosts in a specified hostgroup. If the
"fixed" argument is set to one (1), downtime will start and end at the
times specified by the "start" and "end" arguments. Otherwise, downtime
will begin between the "start" and "end" times and last for "duration"
seconds. The "start" and "end" arguments are specified in time\_t format
(seconds since the UNIX epoch). The host downtime entries can be
triggered by another downtime entry if the "trigger\_id" is set to the
ID of another scheduled downtime entry. Set the "trigger\_id" argument
to zero (0) if the downtime for the hosts should not be triggered by
another downtime entry.

**SCHEDULE\_HOSTGROUP\_SVC\_DOWNTIME**

`SCHEDULE_HOSTGROUP_SVC_DOWNTIME;`\<hostgroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for all services associated with hosts in a specified
hostgroup. If the "fixed" argument is set to one (1), downtime will
start and end at the times specified by the "start" and "end" arguments.
Otherwise, downtime will begin between the "start" and "end" times and
last for "duration" seconds. The "start" and "end" arguments are
specified in time\_t format (seconds since the UNIX epoch). The service
downtime entries can be triggered by another downtime entry if the
"trigger\_id" is set to the ID of another scheduled downtime entry. Set
the "trigger\_id" argument to zero (0) if the downtime for the services
should not be triggered by another downtime entry.

**SCHEDULE\_SERVICEGROUP\_HOST\_DOWNTIME**

`SCHEDULE_SERVICEGROUP_HOST_DOWNTIME;`\<servicegroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for all hosts that have services in a specified
servicegroup. If the "fixed" argument is set to one (1), downtime will
start and end at the times specified by the "start" and "end" arguments.
Otherwise, downtime will begin between the "start" and "end" times and
last for "duration" seconds. The "start" and "end" arguments are
specified in time\_t format (seconds since the UNIX epoch). The host
downtime entries can be triggered by another downtime entry if the
"trigger\_id" is set to the ID of another scheduled downtime entry. Set
the "trigger\_id" argument to zero (0) if the downtime for the hosts
should not be triggered by another downtime entry.

**SCHEDULE\_SERVICEGROUP\_SVC\_DOWNTIME**

`SCHEDULE_SERVICEGROUP_SVC_DOWNTIME;`\<servicegroup\_name\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for all services in a specified servicegroup. If the
"fixed" argument is set to one (1), downtime will start and end at the
times specified by the "start" and "end" arguments. Otherwise, downtime
will begin between the "start" and "end" times and last for "duration"
seconds. The "start" and "end" arguments are specified in time\_t format
(seconds since the UNIX epoch). The service downtime entries can be
triggered by another downtime entry if the "trigger\_id" is set to the
ID of another scheduled downtime entry. Set the "trigger\_id" argument
to zero (0) if the downtime for the services should not be triggered by
another downtime entry.

**SCHEDULE\_SVC\_CHECK**

`SCHEDULE_SVC_CHECK;`\<host\_name\>;\<service\_description\>;\<check\_time\>

Schedules the next active check of a specified service at "check\_time".
The "check\_time" argument is specified in time\_t format (seconds since
the UNIX epoch). Note that the service may not actually be checked at
the time you specify. This could occur for a number of reasons: active
checks are disabled on a program-wide or service-specific basis, the
service is already scheduled to be checked at an earlier time, etc. If
you want to force the service check to occur at the time you specify,
look at the SCHEDULE\_FORCED\_SVC\_CHECK command.

**SCHEDULE\_SVC\_DOWNTIME**

`SCHEDULE_SVC_DOWNTIME;`\<host\_name\>;\<service\_description\>;\<start\_time\>;\<end\_time\>;\<fixed\>;\<trigger\_id\>;\<duration\>;\<author\>;\<comment\>

Schedules downtime for a specified service. If the "fixed" argument is
set to one (1), downtime will start and end at the times specified by
the "start" and "end" arguments. Otherwise, downtime will begin between
the "start" and "end" times and last for "duration" seconds. The "start"
and "end" arguments are specified in time\_t format (seconds since the
UNIX epoch). The specified service downtime can be triggered by another
downtime entry if the "trigger\_id" is set to the ID of another
scheduled downtime entry. Set the "trigger\_id" argument to zero (0) if
the downtime for the specified service should not be triggered by
another downtime entry.

**SEND\_CUSTOM\_HOST\_NOTIFICATION**

`SEND_CUSTOM_HOST_NOTIFICATION;`\<host\_name\>;\<options\>;\<author\>;\<comment\>

Allows you to send a custom host notification. Very useful in dire
situations, emergencies or to communicate with all admins that are
responsible for a particular host. When the host notification is sent
out, the \$NOTIFICATIONTYPE\$ macro will be set to "CUSTOM". The
\<options\> field is a logical OR of the following integer values that
affect aspects of the notification that are sent out: 0 = No option
(default), 1 = Broadcast (send notification to all normal and all
escalated contacts for the host), 2 = Forced (notification is sent out
regardless of current time, whether or not notifications are enabled,
etc.), 4 = Increment current notification \# for the host (this is not
done by default for custom notifications). The contents of the comment
field is available in notification commands using the
\$NOTIFICATIONCOMMENT\$ macro.

**SEND\_CUSTOM\_SVC\_NOTIFICATION**

`SEND_CUSTOM_SVC_NOTIFICATION;`\<host\_name\>;\<service\_description\>;\<options\>;\<author\>;\<comment\>

Allows you to send a custom service notification. Very useful in dire
situations, emergencies or to communicate with all admins that are
responsible for a particular service. When the service notification is
sent out, the \$NOTIFICATIONTYPE\$ macro will be set to "CUSTOM". The
\<options\> field is a logical OR of the following integer values that
affect aspects of the notification that are sent out: 0 = No option
(default), 1 = Broadcast (send notification to all normal and all
escalated contacts for the service), 2 = Forced (notification is sent
out regardless of current time, whether or not notifications are
enabled, etc.), 4 = Increment current notification \# for the
service(this is not done by default for custom notifications). The
contents of the comment field is available in notification commands
using the \$NOTIFICATIONCOMMENT\$ macro.

**SET\_HOST\_NOTIFICATION\_NUMBER**

`SET_HOST_NOTIFICATION_NUMBER;`\<host\_name\>;\<notification\_number\>

Sets the current notification number for a particular host. A value of 0
indicates that no notification has yet been sent for the current host
problem. Useful for forcing an escalation (based on notification number)
or replicating notification information in redundant monitoring
environments. Notification numbers greater than zero have no noticeable
affect on the notification process if the host is currently in an UP
state.

**SET\_SVC\_NOTIFICATION\_NUMBER**

`SET_SVC_NOTIFICATION_NUMBER;`\<host\_name\>;\<service\_description\>;\<notification\_number\>

Sets the current notification number for a particular service. A value
of 0 indicates that no notification has yet been sent for the current
service problem. Useful for forcing an escalation (based on notification
number) or replicating notification information in redundant monitoring
environments. Notification numbers greater than zero have no noticeable
affect on the notification process if the service is currently in an OK
state.

**SHUTDOWN\_PROCESS**

`SHUTDOWN_PROCESS`

Shuts down the Icinga process.

**START\_ACCEPTING\_PASSIVE\_HOST\_CHECKS**

`START_ACCEPTING_PASSIVE_HOST_CHECKS`

Enables acceptance and processing of passive host checks on a
program-wide basis.

**START\_ACCEPTING\_PASSIVE\_SVC\_CHECKS**

`START_ACCEPTING_PASSIVE_SVC_CHECKS`

Enables passive service checks on a program-wide basis.

**START\_EXECUTING\_HOST\_CHECKS**

`START_EXECUTING_HOST_CHECKS`

Enables active host checks on a program-wide basis.

**START\_EXECUTING\_SVC\_CHECKS**

`START_EXECUTING_SVC_CHECKS`

Enables active checks of services on a program-wide basis.

**START\_OBSESSING\_OVER\_HOST**

`START_OBSESSING_OVER_HOST;`\<host\_name\>

Enables processing of host checks via the OCHP command for the specified
host.

**START\_OBSESSING\_OVER\_HOST\_CHECKS**

`START_OBSESSING_OVER_HOST_CHECKS`

Enables processing of host checks via the OCHP command on a program-wide
basis.

**START\_OBSESSING\_OVER\_SVC**

`START_OBSESSING_OVER_SVC;`\<host\_name\>;\<service\_description\>

Enables processing of service checks via the OCSP command for the
specified service.

**START\_OBSESSING\_OVER\_SVC\_CHECKS**

`START_OBSESSING_OVER_SVC_CHECKS`

Enables processing of service checks via the OCSP command on a
program-wide basis.

**STOP\_ACCEPTING\_PASSIVE\_HOST\_CHECKS**

`STOP_ACCEPTING_PASSIVE_HOST_CHECKS`

Disables acceptance and processing of passive host checks on a
program-wide basis.

**STOP\_ACCEPTING\_PASSIVE\_SVC\_CHECKS**

`STOP_ACCEPTING_PASSIVE_SVC_CHECKS`

Disables passive service checks on a program-wide basis.

**STOP\_EXECUTING\_HOST\_CHECKS**

`STOP_EXECUTING_HOST_CHECKS`

Disables active host checks on a program-wide basis.

**STOP\_EXECUTING\_SVC\_CHECKS**

`STOP_EXECUTING_SVC_CHECKS`

Disables active checks of services on a program-wide basis.

**STOP\_OBSESSING\_OVER\_HOST**

`STOP_OBSESSING_OVER_HOST;`\<host\_name\>

Disables processing of host checks via the OCHP command for the
specified host.

**STOP\_OBSESSING\_OVER\_HOST\_CHECKS**

`STOP_OBSESSING_OVER_HOST_CHECKS`

Disables processing of host checks via the OCHP command on a
program-wide basis.

**STOP\_OBSESSING\_OVER\_SVC**

`STOP_OBSESSING_OVER_SVC;`\<host\_name\>;\<service\_description\>

Disables processing of service checks via the OCSP command for the
specified service.

**STOP\_OBSESSING\_OVER\_SVC\_CHECKS**

`STOP_OBSESSING_OVER_SVC_CHECKS`

Disables processing of service checks via the OCSP command on a
program-wide basis.

* * * * *

[Prev](extcommands.md) | [Up](ch07.md) | [Next](eventhandlers.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
