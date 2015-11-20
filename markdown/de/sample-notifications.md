 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

13.9. notifications.cfg
-----------------------

<pre><code>
###############################################################################
#
# NOTES: This config file provides you with some example notification definitions
#
#
# you to use "/usr/bin/mailx" instead of "/usr/bin/mail" in the commands below.
#
# Furthermore, make sure to replace ICINGAHOST with the appropriate host name
# if used in any notification as url.
#
# Notifications are using the macros quite a lot. Watch out for your own in the
# official docs: http://docs.icinga.org/latest/en/macrolist.md
#
# Those notification commands need to be assigned to the contacts/contactgroups
# as host_notification_commands and service_notification_commands as comma
# separated list.
#
################################################################################


################################################################################
# NOTIFICATIONS BY EMAIL
#
# The idea is to add more information to the ascii-only email. This includes
# notes_url, display_name, comment+author.
#
#
#
#
#
################################################################################


# 'notify-host-by-email-advanced' command definition
define command{

# 'notify-service-by-email-advanced' command definition
define command{


################################################################################
# NOTIFICATIONS BY JABBER (XMPP)
#
# http://www.gridpp.ac.uk/wiki/Nagios_jabber_notification
# check contrib/notifications/notify_via_jabber for the script and copy it to
# $USER1$ location (check resource.cfg)
#
# Hint: make sure to define 'pager' as contact attribute! Alternatively, replace
# $CONTACTPAGER$ with $CONTACTADDRESS1$ and use 'address1' attribute instead.
################################################################################




################################################################################
# NOTIFICATIONS BY TWITTER
#
# https://wiki.icinga.org/display/howtos/notify+via+Twitter
################################################################################

define command {
}

define command {
}


################################################################################
# NOTIFICATIONS BY SMS
#
# First off, you need either a local sms service, or an sms gateway. Besides
# an applicable plugin interacting the that api and integrated as notification
# command. Below is only the command example.
################################################################################







################################################################################
# MORE NOTIFICATION POSSIBILITIES
#
# NoMa: https://www.netways.org/projects/noma/
# IRCBot: http://www.vanheusden.com/nagircbot/
################################################################################
</code></pre>

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
