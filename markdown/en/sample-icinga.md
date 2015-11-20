[Prev](sample-config.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](sample-cgi.md)

* * * * *

13.2. icinga.cfg
----------------

<pre><code>
##############################################################################
#
#
# Read the documentation for more information on this configuration
# clear without further explanation.
#
##############################################################################


# LOG FILE
# This is the main log file where service and host events are logged
# in the config file!!!

log_file=@LOGDIR@/icinga.log



# OBJECT CONFIGURATION FILE(S)
# These are the object configuration files in which you define hosts,
# host groups, contacts, contact groups, services, etc.
# Hint: Check the docs/wiki on how to monitor remote hosts with different
# transport methods and plugins

# You can tell Icinga to process all config files (with a .cfg
# extension) in a particular directory recursively by using the
# cfg_dir directive as shown below with conf.d

cfg_dir=@sysconfdir@/conf.d

# or you can split your object definitions across several config files
# in objects/
#
# ATTENTION: do not mix cfg_file and cfg_dir such as
# cfg_file=foo/bar.cfg
# cfg_dir=foo
# this will include bar.cfg 2 times and lead to config verification errors.

# You can specify individual object config files as shown below:
cfg_file=@sysconfdir@/objects/commands.cfg
cfg_file=@sysconfdir@/objects/contacts.cfg
cfg_file=@sysconfdir@/objects/timeperiods.cfg
cfg_file=@sysconfdir@/objects/templates.cfg

# Definitions for monitoring the local (Linux) host
cfg_file=@sysconfdir@/objects/localhost.cfg

# Definitions for monitoring a Windows machine
#cfg_file=@sysconfdir@/objects/windows.cfg

# Definitions for monitoring a router/switch
#cfg_file=@sysconfdir@/objects/switch.cfg

# Definitions for monitoring a network printer
#cfg_file=@sysconfdir@/objects/printer.cfg

# Definitions for ido2db process checks
#cfg_file=@sysconfdir@/objects/ido2db_check_proc.cfg

# Definitions for broker modules like idoutils.cfg
cfg_dir=@sysconfdir@/modules



# OBJECT CACHE FILE
# This option determines where object definitions are cached when
# this cache file (rather than looking at the object config files
# directly) in order to prevent inconsistencies that can occur
# when the config files are modified after Icinga starts.
# If you explicitely set it to /dev/null the core will skip writing
# the objects cache file entirely.
# Tip: Use that file to debug your configuration with fully resolved
# objects like the core sees them.

object_cache_file=@STATEDIR@/objects.cache



# PRE-CACHED OBJECT FILE
# This options determines the location of the precached object file.
# If you run Icinga with the -p command line option, it will preprocess
# your object configuration file(s) and write the cached config to this
# object definitions from this precached file, rather than the standard
# object configuration files (see the cfg_file and cfg_dir options above).
# Using a precached object file can speed up the time needed to (re)start
# the Icinga process if you've got a large and/or complex configuration.
# Read the documentation section on optimizing Icinga to find our more
# about how this feature works.

precached_object_file=@STATEDIR@/objects.precache



# RESOURCE FILE
# This is an optional resource file that contains $USERx$ macro
# definitions. Multiple resource files can be specified by using
# read the contents of resource files, so information that is
# considered to be sensitive (usernames, passwords, etc) can be
# defined as macros in this file and restrictive permissions (600)
# can be placed on this file.

resource_file=@sysconfdir@/resource.cfg



# STATUS FILE
# This is where the current status of all monitored services and
# The contents of the status file are deleted every time Icinga
# restarts.
# If you explicitely set it to /dev/null the core will skip writing
# the status file entirely. This becomes handy when using other methods
# for data retrieval (e.g. IDOUtils DB)

status_file=@STATEDIR@/status.dat



# STATUS FILE UPDATE INTERVAL
# This option determines the frequency (in seconds) that
# Icinga will periodically dump program, host, and
# service status data.
# Increase the value, if you don't require it that often.

#status_update_interval=30
status_update_interval=10



# ICINGA USER
# You can either supply a username or a UID.

icinga_user=@icinga_user@



# ICINGA GROUP
# You can either supply a group name or a GID.

icinga_group=@icinga_grp@



# EXTERNAL COMMAND OPTION
# This option allows you to specify whether or not Icinga should check
# Icinga will *not* check for external commands, just to be on the
# you will have to enable this.
# Values: 0 = disable commands, 1 = enable commands

