![Icinga](../images/logofullsize.png "Icinga")

12.5. IDOUtils Database Model

[Prev](db_example-configs.md) 

Chapter 12. IDOUtils

 [Next](db_changes.md)

* * * * *

12.5. IDOUtils Database Model
-----------------------------

12.5.1. [Central Tables](db_model.md#dbm_ct)

12.5.2. [Debugging Tables](db_model.md#dbm_dt)

12.5.3. [Historical Tables](db_model.md#dbm_ht)

12.5.4. [Current Status Tables](db_model.md#statustables)

12.5.5. [Configuration Tables](db_model.md#dbm_cf)

This documentation is based on the NDOUtils database model documentation
by Ethan Galstad and altered to fit the changes necessary in IDOUtils.

**Introduction**

This documentation is still in flux, and there are undoubtably errors
present, so take everything you find here with a grain of salt. If you
have suggestions, changes, etc. for the documentation, please let us
know.

![[Important]](../images/important.png)

Important

Although we took care to be accurate there may be alterations in the
current code which aren't reflected here so if in doubt please take a
look at the actual code.

![[Note]](../images/note.png)

Note

The data types and field lenghts mentioned throughout the following
documentation show the definitions for MySQL. Oracle and PostgreSQL use
other data types and field lengths.

**Table Names**

The IDOUtils addon allows users to specify a custom prefix to each table
name in the database. By default, this prefix is set to "icinga\_" in
ido2db.cfg. The tables documented here are listed without any prefix.

![[Note]](../images/note.png)

Note

Due to limitations in Oracle the length of table names cannot exceed 30
characters so

-   The name of one table has been shortened:
    serviceescalation\_contactgroups -\> serviceescalationcontactgroups

-   The table prefix is ignored

**Keys**

Every table has a primary key (designated as "PK"). Most tables have a
unique key consisting of one ("UK") or more columns ("UKn" whereas n
shows the position in the key). Some tables have a non-unique key ("NK")
which may be composed of several columns as well ("NKn").

There are a lot of tables containing different information so the
description is divided into five parts:

-   [Central Tables](db_model.md#dbm_ct "12.5.1. Central Tables")

-   [Debugging Tables](db_model.md#dbm_dt "12.5.2. Debugging Tables")

-   [Historical
    Tables](db_model.md#dbm_ht "12.5.3. Historical Tables")

-   [Current Status Tables](db_model.md#dbm_cu)

-   [Configuration
    Tables](db_model.md#dbm_cf "12.5.5. Configuration Tables")

### 12.5.1. Central Tables

There are two "core" or "central" tables, described below, that are
referenced by nearly every table in the database. Read below for more
information.

*Table List*

-   [instances](db_model.md#dbm_instances)

-   [objects](db_model.md#dbm_objects)

*Relationship Diagram*

**Figure 12.14. Relationship of Central Tables**

![Relationship of Central Tables](../images/db_model_ct.png)

\

*Instance Table*

Description: This table is needed to ensure that multiple instances of
Icinga can store their configuration and status information in the same
database. Each instance represents a different Icinga
installation/process. A new instance will automatically be created when
the user specifies a new instance name (when running one of the IDOUtils
components) that does not already exist in the database.

Structure:

Field

Type

Notes

Key

instance\_id

SERIAL

Unique number identifying a distinct instance of Icinga

PK

instance\_name

VARCHAR(64)

Instance name, as passed to and used by IDOUtils components

 

instance\_description

VARCHAR(128)

Optional text describing the instance in more detail

 

*Objects Table*

Description: This table is used to store all current (and past) objects
that are (and have been) defined in your Icinga configuration files. Why
are the names of the objects stored in this table and not elsewhere?
Well, when you delete an object definition from your Icinga
configuration, that object will no longer appear in the object tables of
the database. Since you're still going to want to be able to run reports
for old hosts, service, etc., we store the name of the object here so
you're not completely baffled by the reports you get. :-)

Structure:

Field

Type

Notes

Values

Key

object\_id

SERIAL

A unique number identifying the object

 

PK

instance\_id

BIGINT unsigned

A number indicating the instance of Icinga to which the object belongs

 

 

objecttype\_id

BIGINT unsigned

A number indicating what type of object this is

1 = Host; 2 = Service; 3 = Host group; 4 = Service group; 5 = Host
escalation; 6 = Service escalation; 7 = Host dependency; 8 = Service
dependency; 9 = Timeperiod; 10 = Contact; 11 = Contact group; 12 =
Command; 13 = Extended host info (deprecated); 14 = Extended service
info (deprecated)

NK1

name1

VARCHAR(128)

The first name associated with the object definition, as used in your
Icinga configuration files

 

NK2

name2

VARCHAR(128)

The second name (if any) associated with the object definition, as used
in your Icinga configuration files. This field is only used for service
definitions which have a host name (name1 field) and service description
(name2 field)

 

NK3

is\_active

SMALLINT

A number indicating whether or not the object is currently defined in
your Icinga configuration files. If an object definition is removed from
your Icinga configuration files, it will remain in this table, but will
be marked as inactive

0 = Inactive; 1 = Active

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

### 12.5.2. Debugging Tables

There is currently only one table in the database that is used to hold
information that might be useful for debugging purposes. Read below for
more information.

*Table List*

-   [conninfo](db_model.md#dbm_conninfo)

Relationship Diagram

**Figure 12.15. Relationship of Debugging Tables**

![Relationship of Debugging Tables](../images/db_model_dt.png)

\

*Conninfo Table*

Description: This table is used to store debugging information regarding
the IDO2DB daemon and the user agents (e.g. LOG2DB, IDOMOD NEB module,
etc.) that connect to it. This information is probably only interesting
if you are attempting to debug connection problems.

Structure:

Field

Type

Notes

Values

Key

conninfo\_id

SERIAL

Unique number identifying the connection info record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga for which data
is being transmitted/processed

 

 

agent\_name

VARCHAR(32)

Text string identifying the user agent that is sending data to the
IDO2DB daemon

Typically "IDOMOD" or "LOG2IDO"

 

agent\_version

VARCHAR(8)

Text string identifying the version of the user agent that is sending
data

 

 

disposition

VARCHAR(16)

Text string identifying the disposition or type of data that is being
sent to the IDO2DB daemon

"REALTIME" if being sent directly from a running Icinga process or
"ARCHIVED" if being sent from a flat file

 

connect\_source

VARCHAR(16)

Text string identifying the method that the user agent is using to
connect to the IDO2DB daemon

"TCPSOCKET" or "UNIXSOCKET"

 

connect\_type

VARCHAR(16)

Text string identifying whether this connect was a new connection, or if
it was a reconnect due to an earlier communications failure between the
user agent and the IDO2DB daemon

"INITIAL" or "RECONNECT"

 

connect\_time

TIMESTAMP

The initial time the user agent connected to the daemon

 

 

disconnect\_time

TIMESTAMP

The time (if any) the user agent disconnect from the daemon

 

 

last\_checkin\_time

TIMESTAMP

The time that the user agent last checked in with the daemon to indicate
that it was still alive and sending data

 

 

data\_start\_time

TIMESTAMP

The timestamp of the first data that the user agent sent to the daemon

 

 

data\_end\_time

TIMESTAMP

The timestamp of the last (or latest) data that the user agent sent to
the daemon

 

 

bytes\_processed

BIGINT unsigned

The number of bytes of data that have been sent by the user agent and
processed by the daemon

 

 

lines\_processed

BIGINT unsigned

The number of lines of data that have been sent by the user agent and
processed by the daemon

 

 

entries\_processed

BIGINT unsigned

The number of data entries that have been sent by the user agent and
processed by the daemon

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

### 12.5.3. Historical Tables

**Historical Data Tables**

There are several tables in the database which are used to hold
"historical" information about Icinga and the hosts/services it is
monitoring or was monitoring at some point in the past. Keep in mind
that historical items may not necessarily be "old" - they could have
occurred 5 seconds ago, so the information used within these tables
could/should be used when reporting current status information. Links to
hosts/services which no longer exist in the Icinga configuration are
maintained due to references for these previous objects existing in the
objects table - this is by design.

*Table List*

-   [acknowledgements](db_model.md#dbm_acknowledgements)

-   [commenthistory](db_model.md#dbm_commenthistory)

-   [contactnotifications](db_model.md#dbm_contactnotifications)

-   [dbversion](db_model.md#dbm_dbversion)

-   [downtimehistory](db_model.md#dbm_downtimehistory)

-   [eventhandlers](db_model.md#dbm_eventhandlers)

-   [externalcommands](db_model.md#dbm_externalcommands)

-   [flappinghistory](db_model.md#dbm_flappinghistory)

-   [hostchecks](db_model.md#dbm_hostchecks)

-   [logentries](db_model.md#dbm_logentries)

-   [notifications](db_model.md#dbm_notifications)

-   [processevents](db_model.md#dbm_processevents)

-   [servicechecks](db_model.md#dbm_servicechecks)

-   [statehistory](db_model.md#dbm_statehistory)

-   [systemcommands](db_model.md#dbm_systemcommands)

*Relationship Diagram*

Notes: For clarity, the instances table (to which all these tables are
related) is not shown. There are 17 historical tables, so please excuse
the mess. :-)

**Figure 12.16. Relationship of Historical Tables**

![Relationship of Historical Tables](../images/db_model_ht.png)

\

*Acknowledgements Table*

Table Description: This table is used to store host and service
acknowledgements for historical purposes.

Structure:

Field

Type

Notes

Values

Key

acknowledgement\_id

SERIAL

Unique number identifying the acknowledgement record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

entry\_time

TIMESTAMP

Date and time the acknowledgement was entered

 

 

entry\_time\_usec

INT

Microsecond portion of acknowledgement entry time

 

 

acknowledgement\_type

SMALLINT

Indicates whether this is a host or service acknowledgement

0 = Host ack; 1 = Service ack

 

object\_id

BIGINT unsigned

The object id of the host or service this acknowledgement applies to

 

 

state

SMALLINT

Integer indicating the state the host or service was in when the
acknowledgement was made

Host acks: 0 = UP; 1 = DOWN; 2 = UNREACHABLE; Service acks: 0 = OK; 1 =
WARNING; 2 = CRTICAL; 3 = UNKNOWN

 

author\_name

VARCHAR(64)

Text field containing the name of the person who made the
acknowledgement

 

 

comment\_data

VARCHAR(255)

Text field containing notes on the acknowledgement

 

 

is\_sticky

SMALLINT

Indicates whether or not the acknowledgement is considered "sticky"

0 = Not sticky; 1 = Sticky

 

persistent\_comment

SMALLINT

Indicates whether or not the comment associated with the acknowledgement
is persistent

0 = Not persistent; 1 = Persistent

 

notify\_contacts

SMALLINT

Indicates whether or not contacts are to be notified of the
acknowledgement

0 = Don't notify; 1 = Notify

 

end\_time

TIMESTAMP

Date and time the acknowledgement was deleted

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Commenthistory Table*

Table Description: This table is used to store historical host and
service comments. Current comments will also appear in this table, but
it is recommended to use the comments table to retrieve a list of
current host and service comments.

Structure:

Field

Type

Notes

Values

Key

commenthistory\_id

SERIAL

Unique number identifying the comment record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

entry\_time

TIMESTAMP

Date and time the comment was entered

 

 

entry\_time\_usec

INT

Microsecond portion of comment entry time

 

 

comment\_type

SMALLINT

Indicates whether this is a host or service comment

1 = Host comment; 2 = Service comment

 

entry\_type

SMALLINT

Indicates how this comment came to be entered

1 = User; 2 = Scheduled downtime; 3 = Flapping; 4 = Acknowledgement

 

object\_id

BIGINT unsigned

The object id of the host or service this acknowledgement applies to

 

 

comment\_time

TIMESTAMP

Date and time associated with the comment

 

UK2

Internal\_comment\_id

BIGINT unsigned

The comment ID internal to the Icinga daemon, which may no longer be
valid or present

 

UK3

author\_name

VARCHAR(64)

Text field containing the name of the person who made the comment

 

 

comment\_data

VARCHAR(255)

Text field containing the comment

 

 

is\_persistent

SMALLINT

Indicates whether or not the comment is persistent

0 = Not persistent; 1 = Persistent

 

comment\_source

SMALLINT

Indicates the source of the comment

0 = Internal (Icinga); 1 = External (user)

 

expires

SMALLINT

Indicates whether or not the comment expires

0 = Doesn't expire; 1 = Expires

 

expiration\_time

TIMESTAMP

Date and time at which the comment expires

 

 

deletion\_time

TIMESTAMP

Date and time (if any) when the comment was deleted

 

 

deletion\_time\_usec

INT

Microsecond time (if any) when the comment was deleted

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Contactnotifications Table*

Description: This table is used to store a historical record of host and
service notifications that have been sent out to individual contacts.

Structure:

Field

Type

Notes

Values

Key

contactnotification\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

notification\_id

BIGINT unsigned

The id of the notification this record is associated with

 

 

contact\_object\_id

BIGINT unsigned

The object id of the contact this notification was send to

 

UK2

start\_time

TIMESTAMP

The date/time the notification to this contact was started

 

UK3

start\_time\_usec

INT

The microsecond portion of the time the notification started

 

UK4

end\_time

TIMESTAMP

The date/time the notification to this contact ended

 

 

end\_time\_usec

INT

The microsecond portion of the time the notification ended

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

notification\_id

notifications.notification\_id

contact\_object\_id

objects.object\_id

*Dbversion Table*

Description: This table is used to store version information about the
DB.

Structure:

Field

Type

Notes

Values

Key

dbversion\_id

SERIAL

Unique number identifying the record

 

PK

name

VARCHAR(10)

Name of the database

 

UK

version

VARCHAR(10)

Version number of the database

 

 

*Contactnotificationmethods Table*

Description: This table is used to store a historical record of commands
(methods) that were used to contact individuals about host and service
problems and recoveries.

Structure:

Field

Type

Notes

Values

Key

contactnotificationmethod\_id

INT

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

contactnotification\_id

INT

The id of the contact notification this record is associated with

 

UK2

start\_time

TIMESTAMP

The date/time the notification command started

 

UK3

start\_time\_usec

INT

The microsecond portion of the time the notification command started

 

UK4

end\_time

TIMESTAMP

The date/time the notification command ended

 

 

end\_time\_usec

INT

The microsecond portion of the time the notification command ended

 

 

command\_object\_id

INT

The id of the command that was used for the notification command

 

 

command\_args

VARCHAR

The arguments that were passed to the notification command

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

contactnotification\_id

contactnotifications.contactnotification\_id

command\_object\_id

objects.object\_id

*Downtimehistory Table*

Description: This table is used to store a historical record of
scheduled host and service downtime

Structure:

Field

Type

Notes

Values

Key

downtimehistory\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

downtime\_type

SMALLINT

A number identifying what type of scheduled downtime this is

1 = Service downtime; 2 = Host downtime

 

object\_id

BIGINT unsigned

The object id of the host or service this scheduled downtime is
associated with

 

UK2

entry\_time

TIMESTAMP

The date/time the scheduled downtime was entered/submitted

 

UK3

author\_name

VARCHAR(64)

The name of the person who scheduled this downtime

 

 

comment\_data

VARCHAR(255)

A comment, as entered by the author, associated with the scheduled
downtime

 

 

internal\_downtime\_id

BIGINT unsigned

A number (internal to the Icinga daemon) associated with the scheduled
downtime

 

UK4

triggered\_by\_id

BIGINT unsigned

The id of another scheduled downtime entry that scheduled downtime is
optionally triggered by. Non-triggered downtimes will have a value of 0
in this field

 

 

is\_fixed

SMALLINT

A number indicating whether or not this scheduled downtime is fixed
(i.e. its start and end times are exactly what they are listed below as)
or if it is flexible

0 = Flexible (Not fixed); 1 = Fixed

 

duration

SMALLINT

The number of seconds that the scheduled downtime should last. This is
only used by Icinga is the downtime is flexible. If the downtime is
fixed, this value should reflect the difference between the start and
end times

 

 

scheduled\_start\_time

TIMESTAMP

The date/time the scheduled downtime is supposed to start. If this is a
flexible (non-fixed) downtime, this refers to the earliest possible time
that the downtime can start

 

 

scheduled\_end\_time

TIMESTAMP

The date/time the scheduled downtime is supposed to end. If this is a
flexible (non-fixed) downtime, this refers to the last possible time
that the downtime can start

 

 

was\_started

SMALLINT

Number indicated whether or not the scheduled downtime was started. Some
flexible downtimes may never actually start if the host/service they are
associated with never enter a problem state

0 = Was not started; 1 = Was started

 

actual\_start\_time

TIMESTAMP

The date/time the scheduled downtime was actually started (if
applicable)

 

 

actual\_start\_time\_usec

INT

Microsecond portion of the actual start time

 

 

actual\_end\_time

TIMESTAMP

The date/time the scheduled downtime actually ended

 

 

actual\_end\_time\_usec

INT

Microsecond portion of the actual end time

 

 

was\_cancelled

SMALLINT

Number indicating whether or not the scheduled downtime was cancelled
before it ended normally

0 = Not cancelled; 1 = Cancelled early

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

triggered\_by\_id

[downtimehistory.]downtimehistory\_id

*Eventhandlers Table*

Description: This table is used to store a historical record of host and
service event handlers that have been run. NOTE: This table is usually
trimmed periodically by the IDO2DB daemon, as it would otherwise grow to
an enormous size.

Structure:

Field

Type

Notes

Values

Key

eventhandler\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

eventhandler\_type

SMALLINT

A number indicating what type of event handler this is

0 = Host event handler; 1 = Service event handler; 2 = Global host event
handler; 3 = Global service event handler

 

object\_id

BIGINT unsigned

The object id of the host or service associated with this event handler

 

UK2

state

SMALLINT

Number indicating the state of host or service when the event handler
was run.

For host event handlers: 0 = UP; 1 = DOWN; 2 = UNREACHABLE; For service
event handlers:; 0 = OK; 1 = WARNING; 2 = CRITICAL; 3 = UNKNOWN

 

state\_type

SMALLINT

Number indicating the state type of the host or service when the event
handler was run

0 = SOFT state; 1 = HARD state

 

start\_time

TIMESTAMP

The date/time the event handler started

 

UK3

start\_time\_usec

INT

The microsecond portion of the time the event handler started

 

UK4

end\_time

TIMESTAMP

The date/time the event handler ended

 

 

end\_time\_usec

INT

The microsecond portion of the time the event handler ended

 

 

command\_object\_id

BIGINT unsigned

The id of the command that was run

 

 

command\_args

VARCHAR(255)

Arguments to the event handler command that was run

 

 

command\_line

VARCHAR(1024)

Fully expanded command line of the event handler that was run

 

 

timeout

SMALLINT

Timeout value in seconds for the event handler

 

 

early\_timeout

SMALLINT

Number indicating whether or not the event handler command timed out

0 = Did NOT time out. 1 = Timed out

 

execution\_time

DOUBLE

Time in seconds that the event handler command was running

 

 

return\_code

SMALLINT

The return code value from the event handler command

 

 

output

VARCHAR(255)

The first line of text output (if any) from the event handler command

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

command\_object\_id

objects.object\_id

*Externalcommands Table*

Description: This table is used to store a historical record of external
commands that have been processed by the Icinga daemon.

Structure:

Field

Type

Notes

Values

Key

externalcommand\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

entry\_time

TIMESTAMP

The date/time the external command was processed

 

 

command\_type

SMALLINT

A number indicating what type of external command this is. Each external
command has its own type or "id"

See Icinga source code

 

command\_name

VARCHAR(128)

The name of the command that was processed

 

 

command\_args

VARCHAR(255)

Optional arguments that were specified with the command.

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

*Flappinghistory Table*

Table Description: This table is used to store a historical record of
host and service flapping events.

Structure:

Field

Type

Notes

Values

Key

flappinghistory\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

event\_time

TIMESTAMP

The date/time of the flapping event

 

 

event\_time\_usec

INT

The microsecond portion of the time of the flapping event

 

 

event\_type

SMALLINT

The type of flapping event indicated by this record

1000 = Flapping started; 1001 = Flapping stopped

 

reason\_type

SMALLINT

Number indicating the reason (if any) that the host or service stopped
flapping. This is only valid if this records is a flapping stopped event
(see event\_type field)

1 = Flapping stopped normally 2 = Flapping was disabled

 

flapping\_type

SMALLINT

Number indicating whether this flapping event relates to a host or
service

0 = Host 1 = Service

 

object\_id

BIGINT unsigned

The id of the host or service associated with the flapping event

 

 

percent\_state\_change

DOUBLE

The percent state change of the host or service at the time of the event

 

 

low\_threshold

DOUBLE

The low flapping percent state change threshold (as configured in
Icinga) of the host or service

 

 

high\_threshold

DOUBLE

The high flapping percent state change threshold (as configured in
Icinga) of the host or service

 

 

comment\_time

TIMESTAMP

The date/time of the comment associated with the flapping event

 

 

internal\_comment\_id

BIGINT unsigned

The number (internal to the Icinga daemon) of the comment associated
with the flapping event.

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Hostchecks Table*

Description: This table is used to store a historical record of "raw"
and "processed" host checks. What's the difference between raw and
processed host checks? Raw checks are the raw results from a host check
command that gets executed. Icinga must do some processing on the raw
host check results before it can determine the real state of the host.
Host checks (plugins) cannot directly determine whether a host is DOWN
or UNREACHABLE - only Icinga can do that. In fact, host checks return
the same status codes as service checks (OK, WARNING, UNKNOWN, or
CRITICAL). Icinga processes the raw host check result to determine the
true state of the host (UP, DOWN, or UNREACHABLE). These "processed"
checks contain the the true state of the host. NOTE: This table is
usually trimmed periodically by the IDO2DB daemon, as it would otherwise
grow to an enormous size.

Structure:

Field

Type

Notes

Values

Key

hostcheck\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

host\_object\_id

BIGINT unsigned

The id of the host this check applies to

 

UK2

check\_type

SMALLINT

Number indicating whether this is an active or passive check

0 = Active check 1 = Passive check

 

is\_raw\_check

SMALLINT

Number indicating whether this is a "raw" or "processed" host check

0 = Processed check; 1 = Raw check

 

current\_check\_attempt

SMALLINT

Current check attempt of the host

 

 

max\_check\_attempts

SMALLINT

Max check attempts (as defined in Icinga) for the host

 

 

state

SMALLINT

Current state of the host

For raw checks: 0 = UP 1 = DOWN/UNREACHABLE; For processed checks: 0 =
UP 1 = DOWN 2 = UNREACHABLE

 

state\_type

SMALLINT

Number indicating whether the host is in a soft or hard state

0 = SOFT state 1 = HARD state

 

start\_time

TIMESTAMP

The date/time the host check was started

 

UK3

start\_time\_usec

INT

Microsecond portion of the time the host check was started

 

UK4

end\_time

TIMESTAMP

The date/time the host check was completed

 

 

end\_time\_usec

INT

Microsecond portion of the time the host check was completed

 

 

command\_object\_id

BIGINT unsigned

The id of the command that was used to perform the host check

 

 

command\_args

VARCHAR(255)

The arguments that were passed to the host check command

 

 

command\_line

VARCHAR(1024)

The fully expanded command line that was used to check the host

 

 

timeout

SMALLINT

Number of seconds before the host check command would time out

 

 

early\_timeout

SMALLINT

Number indicating whether or not the host check timed out early

0 = Did NOT timeout 1 = Timed out

 

execution\_time

DOUBLE

Number of seconds it took to execute the host check

 

 

latency

DOUBLE

Number of seconds the host check was "late" in being executed. Scheduled
host checks can have a latency, but on-demand checks will have a latency
of 0. Latency is the difference between the time the check was scheduled
to be executed and the time it was actually executed. For passive checks
it is the different between the timestamp on the passive host check
result (submitted through the external command file) and the time the
passive check result was processed by Icinga

 

 

return\_code

SMALLINT

The return code from the host check command

 

 

output

VARCHAR(255)

Status text output from the host check command (first line)

 

 

long\_output

TEXT

Status text output from the host check command (consecutive lines)

 

 

perfdata

TEXT

Optional performance data returned from the host check command.

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

host\_object\_id

objects.object\_id

command\_object\_id

objects.object\_id

*Logentries Table*

Description: This table is used to store a historical record of entries
from the Icinga log.

Structure:

Field

Type

Notes

Values

Key

logentry\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

object\_id

BIGINT unsigned

The id of the host/service that entry was caused for (NULL if not
provided)

 

 

logentry\_time

TIMESTAMP

The date/time associated with the log entry. This is NOT necessarily the
same as the date/time that Icinga wrote the log entry to the log file
(see below)

 

 

entry\_time

TIMESTAMP

The date/time that Icinga wrote this log entry to the log file

 

 

entry\_time\_usec

INT

The microsecond portion of the time that Icinga wrote this log entry

 

 

logentry\_type

INT

A number indicating what general type of log entry this is

See Icinga source code

 

logentry\_data

VARCHAR(255)

The log entry that was written out to the log file

 

 

realtime\_data

SMALLINT

A number used internally by the IDO2DB daemon

 

 

inferred\_data\_extracted

SMALLINT

A number used internally by the IDO2DB daemon.

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Notifications Table*

Description: This table is used to store a historical record of host and
service notifications that have been sent out. For each notification,
one or more contacts receive notification messages. These contact
notifications are stored in the contactnotifications table.

Structure:

Field

Type

Notes

Values

Key

notification\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

notification\_type

SMALLINT

Number indicating whether this is a host or service notification

0 = Host notification 1 = Service notification

 

notification\_reason

SMALLINT

Number indicating the type of or reason for the notification

0 = Normal notification; 1 = Problem acknowledgement; 2 = Flapping
started; 3 = Flapping stopped; 4 = Flapping was disabled; 5 = Downtime
started; 6 = Downtime ended; 7 = Downtime was cancelled; 99 = Custom
notification

 

object\_id

BIGINT unsigned

The id of the host or service this notification applies to

 

UK2

start\_time

TIMESTAMP

The date/time the notification was started

 

UK3

start\_time\_usec

INT

Microsecond portion of the time the notification was started

 

UK4

end\_time

TIMESTAMP

The date/time the notification ended

 

 

end\_time\_usec

INT

Microsecond portion of the time the notification ended

 

 

state

SMALLINT

Number indicating the state of the host or service when the notification
was sent out.

For Host Notifications: 0 = UP; 1 = DOWN; 2 = CRITICAL; For Service
Notifications: 0 = OK; 1 = WARNING; 2 = CRITICAL; 3 = UNKNOWN

 

output

VARCHAR(255)

The current plugin (text) output of the host or service when the
notification was sent out (first line)

 

 

long\_output

TEXT

The current plugin (text) output of the host or service when the
notification was sent out (consecutive lines)

 

 

escalated

SMALLINT

Number indicating whether or not this notification was escalated or not

0 = NOT escalated; 1 = Escalated

 

contacts\_notified

SMALLINT

Number of contacts that were notified about the host or service as part
of this notification.

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Processevents Table*

Description: This table is used to store a historical record of Icinga
process events (program starts, restarts, shutdowns, etc.).

Structure:

Field

Type

Notes

Values

Key

processevent\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

event\_type

SMALLINT

Number indicating the type of process event that occurred.

100 = Process start; 101 = Process daemonized; 102 = Process restart;
103 = Process shutdown; 104 = Prelaunch; 105 = Event loop start; 106 =
Event loop end

 

event\_time

TIMESTAMP

The date/time that the event occurred

 

 

event\_time\_usec

INT

The microsecond portion of the time the event occurred

 

 

process\_id

INT

The current process ID (PID) of the Icinga daemon

 

 

program\_name

VARCHAR(16)

"Icinga"

 

 

program\_version

VARCHAR(20)

Version of Icinga that is running (e.g. "1.0")

 

 

program\_date

VARCHAR(10)

Release date of Icinga

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

*Servicechecks Table*

Description: This table is used to store a historical record of service
checks that have been performed. NOTE: This table is usually trimmed
periodically by the IDO2DB daemon, as it would otherwise grow to an
enormous size.

Structure:

Field

Type

Notes

Values

Key

servicecheck\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

service\_object\_id

BIGINT unsigned

The id of the service this record refers to

 

UK2

check\_type

SMALLINT

Number indicating whether this was an active or a passive service check

0 = Active check; 1 = Passive check

 

current\_check\_attempt

SMALLINT

Number indicating the current check attempt for the service

 

 

max\_check\_attempts

SMALLINT

Number indicating the max number of check attempts for the service

 

 

state

SMALLINT

Number indicating the current state of the service

0 = OK 1 = WARNING; 2 = CRITICAL; 3 = UNKNOWN

 

state\_type

SMALLINT

Number indicating the current state type of the service

0 = SOFT state; 1 = HARD state

 

start\_time

TIMESTAMP

The date/time the service check was started

 

UK3

start\_time\_usec

INT

Microsecond portion of the time the service check was started

 

UK4

end\_time

TIMESTAMP

The date/time the service check ended

 

 

end\_time\_usec

INT

Microsecond portion of the time the service check ended

 

 

command\_object\_id

BIGINT unsigned

The id of the command that was run to perform the service check

 

 

command\_args

VARCHAR(255)

The arguments passed to the command that was run to perform the service
check

 

 

command\_line

VARCHAR(1024)

The fully expanded command line that was executed to perform the service
check

 

 

timeout

SMALLINT

Number of seconds before the service check command was scheduled to
timeout

 

 

early\_timeout

SMALLINT

Number indicating whether or not the service check timed out

0 = Did NOT timeout 1 = Timed out

 

execution\_time

DOUBLE

Number of seconds it took to execute the service check command

 

 

latency

DOUBLE

Number of seconds the service check was "late" in being executed. For
active checks this is the difference between the scheduled service check
time and the time the check actually occurred. For passive checks this
is the difference between the timestamp on the passive check result
(submitted through the external command file) and the time the passive
check result was picked up by the Icinga daemon for processing

 

 

return\_code

SMALLINT

The return code from the service check command

 

 

output

VARCHAR(255)

The status output that was returned from the service check command
(first line)

 

 

long\_output

TEXT

The status output that was returned from the service check command
(consecutive lines)

 

 

perfdata

TEXT

Optional performance data that was returned from the service check
command

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

service\_object\_id

objects.object\_id

command\_object\_id

objects.object\_id

*Statehistory Table*

Description: This table is used to store a historical record of host and
service state changes.

Structure:

Field

Type

Notes

Values

Key

statehistory\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

state\_time

TIMESTAMP

The date/time that the state change occurred

 

 

state\_time\_usec

INT

The microsecond portion of the time the state change occurred

 

 

object\_id

BIGINT unsigned

The id of the host or service object this state change applies to

 

 

state\_change

SMALLINT

Number indicating whether or not a state change occurred for the host or
service

0 = No state change; 1 = State change

 

state

SMALLINT

Number indicating the current state of the host or service

For Hosts: 0 = UP; 1 = DOWN; 2 = UNREACHABLE; For Services: 0 = OK; 1 =
WARNING; 2 = CRITICAL; 3 = UNKNOWN

 

state\_type

SMALLINT

Number indicating whether the service is in a soft or hard state

0 = SOFT state; 1 = HARD state

 

current\_check\_attempt

SMALLINT

Number indicating the current check attempt for the host or service

 

 

max\_check\_attempts

SMALLINT

Number indicating the max check attempts (as configured in Icinga) for
the host or service

 

 

last\_state

SMALLINT

Number indicating the last state (whether hard or soft) of the host or
service (if available)

For Hosts: -1 = unavailable; 0 = UP; 1 = DOWN; 2 = UNREACHABLE; For
Services: -1 = unavailable; 0 = OK; 1 = WARNING; 2 = CRITICAL; 3 =
UNKNOWN

 

last\_hard\_state

SMALLINT

Number indicating the last hard state of the host or service (if
available)

For Hosts: -1 = unavailable; 0 = UP; 1 = DOWN; 2 = UNREACHABLE; For
Services: -1 unavailable; 0 = OK; 1 = WARNING; 2 = CRITICAL

 

output

VARCHAR(255)

The current plugin/status output of the host or service (first line)

 

 

long\_output

TEXT

The current plugin/status output of the host or service (consecutive
lines)

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Systemcommands Table*

Description: This table is used to store a historical record of system
commands that are run by the Icinga daemon. Note that each event
handler, notification, OCSP command, etc. requires that Icinga execute a
system command. NOTE: This table is usually trimmed periodically by the
IDO2DB daemon, as it would otherwise grow to an enormous size.

Structure:

Field

Type

Notes

Values

Key

systemcommand\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

start\_time

TIMESTAMP

The date/time the command was executed

 

UK2

start\_time\_usec

INT

The microsecond portion of the time the command was executed

 

UK3

end\_time

TIMESTAMP

The date/time the command finished executing

 

 

end\_time\_usec

INT

The microsecond portion of the time the command finished executing

 

 

command\_line

VARCHAR(1024)

Fully expanded command line that was executed

 

 

timeout

SMALLINT

Number of seconds before the command should timeout

 

 

early\_timeout

SMALLINT

Number indicating whether or not the command timed out early

0 = Did NOT timeout; 1 = Timed out

 

execution\_time

DOUBLE

Number of seconds it took to execute the command

 

 

return\_code

SMALLINT

Return code of the command

 

 

output

VARCHAR(255)

First line of text output (if available) that was returned from the
command

 

 

long\_output

TEXT

Consecutive lines of text output (if available) that were returned from
the command

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

### 12.5.4.  Current Status Tables

There are several tables in the database which are used to hold current
status information on the Icinga process and all hosts and services that
it is monitoring. Entries in these tables are cleared whenever the
Icinga daemon (belonging to the same instance) (re)starts

*Table List*

-   [comments](db_model.md#dbm_comments)

-   [customvariablestatus](db_model.md#dbm_customvariablestatus)

-   [hoststatus](db_model.md#dbm_hoststatus)

-   [programstatus](db_model.md#dbm_programstatus)

-   [runtimevariables](db_model.md#dbm_runtimevariables)

-   [scheduleddowntime](db_model.md#dbm_scheduleddowntime)

-   [servicestatus](db_model.md#dbm_servicestatus)

-   [contactstatus](db_model.md#dbm_contactstatus)

*Relationship Diagram*Notes: To reduce clutter, the links to the
instances table (to which all these tables are related) is not shown.

**Figure 12.17. Relationship of Current Status Tables**

![Relationship of Current Status Tables](../images/db_model_cu.png)

\

*Comments Table*

Description: This table is used to store current host and service
comments. Historical comments can be found in the commenthistory table.

Structure:

Field

Type

Notes

Values

Key

comment\_id

SERIAL

Unique number identifying the comment record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

entry\_time

TIMESTAMP

Date and time the comment was entered

 

 

entry\_time\_usec

INT

Microsecond portion of comment entry time

 

 

comment\_type

SMALLINT

Indicates whether this is a host or service comment

1 = Host comment; 2 = Service comment

 

entry\_type

SMALLINT

Indicates how this comment came to be entered

1 = User; 2 = Scheduled downtime; 3 = Flapping; 4 = Acknowledgement

 

object\_id

BIGINT unsigned

The object id of the host or service this acknowledgement applies to

 

 

comment\_time

TIMESTAMP

Date and time associated with the comment

 

UK2

internal\_comment\_id

INT

The comment ID internal to the Icinga daemon

 

UK3

author\_name

VARCHAR(64)

Text field containing the name of the person who made the comment

 

 

comment\_data

VARCHAR(255)

Text field containing the comment

 

 

is\_persistent

SMALLINT

Indicates whether or not the comment is persistent

0 = Not persistent; 1 = Persistent

 

comment\_source

SMALLINT

Indicates the source of the comment

0 =internal (Icinga); 1 = External (user)

 

expires

SMALLINT

Indicates whether or not the comment expires

0 = Doesn't expire; 1 = Expires

 

expiration\_time

TIMESTAMP

Date and time at which the comment expires.

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Customvariablestatus Table*

Description: This table is used to store the current state/values of all
custom host, service, and contact variables. Custom variables are only
support in Icinga or Nagios 3.x and higher, so this table will be empty
for Nagios 2.x.

Structure:

Field

Type

Notes

Values

Key

customvariablestatus\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

object\_id

BIGINT unsigned

The object id of the host or service this acknowledgement applies to

 

UK1

status\_update\_time

TIMESTAMP

Date and time the status of the custom variable was last updated

 

 

has\_been\_modified

SMALLINT

Indiciates whether the value of the custom variable has been modified
(during runtime) from its original value in the config files

0 = Has not been modified; 1 = Has been modified

 

varname

VARCHAR(255)

Text field containing the name of the custom variable

 

UK2, NK

varvalue

VARCHAR(255)

Text field containing the value of the custom variable

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

object\_id

objects.object\_id

*Hoststatus Table*

Description: This table is used to store the current status of hosts
that are being monitored.

Structure:

Field

Type

Notes

Values

Key

hoststatus\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

host\_object\_id

BIGINT unsigned

The object id of the host this status entry is associated with

 

U1

status\_update\_time

TIMESTAMP

Date and time the status data was updated

 

 

output

VARCHAR(255)

Plugin output from the latest host check (first line)

 

 

long\_output

TEXT

Plugin output from the latest host check (consecutive lines)

 

 

perfdata

TEXT

Performance data from the latest host check

 

 

check\_source

TEXT

Optional check result source.

 

 

current\_state

SMALLINT

Number indicating the current state of the host

0 = UP; 1 = DOWN; 2 = UNREACHABLE

 

has\_been\_checked

SMALLINT

Number indicating whether or not the host has been checked yet

0 = Not checked; 1 = Checked

 

should\_be\_scheduled

SMALLINT

Number indicating whether or not checks should be regularly scheduled
for this host

0 = Not scheduled; 1 = Scheduled

 

current\_check\_attempt

SMALLINT

Number indicating the current check attempt of the host. This is only
interesting during soft host states

 

 

max\_check\_attempts

SMALLINT

Number indicating how many maximum check attempts will be made to
determine the hard state of the host

 

 

last\_check

TIMESTAMP

Time the host was last checked

 

 

next\_check

TIMESTAMP

The host is scheduled to be checked next. Will be set to the epoch if
the host is not scheduled for another check

 

 

check\_type

SMALLINT

Number indicating if the last host check was an active or passive check

0 = Active; 1 = Passive

 

last\_state\_change

TIMESTAMP

Time the host last had a hard or soft state change. Will be set to the
epoch if the host has not changed state

 

 

last\_hard\_state\_change

TIMESTAMP

The host last had a hard state change. Will be setup to the epoch if the
host has not changed state

 

 

last\_time\_up

TIMESTAMP

Time the host was last in an UP state (if ever)

 

 

last\_time\_down

TIMESTAMP

Time the host was last in a DOWN state (if ever)

 

 

last\_time\_unreachable

TIMESTAMP

Time the host was last in an UNREACHABLE state (if ever)

 

 

state\_type

SMALLINT

Number indicating the type of state the host is in

0 = SOFT state; 1 = HARD state

 

last\_notification

TIMESTAMP

Time a notification was last sent out for the host (if ever)

 

 

next\_notification

TIMESTAMP

Next possible time that a notification can be sent out for the host

 

 

no\_more\_notifications

SMALLINT

Number indicating whether or not more notifications can be sent out
about the current host problem

0 = Send notifications; 1 = Do not send notifications

 

notifications\_enabled

SMALLINT

Number indicating whether or not notifications are enabled for this host

0 = Notifications disabled; 1 = Notifications enabled

 

problem\_has\_been\_acknowledged

SMALLINT

Number indicating whether or not the current host problem has been
acknowledged

0 = Not acknowledged; 1 = Acknowledged

 

acknowledgement\_type

SMALLINT

Number indicating the type of acknowledgement associated with the host

0 = None; 1 = Normal; 2 = Sticky

 

current\_notification\_number

SMALLINT

Number indicating the current notification number for the current host
problem. This number gets reset to 0 when the host recovers

 

 

passive\_checks\_enabled

SMALLINT

Number indicating whether or not passive checks are enabled for this
host

0 = Disabled; 1 = Enabled

 

active\_checks\_enabled

SMALLINT

Number indicating whether or not active checks are enabled for this host

0 = Disabled; 1 = Enabled

 

event\_handler\_enabled

SMALLINT

Number indicating whether or not the host's event handler is enabled

0 = Disabled; 1 = Enabled

 

flap\_detection\_enabled

SMALLINT

Number indicating whether or not flap detection is enabled for this host

0 = Disabled; 1 = Enabled

 

is\_flapping

SMALLINT

Number indicating whether or not the host is currently flapping

0 = Not flapping; 1 = Flapping

 

percent\_state\_change

DOUBLE

Number indicating the current percent state change (a measure of
stability/volatility) for the host

 

 

latency

DOUBLE

Number of seconds that the host check was "late" in being executed. The
different between the checks scheduled time and the time it was actually
checked

 

 

execution\_time

DOUBLE

Number of seconds it took to perform the last check of the host

 

 

scheduled\_downtime\_depth

SMALLINT

Number indicating how many periods of scheduled

0 = Not in scheduled dowtime downtime are currently active for this
host; \>0 = In scheduled downtime

 

failure\_prediction\_enabled

SMALLINT

Number indicating whether or not failure prediction (not yet
implemented) is enabled for this host

0 = Disabled; 1 = Enabled

 

process\_performance\_data

SMALLINT

Number indicating whether or not performance data should be processed
for this host

0 = Disabled; 1 = Enabled

 

obsess\_over\_host

SMALLINT

Number indicating whether or not this host should be obsessed over

0 = Do not obsess; 1 = Obsess

 

modified\_host\_attributes

INT

Number indicating which attributes of the host have been modified during
runtime. Used by the retention data routines

 

 

event\_handler

VARCHAR

The current event handler command associated with the host

 

 

check\_command

VARCHAR

The current check command associated with the host

 

 

check\_interval

DOUBLE

Number of seconds between normal checks of the host

 

 

retry\_interval

DOUBLE

Number of seconds between retry checks of the host

 

 

check\_timeperiod\_object\_id

BIGINT unsigned

Unique number of the timeperiod object currently used for determining
times the host can be checked

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

host\_object\_id

objects.object\_id

timeperiod\_object\_id

objects.object\_id

*Programstatus Table*

Description: This table stored status information on the currently (or
previously) running Icinga process/daemon.

Structure:

Field

Type

Notes

Values

Key

programstatus\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

U1

status\_update\_time

TIMESTAMP

Date and time the status of the process was last updated

 

 

program\_start\_time

TIMESTAMP

Date and time the Icinga process was started

 

 

program\_end\_time

TIMESTAMP

Date and time the Icinga process as stopped (if currently not running)

 

 

is\_currently\_running

SMALLINT

Indicates whether or not the Icinga process is currently running

0 = Process is not running; 1 = Process is running

 

process\_id

BIGINT unsigned

The processed ID (PID) of the Icinga process

 

 

daemon\_mode

SMALLINT

Indicates whether Icinga is running as a foreground process or a daemon

0 = Foreground process; 1 = Daemon

 

last\_command\_check

TIMESTAMP

Date and time the Icinga process last checked external commands

 

 

last\_log\_rotation

TIMESTAMP

Date and time the log file was last rotated (if at all)

 

 

notifications\_enabled

SMALLINT

Indicates whether or not notifications are enabled

0 = Disabled; 1 = Enabled

 

active\_service\_checks\_enabled

SMALLINT

Indicates whether or not active service checks are enabled

0 = Disabled; 1 = Enabled

 

passive\_service\_checks\_enabled

SMALLINT

Indicates whether or not passive service checks are enabled

0 = Disabled; 1 = Enabled

 

active\_host\_checks\_enabled

SMALLINT

Indicates whether or not active host checks are enabled

0 = Disabled; 1 = Enabled

 

passive\_host\_checks\_enabled

SMALLINT

Indicates whether or not passive host checks are enabled

0 = Disabled; 1 = Enabled

 

event\_handlers\_enabled

SMALLINT

Indicates whether or not event handlers are enabled

0 = Disabled; 1 = Enabled

 

flap\_detection\_enabled

SMALLINT

Indicates whether or not flap detection is enabled

0 = Disabled; 1 = Enabled

 

failure\_prediction\_enabled

SMALLINT

Indicates whether or not failure prediction is enabled

0 = Disabled; 1 = Enabled

 

process\_performance\_data

SMALLINT

Indicates whether or not performance data is enabled/being processed

0 = Disabled; 1 = Enabled

 

obsess\_over\_hosts

SMALLINT

Indicates whether or not hosts are being obsessed over

0 = Disabled; 1 = Enabled

 

obsess\_over\_services

SMALLINT

Indicates whether or not services are being obsessed over

0 = Disabled; 1 = Enabled

 

modified\_host\_attributes

INT

Indicates what (if any) host-related program status variables have been
modified during runtime

See Icinga source code for values

 

modified\_service\_attributes

INT

Indicates what (if any) service-related program status variables have
been modified during runtime

See Icinga source code for values

 

global\_host\_event\_handler

VARCHAR(255)

Text field indicating the current global host event handler command that
is being used.

 

 

global\_service\_event\_handlers

VARCHAR(255)

Text field indicating the current global service event handler command
that is being used

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

*Runtimevariables Table*

Table Description: This table is used to store some runtime variables
from the Icinga process that may be useful to you. The only variables
currently stored in this table are some initial variables calculated at
startup, but more variables may be stored here in future versions.

Structure:

Field

Type

Notes

Values

Key

runtimevariable\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

varname

VARCHAR(64)

Text field containing the name of the variable

 

UK2

varvalue

VARCHAR(255)

Text field containing the value of the variable

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

*Scheduleddowntime Table*

Description: This table is used to store current host and service
downtime, which may either be current in effect or scheduled to begin at
a future time. Historical scheduled downtime information can be found in
the downtimehistory table.

Structure:

Field

Type

Notes

Values

Key

scheduleddowntime\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

downtime\_type

SMALLINT

Indicates whether this is a host or service downtime entry

1 = Service downtime; 2 = Host downtime

 

object\_id

BIGINT unsigned

The object id of the host or service this downtime applies to

 

UK2

entry\_time

TIMESTAMP

Date and time this downtime was entered

 

UK3

author\_name

VARCHAR(64)

Text field containing the name of the person who created this scheduled
downtime

 

 

comment\_data

VARCHAR(255)

Text field containing information about this scheduled downtime (as
entered by the user)

 

 

internal\_downtime\_id

BIGINT unsigned

The ID number (internal to the Icinga daemon) associated with this
scheduled downtime entry

 

UK4

triggered\_by\_id

BIGINT unsigned

The internal Icinga ID number (if any) of another scheduled downtime
entry that this downtime is "triggered" (started) by. If this field is
nonzero, this is a triggered downtime entry, otherwise it is not

 

 

is\_fixed

SMALLINT

Indicates whether this is a "fixed" scheduled downtime entry (that
should start and end at the start and end times indicated) or a
"flexible" entry that can start at a variable time

0 = Flexible (not fixed) 1 = Fixed

 

duration

SMALLINT

Indicates the number of seconds that the scheduled downtime should last.
This is usually only needed if this is "flexible" downtime, which can
start at a variable time, but lasts for the specified duration

 

 

scheduled\_start\_time

TIMESTAMP

Date and time that the downtime is scheduled to start if it is "fixed"
dowtime. If this is a "flexible" downtime entry, this is the first
possible time the downtime can start

 

 

scheduled\_end\_time

TIMESTAMP

Date and time the downtime is scheduled to end if it is "fixed"
downtime. If this is a "flexible" downtime entry, this is the last
possible time the downtime can start

 

 

was\_started

SMALLINT

Indicates whether or not the downtime was started (is currently \#FIXME)

0 = Not started (inactive) 1 = Started (active)

 

actual\_start\_time

TIMESTAMP

Date and time the scheduled downtime was actually started

 

 

actual\_start\_time\_usec

INT

Microsecond portion of time the scheduled downtime was actually started

 

 

Relationships:

Field

Foreign Key

 

instance\_id

instances.instance\_id

 

object\_id

objects.object\_id

 

*Servicestatus Table*

Description: This table is used to store current status information for
all services that are being monitored.

Structure:

Field

Type

Notes

Values

Key

servicestatus\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

service\_object\_id

BIGINT unsigned

The id of the service this record is associated with

 

U1

status\_update\_time

TIMESTAMP

The date/time the status record was updated

 

 

output

VARCHAR(255)

The text output from the most current service check (first line)

 

 

long\_output

TEXT

The text output from the most current service check (consecutive lines)

 

 

perfdata

TEXT

Optional performance data from the most current service check

 

 

check\_source

TEXT

Optional check result source.

 

 

current\_state

SMALLINT

Number indicating the current state of the service

0 = OK; 1 = WARNING; 2 = CRITICAL; 3 = UNKNOWN

 

has\_been\_checked

SMALLINT

Number indicating whether or not the service has been checked yet

0 = Has NOT been checked; 1 = Has been checked

 

should\_be\_scheduled

SMALLINT

Number indicating whether or not the service should be scheduled for
periodic checks on a regular basis

0 = Not scheduled; 1 = Scheduled

 

current\_check\_attempt

SMALLINT

The current check attempt for the service

 

 

max\_check\_attempts

SMALLINT

The max check attempts (as configured in Icinga) for the service

 

 

last\_check

TIMESTAMP

The date/time the service was last checked. Set to the epoch if the
service has not been checked yet

 

 

next\_check

TIMESTAMP

The date/time the service is scheduled to be checked next

 

 

check\_type

SMALLINT

Number indicating whether or not the last service check was active or
passive

0 = Active; 1 = Passive

 

last\_state\_change

TIMESTAMP

The date/time the service last changed state (if at all). This gets
updated for both HARD and SOFT state changes

 

 

last\_hard\_state\_change

TIMESTAMP

The date/time the service last changed HARD states (if at all)

 

 

last\_hard\_state

SMALLINT

0 = OK 1 = WARNING; 2 = CRITICAL; 3 = UNKNOWN

 

 

last\_time\_ok

TIMESTAMP

The date/time the service was last in an OK state (if at all)

 

 

last\_time\_warning

TIMESTAMP

The date/time the service was last in a WARNING state (if at all)

 

 

last\_time\_unknown

TIMESTAMP

The date/time the service was last in an UNKNOWN state (if at all)

 

 

last\_time\_critical

TIMESTAMP

The date/time the service was last in a CRITICAL state (if at all).

 

 

state\_type

SMALLINT

Number indicating whether the service is in a hard or soft state

0 = SOFT state; 1 = HARD

 

state last\_notification

TIMESTAMP

The date/time that a notification was last sent out for the current
service problem (if applicable)

 

 

next\_notification

TIMESTAMP

The earliest date/time that the next notification can be sent out for
the current service problem (if applicable)

 

 

no\_more\_notifications

SMALLINT

Number indicating whether or not future notifications can be sent out
for the current service problem

0 = Do not send more notifications; 1 = Keep sending notifications

 

notifications\_enabled

SMALLINT

Number indicating whether notifications are enabled for the service

0 = Disabled; 1 = Enabled

 

problem\_has\_been\_acknowledged

SMALLINT

Number indicating whether or not the current status problem has been
acknowledged

0 = Not acknowledged; 1 = Acknowledged

 

acknowledgement\_type

SMALLINT

Number indicating the type of acknowledgement (if any)

0 = No acknowledgement; 1 = Normal acknowledgement; 2 = Sticky
acknowledgement

 

current\_notification\_number

SMALLINT

Number indicating how many notifications have been sent out about the
current service problem (if applicable)

 

 

passive\_checks\_enabled

SMALLINT

Number indicating whether or not passive checks are enabled for the
service

0 = Disabled; 1 = Enabled

 

active\_checks\_enabled

SMALLINT

Number indicating whether or not active checks are enabled for the
service

0 = Disabled; 1 = Enabled

 

event\_handler\_enabled

SMALLINT

Number indicating whether or not the service event handler is enabled

0 = Disabled; 1 = Enabled

 

flap\_detection\_enabled

SMALLINT

Number indicating whether or not flap detection is enabled for the
service

0 = Disabled; 1 = Enabled

 

is\_flapping

SMALLINT

Number indicating whether ot not the service is currently flapping

0 = Not flapping; 1 = Flapping

 

percent\_state\_change

DOUBLE

Number indicating the current percent state change (a measure of
volatility) for the service

 

 

latency

DOUBLE

Number indicating how "late" the last service check was in being run.
For active checks, this is the difference between the time the service
was scheduled to be the checked and the time it was actually checked.
For passive checks, this is the difference between the timestamp on the
passive check (submitted via an external command) and the time Icinga
processed the check result. execution\_time DOUBLE Number of seconds it
took to run the last service check

 

 

execution\_time

DOUBLE

Number of seconds it took to execute the service check

 

 

scheduled\_downtime\_depth

SMALLINT

Number indicating how many periods of scheduled downtime are currently
in effect for the service. A value of 0 indicates the service is not in
a period of downtime

 

 

failure\_prediction\_enabled

SMALLINT

Number indicating whether or not failure prediction is enabled for the
service. This feature has not yet been implemented

0 = Disabled; 1 = Enabled

 

process\_performance\_data

SMALLINT

Number indicating whether or not performance data should be processed
for the service

0 = Do NOT process perfdata; 1 = Process perfdata

 

obsess\_over\_service

SMALLINT

Number indicating whether or not Icinga should obsess of check results
of the service

0 = Do NOT obsess; 1 = Obsess

 

modified\_service\_attributes

INT

Number indicating what service attributes have been modified during
runtime

See Icinga source code

 

event\_handler

VARCHAR(255)

The current event handler command that is associated with the service

 

 

check\_command

VARCHAR(255)

The current check command that is used to check the status of the
service

 

 

normal\_check\_interval

DOUBLE

The current normal check interval for the service (in seconds)

 

 

retry\_check\_interval

DOUBLE

The current retry check interval for the service (in seconds)

 

 

check\_timeperiod\_object\_id

BIGINT unsigned

The currently timeperiod that is used to determine when the service can
be checked.

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

service\_object\_id

objects.object\_id

check\_timeperiod\_object\_id

objects.object\_id

*Contactstatus Table*

Description: This table is used to store current status information for
all contacts that are being used.

Structure:

Field

Type

Notes

Values

Key

contactstatus\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

contact\_object\_id

BIGINT unsigned

The id of the service this record is associated with

 

U1

status\_update\_time

TIMESTAMP

The date/time the status record was updated

 

 

hostnotifications\_enabled

SMALLINT

Number indicating whether or not host notifications are enabled for this
contact

0 = Notifications disabled; 1 = Notifications enabled

 

servicenotifications\_enabled

SMALLINT

Number indicating whether or not service notifications are enabled for
this contact

0 = Notifications disabled; 1 = Notifications enabled

 

last\_hostnotification

TIMESTAMP

Time the last host notification was sent

 

 

last\_servicenotification

TIMESTAMP

Time the last service notification was sent

 

 

modified\_attributes

INT

Default = 0

 

 

modified\_host\_attributes

INT

Default = 0

 

 

modified\_service\_attributes

INT

Default = 0

 

 

Relationships:

Field

Foreign Key

instance\_id

instances.instance\_id

### 12.5.5. Configuration Tables

![[Note]](../images/note.png)

Note

The tables that contain configuration data have not yet been fully
documented.

There are many tables in the database that are used to store Icinga
configuration. Note that the data in these tables represents a read-only
output view of the configuration that Icinga was using during its last
(or current) run. Configuration information from these tables is NOT
read by the Icinga daemon in any way, and thus cannot be used to
configure Icinga.

*Table List*

-   [commands](db_model.md#dbm_commands)

-   [configfiles](db_model.md#dbm_configfiles)

-   [configfilevariables](db_model.md#dbm_configfilevariables)

-   [contact\_addresses](db_model.md#dbm_contact_addresses)

-   [contact\_notificationcommands](db_model.md#dbm_contact_notificationcommands)

-   [contactgroup\_members](db_model.md#dbm_contactgroup_members)

-   [contactgroups](db_model.md#dbm_contactgroups)

-   [contactnotificationmethods](db_model.md#dbm_contactnotificationmethods)

-   [contacts](db_model.md#dbm_contacts)

-   [customvariables](db_model.md#dbm_customvariables)

-   [host\_contactgroups](db_model.md#dbm_host_contactgroups)

-   [host\_contacts](db_model.md#dbm_host_contacts)

-   [host\_parenthosts](db_model.md#dbm_host_parenthosts)

-   [hostdependencies](db_model.md#dbm_hostdependencies)

-   [hostescalation\_contactgroups](db_model.md#dbm_hostescalation_contactgroups)

-   [hostescalation\_contacts](db_model.md#dbm_hostescalation_contacts)

-   [hostescalations](db_model.md#dbm_hostescalations)

-   [hostgroup\_members](db_model.md#dbm_hostgroup_members)

-   [hostgroups](db_model.md#dbm_hostgroups)

-   [hosts](db_model.md#dbm_hosts)

-   [service\_contactgroups](db_model.md#dbm_service_contactgroups)

-   [service\_contacts](db_model.md#dbm_service_contacts)

-   [servicedependencies](db_model.md#dbm_servicedependencies)

-   [serviceescalation\_contactgroups](db_model.md#dbm_serviceescalation_contactgroups)

-   [serviceescalation\_contacts](db_model.md#dbm_serviceescalation_contacts)

-   [serviceescalations](db_model.md#dbm_serviceescalations)

-   [servicegroup\_members](db_model.md#dbm_servicegroup_members)

-   [servicegroups](db_model.md#dbm_servicegroups)

-   [services](db_model.md#dbm_services)

-   [timeperiod\_timeranges](db_model.md#dbm_timeperiod_timeranges)

-   [timeperiods](db_model.md#dbm_timeperiods)

**Figure 12.18. Relationship of Configuration Tables**

![Relationship of Configuration Tables](../images/db_model_cf.png)

\

*Commands Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

command\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK3

object\_id

BIGINT unsigned

 

 

UK2

command\_line

VARCHAR(1024)

 

 

 

*Configfiles Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

configfile\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

configfile\_type

SMALLINT

 

 

UK2

configfile\_path

VARCHAR(255)

 

 

UK3

*Configfilevariables Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

configfilevariable\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

configfile\_id

BIGINT unsigned

 

 

 

varname

VARCHAR(64)

 

 

 

varvalue

VARCHAR(1024)

 

 

 

*Contact\_addresses Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

contact\_address\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

contact\_id

BIGINT unsigned

 

 

UK1

address\_number

SMALLINT

 

 

UK2

address

VARCHAR(255)

 

 

 

*Contact\_notificationcommands Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

contact\_notficationcommand\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

contact\_id

BIGINT unsigned

 

 

UK1

notification\_type

SMALLINT

 

 

UK2

command\_object\_id

BIGINT unsigned

 

 

UK3

command\_args

VARCHAR(255)

 

 

UK4

*Contactgroup\_members Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

contactgroup\_member\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

contactgroup\_id

BIGINT unsigned

 

 

UK1

contact\_object\_id

BIGINT unsigned

 

 

UK2

*Contactgroups Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

contactgroup\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

contactgroup\_object\_id

BIGINT unsigned

 

 

UK3

alias

VARCHAR(255)

 

 

 

*Contactnotificationmethods Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

contactnotificationmethod\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

contactnotification\_id

BIGINT unsigned

 

 

UK2

start\_time

TIMESTAMP

 

 

UK3

start\_time\_usec

INT

 

 

UK4

end\_time

TIMESTAMP

 

 

 

end\_time\_usec

INT

 

 

 

command\_object\_id

BIGINT unsigned

 

 

 

command\_args

VARCHAR(255)

 

 

 

*Contacts Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

contact\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

contact\_object\_id

BIGINT unsigned

 

 

UK3

alias

VARCHAR(64)

String describing the contact

 

 

email\_address

VARCHAR(255)

String containing the e-mail address of the contact

 

 

pager\_address

VARCHAR(64)

String containing the pager address of the contact

 

 

host\_timeperiod\_object\_id

BIGINT unsigned

 

 

 

service\_timeperiod\_object\_id

BIGINT unsigned

 

 

 

host\_notifications\_enabled

SMALLINT

Indicates whether or not the contact will receive host notifications

0 = Disabled; 1 = Enabled

 

service\_notifications\_enabled

SMALLINT

Indicates whether or not the contact will receive service notifications

0 = Disabled; 1 = Enabled

 

can\_submit\_commands

SMALLINT

Indicates whether or not the contact can submit external commands via
the web interface

0 = Disabled; 1 = Enabled

 

notify\_service\_recovery

SMALLINT

Indicates whether or not the contact will receive notifications if a
service enters the state "RECOVERY"

0 = Disabled; 1 = Enabled

 

notify\_service\_warning

SMALLINT

Indicates whether or not the contact will receive notifications if a
service enters the state "WARNING"

0 = Disabled; 1 = Enabled

 

notify\_service\_unknown

SMALLINT

Indicates whether or not the contact will receive notifications if a
service enters the state "UNKNOWN"

0 = Disabled; 1 = Enabled

 

notify\_service\_critical

SMALLINT

Indicates whether or not the contact will receive notifications if a
service enters the state "CRITICAL"

0 = Disabled; 1 = Enabled

 

notify\_service\_flapping

SMALLINT

Indicates whether or not the contact will receive notifications if a
service enters the state "FLAPPING"

0 = Disabled; 1 = Enabled

 

notify\_service\_downtime

SMALLINT

Indicates whether or not the contact will receive notifications if a
service enters the state "DOWNTIME"

0 = Disabled; 1 = Enabled

 

notify\_host\_recovery

SMALLINT

Indicates whether or not the contact will receive notifications if a
host enters the state "RECOVERY"

0 = Disabled; 1 = Enabled

 

notify\_host\_down

SMALLINT

Indicates whether or not the contact will receive notifications if a
host enters the state "DOWN"

0 = Disabled; 1 = Enabled

 

notify\_host\_unreachable

SMALLINT

Indicates whether or not the contact will receive notifications if a
host enters the state "UNREACHABLE"

0 = Disabled; 1 = Enabled

 

notify\_host\_flapping

SMALLINT

Indicates whether or not the contact will receive notifications if a
host enters the state "FLAPPING"

0 = Disabled; 1 = Enabled

 

notify\_host\_downtime

SMALLINT

Indicates whether or not the contact will receive notifications if a
host enters the state "DOWNTIME"

0 = Disabled; 1 = Enabled

 

*customvariables Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

customvariable\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

object\_id

BIGINT unsigned

 

 

UK1

config\_type

SMALLINT

 

 

UK2

has\_been\_modified

SMALLINT

 

 

 

varname

VARCHAR(255)

String containing the name of the custom variable

 

UK3,NK

varvalue

VARCHAR(255)

String containing the value of the custom variable

 

 

*Host\_contactgroups Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

host\_contactgroup\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

host\_id

BIGINT unsigned

 

 

UK1

contactgroup\_object\_id

BIGINT unsigned

 

 

UK2

*Host\_contacts Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

host\_contact\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

host\_id

BIGINT unsigned

 

 

UK1

contact\_object\_id

BIGINT unsigned

 

 

UK2

*Hostescalation\_contactgroups Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

hostescalation\_contactgroup\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

hostescalation\_id

BIGINT unsigned

 

 

UK1

contactgroup\_object\_id

BIGINT unsigned

 

 

UK2

*Hostescalation\_contacts Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

hostescalation\_contact\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

hostescalation\_id

BIGINT unsigned

 

 

UK1

contact\_object\_id

BIGINT unsigned

 

 

UK2

*Host\_parenthosts Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

host\_parenthost\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

host\_id

BIGINT unsigned

 

 

UK1

parent\_host\_object\_id

BIGINT unsigned

 

 

UK2

*Hostdependencies Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

hostdependency\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

host\_object\_id

BIGINT unsigned

 

 

UK3

dependent\_host\_object\_id

BIGINT unsigned

 

 

UK4

dependency\_type

SMALLINT

Indicates the type of the dependency

1 = Notification dependency, 2 = Execution dependency

UK5

inherits\_parent

SMALLINT

Indicates whether or not the host will inherit dependencies from parent
hosts

0 = do not inherit dependencies, 1 = inherit dependencies

UK6

timeperiod\_object\_id

BIGINT unsigned

 

 

 

fail\_on\_up

SMALLINT

Indicates whether or not the host will be checked if the master host is
UP

0 = check host, 1 = do not check host

UK7

fail\_on\_down

SMALLINT

Indicates whether or not the host will be checked if the master host is
DOWN

0 = check host, 1 = do not check host

UK8

fail\_on\_unreachable

SMALLINT

Indicates whether or not the host will be checked if the master host is
UNREACHABLE

0 = check host, 1 = do not check host

UK9

*Hostescalations Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

hostescalation\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

host\_object\_id

BIGINT unsigned

 

 

UK3

timeperiod\_object\_id

BIGINT unsigned

 

 

UK4

first\_notification

SMALLINT

 

 

UK5

last\_notification

SMALLINT

 

 

UK6

notification\_interval

DOUBLE

 

 

 

escalate\_on\_recovery

SMALLINT

 

 

 

escalate\_on\_down

SMALLINT

 

 

 

escalate\_on\_unreachable

SMALLINT

 

 

 

*Hostgroup\_members Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

hostgroup\_member\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

hostgroup\_id

BIGINT unsigned

 

 

UK1

host\_object\_id

BIGINT unsigned

 

 

UK2

*Hostgroups Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

hostgroup\_id

SERIAL

 

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

 

hostgroup\_object\_id

BIGINT unsigned

 

 

UK2

alias

VARCHAR(255)

String describing the hostgroup

 

 

*Hosts Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

host\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

host\_object\_id

BIGINT unsigned

 

 

UK3

alias

VARCHAR(64)

String describing the host

 

 

display\_name

VARCHAR(255)

 

 

 

address

VARCHAR(128)

IP-address

 

 

address6

VARCHAR(128)

IPv6-address

 

 

check\_command\_object\_id

BIGINT unsigned

 

 

 

check\_command\_args

VARCHAR(255)

 

 

 

eventhandler\_command\_object\_id

BIGINT unsigned

 

 

 

eventhandler\_command\_args

VARCHAR(255)

 

 

 

notification\_timeperiod\_object\_id

BIGINT unsigned

 

 

 

check\_timeperiod\_object\_id

BIGINT unsigned

 

 

 

failure\_prediction\_options

VARCHAR(64)

 

 

 

check\_interval

DOUBLE

 

 

 

retry\_interval

DOUBLE

 

 

 

max\_check\_attempts

SMALLINT

 

 

 

first\_notification\_delay

DOUBLE

 

 

 

notification\_interval

DOUBLE

 

 

 

notify\_on\_down

SMALLINT

 

 

 

notify\_on\_unreachable

SMALLINT

 

 

 

notify\_on\_recovery

SMALLINT

 

 

 

notify\_on\_flapping

SMALLINT

 

 

 

notify\_on\_downtime

SMALLINT

 

 

 

stalk\_on\_up

SMALLINT

 

 

 

stalk\_on\_down

SMALLINT

 

 

 

stalk\_on\_unreachable

SMALLINT

 

 

 

flap\_detection\_enabled

SMALLINT

 

 

 

flap\_detection\_on\_up

SMALLINT

 

 

 

flap\_detection\_on\_down

SMALLINT

 

 

 

flap\_detection\_on\_unreachable

SMALLINT

 

 

 

low\_flap\_threshold

DOUBLE

 

 

 

high\_flap\_threshold

DOUBLE

 

 

 

process\_performance\_data

SMALLINT

 

 

 

freshness\_checks\_enabled

SMALLINT

 

 

 

freshness\_threshold

SMALLINT

 

 

 

passive\_checks\_enabled

SMALLINT

 

 

 

eventhandler\_enabled

SMALLINT

 

 

 

active\_checks\_enabled

SMALLINT

 

 

 

retain\_status\_information

SMALLINT

 

 

 

retain\_nonstatus\_information

SMALLINT

 

 

 

notifications\_enabled

SMALLINT

 

 

 

obsess\_over\_host

SMALLINT

 

 

 

failure\_prediction\_enabled

SMALLINT

 

 

 

notes

VARCHAR(255)

 

 

 

notes\_url

VARCHAR(255)

 

 

 

action\_url

VARCHAR(255)

 

 

 

icon\_image

VARCHAR(255)

 

 

 

icon\_image\_alt

VARCHAR(255)

 

 

 

vrml\_image

VARCHAR(255)

 

 

 

statusmap\_image

VARCHAR(255)

 

 

 

have\_2d\_coords

SMALLINT

 

 

 

x\_2d

SMALLINT

 

 

 

y\_2d

SMALLINT

 

 

 

have\_3d\_coords

SMALLINT

 

 

 

x\_3d

DOUBLE

 

 

 

y\_3d

DOUBLE

 

 

 

z\_3d

DOUBLE

 

 

 

*Service\_contactgroups Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

service\_contactgroup\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

service\_id

BIGINT unsigned

 

 

UK2

contactgroup\_object\_id

BIGINT unsigned

 

 

UK3

*Service\_contacts Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

service\_contact\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

service\_id

BIGINT unsigned

 

 

UK2

contact\_object\_id

BIGINT unsigned

 

 

UK3

*Servicedependencies Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

servicedependency\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

service\_object\_id

BIGINT unsigned

 

 

UK3

dependent\_service\_object\_id

BIGINT unsigned

 

 

UK4

dependency\_type

SMALLINT

Indicates the type of the dependency

1 = Notification dependency, 2 = Execution dependency

UK5

inherits\_parent

SMALLINT

Indicates whether or not the service will inherit dependencies from
parent services

0 = do not inherit dependencies, 1 = inherit dependencies

UK6

timeperiod\_object\_id

BIGINT unsigned

 

 

 

fail\_on\_ok

SMALLINT

Indicates whether or not the service will be checked if the master
service is OK

0 = check service, 1 = do not check service

UK7

fail\_on\_warning

SMALLINT

Indicates whether or not the service will be checked if the master
service is WARNIING

0 = check service, 1 = do not check service

UK8

fail\_on\_unknown

SMALLINT

Indicates whether or not the service will be checked if the master
service is UNKNOWN

0 = check service, 1 = do not check service

UK9

fail\_on\_critical

SMALLINT

Indicates whether or not the service will be checked if the master
service is CRITICAL

0 = check service, 1 = do not check service

UK10

*Serviceescalation\_contactgroups Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

serviceescalation\_contactgroup\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

serviceescalation\_id

BIGINT unsigned

 

 

UK1

contactgroup\_object\_id

BIGINT unsigned

 

 

UK2

*Serviceescalation\_contacts Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

serviceescalation\_contact\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

serviceescalation\_id

BIGINT unsigned

 

 

UK1

contact\_object\_id

BIGINT unsigned

 

 

UK2

*Serviceescalations Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

serviceescalation\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

service\_object\_id

BIGINT unsigned

 

 

UK3

timeperiod\_object\_id

BIGINT unsigned

 

 

UK4

first\_notification

SMALLINT

 

 

UK5

last\_notification

SMALLINT

 

 

UK6

notification\_interval

DOUBLE

 

 

 

escalate\_on\_recovery

SMALLINT

 

 

 

escalate\_on\_warning

SMALLINT

 

 

 

escalate\_on\_unknown

SMALLINT

 

 

 

escalate\_on\_critical

SMALLINT

 

 

 

*Servicegroup\_members Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

servicegroup\_member\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

servicegroup\_id

BIGINT unsigned

 

 

UK1

service\_object\_id

BIGINT unsigned

 

 

UK2

*Servicegroups Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

servicegroup\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

servicegroup\_object\_id

BIGINT unsigned

 

 

UK3

alias

VARCHAR(255)

String describing the servicegroup

 

 

*Services Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

service\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

host\_object\_id

BIGINT unsigned

 

 

 

service\_object\_id

BIGINT unsigned

 

 

UK3

display\_name

VARCHAR(255)

 

 

 

check\_command\_object\_id

BIGINT unsigned

 

 

 

check\_command\_args

VARCHAR(255)

 

 

 

eventhandler\_command\_object\_id

BIGINT unsigned

 

 

 

eventhandler\_command\_args

VARCHAR(255)

 

 

 

notification\_timeperiod\_object\_id

BIGINT unsigned

 

 

 

check\_timeperiod\_object\_id

BIGINT unsigned

 

 

 

failure\_prediction\_options

VARCHAR(64)

 

 

 

check\_interval

DOUBLE

 

 

 

retry\_interval

DOUBLE

 

 

 

max\_check\_attempts

SMALLINT

 

 

 

first\_notification\_delay

DOUBLE

 

 

 

notification\_interval

DOUBLE

 

 

 

notify\_on\_warning

SMALLINT

 

 

 

notify\_on\_unknown

SMALLINT

 

 

 

notify\_on\_critical

SMALLINT

 

 

 

notify\_on\_recovery

SMALLINT

 

 

 

notify\_on\_flapping

SMALLINT

 

 

 

notify\_on\_downtime

SMALLINT

 

 

 

stalk\_on\_ok

SMALLINT

 

 

 

stalk\_on\_warning

SMALLINT

 

 

 

stalk\_on\_unknown

SMALLINT

 

 

 

stalk\_on\_critical

SMALLINT

 

 

 

is\_volatile

SMALLINT

 

 

 

flap\_detection\_enabled

SMALLINT

 

 

 

flap\_detection\_on\_ok

SMALLINT

 

 

 

flap\_detection\_on\_warning

SMALLINT

 

 

 

flap\_detection\_on\_unknown

SMALLINT

 

 

 

flap\_detection\_on\_critical

SMALLINT

 

 

 

low\_flap\_threshold

DOUBLE

 

 

 

high\_flap\_threshold

DOUBLE

 

 

 

process\_performance\_data

SMALLINT

 

 

 

freshness\_checks\_enabled

SMALLINT

 

 

 

freshness\_threshold

SMALLINT

 

 

 

passive\_checks\_enabled

SMALLINT

 

 

 

eventhandler\_enabled

SMALLINT

 

 

 

active\_checks\_enabled

SMALLINT

 

 

 

retain\_status\_information

SMALLINT

 

 

 

retain\_nonstatus\_information

SMALLINT

 

 

 

notifications\_enabled

SMALLINT

 

 

 

obsess\_over\_service

SMALLINT

 

 

 

failure\_prediction\_enabled

SMALLINT

 

 

 

notes

VARCHAR(255)

 

 

 

notes\_url

VARCHAR(255)

 

 

 

action\_url

VARCHAR(255)

 

 

 

icon\_image

VARCHAR(255)

 

 

 

icon\_image\_alt

VARCHAR(255)

 

 

 

*Timeperiod\_timeranges Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

timeperiod\_timerange\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

 

timeperiod\_id

BIGINT unsigned

 

 

UK1

day

SMALLINT

 

 

UK2

start\_sec

INT

 

 

UK3

end\_sec

INT

 

 

UK4

*Timeperiods Table*

Description: .

Structure:

Field

Type

Notes

Values

Key

timeperiod\_id

SERIAL

Unique number identifying the record

 

PK

instance\_id

BIGINT unsigned

Unique number identifying the distinct instance of Icinga which this
entry is associated with

 

UK1

config\_type

SMALLINT

 

 

UK2

timeperiod\_object\_id

BIGINT unsigned

 

 

UK3

alias

VARCHAR(255)

String describing the timeperiod

 

 

* * * * *

  ---------------------------------- -------------------- -------------------------------------
  [Prev](db_example-configs.md)    [Up](ch12.md)       [Next](db_changes.md)
  12.4. Example Configurations       [Home](index.md)    12.6. Database changes/alterations
  ---------------------------------- -------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
