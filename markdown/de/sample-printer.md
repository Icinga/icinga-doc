 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

13.10. printer.cfg
------------------

<pre><code>
###############################################################################
#
# NOTES: This config file assumes that you are using the sample configuration
#
###############################################################################




###############################################################################
###############################################################################
#
# HOST DEFINITIONS
#
###############################################################################
###############################################################################

# Define a host for the printer we'll be monitoring
# Change the host_name, alias, and address to fit your situation

define host{




###############################################################################
###############################################################################
#
# HOST GROUP DEFINITIONS
#
###############################################################################
###############################################################################

# A hostgroup for network printers

define hostgroup{




###############################################################################
###############################################################################
#
# SERVICE DEFINITIONS
#
###############################################################################
###############################################################################

# Create a service for monitoring the status of the printer
# Change the host_name to match the name of the host you defined above
# If the printer has an SNMP community string other than "public", change the check_command directive to reflect that

define service{



define service{
</code></pre>

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