check_external_commands=1



# EXTERNAL COMMAND CHECK INTERVAL
# This is the interval at which Icinga should check for external commands.
# that at its default value of 60 (seconds), a value of 1 here will cause
# number followed by an "s" (i.e. 15s), this will be interpreted to mean
# actual seconds rather than a multiple of the interval_length variable.
# scheduled intervals, Icinga will also check for external commands after
# event handlers are executed.
# NOTE: Setting this value to -1 causes Icinga to check the external
# command file as often as possible.

#command_check_interval=15s
command_check_interval=-1



# EXTERNAL COMMAND FILE
# This is the file that Icinga checks for external command requests.
# It is also where the command CGI will write commands that are submitted
# by users, so it must be writeable by the user that the web server
# directory level instead of on the file, as the file is deleted every
# time its contents are processed.

command_file=@EXTCMDFILEDIR@/icinga.cmd



# EXTERNAL COMMAND BUFFER SLOTS
# This settings is used to tweak the number of items or "slots" that
# the Icinga daemon should allocate to the buffer that holds incoming
# are processed by the daemon, they are removed from the buffer.
# Increase the value, if you are using addons like check_mk supplying
# more external commands (passive check results) than usual.

#external_command_buffer_slots=32768
external_command_buffer_slots=4096



# LOCK FILE
# This is the lockfile that Icinga will use to store its PID number
# in when it is running in daemon mode.

lock_file=@lockfile@



# TEMP FILE
# This is a temporary file that is used as scratch space when Icinga
# is created, used, and deleted throughout the time that Icinga is
# running.

temp_file=@TMPFILE@



# TEMP PATH
# This is path where Icinga can create temp files for service and
# host check results, etc.

temp_path=@TMPDIR@



# EVENT BROKER OPTIONS
# Controls what (if any) data gets sent to the event broker.

event_broker_options=-1



# EVENT BROKER MODULE(S)
# ----> use the new *module definition* instead:
# ----> http://docs.icinga.org/latest/en/objectdefinitions.md
#
# Example definitions can be found in the '/etc/icinga/modules/' directory.




# LOG ROTATION METHOD
# This is the log rotation method that Icinga should use to rotate
# the main log file. Values are as follows..

log_rotation_method=d



# LOG ARCHIVE PATH
# placed (assuming you've chosen to do log rotation).

log_archive_path=@LOGDIR@/archives



# LOGGING OPTIONS FOR DAEMON
# If you want messages logged to the daemon log file (usually icinga.log).
# Default option is 1 (yes), the other valid option is 0 (no)

use_daemon_log=1



# LOGGING OPTIONS FOR SYSLOG
# If you want messages logged to the syslog facility, as well as the

use_syslog=1



# SYSLOG FACILITY
# If you enabled use_syslog you can set icinga to use a local facility
# instead of the default.To enable set this option to 1, if not, set it to 0.

use_syslog_local_facility=0



# SYSLOG LOCAL FACILITY
# If you specified the use_syslog_local_facility you can chose which
# local facility to use. Valid values are from 0 to 7

syslog_local_facility=5



# NOTIFICATION LOGGING OPTION
# If you don't want notifications to be logged, set this value to 0.
# If notifications should be logged, set the value to 1.

log_notifications=1



# SERVICE RETRY LOGGING OPTION
# If you don't want service check retries to be logged, set this value

log_service_retries=1



# HOST RETRY LOGGING OPTION
# If you don't want host check retries to be logged, set this value to

log_host_retries=1



# EVENT HANDLER LOGGING OPTION
# If you don't want host and service event handlers to be logged, set
# to 1.

log_event_handlers=1



# INITIAL STATES LOGGING OPTION
# If you want Icinga to log all initial host and service states to
# the main log file (the first time the service or host is checked)
# are not using an external application that does long term state
# this case, set the value to 0.

log_initial_states=0



# CURRENT STATES LOGGING OPTION
# If you don't want Icinga to log all current host and service states
# after log has been rotated to the main log file, you can disable this
# option by setting this value to 0. Default value is 1.

log_current_states=1



# EXTERNAL COMMANDS LOGGING OPTION
# If you don't want Icinga to log external commands, set this value
# Note: This option does not include logging of passive service
# passive checks are logged.

