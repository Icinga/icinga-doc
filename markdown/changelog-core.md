Changelog of the NAME-CORE
==========================

**NAME-CORE 1.0.3 - 18/08/2010**

\* core: new config option to set initial state of persistence for
acknowledgements

\* core: add opt-in log\_external\_commands\_user in icinga.cfg, user
will be logged by the core if enabled and sent through icinga.cmd

\* core: add config option to disable the logging of current state in
log after rotation (Ricardo Bartels)

\* core: add config option to log long plugin output (Ricardo Bartels)

\* core: add config option to enable event handlers for stalked
hosts/services (Petya Kohts)

\* core: scheduled downtime can now start on SOFT error states

\* idoutils: add syslog output for start/stop, client connecting

\* idoutils: add db trimming thread startup delay config option

\* classic ui: cgi config option to show long\_plugin\_output in
status.cgi (Ricardo Bartels)

\* classic ui: add config option to only show HARD states in tac.cgi

\* classic ui: add multiple selection/command sending to host/service
status page

-   added extra column in host and service status with checkboxes using
    jquery

-   It is now possible to check off the hosts you want to send commands
    to Icinga.

-   Ex: schedule downtime for a custom selection of hosts or X number of
    services.

\* classic ui: add a pause/continue update button (main parts by Steve
Koenig). Affects status.cgi and allows to select and run commands w/o
page reload

**FIXES:**

\* core: fix temp\_path overwritten by check\_result\_path in
base/config.c

\* core: modify execv to execvp, accepting 4096 cmd args, for both host
and service checks with adapted error handling

\* core: execvp searches in PATH too like popen, and returns if error,
outputting the errno string

\* core: fix possible overflows and increase command length limit in
mini\_epn's (Thomas Guyot-Sionnest)

\* core: fix new\_mini\_epn to allow any command line length without
breaking on extra trailing or leading whitespace (Ray Bengen)

\* core: fix wrong is\_volatile conditions causing wrong service alerts
in the logs

\* core: fix notify-service-by-email command from the stock template
cuts off service check output

\* core: fix service checks should recognize that exit code 126 means
plugin is not executable

\* core: fix service event handlers when service problem becomes hard
during host down

\* core: fix service in soft state after hard state without recovery

\* core: fix all comments disappear after restart if one user comment is
non-persistent (Ricardo Bartels)

\* core: fix macro processing (Jochen Bern)

\* core: fix non-scheduled hosts/services not being updated in IDO\*

\* core: move the malloc block in insert\_skiplist below dupcheck to
avoid memory leaks (Thomas Guyot-Sionnest, Holger Weiss)

\* classic ui: fix image urls in stylesheets

\* classic ui: remove check\_daemon\_running, remains useless

\* classic ui: fix multiurl action/status icon wrong name

\* classic ui: cmd.cgi "his" instead of "its" in command description

\* classic ui: fix customers can see machines from other customers when
entering a downtime

\* classic ui: fix invalid pointer in extinfo.cgi type=7

\* classic ui: for new Splunk integration query parameters

\* classic ui: fix for incorrect host state counts in status CGI when
viewing servicegroups

\* classic ui: fix for extra colum in CSV export

\* install: fix api not installed using make install-unstripped

\* install: enable debuginfo in spec file

\* install: remove daemonchk.cgi from init-script

\* install: improve output of rhel init-script

\* install: add config checks for start, reload and restart on rhel init
script

\* install: fix duplicated configcheck on restart in init-script

\* install: fix specfile for idoutils description

\* install: fix Makefile output if Icinga API not available

\* install: fix t/ and daemon-ini-redhat in distclean

\* install: add note about api installed successfully

\* idoutils: adapt oracle-drop.sql for current schema

\* idoutils: fix binding null values to name1/name2 in oracle

\* idoutils: fix typo in servicedepencies query for oracle

\* idoutils: fix oracle prep statement contactnotifmethoddata

\* idoutils: full rewrite of binding NULL values for oracle with ocilib

\* idoutils: change display\_name to varchar(255) for mysql/oracle

\* idoutils: update pgsql schema, replace varchar(n) by text

