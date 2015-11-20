[Prev](sample-timeperiods.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ix01.md)

* * * * *

13.14. windows.cfg
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

# Define a host for the Windows machine we'll be monitoring
# Change the host_name, alias, and address to fit your situation

define host{




###############################################################################
###############################################################################
#
# HOST GROUP DEFINITIONS
#
###############################################################################
###############################################################################


# Define a hostgroup for Windows machines
# All hosts that use the windows-server template will automatically be a member of this group

define hostgroup{




###############################################################################
###############################################################################
#
# SERVICE DEFINITIONS
#
###############################################################################
###############################################################################


# Create a service for monitoring the version of NSCLient++ that is installed
# Change the host_name to match the name of the host you defined above

define service{



# Create a service for monitoring the uptime of the server
# Change the host_name to match the name of the host you defined above

define service{



# Create a service for monitoring CPU load
# Change the host_name to match the name of the host you defined above

define service{



# Create a service for monitoring memory usage
# Change the host_name to match the name of the host you defined above

define service{



# Create a service for monitoring C:\ disk usage
# Change the host_name to match the name of the host you defined above

define service{



# Create a service for monitoring the W3SVC service
# Change the host_name to match the name of the host you defined above

define service{



# Create a service for monitoring the Explorer.exe process
# Change the host_name to match the name of the host you defined above

define service{
</code></pre>

* * * * *

[Prev](sample-timeperiods.md) | [Up](ch13.md) | [Next](ix01.md)

13.13. timeperiods.cfg  |<=== [Index](index.md) ===>|  Index

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