log_external_commands=1



# PASSIVE CHECKS LOGGING OPTION
# If you don't want Icinga to log passive host and service checks, set
# this value to 1.

log_passive_checks=1



# LONG PLUGIN OUTPUT LOGGING OPTION
# If you want Icinga to log the complete text of the plugin output
# to the log instead of only the first line then set this value to 1.
# Default value is 0.

log_long_plugin_output=0



# GLOBAL HOST AND SERVICE EVENT HANDLERS
# These options allow you to specify a host and service event handler
# command that is to be run for every host or service state change.
# The global event handler is executed immediately prior to the event
# handler that you have optionally specified in each host or
# service definition. The command argument is the short name of a
# command definition that you define in your host configuration file.
# Read the HTML docs for more information.

#global_host_event_handler=somecommand
#global_service_event_handler=somecommand



# SERVICE INTER-CHECK DELAY METHOD
# This is the method that Icinga should use when initially
# default is to use smart delay calculation, which will try to
# space all service checks out evenly to minimize CPU load.
# Using the dumb setting will cause all checks to be scheduled
# good thing for production, but is useful when testing the
# parallelization functionality.

service_inter_check_delay_method=s



# MAXIMUM SERVICE CHECK SPREAD
# This variable determines the timeframe (in minutes) from the
# program start time that an initial check of all services should

max_service_check_spread=30



# SERVICE CHECK INTERLEAVE FACTOR
# This variable determines how service checks are interleaved.
# Interleaving the service checks allows for a more even
# distribution of service checks and reduced load on remote
# value to s (smart) for automatic calculation of the interleave
# factor unless you have a specific reason to change it.

service_interleave_factor=s



# HOST INTER-CHECK DELAY METHOD
# This is the method that Icinga should use when initially
# default is to use smart delay calculation, which will try to
# space all host checks out evenly to minimize CPU load.
# Using the dumb setting will cause all checks to be scheduled
# at the same time (with no delay between them)!

host_inter_check_delay_method=s



# MAXIMUM HOST CHECK SPREAD
# This variable determines the timeframe (in minutes) from the
# program start time that an initial check of all hosts should

max_host_check_spread=30



# MAXIMUM CONCURRENT SERVICE CHECKS
# service checks that can be run in parallel at any given time.
# Specifying a value of 1 for this variable essentially prevents
# will not restrict the number of concurrent checks that are
# being executed.

max_concurrent_checks=0



# HOST AND SERVICE CHECK REAPER FREQUENCY
# This is the frequency (in seconds!) that Icinga will process
# the results of host and service checks.
# Lower this value in larger environments to allow faster
# check result processing (requires more cpu power).

#check_result_reaper_frequency=1
check_result_reaper_frequency=10




# MAX CHECK RESULT REAPER TIME
# returning control back to Icinga so it can perform other
# duties.

max_check_result_reaper_time=30




# CHECK RESULT PATH
# This is directory where Icinga stores the results of host and
# service checks that have not yet been processed.
#
# Note: Make sure that only one instance of Icinga has access

check_result_path=@CHECKRESULTDIR@




# MAX CHECK RESULT FILE AGE
# This option determines the maximum age (in seconds) which check
# threshold will be mercilessly deleted without further processing.

max_check_result_file_age=3600




# MAX CHECK RESULT LIST ITEMS !!EXPERIMENTAL!!
# This experimental option allows you to set the max number of items
# the checkresult reaper will put onto the checkresult list for further
# processing by the core. If there are too many, the reaping will be
# terminated early, allowing the core to process the results sooner.
# On larger setups, that list might grow too much, and decrease
# performance on processing. You might experiment with that value, the
# inner core default is set to 0, disabling that feature.
# Values:

#max_check_result_list_items=1024




# CACHED HOST CHECK HORIZON
# This option determines the maximum amount of time (in seconds)
# that the state of a previous host check is considered current.
# Cached host states (from host checks that were performed more
# recently that the timeframe specified by this value) can immensely
# improve performance in regards to the host check logic.
# Too high of a value for this option may result in inaccurate host
# states being used by Icinga, while a lower value may result in a
# check caching.

cached_host_check_horizon=15