\* idoutils: change configfilevariables varvalue to 1024 length for
mysql/oracle

**NAME-CORE 1.0.2 - 30/06/2010**

\* core: init script shows config errors option; don't remove pidfile if
icinga did not stop in a timely manner

\* core: check if icinga running before starting; if died remove
lockfile first

\* core: add in sync retention facility (Ton Voon, Opsera Ltd)

\* core: add new is\_volatile setting of 2 for services, which respects
the re-notification interval for notifications (Ton Voon)

\* core: add Icinga option -S functions much like -s but will dump the
entire scheduling queue is it would run, in addition to providing the
summary data (Steven (Steven D. Morrey)

\* core: icinga can send log messages to syslogd using a local facility
instead of the default one

\* core: enhanced diagnostic output when a regular expression fails to
compile (Max Schubert)

\* core: add state-based escalation ranges (Mark Gius) The directives
first\_notification and last\_notification apply to the total count of
notifications on a particular service or host. It is sometimes desirable
to escalate after the Nth critical notification, rather than after a
total number of N notifications have been sent.

\* core: add event profiling option for stats of event counts and time
taken for events

\* core: retention file loading speedup (Matthieu Kermagoret)

\* cgi: add opt-in display\_name from hosts/services definitions; if
set, they will be shown in the classical ui

\* cgi: re-add quick search to navmenu in order to provide quick
host/service lookups without idoutils/api

\* cgi: add event profiling stats of event counts and time taken for
events in 'Performance Info'

\* cgi: add config option show\_all\_services\_host\_is\_authorized\_for
to cgi.cfg It's possible to disable that the user can see all services
only being an authorized contact for the host

\* cgi: add multiple urls for notes|action\_url on host|service object
definition (Jochen Bernd).

\* idoutils: add config options to allow users decision on clearing
realtime and config tables on Icinga core startup. Actual config objects
are marked as (in)active, because disabling the clearing results in
historical config

\* idoutils: remove mysql binary selects, use case-sensitive collation
instead (William Preston)

\* idoutils: Spread the list of linked lists thinner (extend objects
hash slots) (Opsera Ltd)

\* idoutils: change select \* into select [\*\_]id if unused results

\* idoutils: add syslog output, if ido2db is unable to do initial db
query

\* idoutils: rewrite initscript not only depending on lockfile

\* idoutils: check if ido2db running before starting; if died remove
lockfile first

\* idoutils: add upgrade scripts to fix object relations to historical
data

\* config: add trailing slash in apache config for html dir

**FIXES:**

\* core: fix scheduling downtime for all services AND the host (cgi url,
external commands)

\* core: fix custom notifications being sent during downtimes (Sven
Nierlein)

\* core: fix spurious dollar signs added to command\_lines (Alexander
Wirt)

\* core: fix for choosing next valid time on day of DST change when
clocks go one hour backwards (Ton Voon)

\* core: fix for nagios now erroring when "Error: Could not find any
contactgroup matching..." displayed (Ton Voon)

\* core: minor cleanups to icingastats.c (Eric Sesterhenn)

\* core: remove dead code (Andreas Ericsson)

\* core: introduce common/shared.c and include/shared.h (Andreas
Ericsson)

\* core: move cgiutils.h compile time option macros to config.h (Andreas
Ericsson)

\* core: icinga.c: remove conditional main() configuration (Andreas
Ericsson)

\* core: icinga.c: replace asprintf() + write\_to\_logs\_and\_console()
with logit() (Andreas Ericsson)

\* core: revamp logging somewhat (Andreas Ericsson)

\* core: create logging.h, with stubs for the common function in
cgiutils.c (Andreas Ericsson)

\* core: Janitor patch: Remove unused variables (Andreas Ericsson)

\* core: base/utils.c: typo-fix
s/escape\_newlines==/escape\_newlines\_please==/ (Andreas Ericsson)

\* core: cgi/cmd.c: Squelch warning about empty gnu\_printf format
string (Andreas Ericsson)

\* core: more linker tricks and less \#ifdef's - log\_debug\_info()
stubbed (Andreas Ericsson)

\* core: common/objects.c: Use calloc() instead of malloc() + manual
NULL'ing (Andreas Ericsson)

\* core: macros: Protect against typos in macro names (Andreas Ericsson)

\* core: macros: Add NOTIFICATIONISESCALATED to the list of macro names
(Marc Powell)

\* core: comments: Remove one comment at a time from hashlist (Hiren
Patel)

\* core: fix checking of the open(2) system call (David Glick)

\* core: xodtemplate: Use macro magic to get rid of 900 LoC (Andreas
Ericsson)

\* core: more s/malloc(size) + init/calloc(1, size)/ replacements
(Andreas Ericsson)

\* core: header files: Remove dead prototypes (Andreas Ericsson)

\* core: remove grab\_contactgroup\_macros() and its prototype (Andreas
Ericsson)

\* core: base/commands.c: Fix error path of opening checkresult files
(Andreas Ericsson)

\* core: base/nebmods.c: Replace local file-copy hack with my\_fcopy()
(Andreas Ericsson)

\* core: enable compiler flag -Wall by default
(base/cgi/common/idoutils)

\* core: fix open() error checking in move\_check\_result\_to\_queue()
(Andreas Ericsson)

\* core: base/utils.c: Refactor my\_fcopy() (Andreas Ericsson)

\* core: xdata/xpddefault.c: Close perfdata files if fd's are \>= 0
(Andreas Ericsson)

\* core: fix xpddefault\_{host,service}\_perfdata\_file\_pipe not set
properly on configuration re-read

\* core: fix SIGSEGV in checks.c on Solaris (Torsten Huebler)

\* core: added icinga object version variable in neb api for usage with
idomod

\* core: fix notification\_period inheritance for services (Gordon
Messmer)

\* core: only catch SIGSEGV if we're not dumping core and running as a
daemon (Andreas Ericsson)

\* core: fix for notifications not being sent out when scheduled
downtime is cancelled (Daniel Pouzzner)

\* core: fix for first notification delay being calculated incorrectly,
and notifications potentially going out early (reported by Pawel
Malachowski)(Ethan Galstad)

\* core: error out on services without description in service object
definition

\* core: fix servicechecks with timeperiods containing 'exclude'
directives are incorrectly re-scheduled

\* cgi: minor cleanups to cgiutils.c (Eric Sesterhenn)

\* cgi: fix cmd.cgi incomplete output for command description

\* cgi: fix typo: "stye" instead of "style" in cgi/tac.c

\* cgi: check\_daemon\_running() not working on MacOS (Hendrik Baecker)

\* cgi: fix CGIs don't show correct error on missing archived
icinga-DATE.log file

\* cgi: fix missing js files

\* idoutils: Host DB inserts use string 'NULL\\n' instead of NULL
(William Preston)

\* idoutils: ndo2db\_get\_object\_id fails to return existing IDs
(William Preston)

\* idoutils: fix postgres wrong type in service\_object\_id

\* idoutils: modify string escaping again (mysql, pgsql), needs a full
rewrite though

\* idoutils: fix for oracle when binding a NULL value on
contactnotificationmethods

\* idoutils: completely renamed idoutils (s/ndo/ido/g etc), removing old
sources

\* idoutils: fix compilation error of SUN\_LEN on Solaris

**NAME-CORE 1.0.1 - 03/03/2010**

\* core: updated docs

\* core: fix config parsing for icinga\_user and icinga\_group

\* core: fix status.dat ok, no daemon running, show error instead of old
data

\* core: permanently remove sleep on run\_event == FALSE in main loop
(Max Schubert)

\* core: add service\_check\_timeout\_state configuration variable. This
setting determines the state Icinga will report when a service check
times out - it does not respond within service\_check\_timeout seconds.

-   c - Critical (default)

-   u - Unknown

-   w - Warning

-   o - OK

\* core: add escalation\_condition definition (Vitali Voroth DECOIT
GmbH) The escalation\_condition option is completely optional and can be
defined for host escalations as well as for service escalations.

escalation\_condition \<condition\> ( [ &/ | ] \<condition\> )\* where
\<condition\> is either host hostname = [u,d,o] or service
hostname.service\_description] = [w,u,c,o].

