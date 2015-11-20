[Prev](sample-contacts.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](sample-notifications.md)

* * * * *

13.8.  localhost.cfg
--------------------

<pre><code>
###############################################################################
#
#
###############################################################################




###############################################################################
###############################################################################
#
# HOST DEFINITION
#
###############################################################################
###############################################################################

# Define a host for the local machine

define host{



###############################################################################
###############################################################################
#
# HOST GROUP DEFINITION
#
###############################################################################
###############################################################################

# Define an optional hostgroup for Linux machines

define hostgroup{



###############################################################################
###############################################################################
#
# SERVICE DEFINITIONS
#
###############################################################################
###############################################################################


# Define a service to "ping" the local machine

define service{


# Define a service to check the disk space of the root partition
# < 10% free space on partition.

define service{



# Define a service to check the number of currently logged in
# if > 50 users.

define service{


# Define a service to check the number of currently running procs
# > 400 users.

define service{




define service{



# Critical if less than 10% of swap is free, warning if less than 20% is free

define service{



# Define a service to check SSH on the local machine.
# Disable notifications for this service by default, as not all users may have SSH enabled.

define service{



# Define a service to check HTTP on the local machine.
# Disable notifications for this service by default, as not all users may have HTTP enabled.

define service{


# Define a service to check current startup delay of the Icinga core daemon.
# Disable notifications for this service by default, as no thresholds are defined.

define service{
</code></pre>

* * * * *

[Prev](sample-contacts.md) | [Up](ch13.md) | [Next](sample-notifications.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
