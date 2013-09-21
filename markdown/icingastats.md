Nutzung des NAME-ICINGAstats-Utilitys
=====================================

Einführung
----------

Ein Utility namens **NAME-STATS** ist in der NAME-ICINGA-Distribution
enthalten. Es wird zusammen mit dem NAME-ICINGA-Daemon kompiliert und
installiert. Das NAME-STATS-Utility liefert Ihnen verschiedene
Informationen zu einem laufenden NAME-ICINGA-Prozess, die sehr hilfreich
bei der [Leistungsoptimierung](#tuning) sein können. Sie können
Informationen in einem menschlich-lesbaren oder im
Performance-Daten-kompatiblen Format erhalten.

Gebrauchshinweise
-----------------

Sie können das *NAME-STATS*-Utility mit der **--help**-Option starten,
um Gebrauchshinweise zu bekommen.

menschlich-lesbare Ausgabe
--------------------------

Um menschlich-lesbare Informationen zur Leistung eines laufenden
NAME-ICINGA-Prozesses zu erhalten, starten Sie das *NAME-STATS*-Utility
mit dem **-c**-Kommandozeilenargument, um die Position Ihrer
Hauptkonfigurationsdatei wie folgt anzugeben:

    [icinga@monitoring ~]# URL-ICINGA-BASE/bin/NAME-STATS -c URL-ICINGA-BASE/etc/nagios.cfg
    NAME-ICINGA Stats VER-ICINGA
    Copyright (c) 2009 Nagios Core Development Team and Community Contributors
    Copyright (c) 1999-2009 Ethan Galstad
    Last Modified: 02-16-2011
    License: GPL
    CURRENT STATUS DATA
    ------------------------------------------------------
    Status File:                            URL-ICINGA-BASE/var/status.dat
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

Wie Sie sehen können, zeigt das Utility ein Reihe von verschiedenen
Metriken zum NAME-ICINGA-Prozess an. Metriken mit mehreren Werten sind
(wenn nicht anders angegeben) Minimum-, Maximum- und Durchschnittswerte
für die betreffende Metrik.

NAME-PNP-Integration
--------------------

Sie können das *NAME-STATS*-Utility benutzen, um verschiedene
NAME-ICINGA-Metriken mit NAME-PNP (oder anderen kompatiblen Programmen)
anzuzeigen. Um das zu tun, starten Sie das *NAME-STATS*-Utility mit den
**--mrtg**- und **--data**-Optionen. Die **--data**-Option wird benutzt,
um anzugeben, welche Statistiken dargestellt werden sollen. Mögliche
Werte für die **--data**-Option finden Sie durch Start des
*NAME-STATS*-Utilitys mit der **--help**-Option.

![](../images/note.gif) Anmerkung: Informationen zum Gebrauch des
*NAME-STATS*-Utilitys zu Generierung von NAME-PNP-Grafiken zu
Darstellung von NAME-ICINGA-Leistungsstatistiken finden Sie
[hier](#perfgraphs).

Icingastats
benutzen des NAME-ICINGAstats-Utilitys
