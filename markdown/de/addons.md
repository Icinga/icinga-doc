 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

10.1. Icinga Addons
-------------------

10.1.1. [Einführung](addons.md#introduction)

### 10.1.1. Einführung

Es gibt eine Menge von "Addon"-Software-Paketen, die für Icinga
verfügbar sind. Addons können genutzt werden, um die Funktionalität von
Icinga zu erweitern oder Icinga mit anderen Applikationen zu
integrieren.

Addons gibt es für:

















Sie finden viele Addons für Icinga unter:




Wir werden eine kurze Einführung für ein paar Addons geben, die Ethan
Galstad für Nagios entwickelt hat...

**NRPE**

![](../images/nrpe.png)

NRPE ist ein Addon, das es Ihnen erlaubt,
[Plugins](plugins.md "5.1. Icinga Plugins") auf entfernten
Linux-/Unix-Hosts auszuführen. Dies ist nützlich, wenn Sie lokale
Ressourcen/Attribute wie Plattenbelegung, CPU-Last, Speicherbelegung
usw. auf entfernten Hosts überwachen wollen. Ähnliche Funktionalitäten
können durch das *check\_by\_ssh*-Plugin erreicht werden, obwohl es auf
besonders dann, wenn Sie hunderte oder tausende von Hosts überwachen.

Das NRPE-Addon finden Sie unter
[http://sourceforge.net/projects/nagios/files/nrpe-2.x/](http://sourceforge.net/projects/nagios/files/nrpe-2.x/).
Etwas [Dokumentation](nrpe.md "10.2. NRPE") finden Sie in nächsten
Abschnitt.

**NSCA**

![](../images/nsca.png)

NSCA-ng (ein Ersatz für NSCA) ist ein Addon, das es Ihnen erlaubt,
[passive
Prüf](passivechecks.md "5.7. Passive Prüfungen (Passive Checks)")-Resultate
von entfernten Linux-/Unix-Hosts an den Icinga-Daemon zu senden, der auf
dem Überwachungs-Server läuft. Das ist sehr hilfreich in
[verteilten](distributed.md "7.6. Verteilte Überwachung") und
[redundanten/Failover](redundancy.md "7.7. Redundante und Failover-Netzwerk-Überwachung")-Überwachungs-Umgebungen.

Das NSCA-ng-Addon finden Sie unter
[http://www.nsca-ng.org/](http://www.nsca-ng.org/). Darüber hinaus
finden Sie etwas [Dokumentation](nsca.md "10.3. NSCA") zu NSCA im
nächsten Abschnitt.

**IDOUtils**

![](../images/idoutils.png)

IDOUtils ist ein Addon, das es Ihnen erlaubt, alle
Icinga-Statusinformationen in einer Datenbank zu speichern. Mehrere
Instanzen von Icinga können all ihre Informationen in einer gemeinsamen
Datenbank für ein zentrales Berichtswesen speichern. Dies wird
wahrscheinlich in der Zukunft als Basis für ein neues PHP-basiertes
Web-Interface für Icinga dienen. Neben MySQL werden auch Oracle und
PostgreSQL unterstützt.

Das IDOUtils-Addon und die Dokumentation finden Sie unter
[http://docs.icinga.org/](http://docs.icinga.org/).

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
