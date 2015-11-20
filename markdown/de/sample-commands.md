 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

13.6. commands.cfg
------------------

<pre><code>
###############################################################################
#
# NOTES: This config file provides you with some example command definitions
#
###############################################################################


################################################################################
#
# SAMPLE NOTIFICATION COMMANDS
#
# you to use "/usr/bin/mailx" instead of "/usr/bin/mail" in the commands below.
#
################################################################################


# 'notify-host-by-email' command definition
define command{

# 'notify-service-by-email' command definition
define command{





################################################################################
#
# SAMPLE HOST CHECK COMMANDS
#
################################################################################


# This command checks to see if a host is "alive" by pinging it
# average time to produce a critical error.
# Note: Five ICMP echo packets are sent (determined by the '-p 5' argument)

# 'check-host-alive' command definition
define command{




################################################################################
#
# SAMPLE SERVICE CHECK COMMANDS
#
# documentation on the plugins for examples of how to configure command definitions.
#
################################################################################

# 'check_local_disk' command definition
define command{


# 'check_local_load' command definition
define command{


# 'check_local_procs' command definition
define command{


# 'check_local_users' command definition
define command{


# 'check_local_swap' command definition
define command{


# 'check_local_mrtgtraf' command definition
define command{


################################################################################
################################################################################

# 'check_ftp' command definition
define command{


# 'check_hpjd' command definition
define command{


# 'check_snmp' command definition
define command{


# 'check_http' command definition
define command{


# 'check_ssh' command definition
define command{


# 'check_dhcp' command definition
define command{


# 'check_ping' command definition
define command{


# 'check_pop' command definition
define command{


# 'check_imap' command definition
define command{


# 'check_smtp' command definition
define command{


# 'check_tcp' command definition
define command{


# 'check_udp' command definition
define command{


# 'check_nt' command definition
define command{


# 'check_dummy' command definition
define command{

# 'check_icinga_startup_delay' command definition
define command {
}


################################################################################
#
# SAMPLE PERFORMANCE DATA COMMANDS
#
# These are sample performance data commands that can be used to send performance
# host_perfdata_file and service_perfdata_file options in the main config file.
#
################################################################################


# 'process-host-perfdata' command definition
define command{


# 'process-service-perfdata' command definition
define command{
</code></pre>

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
