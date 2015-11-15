![Icinga](../images/logofullsize.png "Icinga")

1.1. Über Icinga

[Zurück](ch01.md) 

Kapitel 1. Über

 [Weiter](whatsnew.md)

* * * * *

1.1. Über Icinga
----------------

1.1.1. [Was ist das?](about.md#whatsicinga)

1.1.2. [Systemvoraussetzungen](about.md#system_requirements)

1.1.3. [Lizenzierung](about.md#licensing)

1.1.4. [Danksagungen](about.md#acknowledgements)

1.1.5. [Beschaffen der neuesten Version](about.md#downloading)

1.1.6. [Kompatibilität](about.md#compatibility)

### 1.1.1. Was ist das?

Icinga ist eine System- und Netzwerküberwachungsapplikation. Sie
überwacht Hosts und Services, die Sie angeben, und alarmiert Sie, wenn
sich die Dinge verschlechtern und wenn sie wieder besser werden.

Icinga läuft unter Linux, allerdings sollte es unter den meisten anderen
Unix-Derivaten ebenfalls funktionieren.

Einige der vielen Features von Icinga umfassen:

-   Überwachen von Netzwerkdiensten (SMTP, POP3, HTTP, NNTP, PING, etc.)

-   Überwachen von Host-Ressourcen (Prozessorauslastung, Diskbelegung,
    usw.)

-   Einfaches Plugin-Design, das es Benutzern erlaubt, schnell eigene
    Service-Prüfungen zu entwickeln

-   Parallel laufende Service-Prüfungen

-   Die Möglichkeit, Netzwerk-Host-Hierarchien mit Hilfe von
    "Eltern"-Hosts zu definieren, um die Erkennung von Hosts zu
    erlauben, die "down" sind und die Unterscheidung zwischen Hosts, die
    "down" bzw. unerreichbar sind

-   Benachrichtigung von Kontakten, wenn Service- oder Host-Probleme
    auftreten bzw. gelöst werden (über e-Mail, Pager oder
    benutzerdefinierte Methoden)

-   Die Möglichkeit, Routinen zur Ereignisbehandlung (Eventhandler) zu
    definieren, die bei Host- oder Service-Ereignissen ablaufen, um
    proaktive Problemlösungen zu erlauben

-   Automatische Rotation von Protokolldateien

-   Unterstützung, um redundante Überwachungs-Hosts zu implementieren

-   Optionales Classic-Web-Interface, um den aktuellen Netzwerkstatus,
    Benachrichtigungs- und Problemverläufe, Protokolldateien usw.
    anzusehen

-   Optionales neues Icinga-Web-Interface basierend auf Icinga Core,
    IDOUtils, API, das eine moderne, rundum erneuerte Web 2.0 Oberfläche
    mit Multilanguage-Support bietet, um den aktuellen Status und
    historische Informationen zur Verfügung zu stellen. Es werden Cronks
    und Filter bereitgestellt und es können Reports erstellt werden

### 1.1.2. Systemvoraussetzungen

*Die einzige Voraussetzung für den Betrieb von Icinga ist eine Maschine,
auf der Linux (oder eine UNIX-Variante) läuft und ein C-Compiler.*
Voraussichtlich werden Sie auch noch TCP/IP konfigurieren wollen, weil
die meisten Service-Prüfungen über das Netzwerk durchgeführt werden.

Sie *müssen* nicht eins der Web-Interfaces benutzen, die in Icinga
enthalten sind. Wenn Sie sich allerdings entscheiden, sie zu benutzen,
muss zusätzlich die folgende Software installiert sein...

1.  Ein Web-Server (vorzugsweise [Apache](http://www.apache.org))

2.  Thomas Boutells [gd library](http://www.boutell.com/gd) Version
    1.6.3 oder höher (wird benötigt von den
    [statusmap](cgis.md#cgis-statusmap_cgi)- und
    [trends](cgis.md#cgis-trends_cgi)-CGIs)

3.  PHP

### 1.1.3. Lizenzierung

Icinga ist unter den Bedingungen der [GNU General Public
License](http://www.gnu.org/copyleft/gpl.md) Version 2 lizenziert, wie
sie von der [Free Software Foundation](http://www.fsf.org/)
veröffentlicht wird. (A.d.Ü.: eine deutsche Übersetzung finden Sie
[hier](http://www.gnu.de//documents/gpl-2.0.de.md).) Die Lizenz gibt
Ihnen das Recht, Icinga unter bestimmten Bedingungen zu kopieren, zu
verteilen und/oder zu modifizieren. Lesen Sie die 'LICENSE'-Datei in der
Icinga-Distribution oder lesen Sie die (englische) [Online-Version der
Lizenz](http://www.gnu.org/copyleft/gpl.md) für nähere Details.

Icinga wird geliefert WIE ES IST OHNE GARANTIE IRGENDEINER ART,
EINSCHLIESSLICH DER GARANTIE FÜR DESIGN, VERMARKTBARKEIT ODER DER
TAUGLICHKEIT FÜR EINEN BESTIMMTEN ZWECK.

### 1.1.4. Danksagungen

Verschiedene Leute haben zu Icinga beigetragen, z.B. durch Meldung von
Fehlern, vorschlagen von Verbesserungen, schreiben von Plugins usw.

### 1.1.5. Beschaffen der neuesten Version

Sie können auf [https://www.icinga.org/](http://www.icinga.org/) nach
neuen Versionen von Icinga suchen.

### 1.1.6. Kompatibilität

Icinga ist ein "Fork" des wohlbekannten Überwachungssystems
[Nagios](http://www.nagios.org/). Eine 100%ige Kompatibilität mit den
internen Strukturen des letzteren erlaubt es Ihnen, mit Icinga alle
Plugins und Addons zu benutzen, die von verschiedenen Firmen und der
großen Community entwickelt wurden bzw. werden.

Icinga und das Icinga-Logo sind Markenzeichen von icinga.org. Alle
anderen Markenzeichen, Dienstmarkenzeichen, registrierte Markenzeichen
und registrierte Dienstmarkenzeichen können das Eigentum der jeweiligen
Inhaber sein.

* * * * *

  ---------------------- -------------------------- ---------------------------------
  [Zurück](ch01.md)    [Nach oben](ch01.md)      [Weiter](whatsnew.md)
  Kapitel 1. Über        [Zum Anfang](index.md)    1.2. What's New in Icinga 1.13
  ---------------------- -------------------------- ---------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