# CACHED SERVICE CHECK HORIZON
# This option determines the maximum amount of time (in seconds)
# that the state of a previous service check is considered current.
# Cached service states (from service checks that were performed more
# recently that the timeframe specified by this value) can immensely
# improve performance in regards to predictive dependency checks.
# Use a value of 0 to disable service check caching.

cached_service_check_horizon=15



# ENABLE PREDICTIVE HOST DEPENDENCY CHECKS
# This option determines whether or not Icinga will attempt to execute
# checks of hosts when it predicts that future dependency logic test
# host dependency logic works well.
# Values:

enable_predictive_host_dependency_checks=1



# ENABLE PREDICTIVE SERVICE DEPENDENCY CHECKS
# This option determines whether or not Icinga will attempt to execute
# checks of service when it predicts that future dependency logic test
# service dependency logic works well.
# Values:

enable_predictive_service_dependency_checks=1



# SOFT STATE DEPENDENCIES
# checking dependencies. If you want it to use the latest state (regardless
# Values:

soft_state_dependencies=0



# TIME CHANGE ADJUSTMENT THRESHOLDS
# These options determine when Icinga will react to detected changes
# in system time (forward into the future).

#time_change_threshold=900



# AUTO-RESCHEDULING OPTION
# This option determines whether or not Icinga will attempt to
# automatically reschedule active host and service checks to
# PERFORMANCE, RATHER THAN INCREASE IT, IF USED IMPROPERLY

auto_reschedule_checks=0



# AUTO-RESCHEDULING INTERVAL
# This option determines how often (in seconds) Icinga will
# has an effect if the auto_reschedule_checks option is enabled.
# Default is 30 seconds.
# PERFORMANCE, RATHER THAN INCREASE IT, IF USED IMPROPERLY

auto_rescheduling_interval=30



# AUTO-RESCHEDULING WINDOW
# This option determines the "window" of time (in seconds) that
# Icinga will look at when automatically rescheduling checks.
# Only host and service checks that occur in the next X seconds
# (determined by this variable) will be rescheduled. This option
# only has an effect if the auto_reschedule_checks option is
# PERFORMANCE, RATHER THAN INCREASE IT, IF USED IMPROPERLY

auto_rescheduling_window=180



# SLEEP TIME
# This is the number of seconds to sleep between checking for system
# events and service checks that need to be run.

sleep_time=0.25



# TIMEOUT VALUES
# These options control how much time Icinga will allow various
# are available for controlling maximum time allotted for
# service checks, host checks, event handlers, notifications, the
# seconds.
# Increase the timeout values in case you are experiencing a lot
# of check timeouts. Addons like e.g. check_mk will perform
# one combined active servicecheck which could take longer than
# the default of 60sec.

#service_check_timeout=120
service_check_timeout=60
host_check_timeout=30
event_handler_timeout=30
notification_timeout=30
ocsp_timeout=5
perfdata_timeout=5



# RETAIN STATE INFORMATION
# This setting determines whether or not Icinga will save state
# startup Icinga will reload all saved service and host state
# maintaining long-term data on state statistics, etc, but will
# a one-time penalty, I think its well worth the additional
# startup delay.

retain_state_information=1



# STATE RETENTION FILE
# This is the file that Icinga should use to store host and
# information in this file is also read immediately prior to
# starting to monitor the network when Icinga is restarted.
# This file is used only if the retain_state_information
# variable is set to 1.

state_retention_file=@STATEDIR@/retention.dat



# SYNC FILE
# to the state retention file with the following difference:
#
#
#
# file is read successfully, it will be removed.
# If the file does not exist, no error will appear.
# There is also an API that will force a read of the sync file.

#sync_retention_file=@STATEDIR@/sync.dat



# RETENTION DATA UPDATE INTERVAL
# This setting determines how often (in minutes) that Icinga
# will automatically save retention data during normal operation.
# If you set this value to 0, Icinga will not save retention
# data at regular interval, but it will still save retention
# state retention, this option has no effect.

retention_update_interval=60



# USE RETAINED PROGRAM STATE
# program status variables based on the values saved in the
# to 0.

use_retained_program_state=1


# DUMP RETAINED HOST SERVICE STATES TO NEB
# This setting determines wether or not Icinga will dump host
# and service states based on the values saved in the retention
# file to the neb modules. If you don't want that, use at your
# own risk and disable it

dump_retained_host_service_states_to_neb=1



