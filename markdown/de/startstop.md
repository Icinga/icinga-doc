 ![Icinga](../images/logofullsize.png "Icinga") 

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








**Icinga erneut starten**

Ein Neustart bzw. neu laden ist notwendig, wenn Sie Ihre
Konfigurationsdateien verändert haben und diese Änderungen aktiv werden
sollen.







**Icinga stoppen**







**Protokoll-Einstellungen in /usr/local/icinga/etc/icinga.cfg**

Einstellungen für den Daemon:

Definiert ob Nachrichten in die Daemon Logdatei geschrieben werden
sollen (gewöhnlich nach icinga.log). Der Standardwert ist 1 (ja), setzen
des Wertes auf 0 (nein) verhindert den Log der Nachrichten.

<pre><code>
use_daemon_log=0/1
</code></pre>

Einstellungen für den Syslog-Dienst:

Wenn Sie möchten, dass Icinga Meldungen an den Syslog-Dienst übergibt,
setzen Sie diese Einstellung auf 1.

<pre><code>
use_syslog=0/1
</code></pre>

Diese Option kann zusätzlich zur use\_daemon\_log-Option verwendet
werden.

**Verschiedene Optionen**

Falls Sie große Verzögerungen zwischen dem Start von Icinga und den
ersten Prüfungen feststellen, dann gibt es verschiedene Optionen, die
[hier](faststartup.md "8.4. Schnellstart-Optionen") näher beschrieben
sind. Dort finden Sie auch die Option -S, die nähere Informationen zur
Scheduling Queue ausgibt.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
