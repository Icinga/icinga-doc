Überprüfen Ihrer NAME-ICINGA-Konfiguration
==========================================

**Überprüfen Ihrer Konfiguration**

Jedes Mal, nachdem Sie Ihre [Konfigurationsdateien](#config) verändert
haben, sollten Sie sie überprüfen. Es ist wichtig, das zu tun, bevor Sie
NAME-ICINGA (neu)starten, weil NAME-ICINGA herunterfährt, wenn Ihre
Konfiguration Fehler enthält.

Um Ihre Konfiguration zu überprüfen, starten Sie NAME-ICINGA mit der
**-v**-Option wie folgt:

     #> URL-ICINGA-BIN -v URL-ICINGA-CFG

Wenn Sie vergessen haben, kritische Daten einzugeben oder Dinge
fehlkonfiguriert haben, spuckt NAME-ICINGA eine Warnung oder eine
Fehlermeldung aus, die Ihnen die Stelle des Problems zeigen sollte.
Fehlermeldungen geben grundsätzlich die Zeile der Konfigurationsdatei
aus, die die Ursache des Problems zu sein scheint. Bei Fehlern wird
NAME-ICINGA oft sofort die Überprüfung beenden und bereits nach der
Ausgabe des ersten Fehlers zur Kommandozeile zurückkehren. Das
geschieht, weil dieser erste Fehler im Laufe der restlichen
Konfigurationdatei(en) weitere Fehler nach sich ziehen könnte. Sobald
Sie Fehlermeldungen bekommen, müssen Sie Ihre Konfigurationsdateien
editieren, um das Problem zu beheben. Warnungen können *generell*
problemlos ignoriert werden, weil sie lediglich Empfehlungen darstellen
und keine Erfordernisse für den Betrieb.

Anstatt die Pfade für das Binary und die Konfigurationsdatei anzugeben
können Sie auch den folgenden Befehl eingeben:

     #> /etc/init.d/icinga checkconfig

Die Ausführung ergibt einen Return-Code ungleich Null, wenn Ihre
Konfiguration Fehler enthält. Das kann sinnvoll sein, wenn Sie Icinga
automatisch erneut starten wollen..

Wenn Sie stattdessen den folgenden Befehl eingeben

     #> /etc/init.d/icinga show-errors

dann wird eine Datei mit den gefundenen Fehlern erstellt. Falls es
Fehler gibt, wird der Inhalt der Datei angezeigt ("show-errors" ab
NAME-ICINGA 1.0.2).

Sobald Sie Ihre Konfigurationsdateien überprüft und eventuelle Fehler
bereinigt haben, können Sie [NAME-ICINGA (neu)starten](#startstop)

Überprüfen Ihrer Konfiguration
Konfiguration
Überprüfung Ihrer Konfiguration
Konfiguration
check-config
Konfiguration
show-errors
NAME-ICINGA Kommandozeilenoptionen
Option -v (Konfiguration überprüfen)
