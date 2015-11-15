![Icinga](../images/logofullsize.png "Icinga")

7.25. Modifizierte Attribute

[Zurück](cgiincludes.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](objectinheritance.md)

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

-   Host-Attribute ändern:
    `CHANGE_HOST_MODATTR;`{.code}\<host\_name\>;\<value\>

-   Service-Attribute ändern:
    `CHANGE_SVC_MODATTR;`{.code}\<host\_name\>;\<service\_description\>;\<value\>

-   Kontakt-Attribute ändern:
    `CHANGE_CONTACT_MODATTR;`{.code}\<contact\_name\>;\<value\>

-   Kontakt-Attribute ändern:
    `CHANGE_CONTACT_MODHATTR;`{.code}\<contact\_name\>;\<value\>

-   Kontakt-Attribute ändern:
    `CHANGE_CONTACT_MODSATTR;`{.code}\<contact\_name\>;\<value\>

Der Werte ist ein logisches ODER der verschiedenen Werte aus der Tabelle
am Ende dieses Abschnitts. "Logisches ODER" bedeutet, dass Sie die Werte
addieren und die Summe benutzen müssen.

### 7.25.2. Beispiel

Die folgenden Zeilen zeigen ein allgemeines Beispiel, wie externe
Befehle an das Command-File übergeben werden.

~~~~ {.programlisting}
 #!/bin/sh
 # Adjust variables to fit your environment as necessary.

 now=`date +%s`
 commandfile='/usr/local/icinga/var/rw/icinga.cmd'

 /bin/printf "[%lu] CHANGE_HOST_MODATTR;Host1;11\n" $now > $commandfile
~~~~

Das o.g. Kommando wird verschiedene Attribute von "Host1" ändern:

~~~~ {.screen}
enable notifications      1
enable active checks      2
enable the eventhandler   8
                         --
                         11
~~~~

**Auszug aus include/common.h**

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

  -------------------------------------------------------- -------------------------- -----------------------------------
  [Zurück](cgiincludes.md)                               [Nach oben](ch07.md)      [Weiter](objectinheritance.md)
  7.24. Angepasste Classic UI-Modul-Kopf- und Fußzeilen    [Zum Anfang](index.md)    7.26. Objektvererbung
  -------------------------------------------------------- -------------------------- -----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