The escalation\_condition accepts a list of one or more conditions
separated by & (logical AND) or | (logical OR).

-   w = WARNING

-   u = UNKNOWN

-   c = CRITICAL

-   o = OK for services or UP for hosts

-   d = DOWN for hosts

\* idoutils: add ido2db threaded housekeeper

-   periodic cleanup will now be performed in own thread

-   startup blocking behaviour removed

-   housekeeper will wait for idomod instance, idle wait using und
    db\_hello

-   creates own db connection and does its job

\* idoutils: add indexes for delete/select statements

-   delete/select will perform faster

-   getting cached objects with select runs faster

-   getting logentries within icinga-web is faster

\* idoutils: reorganize db setup files for MySQL/Postgresql/Oracle

-   module/idoutils/db/\<rdbms\>/ holds needed files

-   module/idoutils/scripts/ with installdb/upgradedb for MySQL

-   updated Makefile, README

\* idoutils: complete oracle rewrite to improve performance

-   1x SELECT latest data time as is (called only at startup)

-   dynamic binded procedure for DELETE on table by instance\_id called
    at startup for cleaning config/status

-   dynamic binded procedure for DELETE on tably by instance\_id,
    field\<time called during periodic cleanup in threaded housekeeper

-   all other queries are prepared with their own statement handler

    -   4x DELETE

    -   52x MERGE

    -   9x INSERT

    -   9x UPDATE

    -   5x SELECT