# USE RETAINED SCHEDULING INFO
# This setting determines whether or not Icinga will retain
# the scheduling info (next check time) for hosts and services
# If you want to use retained scheduling info, set this

use_retained_scheduling_info=1



# RETAINED ATTRIBUTE MASKS (ADVANCED FEATURE)
# The following variables are used to specify specific host and
# service attributes that should *not* be retained by Icinga during
# program restarts.
#
# The values of the masks are bitwise ANDs of values specified
# For example, if you do not want the current enabled/disabled state
# of flap detection and event handlers for hosts to be retained, you
# would use a value of 24 for the host attribute mask...
# MODATTR_EVENT_HANDLER_ENABLED (8) + MODATTR_FLAP_DETECTION_ENABLED (16) = 24

# This mask determines what host attributes are not retained
retained_host_attribute_mask=0

# This mask determines what service attributes are not retained
retained_service_attribute_mask=0

# These two masks determine what process attributes are not retained.
# There are two masks, because some process attributes have host and service
# service checks enabled.
retained_process_host_attribute_mask=0
retained_process_service_attribute_mask=0

# These two masks determine what contact attributes are not retained.
# There are two masks, because some contact attributes have host and
# a contact, but leave service notifications enabled for them.
retained_contact_host_attribute_mask=0
retained_contact_service_attribute_mask=0



# INTERVAL LENGTH
# This is the seconds per unit interval as used in the
# have not been tested much, so your mileage is likely to vary...

interval_length=60



# AGGRESSIVE HOST CHECKING OPTION
# If you don't want to turn on aggressive host checking features, set
# on what aggressive host check is or check out the source code in
# base/checks.c

use_aggressive_host_checking=0



# SERVICE CHECK EXECUTION OPTION
# This determines whether or not Icinga will actively execute
# disabled, checks are not actively made, but Icinga can still
# you're implementing redundant hosts or have a special need for
# disabling the execution of service checks, leave this enabled!
# Values: 1 = enable checks, 0 = disable checks

execute_service_checks=1



# PASSIVE SERVICE CHECK ACCEPTANCE OPTION
# This determines whether or not Icinga will accept passive
# service checks results when it initially (re)starts.
# Values: 1 = accept passive checks, 0 = reject passive checks

accept_passive_service_checks=1



# HOST CHECK EXECUTION OPTION
# This determines whether or not Icinga will actively execute
# disabled, checks are not actively made, but Icinga can still
# you're implementing redundant hosts or have a special need for
# disabling the execution of host checks, leave this enabled!
# Values: 1 = enable checks, 0 = disable checks

execute_host_checks=1



# PASSIVE HOST CHECK ACCEPTANCE OPTION
# This determines whether or not Icinga will accept passive
# host checks results when it initially (re)starts.
# Values: 1 = accept passive checks, 0 = reject passive checks

accept_passive_host_checks=1



# NOTIFICATIONS OPTION
# This determines whether or not Icinga will sent out any host or
# service notifications when it is initially (re)started.
# Values: 1 = enable notifications, 0 = disable notifications

enable_notifications=1



# EVENT HANDLER USE OPTION
# This determines whether or not Icinga will run any host or
# you're implementing redundant hosts, leave this option enabled.
# Values: 1 = enable event handlers, 0 = disable event handlers

enable_event_handlers=1



# STATE BASED ESCALATION RANGES !!!Experimental!!!
# This option allows you to enable state based escalation ranges which
# will allow a more detailed granularity on when an escalation notification
# may happen, adding a filter based on the current host or service state
# when checking the escalation for notification viability.
# This is a behavioural change to the default, and therefore intentionally
# disabled. Enable at your own risk, as this remains an experimental feature.
# Values: 1 = enable state based escalation ranges,
# 0 = disable state based escalation ranges

#enable_state_based_escalation_ranges=0



# PROCESS PERFORMANCE DATA OPTION
# This determines whether or not Icinga will process performance
# enabled, host performance data will be processed using the
# host_perfdata_command (defined below) and service performance
# data will be processed using the service_perfdata_command (also
# performance data.
# Values: 1 = process performance data, 0 = do not process performance data

process_performance_data=0



# HOST AND SERVICE PERFORMANCE DATA PROCESSING COMMANDS
# These commands are run after every host and service check is
# argument is the short name of a command definition that you
# more information on performance data.

