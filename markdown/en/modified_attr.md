![Icinga](../images/logofullsize.png "Icinga")

7.25. Modified attributes

[Prev](cgiincludes.md) 

Chapter 7. Advanced Topics

 [Next](objectinheritance.md)

* * * * *

7.25. Modified attributes
-------------------------

7.25.1. [Introduction](modified_attr.md#introduction)

7.25.2. [Example](modified_attr.md#example)

### 7.25.1. Introduction

Several attributes of hosts, services, and contacts can be changed
during runtime, e.g. when disabling notifications through the
webinterface, thus overriding the local configuration default. The core
will **always** use the modified attributes in the first place.

If
"[retain\_state\_information](configmain.md#configmain-retain_state_information)"
is enabled (this is the default) these changes will be saved across
restarts. If you choose to disable this setting the changes will only
last until the next restart.

Apart from changing them automatically via several commands in the
classic UI you can alter the values using [external
commands](extcommands.md "7.1. External Commands").

**List of external commands to modify attributes** (for details see the
[list of external
commands](extcommands2.md "7.2. List of External Commands"))

-   change host attributes:
    `CHANGE_HOST_MODATTR;`{.code}\<host\_name\>;\<value\>

-   change service attributes:
    `CHANGE_SVC_MODATTR;`{.code}\<host\_name\>;\<service\_description\>;\<value\>

-   change contact attributes:
    `CHANGE_CONTACT_MODATTR;`{.code}\<contact\_name\>;\<value\>

-   change contact attributes:
    `CHANGE_CONTACT_MODHATTR;`{.code}\<contact\_name\>;\<value\>

-   change contact attributes:
    `CHANGE_CONTACT_MODSATTR;`{.code}\<contact\_name\>;\<value\>

The value is a logical OR of the different values from the table at the
end of this section. "Logical OR" means that you have to add the values
and use the result.

### 7.25.2. Example

The following lines show a general example how to submit external
commands to the command file.

~~~~ {.programlisting}
 #!/bin/sh
 # Adjust variables to fit your environment as necessary.

 now=`date +%s`
 commandfile='/usr/local/icinga/var/rw/icinga.cmd'

 /bin/printf "[%lu] CHANGE_HOST_MODATTR;Host1;11\n" $now > $commandfile
~~~~

The above command will modify several attributes on "Host1":

~~~~ {.screen}
enable notifications      1
enable active checks      2
enable the eventhandler   8
                         --
                         11
~~~~

**Excerpt from include/common.h**

~~~~ {.screen}
/************************MODIFIED ATTRIBUTES *************************/
#define MODATTR_NONE                            0
#define MODATTR_NOTIFICATIONS_ENABLED           1
#define MODATTR_ACTIVE_CHECKS_ENABLED           2
#define MODATTR_PASSIVE_CHECKS_ENABLED          4
#define MODATTR_EVENT_HANDLER_ENABLED           8
#define MODATTR_FLAP_DETECTION_ENABLED          16
#define MODATTR_FAILURE_PREDICTION_ENABLED      32
#define MODATTR_PERFORMANCE_DATA_ENABLED        64
#define MODATTR_OBSESSIVE_HANDLER_ENABLED       128
#define MODATTR_EVENT_HANDLER_COMMAND           256
#define MODATTR_CHECK_COMMAND                   512
#define MODATTR_NORMAL_CHECK_INTERVAL           1024
#define MODATTR_RETRY_CHECK_INTERVAL            2048
#define MODATTR_MAX_CHECK_ATTEMPTS              4096
#define MODATTR_FRESHNESS_CHECKS_ENABLED        8192
#define MODATTR_CHECK_TIMEPERIOD                16384
#define MODATTR_CUSTOM_VARIABLE                 32768
#define MODATTR_NOTIFICATION_TIMEPERIOD         65536
~~~~

* * * * *

  ---------------------------------------------------- -------------------- ---------------------------------
  [Prev](cgiincludes.md)                             [Up](ch07.md)       [Next](objectinheritance.md)
  7.24. Custom CGI Headers and Footers (Classic UI)    [Home](index.md)    7.26. Object Inheritance
  ---------------------------------------------------- -------------------- ---------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
