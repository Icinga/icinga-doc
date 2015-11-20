[Prev](cgiincludes.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](objectinheritance.md)

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






The value is a logical OR of the different values from the table at the
end of this section. "Logical OR" means that you have to add the values
and use the result.

### 7.25.2. Example

The following lines show a general example how to submit external
commands to the command file.

<pre><code>
 #!/bin/sh
 # Adjust variables to fit your environment as necessary.

 now=`date +%s`
 commandfile='/usr/local/icinga/var/rw/icinga.cmd'

 /bin/printf "[%lu] CHANGE_HOST_MODATTR;Host1;11\n" $now > $commandfile
</code></pre>

The above command will modify several attributes on "Host1":

</code></pre>

**Excerpt from include/common.h**

/************************MODIFIED ATTRIBUTES *************************/
</code></pre>

* * * * *

[Prev](cgiincludes.md) | [Up](ch07.md) | [Next](objectinheritance.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