#host_perfdata_command=process-host-perfdata
#service_perfdata_command=process-service-perfdata



# HOST AND SERVICE PERFORMANCE DATA FILES
# These files are used to store host and service performance data.
# Performance data is only written to these files if the
# process_performance_data option (above) is set to 1.

#host_perfdata_file=/tmp/host-perfdata
#service_perfdata_file=/tmp/service-perfdata



# HOST AND SERVICE PERFORMANCE DATA FILE TEMPLATES
# These options determine what data is written (and how) to the
# characters (\t for tab, \r for carriage return, \n for newline)
# shown below.

#host_perfdata_file_template=[HOSTPERFDATA]\t$TIMET$\t$HOSTNAME$\t$HOSTEXECUTIONTIME$\t$HOSTOUTPUT$\t$HOSTPERFDATA$
#service_perfdata_file_template=[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$



# HOST AND SERVICE PERFORMANCE DATA FILE MODES
# This option determines whether or not the host and service
# performance data files are opened in write ("w") or append ("a")
# mode. If you want to use named pipes, you should use the special
# pipe ("p") mode which avoid blocking at startup, otherwise you will
# likely want the defult append ("a") mode.

#host_perfdata_file_mode=a
#service_perfdata_file_mode=a



# HOST AND SERVICE PERFORMANCE DATA FILE PROCESSING INTERVAL
# These options determine how often (in seconds) the host and service
# performance data files are processed using the commands defined
# processed.

#host_perfdata_file_processing_interval=0
#service_perfdata_file_processing_interval=0



# HOST AND SERVICE PERFORMANCE DATA FILE PROCESSING COMMANDS
# These commands are used to periodically process the host and
# processing occurs is determined by the options above.

#host_perfdata_file_processing_command=process-host-perfdata-file
#service_perfdata_file_processing_command=process-service-perfdata-file


# HOST AND SERVICE PERFORMANCE DATA PROCESS EMPTY RESULTS
# THese options determine wether the core will process empty perfdata
# results or not. This is needed for distributed monitoring, and intentionally
# turned on by default.
# Values: 1 = enable, 0 = disable

#host_perfdata_process_empty_results=1
#service_perfdata_process_empty_results=1



# ALLOW EMPTY HOSTGROUP ASSIGMENT FOR SERVICES
# This boolean option determines whether services assigned to empty
# host groups (host groups with no host members) will cause Icinga to
# exit with error on start up (or during a configuration check) or not.
# It's useful to be able to assign services to empty hostgroups when
# configuration files or pre-cached object files are distributed to
# various pollers, or when the process of generating Icinga config is
# automated, or when a set of services is slowly being phased out but
# should be kept around.
# The default behavior if the option is not present in the main
# configuration file is for Icinga to exit with error if services are
# associated with host groups that have no hosts associated with them.

#allow_empty_hostgroup_assignment=0



# OBSESS OVER SERVICE CHECKS OPTION
# This determines whether or not Icinga will obsess over service
# planning on implementing distributed monitoring, do not enable
# implementing distributed monitoring.
# Values: 1 = obsess over services, 0 = do not obsess (default)

obsess_over_services=0



# OBSESSIVE COMPULSIVE SERVICE PROCESSOR COMMAND
# This is the command that is run for every service check that is
# argument is the short name of a command definition that you
# define in your host configuration file. Read the HTML docs for
# more information on implementing distributed monitoring.

#ocsp_command=somecommand



# OBSESS OVER HOST CHECKS OPTION
# This determines whether or not Icinga will obsess over host
# planning on implementing distributed monitoring, do not enable
# implementing distributed monitoring.
# Values: 1 = obsess over hosts, 0 = do not obsess (default)

obsess_over_hosts=0



# OBSESSIVE COMPULSIVE HOST PROCESSOR COMMAND
# This is the command that is run for every host check that is
# argument is the short name of a command definition that you
# define in your host configuration file. Read the HTML docs for
# more information on implementing distributed monitoring.

#ochp_command=somecommand



# TRANSLATE PASSIVE HOST CHECKS OPTION
# This determines whether or not Icinga will translate
# DOWN/UNREACHABLE passive host check results into their proper
# these cases your other Icinga servers probably have a different
# "view" of the network, with regards to the parent/child relationship
# is DOWN, it may actually be UNREACHABLE from the point of
# to translate any DOWN or UNREACHABLE host states it receives
# passively into the correct state from the view of this server.
# Values: 1 = perform translation, 0 = do not translate (default)

