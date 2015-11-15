![Icinga](../images/logofullsize.png "Icinga")

4.2. Icinga starten und stoppen

[Zurück](verifyconfig.md) 

Kapitel 4. Icinga starten/stoppen/prüfen

 [Weiter](ch05.md)

* * * * *

4.2. Icinga starten und stoppen
-------------------------------

Es gibt mehr als einen Weg, um Icinga zu starten, zu stoppen und erneut
zu starten. Hier einige der üblichen...

![](../images/tip.gif) Hinweis: Stellen Sie immer sicher, dass Sie Ihre
[Konfiguration
überprüfen](verifyconfig.md "4.1. Überprüfen Ihrer Icinga-Konfiguration"),
bevor Sie Icinga (neu)starten.

**Icinga starten**

1.  **Init-Script:** Der einfachste Weg, den Icinga-Daemon zu starten,
    ist die Nutzung des Init-Scripts:

    ~~~~ {.screen}
     #> /etc/rc.d/init.d/icinga start
    ~~~~

2.  **manuell:** Sie können Icinga manuell mit der
    **-d**-Kommandozeilenoption wie folgt starten:

    ~~~~ {.screen}
     #> /usr/local/icinga/bin/icinga -d /usr/local/icinga/etc/icinga.cfg
    ~~~~

3.  **Debug Modus:** Im ziemlich seltenen Fall, dass Icinga sich still
    ohne Hinweise in den verschiedenen Log-Dateien beendet, können Sie
    Icinga durch das Weglassen der Daemon-Option starten:

    ~~~~ {.programlisting}
     #> /usr/local/icinga/bin/icinga /usr/local/icinga/etc/icinga.cfg
    ~~~~

    Auf diese Weise wird es im Vordergrund gestartet, so dass eine Menge
    von Meldungen über den Bildschirm laufen, aber es könnte zu einem
    Hinweis ganz am Ende führen.

**Icinga erneut starten**

Ein Neustart bzw. neu laden ist notwendig, wenn Sie Ihre
Konfigurationsdateien verändert haben und diese Änderungen aktiv werden
sollen.

1.  **Init-Script:** Der einfachste Weg, den Icinga-Daemon neu zu
    starten, ist die Nutzung des Init-Scripts:

    ~~~~ {.screen}
     #> /etc/rc.d/init.d/icinga reload
    ~~~~

2.  **Web-Interface:** Sie können Icinga mit Hilfe des Web-Interfaces
    neu starten. Klicken Sie auf den "Process Info"-Navigations-Link und
    wählen Sie "Restart the Icinga process":

    ![](../images/stoprestart.png)

3.  **manuell:** Sie können den Icinga-Prozess durch Senden eines
    SIGHUP-Signals neu starten:

    ~~~~ {.screen}
     #> kill -HUP <icinga_pid>
    ~~~~

**Icinga stoppen**

1.  **Init-Script:** Der einfachste Weg, den Icinga-Daemon zu stoppen,
    ist die Nutzung des Init-Script:

    ~~~~ {.screen}
     #> /etc/rc.d/init.d/icinga stop
    ~~~~

2.  **Web-Interface:** Sie können Icinga mit Hilfe des Web-Interfaces
    stoppen. Klicken Sie auf den "Process Info"-Navigations-Link und
    wählen Sie "Shutdown the Icinga process":

    ![](../images/stoprestart.png)

3.  **manuell:** Sie können den Icinga-Prozess durch Senden eines
    SIGTERM-Signals stoppen:

    ~~~~ {.screen}
     #> kill <icinga_pid>
    ~~~~

**Protokoll-Einstellungen in /usr/local/icinga/etc/icinga.cfg**

Einstellungen für den Daemon:

Definiert ob Nachrichten in die Daemon Logdatei geschrieben werden
sollen (gewöhnlich nach icinga.log). Der Standardwert ist 1 (ja), setzen
des Wertes auf 0 (nein) verhindert den Log der Nachrichten.

~~~~ {.programlisting}
use_daemon_log=0/1
~~~~

Einstellungen für den Syslog-Dienst:

Wenn Sie möchten, dass Icinga Meldungen an den Syslog-Dienst übergibt,
setzen Sie diese Einstellung auf 1.

~~~~ {.programlisting}
use_syslog=0/1
~~~~

Diese Option kann zusätzlich zur use\_daemon\_log-Option verwendet
werden.

**Verschiedene Optionen**

Falls Sie große Verzögerungen zwischen dem Start von Icinga und den
ersten Prüfungen feststellen, dann gibt es verschiedene Optionen, die
[hier](faststartup.md "8.4. Schnellstart-Optionen") näher beschrieben
sind. Dort finden Sie auch die Option -S, die nähere Informationen zur
Scheduling Queue ausgibt.

* * * * *

  --------------------------------------------- -------------------------- ----------------------------
  [Zurück](verifyconfig.md)                   [Nach oben](ch04.md)      [Weiter](ch05.md)
  4.1. Überprüfen Ihrer Icinga-Konfiguration    [Zum Anfang](index.md)    Kapitel 5. Die Grundlagen
  --------------------------------------------- -------------------------- ----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
