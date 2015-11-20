 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.25. Modifizierte Attribute
----------------------------

7.25.1. [Einführung](modified_attr.md#introduction)

7.25.2. [Beispiel](modified_attr.md#example)

### 7.25.1. Einführung

Verschiedene Attribute von Host, Services und Kontakte können während
der Laufzeit verändert werden, z.B. beim Deaktivieren von
Benachrichtigungen über das Web-Interface, wodurch der lokale
Standardwert überschrieben wird. Der Core wird **immer** zuerst das
modifizierte Attribut benutzen.

Wenn
"[retain\_state\_information](configmain.md#configmain-retain_state_information)"
aktiviert ist (das ist der Standard), dann werden diese Änderungen über
Neustarts hinweg beibehalten. Falls Sie diese Einstellung deaktivieren,
dann gelten die geänderten Werte nur bis zum nächsten Neustart.

Neben der automatischen Änderung durch verschiedene Befehle der
klassischen Oberfläche können Sie diese Werte auch mit Hilfe von
[externen Befehlen](extcommands.md "7.1. Externe Befehle") anpassen.

**Liste der externen Befehle zum ändern von Attributen** (zu Details
siehe [Liste der externen
Befehle](extcommands2.md "7.2. Liste der externen Befehle"))






Der Werte ist ein logisches ODER der verschiedenen Werte aus der Tabelle
am Ende dieses Abschnitts. "Logisches ODER" bedeutet, dass Sie die Werte
addieren und die Summe benutzen müssen.

### 7.25.2. Beispiel

Die folgenden Zeilen zeigen ein allgemeines Beispiel, wie externe
Befehle an das Command-File übergeben werden.

<pre><code>
 #!/bin/sh
 # Adjust variables to fit your environment as necessary.

 now=`date +%s`
 commandfile='/usr/local/icinga/var/rw/icinga.cmd'

 /bin/printf "[%lu] CHANGE_HOST_MODATTR;Host1;11\n" $now > $commandfile
</code></pre>

Das o.g. Kommando wird verschiedene Attribute von "Host1" ändern:

</code></pre> 
</code></pre>

**Auszug aus include/common.h**

</code></pre> 
/************************MODIFIED ATTRIBUTES *************************/
</code></pre>

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