-   rewritten getting cached object\_id using select

-   all queries use binded unixtimestamp instead of prepared query
    string

-   removed autoincrement sequence and insert triggers to update primary
    key

-   added sequence for each table

-   INSERT INTO ... (id, ...) VALUES (seq\_name.nextval, ...) will do
    the trick

-   added RETURNING id INTO :id for INSERT statements to save one round
    trip

-   MERGE does not support returning INTO, added SELECT
    seq\_name.currval query instead for fetching last inserted id

-   add explicit upgrade information and provided procedure to alter
    sequence start when importing data (check oracle-upgrade-1.0.1.sql
    for more info)

\* idoutils: add upgrade path for mysql/pgsql/oracle for 1.0.1

\* idoutils: add initial debug output for idomod (to be set in
idomod.cfg)

\* idoutils: add database name in connection msg to syslog

\* idoutils: change mysql db engine to innodb (no table locking, better
transcations)

**FIXES**

\* core: fix segfault in cmd.cgi

\* core: fix event broker callback function self de-registering for
callbacks (Sean Millichamp)

\* core: add missing sound.js provided by scriptaculous

\* core: string replaces for icinga

\* core: typo fix in mrtg.cfg (Dennis van Zuijlekom)

\* core: add init info as required by LSB

\* core: fix perl tests

\* core: fix missing clean & distclean against tap/ directory

\* core: fix several libtap c TAP tests and cleanups

\* core: refactor perl test to use icingaadmin

\* core: add cgi argument 'nodaemoncheck' and tests

\* core: add config.cgi test

\* core: add subtests to extinfo tests

\* core: add tests against histogram.cgi

\* core: add \$srcdir to paths

\* core: fix idomod doesn't de-initialize after config error

\* core: fix make fullinstall/idoutils without enabled idoutils during
configure

\* idoutils: modify string escaping for mysql and pgsql

\* idoutils: fix pgsql table systemcommands (missing column 'output')

\* idoutils: fix arraysize of es in save\_custom\_variables

\* idoutils: rename ndomod.h to idomod.h

\* idoutils: fix several naming issues

\* idoutils: fix acknowledgments query, wrong buffer freed/set as query
to db (Bruce Pennypacker)

\* idoutils: fix contactnotification data array, command args were not
provided (Bruce Pennypacker)

\* idoutils: fix custom\_variables object\_id type int =\> unsigned long

**NAME-CORE 1.0 Stable - 16/12/2009**

\* core: create webserver conf.d dir if not existing

\* core: output the correct config parameter name on error message

