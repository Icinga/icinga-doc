[Prev](configmain.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](objectdefinitions.md)

* * * * *

3.3. Object Configuration Overview
----------------------------------

**What Are Objects?**

Objects are all the elements that are involved in the monitoring and
notification logic. Types of objects include:











More information on what objects are and how they relate to each other
can be found below.

**Where Are Objects Defined?**

Objects can be defined in one or more configuration files and/or
directories that you specify using the
[cfg\_file](configmain.md#configmain-cfg_file) and/or
[cfg\_dir](configmain.md#configmain-cfg_dir) directives in the main
configuration file.

**include\_file / include\_dir**

An object definition file can include other object definition files with
the use of the **include\_file=\< file\_name\>** and
**include\_dir=\<directory\_name\>** directives. The former includes the
single file specified, the latter will process all files ending in the
*.cfg* extension in the directory specified. These directives may be
repeated to include multiple files/directories.

The directives are not allowed within the actual definition of an
object, and should appear before, after, or in between any object
definitions. They are closely related to the
[cfg\_file=](configmain.md#configmain-cfg_file) and
[cfg\_dir=](configmain.md#configmain-cfg_dir) directives in the main
configuration file.

These directives may be chained; e.g. an object definition file included
from the main configuration file with a **cfg\_file=** or **cfg\_dir=**
directive can use **include\_file=** or **include\_dir=** to include
another object definition file, which in turn can also use
**include\_file=** or **include\_dir=** to include yet another object
definition file, and so on.

![[Tip]](../images/tip.png)

Tip

When you follow [quickstart installation
guide](quickstart.md "2.3. Quickstart Installation Guides"), several
sample object configuration files are placed in
*/usr/local/icinga/etc/objects/*. You can use these sample files to see
how object inheritance works and learn how to define your own object
definitions.

**How Are Objects Defined?**

Objects are defined in a flexible template format, which can make it
much easier to manage your Icinga configuration in the long term. Basic
information on how to define objects in your configuration files can be
found [here](objectdefinitions.md "3.4. Object Definitions").

Once you get familiar with the basics of how to define objects, you
should read up on [object
inheritance](objectinheritance.md "7.26. Object Inheritance"), as it
will make your configuration more robust for the future. Seasoned users
can exploit some advanced features of object definitions as described in
the documentation on [object
tricks](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions").

**Objects Explained**

Some of the main object types are explained in greater detail below...

[**Hosts**](objectdefinitions.md#objectdefinitions-host) are one of
the central objects in the monitoring logic. Important attributes of
hosts are as follows:





[**Host Groups**](objectdefinitions.md#objectdefinitions-hostgroup)
are groups of one or more hosts. Host groups can make it easier to (1)
view the status of related hosts in the Icinga web interface and (2)
simplify your configuration through the use of [object
tricks](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions").

![](../images/objects-hosts.png)

[**Services**](objectdefinitions.md#objectdefinitions-service) are one
of the central objects in the monitoring logic. Services are associated
with hosts and can be:




[**Service
Groups**](objectdefinitions.md#objectdefinitions-servicegroup) are
groups of one or more services. Service groups can make it easier to (1)
view the status of related services in the Icinga web interface and (2)
simplify your configuration through the use of [object
tricks](objecttricks.md "7.27. Time-Saving Tricks For Object Definitions").

![](../images/objects-services.png)

[**Contacts**](objectdefinitions.md#objectdefinitions-contact) are
people involved in the notification process:



[**Contact
Groups**](objectdefinitions.md#objectdefinitions-contactgroup) are
groups of one or more contacts. Contact groups can make it easier to
define all the people who get notified when certain host or service
problems occur.

![](../images/objects-contacts.png)

[**Timeperiods**](objectdefinitions.md#objectdefinitions-timeperiod)
are are used to control:



Information on how timeperiods work can be found
[here](timeperiods.md "5.9. Time Periods").

![](../images/objects-timeperiods.png)

[**Commands**](objectdefinitions.md#objectdefinitions-command) are
used to tell Icinga what programs, scripts, etc. it should execute to
perform:





![](../images/objects-commands.png)

* * * * *

[Prev](configmain.md) | [Up](ch03.md) | [Next](objectdefinitions.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