translate_passive_host_checks=0



# PASSIVE HOST CHECKS ARE SOFT OPTION
# This determines whether or not Icinga will treat passive host
# by enabling this option.
# Values: 0 = passive checks are HARD, 1 = passive checks are SOFT

passive_host_checks_are_soft=0



# ORPHANED HOST/SERVICE CHECK OPTIONS
# instance are processed, there exists a possibility that some
# host checks, although the exact scheduling details differ a bit
# problem and should not happen under normal circumstances.
# If you have problems with service checks never getting
# rescheduled, make sure you have orphaned service checks enabled.
# Values: 1 = enable checks, 0 = disable checks

check_for_orphaned_services=1
check_for_orphaned_hosts=1



# SERVICE CHECK TIMEOUT STATE
# This setting determines the state Icinga will report when a
# service check times out meaning it does not respond within
# and not Critical.
# Valid settings are:

service_check_timeout_state=u



# SERVICE FRESHNESS CHECK OPTION
# This option determines whether or not Icinga will periodically
# is useful for ensuring passive checks are received in a timely
# manner.
# Values: 1 = enabled freshness checking, 0 = disable freshness checking

check_service_freshness=1



# SERVICE FRESHNESS CHECK INTERVAL
# This setting determines how often (in seconds) Icinga will
# disabled service freshness checking, this option has no effect.

service_freshness_check_interval=60



# HOST FRESHNESS CHECK OPTION
# This option determines whether or not Icinga will periodically
# is useful for ensuring passive checks are received in a timely
# manner.
# Values: 1 = enabled freshness checking, 0 = disable freshness checking

check_host_freshness=0



# HOST FRESHNESS CHECK INTERVAL
# This setting determines how often (in seconds) Icinga will
# disabled host freshness checking, this option has no effect.

host_freshness_check_interval=60




# ADDITIONAL FRESHNESS THRESHOLD LATENCY
# This setting determines the number of seconds that Icinga
# will add to any host and service freshness thresholds that
# it calculates (those not explicitly specified by the user).

additional_freshness_latency=15




# FLAP DETECTION OPTION
# This option determines whether or not Icinga will try
# Flapping occurs when a host or service changes between
# host or service is flapping, it will temporarily suppress
# notifications for that host/service until it stops
# the HTML documentation before enabling this feature!
# Values: 1 = enable flap detection

enable_flap_detection=1



# FLAP DETECTION THRESHOLDS FOR HOSTS AND SERVICES
# Read the HTML documentation on flap detection for
# has no effect if flap detection is disabled.

low_service_flap_threshold=5.0
high_service_flap_threshold=20.0
low_host_flap_threshold=5.0
high_host_flap_threshold=20.0



# DATE FORMAT OPTION
# This option determines how short dates are displayed. Valid options
# include:
#

date_format=us




# TIMEZONE OFFSET
# This option is used to override the default timezone that this
# the system configured timezone.
#
# NOTE: In order to display the correct timezone in the CGIs, you
#

#use_timezone=US/Mountain
#use_timezone=Australia/Brisbane




# P1.PL FILE LOCATION
# This value determines where the p1.pl perl script (used by the
# Icinga with embedded Perl support, this option has no effect.

p1_file=@P1FILELOC@/p1.pl



# EMBEDDED PERL INTERPRETER OPTION
# This option determines whether or not the embedded Perl interpreter
# has not been compiled with support for embedded Perl.
# This option is intentionally disabled by default, because embedded
# perl can cause memory leaks and make Icinga unstable if not properly
# used.
# Only enable this setting when you really know what you are doing!
# Values: 0 = disable interpreter, 1 = enable interpreter

enable_embedded_perl=0



# EMBEDDED PERL USAGE OPTION
# This option determines whether or not Icinga will process Perl plugins
# and scripts with the embedded Perl interpreter if the plugins/scripts
# do not explicitly indicate whether or not it is okay to do so. Read
# information on how this option works.

use_embedded_perl_implicitly=1



# EVENT HANDLERS FOR STALKED HOSTS/SERVICES
# Allow running event handlers for stalked hosts/services in order
# to forward to external systems.
# Values: 0 = disabled (default), 1 = enabled

