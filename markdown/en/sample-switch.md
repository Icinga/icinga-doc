[Prev](sample-printer.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](sample-templates.md)

* * * * *

13.11. switch.cfg
-----------------

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

# Define the switch that we'll be monitoring

define host{




###############################################################################
###############################################################################
#
# HOST GROUP DEFINITIONS
#
###############################################################################
###############################################################################

# Create a new hostgroup for switches

define hostgroup{




###############################################################################
###############################################################################
#
# SERVICE DEFINITIONS
#
###############################################################################
###############################################################################

# Create a service to PING to switch

define service{


# Monitor uptime via SNMP

define service{



# Monitor Port 1 status via SNMP

define service{



# Monitor bandwidth via MRTG logs

define service{










</code></pre>

* * * * *

[Prev](sample-printer.md) | [Up](ch13.md) | [Next](sample-templates.md)

13.10. printer.cfg  |<=== [Index](index.md) ===>|  13.12. templates.cfg

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
