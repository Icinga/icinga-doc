![Icinga](../images/logofullsize.png "Icinga")

12.3. Configuration of IDOUtils

[Prev](db_components.md) 

Chapter 12. IDOUtils

 [Next](db_example-configs.md)

* * * * *

12.3. Configuration of IDOUtils
-------------------------------

12.3.1. [IDOMOD config options](configido.md#configido-idomod_options)

12.3.2. [IDO2DB config options](configido.md#configido-ido2db_options)

![[Note]](../images/note.png)

Note

This is to be considered "work in progress".

[Changes to core files](configido.md#configido_)

[Changes in idomod.cfg](configido.md#configido-idomod)

[Hints on performance and
troubleshooting](configido.md#configido-hints)

[Changes in ido2db.cfg](configido.md#configido-ido2db)

[idomod.cfg config
options](configido.md#configido-idomod_options "12.3.1. IDOMOD config options")

[ido2db.cfg config
options](configido.md#configido-ido2db_options "12.3.2. IDO2DB config options")

**Core**

The configuration starts with setting up the directive "broker\_options"
in `icinga.cfg`{.filename}. In most cases this value is already present
in the file but may have to be activated (by removing the leading hash
sign).

![[Important]](../images/important.png)

Important

Keep in mind that this setting affects **all** event broker modules!
(for details see
[http://www.mail-archive.com/nagios-users@lists.sourceforge.net/msg24002.md).](http://www.mail-archive.com/nagios-users@lists.sourceforge.net/msg24002.md))

Enable the idomod event broker module. Please note that under normal
circumstances the following module definition is already present in the
`modules`{.filename} subdirectory so there is no need to edit the main
config file.

If not the definition of the broker module can be done using a [module
definition](objectdefinitions.md#objectdefinitions-module) similar to
the following:

~~~~ {.programlisting}
 define module {
    module_name   ido_mod
    path          /usr/local/icinga/lib/idomod.so
    module_type   neb
    args          config_file=/usr/local/icinga/etc/idomod.cfg
 }
~~~~

**idomod.cfg**

Please review the settings before actually (re)starting Icinga.

The directive "output\_type" should be set to "unixsocket" (default) or
"tcpsocket" depending on whether you try access the IDO2DB daemon
remote. Please set the value of "output" accordingly (and "tcp\_port" as
well if applicable). The other options are set to values suitable for
starters. If you encounter difficulties during operation you might want
to take a look at the following lines:

**Some hints on performance and troubleshooting**

-   *Buffer*

    Increasing the buffer size will help in case of a slow ido2db daemon
    or RDBMS on the other side, dropping out. But keep in mind that
    setting this value too high will cause more load on core handling
    live and cached data in sync. For performance reasons, it is a good
    idea to put the buffer into a ramdisk reducing file I/O. If using a
    virtual environment, do not put it on the same volume as the
    checkresults / logs are located. Side by side to
    `status.dat`{.filename} will fit probably.

    ~~~~ {.programlisting}
     output_buffer_items=
     buffer_file=
    ~~~~

-   *Reconnect*

    It may happen that a slow ido2db daemon or RDBMS will disconnect the
    client after timing out on insert/update/delete. The output buffer
    will then being filled while waiting for a reconnect. In order to
    allow faster reconnect, you can decrease the default value of
    reconnecting. But keep in mind, that too less and large values can
    create performance issues. Play around a bit yourself.

    ~~~~ {.programlisting}
     reconnect_interval=15
     reconnect_warning_interval=15
    ~~~~

    *Data Processing Options*

    Decide what you need. Do you want to keep historical data or is it
    just a status database containing only current data?

    -   Normal operation

        -   drop \*TIMED\_EVENT\_DATA (default)

    -   Icinga Web requirements

        -   drop \*TIMED\_EVENT\_DATA

        -   drop \*CHECK\_DATA

        -   keep \*LOG\_DATA

        -   keep \*STATUS\_DATA

        -   keep \*STATE\_HISTORY

        -   Config tables

    -   Only status data

        -   drop \*CHECK\_DATA

        -   drop \*TIMED\_EVENT\_DATA

        -   drop \*LOG\_DATA

    -   Historical data

        -   watch \*LOG\_DATA

        -   watch \*CHECK\_DATA

            -   archive older, static data into separated tables

            -   use the housekeeping cycles in `ido2db.cfg`{.filename}

    -   Only performance data

        -   drop \*LOG\_DATA

        -   keep \*CHECK\_DATA

    Use the [calculator by
    Consol](http://labs.consol.de/nagios/ndo-data-processing-options) to
    calculate the correct value in an easy way.

    Have a look at the
    ["data\_processing\_options"](configido.md#configido-data_processing_options)
    directive for details.

-   *Config Output Options*

    This determines what happens on start/restart/reload of the Core,
    dumping the configuration (main and object, to be separated in the
    data processing options). Keep in mind that a reload is just a
    SIGHUP restart, not dropping memory and values. Internally IDOMOD
    will handle this the same way fetching the data from the NEB API.

    Using Icinga Web, the default is currently "2" (retained config
    data), which requires to have retention data to be enabled (by
    default) and at least being able to read the data once (so start,
    and reload then, dumping the configs at this stage). This won't take
    as long as the original config dump because the config is already
    compiled/assembled into its respective resulting object data.

    Taking the original configs, this will add a hook to the core config
    parser and add each single directive to IDOMOD too, acquiring cpu
    cycles and generating much data upon (re)start. Icinga Web can be
    set to use that data too.

    Within the database itself, the icinga\_hosts and icinga\_services
    table defines the config\_type column, where

    -   config\_type=1 \<==\> config\_output\_options=2 (retained)

    -   config\_type=0 \<==\> config\_output\_options=1 (original)

    config\_type itself can be used for Icinga Web config as XML
    attribute.

    See
    ["config\_output\_options"](configido.md#configido-config_output_options)
    for details.

-   *Debug*

    Keep in mind that writing a debug file may slow down the module
    processing data. But it will help in order to analyze what data runs
    from the core through idomod onto the socket against ido2db.

**ido2db.cfg**

-   *table trimming options*

    By default timed events are not processed, because the remaining
    data would be rather useless. The rest can be set to be cleaned, and
    holding only the current data, defined by the max age.

    It might be a good idea to reduce this especially for logentries
    because this table can grow very fast.

    **Please keep in mind:** If you change the instance\_name in
    `idomod.cfg`{.filename} the historical data will stay within the
    database. The housekeeping process will only catch columns targetted
    against the current active instance\_id (which will be read from
    IDOMOD and DB on ido2db startup).

    ~~~~ {.programlisting}
     ## TABLE TRIMMING OPTIONS
     # Several database tables containing Icinga event data can become quite large
     # over time.  Most admins will want to trim these tables and keep only a
     # certain amount of data in them.  The options below are used to specify the
     # age (in MINUTES) that data should be allowd to remain in various tables
     # before it is deleted.  Using a value of zero (0) for any value means that
     # that particular table should NOT be automatically trimmed.
     #
     # Remember: There are no optimized settings, it depends on your rdbm install,
     # number/checkinterval of host/service-checks and your desired time of data
     # savings - historical vs live-data. Please keep in mind that low delete
     # intervals may interfere with insert/update data from Icinga.

     # ***DEFAULT***

     # Keep system commands for 1 day
     max_systemcommands_age=1440

     # Keep service checks for 1 day
     max_servicechecks_age=1440

     # Keep host checks for 1 day
     max_hostchecks_age=1440

     # Keep event handlers for 1 week
     max_eventhandlers_age=10080

     # Keep external commands for 1 week
     max_externalcommands_age=10080

     # Keep logentries for 31 days
     max_logentries_age=44640

     # Keep acknowledgements for 31 days
     max_acknowledgements_age=44640

     # Keep notifications for 31 days
     max_notifications_age=44640

     # Keep contactnotifications for 31 days
     max_contactnotifications_age=44640

     # Keep contactnotificationmethods for 31 days
     max_contactnotificationmethods_age=44640
    ~~~~

-   *db trim interval*

    This option can be used to adjust the overall trimming interval (the
    time between the dates when the table trimming delete queries are
    actually run against the database). This value has been increased
    from 60 to 3600 seconds in Icinga 1.4 in order to only run that
    every hour (and not to stress the database every minute for
    performance reasons).

    Please keep in mind that the table trimming options go hand in hand
    with that value, so setting e.g. max\_logentries\_age to 30 minutes
    will also require the trimming interval to be set to less than
    30\*60 seconds.

    ~~~~ {.programlisting}
     trim_db_interval=3600
    ~~~~

-   *use transactions*

    This option can be used to disable the database transactions.
    Default value is '1' (enabled).

    ~~~~ {.programlisting}
     use_transactions=1|0
    ~~~~

### 12.3.1. IDOMOD config options

**Instance name**

Format:

**instance\_name=\<name\>**

Example:

**instance\_name=default**

This option identifies the "name" associated with this particular
instance of Icinga and is used to separate data coming from multiple
instances. Defaults to 'default' (without quotes).

**Output type**

Format:

**output\_type**=**\<file\>|\<tcpsocket\>|\<unixsocket\>**

Example:

**output\_type=unixsocket**

This option determines what type of output sink the IDO NEB module
should use for data output.

Possible values are:

-   file = standard text file

-   tcpsocket = TCP socket

-   unixsocket = UNIX domain socket (default)

**Output**

Format:

**output=****\<ip address\>|\<file name\>**

Example:

**output=/usr/local/icinga/var/ido.sock**

This option determines the name and path of the file or UNIX domain
socket to which output will be sent if the output type option specified
above is "file" or "unixsocket", respectively. If the output type option
is "tcpsocket", this option is used to specify the IP address or fully
qualified domain name of the host that the module should connect to for
sending output.

**TCP-port**

Format:

**tcp\_port=\<n\>**

Example:

**tcp\_port=5668**

This option determines which port the module will connect to in order to
send output. This option is only valid if the output type option
specified above is "tcpsocket".

**Use encryption**

Format:

**use\_ssl=**

Example:

**use\_ssl=0**

This option determines if the module will use SSL to encrypt the network
traffic between module and ido2db daemon. Both sides have to enable this
feature which depends on SSL libraries like openssl or kerberos.

This option is only valid if the output type option specified above is
"tcpsocket".

**Output buffer size**

Format:

**output\_buffer\_items=\<n\>**

Example:

**output\_buffer\_items=5000**

This option determines the size of the output buffer, which will help
prevent data from getting lost if there is a temporary disconnect from
the data sink. The number of items specified here is the number of lines
(each of variable size) of output that will be buffered.

**Buffer file**

Format:

**buffer\_file=\<file name\>**

Example:

**buffer\_file=/usr/local/icinga/var/idomod.tmp**

This option is used to specify a file which will be used to store the
contents of buffered data which could not be sent to the IDO2DB daemon
before Icinga shuts down. Prior to shutting down, the IDO NEB module
will write all buffered data to this file for later processing. When
Icinga (re)starts, the IDO NEB module will read the contents of this
file and send it to the IDO2DB daemon for processing.

**File rotation interval**

Format:

**file\_rotation\_interval=\<seconds\>**

Example:

**file\_rotation\_interval=14400**

This option determines how often (in seconds) the output file is rotated
by Icinga. File rotation is handled by Icinga by executing the command
defined by the file\_rotation\_command option. This option has no effect
if the output\_type option is a socket.

**File rotation command**

Format:

**file\_rotation\_command=\<command\>**

Example:

**file\_rotation\_command=rotate\_ido\_log**

This option specified the command (as defined in Icinga) that is used to
rotate the output file at the interval specified by the
file\_rotation\_interval option. This option has no effect if the
output\_type option is a socket.

See the file 'misccommands.cfg' for an example command definition that
you can use to rotate the log file.

**File rotation timeout**

Format:

**file\_rotation\_timeout=\<seconds\>**

Example:

**file\_rotation\_timeout=60**

This option specified the maximum number of seconds that the file
rotation command should be allowed to run before being terminated
prematurely.

**Reconnect interval**

Format:

**reconnect\_interval=\<seconds\>**

Example:

**reconnect\_interval=15**

This option determines how often (in seconds) the IDO NEB module will
attempt to re-connect to the output file or socket if a connection to it
is lost.

**Reconnect warning interval**

Format:

**reconnect\_warning\_interval=\<seconds\>**

Example:

**reconnect\_warning\_interval=15**

This option determines how often (in seconds) a warning message will be
logged to the Icinga log file if a connection to the output file or
socket cannot be re-established.

**Data processing options**

Format:

**data\_processing\_options=\<n\>**

Example:

**data\_processing\_options=-1**

![[Caution]](../images/caution.png)

Caution

Do not mess with this option unless you know what you're doing!!!

This option determines what data the IDO NEB module will process.

Read the source code (`module/idoutils/include/idomod.h`{.filename}) and
look for "IDOMOD\_PROCESS\_" to determine what values to use here.

Values from source code should be OR'ed to get the value to use here. A
value of -1 will cause all data to be processed.

Basically you have to calculate from the following values

~~~~ {.programlisting}
 #define IDOMOD_PROCESS_PROCESS_DATA                   1
 #define IDOMOD_PROCESS_TIMED_EVENT_DATA               2
 #define IDOMOD_PROCESS_LOG_DATA                       4
 #define IDOMOD_PROCESS_SYSTEM_COMMAND_DATA            8
 #define IDOMOD_PROCESS_EVENT_HANDLER_DATA             16
 #define IDOMOD_PROCESS_NOTIFICATION_DATA              32
 #define IDOMOD_PROCESS_SERVICE_CHECK_DATA             64
 #define IDOMOD_PROCESS_HOST_CHECK_DATA                128
 #define IDOMOD_PROCESS_COMMENT_DATA                   256
 #define IDOMOD_PROCESS_DOWNTIME_DATA                  512
 #define IDOMOD_PROCESS_FLAPPING_DATA                  1024
 #define IDOMOD_PROCESS_PROGRAM_STATUS_DATA            2048
 #define IDOMOD_PROCESS_HOST_STATUS_DATA               4096
 #define IDOMOD_PROCESS_SERVICE_STATUS_DATA            8192
 #define IDOMOD_PROCESS_ADAPTIVE_PROGRAM_DATA          16384
 #define IDOMOD_PROCESS_ADAPTIVE_HOST_DATA             32768
 #define IDOMOD_PROCESS_ADAPTIVE_SERVICE_DATA          65536
 #define IDOMOD_PROCESS_EXTERNAL_COMMAND_DATA          131072
 #define IDOMOD_PROCESS_OBJECT_CONFIG_DATA             262144
 #define IDOMOD_PROCESS_MAIN_CONFIG_DATA               524288
 #define IDOMOD_PROCESS_AGGREGATED_STATUS_DATA         1048576
 #define IDOMOD_PROCESS_RETENTION_DATA                 2097152
 #define IDOMOD_PROCESS_ACKNOWLEDGEMENT_DATA           4194304
 #define IDOMOD_PROCESS_STATECHANGE_DATA               8388608
 #define IDOMOD_PROCESS_CONTACT_STATUS_DATA            16777216
 #define IDOMOD_PROCESS_ADAPTIVE_CONTACT_DATA          33554432
 #
 #define IDOMOD_PROCESS_EVERYTHING                     67108863
 #
 # You may use the Online Calculator by Gerhard Lausser:
 # http://labs.consol.de/nagios/ndo-data-processing-options/
 # (please note that there is a checkbox for everything!)
 #
 # The default setting will remove everything not used by default.
 #       TIMED_EVENT_DATA        (-2)
 #       SERVICE_CHECK_DATA      (-64)
 #       HOST_CHECK_DATA         (-128)
 #
 # 67108863-(2+64+128) = 67108863-194 = 67108669

 data_processing_options=67108669

 # If you are planning to use NagVis you may want to use the following setting:
 #
 #data_processing_options=4061953
 #
 # You may have to experiment in your environment and find the best value yourself! 
~~~~

**Config output options**

Format:

**config\_output\_options=\<0|1|2|3\>**

Example:

**config\_output\_options=2**

This option determines what types of configuration data from Icinga the
IDO NEB module will dump. Values can be OR'ed together. Hint: "2" is the
preferred value, doing a restart after initial startup.

Possible values are:

-   0 = Don't dump any configuration information

-   1 = Dump only original config (from config files)

-   2 = Dump config only after retained information has been restored

-   3 = Dump both original and retained configuration

**Debug level**

Format:

**debug\_level=\<-1|0|1|2\>**

Example:

**debug\_level=0**

This option determines how much (if any) debugging information will be
written to the debug file. OR values together to log multiple types of
information.

Possible values are:

-   -1 = Everything

-   0 = Nothing

-   1 = Process info

-   2 = SQL queries

**Debug verbosity**

Format:

**debug\_verbosity=\<0|1|2\>**

Example:

**debug\_verbosity=1**

This option determines how verbose the debug log output will be.

Possible values are:

-   0 = Brief output

-   1 = More detailed

-   2 = Very detailed

**Debug file name**

Format:

**debug\_file=\<file name\>**

Example:

**debug\_file=/usr/local/icinga/var/idomod.debug\>**

This option determines where the daemon should write debugging
information.

**Maximum debug file size**

Format:

**max\_debug\_file\_size=\<bytes\>**

Example:

**max\_debug\_file\_size=100000000**

This option determines the maximum size (in bytes) of the debug file. If
the file grows larger than this size, it will be renamed with a .old
extension. If a file already exists with a .old extension it will be
deleted automatically. This helps to ensure that your disk space usage
doesn't get out of control when debugging.

**Dump status of custom variables**

Format:

**dump\_customvar\_status=0|1**

Example:

**dump\_customvar\_status=1**

Custom variables are dumped as required configuration on core startup
but also during runtime (there may be modifications via external
commands). Since these updates happen on each host/service/contact
status update without any possibility to filter via
data\_processing\_options, this is made a separate config option. In
most scenarios, those updates are not required, therefore the default
option is disabled.

Possible values are:

-   0 = disabled (default)

-   1 = enabled

### 12.3.2. IDO2DB config options

**Lock file**

Format:

**lock\_file=\<file name\>**

Example:

**lock\_file=ido2db.lock**

This is the lockfile that IDO2DB will use to store its PID number in
when it is running in daemon mode.

**IDO2DB user/group**

Format:

**ido2db\_user=\<user name\>**

**ido2db\_group=\<group name\>**

Example:

**ido2db\_user=icinga** **ido2db\_group=icinga-cmd**

These options determine the user/group that the daemon should run as.
You can specify a number (uid/gid) or a name for either option.

**Socket type**

Format:

**socket\_type=\<unix|tcp\>**

Example:

**socket\_type=unix**

This option determines what type of socket the daemon will create and
accept connections from.

**Socket name**

Format:

**socket\_name=\<file name\>**

Example:

**socket\_name=/usr/local/icinga/rw/ido.sock**

This option determines the name and path of the UNIX domain socket that
the daemon will create and accept connections from. This option is only
valid if the socket type specified above is "unix".

**Socket Permissions**

Format:

**socket\_perm=\<n\>**

Example:

**socket\_perm=0755**

This option determines the permissons of the Unix domain socket. This
option is only valid if the socket type specified above is "unix".
Default permissions are set to 0755.

**TCP-port**

Format:

**tcp\_port=\<n\>**

Example:

**tcp\_port=5668**

This option determines which port the module will connect to in order to
send output. This option is only valid if the output type option
specified above is "tcp".

**Use encryption**

Format:

**use\_ssl=**

Example:

**use\_ssl=0**

This option determines if the module will use SSL to encrypt the network
traffic between module and ido2db daemon. Both sides have to enable this
feature which depends on SSL libraries like openssl or kerberos.

This option is only valid if the output type option specified above is
"tcp".

**Libdbi Driver Directory**

Format:

**libdbi\_driver\_dir=@LIBDBIDRIVERDIR@**

Example:

**libdbi\_driver\_dir=/usr/local/lib/dbd**

![[Note]](../images/note.png)

Note

!!!EXPERIMENTAL!!! This option is only valid when using libdbi as
database abstraction layer (so not oracle) on compile time. By default,
libdbi will figure out the correct path itself. If you want to change
it, enable and change the value. Default: not in use.

**Database server type**

Format:

**db\_servertype=\<type\>**

Example:

**db\_servertype=mysql**

This option determines what type of DB server the daemon should connect
to. Supported databases are MySQL, PostgreSQL, and Oracle

Possible values are:

-   mysql (uses libdbi)

-   pgsql (uses libdbi)

-   oracle (uses ocilib)

**Database host**

Format:

**db\_host=\<host name|ip address\>**

Example:

**db\_host=localhost**

This option specifies what host the DB server is running on.

**MySQL:**The hostname or IP address of the MySQL database server. Use
empty string or "localhost" to connect to a MySQL server running on the
local machine.

**PostgreSQL:**If this begins with a slash, it speciﬁes Unix-domain
communication rather than TCP/IP communication; the value is the name of
the directory in which the socket ﬁle is stored. The default behaviour
when host is not speciﬁed is to connect to a Unix-domain socket in /tmp
(or whatever socket directory was speciﬁed when PostgreSQL was built).

**Oracle:**This setting will be ignored.

**Database port**

Format:

**db\_port=\<n\>**

Example:

**db\_port=3306**

This option specifies the port that the DB server is running on.

Common values are:

-   3306 (default MySQL port)

-   5432 (default PostgreSQL port)

-   1521 (default Oracle port)

**MySQL:**The port used to remotely connect to the MySQL database server
over TCP. Use "0" (zero) to accept the default socket.

**PostgreSQL:**Port number to connect to at the server host, or socket
ﬁle name extension for Unix-domain connections.

**Oracle:**ocilib will ignore this, you have to modify your
`tnsnames.ora`{.filename}.

**Database socket**

Format:

**db\_socket=\<file name\>**

Example:

**db\_socket=/var/lib/mysql/mysql.sock**

Optional db\_socket allows to specify a different socket location. This
will be passed to libdbi MySQL as mysql\_unix\_socket, while PostgreSQL
overrides the port, ocilib Oracle ignores this setting.

![[Note]](../images/note.png)

Note

This setting overrules db\_port, making it useless!

**Database name**

Format:

**db\_name=\<name\>**

Example:

**db\_name=icinga**

This option specifies the name of the database that should be used.

![[Note]](../images/note.png)

Note

Oracle with ocilib requires `tnsnames.ora`{.filename} filled with host,
port and database information. Then you can use one of the following:

-   //DBSERVER/SID

-   SID

**Database prefix**

Format:

**db\_prefix=\<name\>**

Example:

**db\_prefix=icinga\_**

Determines the prefix (if any) that should be prepended to table names.
If you modify the table prefix, you'll need to modify the SQL script for
creating the database as well!

![[Note]](../images/note.png)

Note

Oracle will ignore this prefix since the tablename length will exceed 30
characters.

**Database user/password**

Format:

**db\_user=\<user name\>**

**db\_pass=\<password\>**

Example:

**db\_user=icinga** **db\_pass=icinga**

This is the username/password that will be used to authenticate to the
DB. The user needs at least SELECT, INSERT, UPDATE, and DELETE
privileges on the database.

**Debug level**

Format:

**debug\_level=\<-1|0|1|2\>**

Example:

**debug\_level=0**

This option determines how much (if any) debugging information will be
written to the debug file. OR values together to log multiple types of
information.

Possible values are:

-   -1 = Everything

-   0 = Nothing

-   1 = Process info

-   2 = SQL queries

**Debug verbosity**

Format:

**debug\_verbosity=\<0|1|2\>**

Example:

**debug\_verbosity=1**

This option determines how verbose the debug log out will be.

Possible values are:

-   0 = Brief output

-   1 = More detailed

-   2 = Very detailed

**Debug file name**

Format:

**debug\_file=\<file name\>**

Example:

**debug\_file=/usr/local/icinga/var/idomod.debug\>**

This option determines where the daemon should write debugging
information.

**Maximum debug file size**

Format:

**max\_debug\_file\_size=\<bytes\>**

Example:

**max\_debug\_file\_size=100000000**

This option determines the maximum size (in bytes) of the debug file. If
the file grows larger than this size, it will be renamed with a .old
extension. If a file already exists with a .old extension it will
automatically be deleted. This helps ensure your disk space usage
doesn't get out of control when debugging.

**Readable debug timestamp**

Format:

**debug\_readable\_timestamp=\<0|1\>**

Example:

**debug\_readable\_timestamp=0**

This option will allow you to set a readable timestamp instead of the
default unix timestamp.

Possible values are:

-   0 = disabled (unix timestamp)

-   1 = enabled (human readable timestamp)

**OCI errors to syslog**

Format:

**oci\_errors\_to\_syslog=\<0|1\>**

Example:

**oci\_errors\_to\_syslog=0**

ido2db registers an error handler in ocilib which spits all messages
into debug and syslog by default. Setting this option to 0, syslog
output will be disabled, only debug log will be used (if appropriate
debug\_level is set).

**Oracle trace level**

Format:

**oracle\_trace\_level=\<0|1|4|8|12\>**

Example:

**oracle\_trace\_level=0**

This setting activates oracle session trace for each ido2db connection
using trace event. Level value must be one of the currently supported
values (1,4,8,12) or 0 for off. This requires explicit "alter session"
privilege, select rights to v\$session and v\$process are recommended.

Possible values are:

-   0 = pseudo level TRACE OFF

-   1 = standard SQL trace, no wait events, or bind variables

-   4 = bind variables only

-   8 = wait events only

-   12 = bind variables and wait events

* * * * *

  ----------------------------- -------------------- ----------------------------------
  [Prev](db_components.md)    [Up](ch12.md)       [Next](db_example-configs.md)
  12.2. Components              [Home](index.md)    12.4. Example Configurations
  ----------------------------- -------------------- ----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
