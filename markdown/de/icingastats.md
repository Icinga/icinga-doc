![Icinga](../images/logofullsize.png "Icinga")

8.6. Nutzung des Icingastats-Utilitys

[Zurück](largeinstalltweaks.md) 

Kapitel 8. Sicherheit und Leistungsoptimierung

 [Weiter](perfgraphs.md)

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

~~~~ {.screen}
[icinga@monitoring ~]# /usr/local/icinga/bin/icingastats -c /usr/local/icinga/etc/nagios.cfg
Icinga Stats 1.13
Copyright (c) 2009 Nagios Core Development Team and Community Contributors
Copyright (c) 1999-2009 Ethan Galstad
Last Modified: 02-16-2011
License: GPL
CURRENT STATUS DATA
------------------------------------------------------
Status File:                            /usr/local/icinga/var/status.dat
Status File Age:                        0d 0h 0m 27s
Status File Version:                    1.3.0

Program Running Time:                   0d 14h 28m 16s
Icinga PID:                             21182
Used/High/Total Command Buffers:        0 / 3 / 4096

Total Services:                         1001
Services Checked:                       945
Services Scheduled:                     950
Services Actively Checked:              1000
Services Passively Checked:             1
Total Service State Change:             0.000 / 100.000 / 1.881 %
Active Service Latency:                 0.000 / 285.165 / 25.045 sec
Active Service Execution Time:          0.000 / 304.925 / 0.834 sec
Active Service State Change:            0.000 / 100.000 / 1.883 %
Active Services Last 1/5/15/60 min:     20 / 191 / 471 / 926
Passive Service Latency:                0.862 / 0.862 / 0.862 sec
Passive Service State Change:           0.000 / 0.000 / 0.000 %
Passive Services Last 1/5/15/60 min:    1 / 1 / 1 / 1
Services Ok/Warn/Unk/Crit:              816 / 56 / 51 / 78
Services Flapping:                      39
Services In Downtime:                   0

Total Hosts:                            111
Hosts Checked:                          104
Hosts Scheduled:                        104
Hosts Actively Checked:                 111
Host Passively Checked:                 0
Total Host State Change:                0.000 / 100.000 / 10.574 %
Active Host Latency:                    0.000 / 279.257 / 21.700 sec
Active Host Execution Time:             0.000 / 6.405 / 0.432 sec
Active Host State Change:               0.000 / 100.000 / 10.574 %
Active Hosts Last 1/5/15/60 min:        17 / 50 / 74 / 104
Passive Host Latency:                   0.000 / 0.000 / 0.000 sec
Passive Host State Change:              0.000 / 0.000 / 0.000 %
Passive Hosts Last 1/5/15/60 min:       0 / 0 / 0 / 0
Hosts Up/Down/Unreach:                  89 / 7 / 15
Hosts Flapping:                         22
Hosts In Downtime:                      0

Active Host Checks Last 1/5/15 min:     73 / 97 / 246
   Scheduled:                           13 / 21 / 50
   On-demand:                           60 / 76 / 196
   Parallel:                            45 / 63 / 171
   Serial:                              0 / 0 / 0
   Cached:                              28 / 34 / 75
Passive Host Checks Last 1/5/15 min:    0 / 0 / 0
Active Service Checks Last 1/5/15 min:  142 / 192 / 501
   Scheduled:                           142 / 192 / 500
   On-demand:                           0 / 0 / 1
   Cached:                              0 / 0 / 0
Passive Service Checks Last 1/5/15 min: 6 / 6 / 15

External Commands Last 1/5/15 min:      6 / 6 / 15

[icinga@monitoring ~]# 
~~~~

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

  ------------------------------------ -------------------------- --------------------------------------------------------------------------
  [Zurück](largeinstalltweaks.md)    [Nach oben](ch08.md)      [Weiter](perfgraphs.md)
  8.5. Large Installation Tweaks       [Zum Anfang](index.md)    8.7. Grafische Darstellung von Performance-Informationen mit PNP4Nagios
  ------------------------------------ -------------------------- --------------------------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
