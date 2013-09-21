Über NAME-ICINGA
================

Was ist das?
------------

NAME-ICINGA ist eine System- und Netzwerküberwachungsapplikation. Sie
überwacht Hosts und Services, die Sie angeben, und alarmiert Sie, wenn
sich die Dinge verschlechtern und wenn sie wieder besser werden.

NAME-ICINGA läuft unter NAME-LINUX, allerdings sollte es unter den
meisten anderen Unix-Derivaten ebenfalls funktionieren.

Einige der vielen Features von NAME-ICINGA umfassen:

-   Überwachen von Netzwerkdiensten (PROTOCOL-SMTP, PROTOCOL-POP3,
    PROTOCOL-HTTP, PROTOCOL-NNTP, PROTOCOL-PING, etc.)

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

Was ist NAME-ICINGA?
Systemvoraussetzungen
---------------------

*Die einzige Voraussetzung für den Betrieb von NAME-ICINGA ist eine
Maschine, auf der NAME-LINUX (oder eine UNIX-Variante) läuft und ein
C-Compiler.* Voraussichtlich werden Sie auch noch TCP/IP konfigurieren
wollen, weil die meisten Service-Prüfungen über das Netzwerk
durchgeführt werden.

Sie *müssen* nicht eins der Web-Interfaces benutzen, die in NAME-ICINGA
enthalten sind. Wenn Sie sich allerdings entscheiden, sie zu benutzen,
muss zusätzlich die folgende Software installiert sein...

1.  Ein Web-Server (vorzugsweise [NAME-APACHE](http://www.apache.org))

2.  Thomas Boutells [gd library](http://www.boutell.com/gd) Version
    1.6.3 oder höher (wird benötigt von den
    [statusmap](#cgis-statusmap_cgi)- und
    [trends](#cgis-trends_cgi)-CGIs)

3.  PHP

Systemanforderungen
Lizenzierung
------------

NAME-ICINGA ist unter den Bedingungen der [GNU General Public
License](http://www.gnu.org/copyleft/gpl.html) Version 2 lizenziert, wie
sie von der [Free Software Foundation](http://www.fsf.org/)
veröffentlicht wird. (A.d.Ü.: eine deutsche Übersetzung finden Sie
[hier](http://www.gnu.de//documents/gpl-2.0.de.html).) Die Lizenz gibt
Ihnen das Recht, NAME-ICINGA unter bestimmten Bedingungen zu kopieren,
zu verteilen und/oder zu modifizieren. Lesen Sie die 'LICENSE'-Datei in
der NAME-ICINGA-Distribution oder lesen Sie die (englische)
[Online-Version der Lizenz](http://www.gnu.org/copyleft/gpl.html) für
nähere Details.

NAME-ICINGA wird geliefert WIE ES IST OHNE GARANTIE IRGENDEINER ART,
EINSCHLIESSLICH DER GARANTIE FÜR DESIGN, VERMARKTBARKEIT ODER DER
TAUGLICHKEIT FÜR EINEN BESTIMMTEN ZWECK.

Lizenzierung
Danksagungen
------------

Verschiedene Leute haben zu NAME-ICINGA beigetragen, z.B. durch Meldung
von Fehlern, vorschlagen von Verbesserungen, schreiben von Plugins usw.

Danksagungen
Beschaffen der neuesten Version
-------------------------------

Sie können auf [URL-ICINGA](http://www.icinga.org/) nach neuen Versionen
von NAME-ICINGA suchen.

Herunterladen der letzten Version
Kompatibilität
--------------

NAME-ICINGA ist ein "Fork" des wohlbekannten Überwachungssystems
[NAME-NAGIOS](http://www.nagios.org/). Eine 100%ige Kompatibilität mit
den internen Strukturen des letzteren erlaubt es Ihnen, mit NAME-ICINGA
alle Plugins und Addons zu benutzen, die von verschiedenen Firmen und
der großen Community entwickelt wurden bzw. werden.

NAME-ICINGA und das NAME-ICINGA-Logo sind Markenzeichen von icinga.org.
Alle anderen Markenzeichen, Dienstmarkenzeichen, registrierte
Markenzeichen und registrierte Dienstmarkenzeichen können das Eigentum
der jeweiligen Inhaber sein.

Kompatibilität