stalking_event_handlers_for_hosts=0
stalking_event_handlers_for_services=0



# NOTIFICATIONS FOR STALKED HOSTS/SERVICES
# Allow notifications for stalked hosts/services globally
# for all contacts in order to notify about a stalking
# alert.
# Values: 0 = disabled (default), 1 = enabled

stalking_notifications_for_hosts=0
stalking_notifications_for_services=0



# ILLEGAL OBJECT NAME CHARACTERS
# This option allows you to specify illegal characters that cannot
# be used in host names, service descriptions, or names of other
# object types.

illegal_object_name_chars=`~!$%^&*|'"<>?,()=



# ILLEGAL MACRO OUTPUT CHARACTERS
# This option allows you to specify illegal characters that are
# stripped from macros before being used in notifications, event
# host check commands.
# The following macros are stripped of the characters you specify:

illegal_macro_output_chars=`~$&|'"<>



# KEEP UNKNOWN MACROS
# This option can be used to keep unknown macros within the output.
# e.g. check_proc -C $foo$ will remain.
# This was the default in versions older than Icinga 1.8, but now
# the default is to remove those macros from the output, causing
# the shell to interpret $foo and leaving a single $ there. See
# #2291 for further information.
# Make sure to escape single dollar signs with another '$', as the
# docs describe. Other than that, enable this setting to revert to
# the old behaviour.

keep_unknown_macros=0



# REGULAR EXPRESSION MATCHING
# This option controls whether or not regular expression matching
# matching is used to match host, hostgroup, service, and service
# group names/descriptions in some fields of various object types.
# Values: 1 = enable regexp matching, 0 = disable regexp matching

use_regexp_matching=0



# "TRUE" REGULAR EXPRESSION MATCHING
# only has an effect if regular expression matching is enabled
# matching only occurs if a string contains wildcard characters
# all the time (which can be annoying).
# Values: 1 = enable true matching, 0 = disable true matching

use_true_regexp_matching=0



# ADMINISTRATOR EMAIL/PAGER ADDRESSES
# The email and pager address of a global administrator (likely you).
# Icinga never uses these values itself, but you can access them by
# using the $ADMINEMAIL$ and $ADMINPAGER$ macros in your notification
# commands.

admin_email=@icinga_user@@localhost
admin_pager=page@icinga_user@@localhost



# DAEMON CORE DUMP OPTION
# This option determines whether or not Icinga is allowed to create
# considered bad form to allow this, but it may be useful for
# a core file will be produced, but that's just life...

daemon_dumps_core=0



# LARGE INSTALLATION TWEAKS OPTION
# This option determines whether or not Icinga will take some shortcuts
# which can save on memory and CPU usage in large Icinga installations.
# Read the documentation for more information on the benefits/tradeoffs
# of enabling this option.

use_large_installation_tweaks=0



# ENABLE ENVIRONMENT MACROS
# This option determines whether or not Icinga will make all standard
# macros available as environment variables when host/service checks
# and system commands (event handlers, notifications, etc.) are
# large installations, as it will consume a bit more memory and (more
# importantly) consume more CPU.
# Keep in mind that various addons/plugins will require this setting
# to be enabled (e.g. check_oracle_health) for special usage.

enable_environment_macros=0



# CHILD PROCESS MEMORY OPTION
# This option determines whether or not Icinga will free memory in
# child processes (processed used to execute system commands and host/
# program defaults.

#free_child_process_memory=1



# CHILD PROCESS FORKING BEHAVIOR
# This option determines how Icinga will fork child processes
# child processes are fork()ed twice, which provides a very high level
# save a great deal on CPU usage (in large installs), so you might
# program defaults.

#child_processes_fork_twice=1



# DEBUG LEVEL
# This option determines how much (if any) debugging information will
# types of information.

debug_level=0



# DEBUG VERBOSITY
# This option determines how verbose the debug log out will be.
# Values: 0 = Brief output

debug_verbosity=2



# DEBUG FILE
# This option determines where Icinga should write debugging information.

debug_file=@LOGDIR@/icinga.debug



# MAX DEBUG FILE SIZE
# the file grows larger than this size, it will be renamed with a .old
# get out of control when debugging Icinga.

# 100M
max_debug_file_size=100000000
</code></pre>

* * * * *

[Prev](sample-config.md) | [Up](ch13.md) | [Next](sample-cgi.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
