 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.4. sprunghafte Services
-------------------------

7.4.1. [Einführung](volatileservices.md#introduction)

7.4.2. [Wofür sind sie nützlich?](volatileservices.md#usage)

7.4.3. [Was ist so besonders an flüchtigen
Services?](volatileservices.md#speciality)

7.4.4. [Die Macht der Zwei](volatileservices.md#poweroftwo)

7.4.5. [Icinga Konfiguration:](volatileservices.md#configvolatile)

7.4.6. [PortSentry
Konfiguration:](volatileservices.md#portsentryconfig)

7.4.7. [Portscan-Script:](volatileservices.md#portscanscript)

### 7.4.1. Einführung

Icinga hat die Möglichkeit, zwischen "normalen" und "flüchtigen"
Services zu unterscheiden. Die *is\_volatile*-Option in jeder
Service-Definition erlaubt Ihnen festzulegen, ob ein bestimmter Service
flüchtig ist oder nicht. Für die meisten Leute wird die Mehrzahl der
überwachten Services nicht-flüchtig (d.h. "normal") sein. Trotzdem
können flüchtige Services sehr nützlich sein, wenn sie richtig
eingesetzt werden...

### 7.4.2. Wofür sind sie nützlich?

Flüchtige Services sind nützlich zur Überwachung von...



### 7.4.3. Was ist so besonders an flüchtigen Services?

Flüchtige Services unterscheiden sich von "normalen" Services in drei
wichtigen Punkten. *Jedes Mal* wenn sie in einem
[harten](statetypes.md "5.8. Statustypen") nicht-OK-Zustand sind und
die Prüfung einen nicht-OK-Zustand ergibt (also keine Statusänderung
eintritt)...




Diese Ereignisse finden normalerweise nur für Services statt, wenn sie
in einem nicht-OK-Zustand sind und gerade ein Hard-Zustandswechsel
erfolgte. In anderen Worten, sie passieren nur das erste Mal, wenn ein
Service in einen nicht-OK-Zustand geht. Wenn weitere Prüfungen des
Service den gleichen nicht-OK-Zustand ergeben, erfolgt kein harter
Zustandswechsel und keines der genannten Ereignisse wird stattfinden.

![](../images/tip.gif) Hinweis: Wenn Sie nur an der Protokollierung
interessiert sind, dann sehen Sie sich die
[Stalking](stalking.md "7.14. Status Stalking")-Option an.

### 7.4.4. Die Macht der Zwei

Wenn Sie die Möglichkeiten von flüchtigen Services und [passiven
Service-Prüfungen](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")
kombinieren, können Sie einige sehr nützliche Dinge tun. Beispiele
hierfür umfassen u.a. die Behandlung von SNMP-Traps, Sicherheits-Alarme,
usw.

Wie wäre es mit einem Beispiel... Nehmen wir an, Sie nutzen
[PortSentry](http://sourceforge.net/projects/sentrytools/), um Portscans
auf Ihrer Maschine zu erkennen und automatisch potenzielle Eindringlinge
auszusperren. Wenn Sie wollen, dass Icinga über Portscans erfährt,
können Sie das Folgende tun...

### 7.4.5. Icinga Konfiguration:






### 7.4.6. PortSentry Konfiguration:

Editieren Sie die PortSentry-Konfigurationsdatei (portsentry.conf) und
definieren Sie einen Befehl für die *KILL\_RUN\_CMD*-Direktive wie
folgt:

</code></pre> 
</code></pre>

Stellen Sie sicher, *host\_name* durch den Kurznamen des Hosts zu
ersetzen, mit dem der Service verbunden ist.

### 7.4.7. Portscan-Script:

Erstellen Sie ein Shell-Script im
*/usr/local/icinga/libexec/eventhandlers*-Verzeichnis namens
*submit\_check\_result*. Der Inhalt des Shell-Scripts sollte ähnlich dem
Folgenden sein...

</code></pre> 
 #!/bin/sh
 # Write a command to the Icinga command file to cause
 # it to process a service check result
 echocmd="/bin/echo"
 CommandFile="/usr/local/icinga/var/rw/nagios.cmd"
 # get the current date/time in seconds since UNIX epoch
 datetime=`date +%s`
 # create the command line to add to the command file
 cmdline="[$datetime] PROCESS_SERVICE_CHECK_RESULT;$1;$2;$3;$4"
 # append the command to the end of the command file
 `$echocmd $cmdline >> $CommandFile`
</code></pre>

Was passiert, wenn PortSentry in der Zukunft einen Portscan auf der
Maschine entdeckt?





Ziemlich hübsch, oder?

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