\* core: run dos2unix on spec file

\* core: check /proc/\$pid instead of lock file while waiting for
shutdown

\* core: fix cgi/config.c typo

\* core: fix typo in cgi/cmd.c

\* core: applied nagios patches after 3.2.0

\* idoutils: change default data\_processing\_options in idomod.cfg

\* idoutils: fix missing query arguments in servicecheck query

\* idoutils: fix thisversion and perl path generation in db install
scripts

\* idoutils: change db README to docs.icinga.org

\* idoutils: fix wrong debug output in db\_hello()

\* idoutils: fix save custom variables segfault caused by wrong char\*

\* idoutils: fix duplicate rows in table servicecheck

\* idoutils: fix duplicate rows in table systemcommands, timedevents,
timedeventqueue (missing unique keys)

\* idoutils: add upgrade path/sql queries for unique key failure - check
the docs for upgrading information

\* idoutils: Oracle improvents:

\* add prepared statements for most called queries

- hoststatus

- servicestatus

- hostchecks

- servicechecks

- timedevents

- contact\_notificationcommands

- programstatus

\* modify data[] to get unixtimestamps only

\* rewrite prepared statement queries to use SELECT
unixts2date(unixtimestamp) FROM DUAL

\* allow rebinding of params in prepared statement for multi execution

\* prepared statement at db init

\* bind params the correct way

\* execute binded statement query instead of plain MERGE statement

\* code is now the same as NDOUtils Oracle, but with

- better code base (current NDOUtils code)

- long\_output

- SSL support

- better library: ocilib instead of own driver

- more prepared statements/bind param queries

\* split code into ocilib OR libdbi

\* --enable-oracle during configure decides which rdbm lib will be used

**NAME-CORE 1.0 RC - 28.10.2009**

\* idoutils: add Oracle support with oclilib

\* idoutils: add ssl support

\* idoutils: add configure --enable-oracle

\* idoutils: add configure --enable-ssl

\* idoutils: add configure -with-ocilib-lib/inc for ocilib detection

\* idoutils: add oracle support to ido2db.cfg

\* idoutils: add ocilib runtime version check

\* idoutils: add ocilib linked at runtime (prevents setting of
\$ORACLE\_HOME during configure)

\* idoutils: add ocilib hack to temp \#undef CONFIG\_H during compiling

\* idoutils: add \#define USE\_ORACLE set by --enable-oracle

\* idoutils: add \#ifndef USE\_ORACLE \#else \#endif to get code
compatible with libdbi

\* idoutils: add ocilib connection, statement, resultset

\* idoutils: add ocilib execute statement, commit (no autocommit since
we want to use the pros of Oracle!)

\* idoutils: add ocilib insert id for sequence handling

\* idoutils: add ocilib free statement to match with sequences

\* idoutils: add oracle sysdate instead of NOW()

\* idoutils: add long\_output to oracle.sql - introduce clob (Character
Large Object)

\* idoutils: add even more debugoutput for Oracle

\* idoutils: modify configure to use OCI\_CHARSET\_ANSI

\* idoutils: modify configure to set LD\_LIBRARY\_PATH for ido2db init
script

\* idoutils: modify formatting to get more readable

\* idoutils: fix typecast bug - unsigned long is bigger then int

\* idoutils: fix Oracle notif\_timeperiod\_object\_id (30 chars max)

\* idoutils: fix Oracle table serviceescalationcontactgroups (30 chars
max)

\* idoutils: fix hoststatus/servicestatus/servicecheck unique constraint
updating mismatch

\* idoutils: fix insert\_or\_update queries where update violates unique
constraint

\* idoutils: remove and ignore oracle table\_prefix (30 chars max)

\* idoutils: workaround to handle more than 4k data which may exceed
service outputs incl. long perf\_data

\* core init: delete 'su' usage since all previously su touched files
were created by the icinga user

\* idoutils: fix unescape bug during tabstops

\* idoutils: fix idomod/icinga segfault while try to use ssl on unix
sockets

\* core configure: set INIT\_OPTS depending on detected host OS (no more
root:root on FreeBSD?)

