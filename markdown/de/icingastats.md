 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

8.6. Nutzung des Icingastats-Utilitys
-------------------------------------

8.6.1. [Einführung](icingastats.md#introduction)

8.6.2. [Gebrauchshinweise](icingastats.md#usageinfo)

8.6.3. [menschlich-lesbare Ausgabe](icingastats.md#output)

8.6.4. [PNP4Nagios-Integration](icingastats.md#integration)

### 8.6.1. Einführung

Ein Utility namens **icingastats** ist in der Icinga-Distribution
enthalten. Es wird zusammen mit dem Icinga-Daemon kompiliert und
installiert. Das icingastats-Utility liefert Ihnen verschiedene
Informationen zu einem laufenden Icinga-Prozess, die sehr hilfreich bei
der
[Leistungsoptimierung](tuning.md "8.3. Icinga für maximale Leistung optimieren")
sein können. Sie können Informationen in einem menschlich-lesbaren oder
im Performance-Daten-kompatiblen Format erhalten.

### 8.6.2. Gebrauchshinweise

Sie können das *icingastats*-Utility mit der **--help**-Option starten,
um Gebrauchshinweise zu bekommen.

### 8.6.3. menschlich-lesbare Ausgabe

Um menschlich-lesbare Informationen zur Leistung eines laufenden
Icinga-Prozesses zu erhalten, starten Sie das *icingastats*-Utility mit
dem **-c**-Kommandozeilenargument, um die Position Ihrer
Hauptkonfigurationsdatei wie folgt anzugeben:

</code></pre> 
[icinga@monitoring ~]# /usr/local/icinga/bin/icingastats -c /usr/local/icinga/etc/nagios.cfg
Icinga Stats 1.13
Copyright (c) 2009 Nagios Core Development Team and Community Contributors
Copyright (c) 1999-2009 Ethan Galstad
Last Modified: 02-16-2011
License: GPL
CURRENT STATUS DATA
------------------------------------------------------




Passive Service Checks Last 1/5/15 min: 6 / 6 / 15


</code></pre>

Wie Sie sehen können, zeigt das Utility ein Reihe von verschiedenen
Metriken zum Icinga-Prozess an. Metriken mit mehreren Werten sind (wenn
nicht anders angegeben) Minimum-, Maximum- und Durchschnittswerte für
die betreffende Metrik.

### 8.6.4. PNP4Nagios-Integration

Sie können das *icingastats*-Utility benutzen, um verschiedene
Icinga-Metriken mit PNP4Nagios (oder anderen kompatiblen Programmen)
anzuzeigen. Um das zu tun, starten Sie das *icingastats*-Utility mit den
**--mrtg**- und **--data**-Optionen. Die **--data**-Option wird benutzt,
um anzugeben, welche Statistiken dargestellt werden sollen. Mögliche
Werte für die **--data**-Option finden Sie durch Start des
*icingastats*-Utilitys mit der **--help**-Option.

![](../images/note.gif) Anmerkung: Informationen zum Gebrauch des
*icingastats*-Utilitys zu Generierung von PNP4Nagios-Grafiken zu
Darstellung von Icinga-Leistungsstatistiken finden Sie
[hier](perfgraphs.md "8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios").

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
