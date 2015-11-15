![Icinga](../images/logofullsize.png "Icinga")

7.4. sprunghafte Services

[Zurück](eventhandlers.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](freshness.md)

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

-   Dingen, die sich jedes Mal automatisch in einen "OK"-Zustand
    zurücksetzen, wenn sie geprüft werden

-   Ereignisse wie Sicherheits-Alarme, die jedes Mal Beachtung
    erfordern, wenn ein Problem vorliegt (und nicht nur beim ersten Mal)

### 7.4.3. Was ist so besonders an flüchtigen Services?

Flüchtige Services unterscheiden sich von "normalen" Services in drei
wichtigen Punkten. *Jedes Mal* wenn sie in einem
[harten](statetypes.md "5.8. Statustypen") nicht-OK-Zustand sind und
die Prüfung einen nicht-OK-Zustand ergibt (also keine Statusänderung
eintritt)...

-   wird der nicht-OK-Zustand des Service protokolliert

-   werden Kontakte über das Problem informiert (falls es das ist, [was
    zu tun ist](notifications.md "5.11. Benachrichtigungen")).
    Anmerkung: Benachrichtigungsintervalle werden bei flüchtigen
    Services ignoriert.

-   Der [Eventhandler](eventhandlers.md "7.3. Eventhandler") für den
    Service wird ausgeführt (falls einer definiert ist)

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

-   Legen Sie eine Service-Definition namens *Port Scans* an und
    verbinden Sie diese mit dem Host, auf dem PortSentry läuft.

-   Setzen Sie die *max\_check\_attempts*-Direktive in der
    Service-Definition auf 1. Dies teilt Icinga mit, sofort einen
    [Hard-Zustand](statetypes.md "5.8. Statustypen") für den Service
    zu erzwingen, wenn ein nicht-OK-Zustand ermittelt wird.

-   Setzen Sie die *active\_checks\_enabled*-Direktive in der
    Service-Definition auf 0. Dies hält Icinga davon ab, den Service
    aktiv zu prüfen.

-   Setzen Sie die *passive\_checks\_enabled*-Direktive in der
    Service-Definition auf 1. Das erlaubt passive Prüfungen für den
    Service.

-   Setzen Sie die *is\_volatile*-Direktive in der Service-Definition
    auf 1.

### 7.4.6. PortSentry Konfiguration:

Editieren Sie die PortSentry-Konfigurationsdatei (portsentry.conf) und
definieren Sie einen Befehl für die *KILL\_RUN\_CMD*-Direktive wie
folgt:

~~~~ {.screen}
 KILL_RUN_CMD="/usr/local/icinga/libexec/eventhandlers/submit_check_result host_name 'Port Scans' 2 'Port scan from host $TARGET$ on port $PORT$.  Host has been firewalled.'"
~~~~

Stellen Sie sicher, *host\_name* durch den Kurznamen des Hosts zu
ersetzen, mit dem der Service verbunden ist.

### 7.4.7. Portscan-Script:

Erstellen Sie ein Shell-Script im
*/usr/local/icinga/libexec/eventhandlers*-Verzeichnis namens
*submit\_check\_result*. Der Inhalt des Shell-Scripts sollte ähnlich dem
Folgenden sein...

~~~~ {.screen}
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
~~~~

Was passiert, wenn PortSentry in der Zukunft einen Portscan auf der
Maschine entdeckt?

-   PortSentry wird den Host ausschließen ("firewall", das ist eine
    Funktion der PortSentry-Software)

-   PortSentry wird das *submit\_check\_result*-Shell-Script ausführen
    und ein passives Prüfergebnis an Icinga senden

-   Icinga wird das external command file lesen und das passive
    Service-Prüfergebnis von PortSentry verarbeiten

-   Icinga wird den *Port Scans*-Service in einen harten
    CRITICAL-Zustand versetzen und Benachrichtigungen an die Kontakte
    senden

Ziemlich hübsch, oder?

* * * * *

  ------------------------------- -------------------------- -------------------------------------------
  [Zurück](eventhandlers.md)    [Nach oben](ch07.md)      [Weiter](freshness.md)
  7.3. Eventhandler               [Zum Anfang](index.md)    7.5. Service- und Host-Frische-Prüfungen
  ------------------------------- -------------------------- -------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