\* core spec: added new spec file

\* idoutils: fix case insensitive comparison in MySQL using BINARY

\* idoutils: change ido2db.cfg: ndo2db\_[user|group] to
ido2db\_[user|group]

\* core web: fix missing gif icon copy

**NAME-CORE 0.8.4 - 16/09/2009**

\* idoutils: fix failure\_prediction\_options in tables hosts, services
for postgres

\* idoutils: add configure support for manual libdbi detection

\* idoutils: fix typo laste\_state (wrong column)

\* idoutils: fix buffer freeing with NAGIOS\_SIZEOF\_ARRAY

\* idoutils: delete old mysql files coming from ndoutils

\* idoutils: add new versionhandling, idomod/ido2db now shows version of
Icinga core

\* idoutils: rename existing mysql/pgsql files, added upgrade/fix files

\* idoutils: fix wrong typecast in servicestatusdata\_add, no more
segfault while query preparing

\* idoutils: add experimental db trimming interval option in ido2db.cfg

\* core: fix wrong copyright url for Ethan

**NAME-CORE 0.8.3 - 09/02/2009**

\* idoutils: add PostgreSQL support

\* new Icinga documentation in docbook and html format

\* fetch current Nagios patches

\* fix support links after make

\* idoutils: add note if install desired but not enabled

\* idoutils: fix installing of rc.ido2db in make install-idoutils

\* idoutils: add db/pgsql.sql, adapted table scheme for postgresql

\* idoutils: add time conversion functions for postgresql

\* idoutils: add try update, if affected rows=0, then insert queries for
postgresql

\* idoutils: modify insert queries, normalized to sql-standard

\* idoutils: add insert-or-update functions in dbqueries.c, prepared for
more rdbms

\* idoutils: modify insert-or-update queries, build data array for
functions

\* idoutils: fix string escaping for postgresql

\* idoutils: fix last insert id for postgresql - needs defined sequence
id for table

\* idoutils: modify command\_line in commands table to varchar(1024)

\* idoutils: add more debug output

\* idoutils: Support 8192 chars of perfdata

**NAME-CORE 0.8.2 - 08/12/2009**

\* create a new basic ido2db init script

\* idoutils: fix child signal handling in ido2db

\* idoutils: fix escaping of customvars before insert

\* idoutils: fix in buggy rotate command execution

\* idoutils: fix fmt specifier in ndo2db\_daemonize() error

\* idoutils: added long\_output support to IDOUtils

\* idoutils: Fix for not retrying read on 'EAGAIN' and 'EINTR' soft
errors (Opsera Ltd)

\* idoutils: Allow externalcommands table to be trimmed with a specific
time limit (Opsera Ltd)

\* icinga-api added: The search function now uses the icinga-api
submodule

\* various minor changes

**NAME-CORE 0.8.1 - 06/17/2009**

\* Archived Logfiles renamed from Icinga-date-syntax.log =\>
icinga-date-syntax.log (capital 'i')

\* cherry picked latest Nagios Patches (see Nagios Changelog below)

\* new ido2db command switch: '-f' don't daemonize the ido2db

\* ido2db will now prints out available database drivers

\* fix ido2db segfault when try to access non existing tables

\* DocBook v5 conversion

\* Fix menu frameset cols width

**NAME-CORE 0.8 - 05/19/2009**

\* Almost biggest deal to rename the components

\* including IDOUtils (former NDOUtils) into the core code, updating
configure & make to get in touch with it

\* changed database handling in IDOUtils from native database support to
libdbi (libdbi.sourceforge.net) as an abstraction layer, enable compile
try with "configure --enable-idoutils"

\* Included a new stylesheet/icon theme based on Vautour Style. Vautour
Style have been created by Yoann LAMY.

The menu of Vautour Style use the javascript framework MooTools
(http://mootools.net/). The icons of Vautour Style use "Silk icon set"
(http://www.famfamfam.com/lab/icons/silk/) created by Mark James.

"Silk icon set" is licensed under Creative Commons Attribution 2.5
License (http://creativecommons.org/licenses/by/2.5/).

Changelog of NAME-CORE
