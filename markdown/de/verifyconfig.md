![Icinga](../images/logofullsize.png "Icinga")

4.1. Überprüfen Ihrer Icinga-Konfiguration

[Zurück](ch04.md) 

Kapitel 4. Icinga starten/stoppen/prüfen

 [Weiter](startstop.md)

* * * * *

4.1. Überprüfen Ihrer Icinga-Konfiguration
------------------------------------------

**Überprüfen Ihrer Konfiguration**

Jedes Mal, nachdem Sie Ihre
[Konfigurationsdateien](config.md "3.1. Konfigurationsüberblick")
verändert haben, sollten Sie sie überprüfen. Es ist wichtig, das zu tun,
bevor Sie Icinga (neu)starten, weil Icinga herunterfährt, wenn Ihre
Konfiguration Fehler enthält.

Um Ihre Konfiguration zu überprüfen, starten Sie Icinga mit der
**-v**-Option wie folgt:

~~~~ {.screen}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
~~~~

Wenn Sie vergessen haben, kritische Daten einzugeben oder Dinge
fehlkonfiguriert haben, spuckt Icinga eine Warnung oder eine
Fehlermeldung aus, die Ihnen die Stelle des Problems zeigen sollte.
Fehlermeldungen geben grundsätzlich die Zeile der Konfigurationsdatei
aus, die die Ursache des Problems zu sein scheint. Bei Fehlern wird
Icinga oft sofort die Überprüfung beenden und bereits nach der Ausgabe
des ersten Fehlers zur Kommandozeile zurückkehren. Das geschieht, weil
dieser erste Fehler im Laufe der restlichen Konfigurationdatei(en)
weitere Fehler nach sich ziehen könnte. Sobald Sie Fehlermeldungen
bekommen, müssen Sie Ihre Konfigurationsdateien editieren, um das
Problem zu beheben. Warnungen können *generell* problemlos ignoriert
werden, weil sie lediglich Empfehlungen darstellen und keine
Erfordernisse für den Betrieb.

Anstatt die Pfade für das Binary und die Konfigurationsdatei anzugeben
können Sie auch den folgenden Befehl eingeben:

~~~~ {.programlisting}
 #> /etc/init.d/icinga checkconfig
~~~~

Die Ausführung ergibt einen Return-Code ungleich Null, wenn Ihre
Konfiguration Fehler enthält. Das kann sinnvoll sein, wenn Sie Icinga
automatisch erneut starten wollen..

Wenn Sie stattdessen den folgenden Befehl eingeben

~~~~ {.programlisting}
 #> /etc/init.d/icinga show-errors
~~~~

dann wird eine Datei mit den gefundenen Fehlern erstellt. Falls es
Fehler gibt, wird der Inhalt der Datei angezeigt.

Sobald Sie Ihre Konfigurationsdateien überprüft und eventuelle Fehler
bereinigt haben, können Sie [Icinga
(neu)starten](startstop.md "4.2. Icinga starten und stoppen")

* * * * *

  ------------------------------------------- -------------------------- ----------------------------------
  [Zurück](ch04.md)                         [Nach oben](ch04.md)      [Weiter](startstop.md)
  Kapitel 4. Icinga starten/stoppen/prüfen    [Zum Anfang](index.md)    4.2. Icinga starten und stoppen
  ------------------------------------------- -------------------------- ----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
