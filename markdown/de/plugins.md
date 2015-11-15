![Icinga](../images/logofullsize.png "Icinga")

5.1. Icinga Plugins

[Zurück](ch05.md) 

Kapitel 5. Die Grundlagen

 [Weiter](macros.md)

* * * * *

5.1. Icinga Plugins
-------------------

5.1.1. [Einführung](plugins.md#introduction)

5.1.2. [Was sind Plugins?](plugins.md#overview)

5.1.3. [Plugins als eine
Abstraktionsschicht](plugins.md#abstractionlayer)

5.1.4. [Welche Plugins sind verfügbar?](plugins.md#available)

5.1.5. [Plugins beschaffen](plugins.md#obtaining)

5.1.6. [Zum Icinga-Benutzer wechseln](plugins.md#hints)

5.1.7. [Anpassen der Umgebung](plugins.md#extending)

5.1.8. [Wie benutze ich Plugin X?](plugins.md#plugins-howto)

5.1.9. [Integration eines neuen
Plugins](plugins.md#plugins-new_plugin)

5.1.10. [Raw command line](plugins.md#rawcommandline)

5.1.11. [Schwellwert und Bereiche](plugins.md#thresholdranges)

5.1.12. [Aktivieren der Definition](plugins.md#errors)

5.1.13. [Plugin API](plugins.md#pluginsapi)

### 5.1.1. Einführung

Icinga enthält nicht, wie viele andere Überwachungs-Tools, interne
Mechanismen zur Prüfung des Zustands von Hosts und Services in Ihrem
Netzwerk. Icinga verlässt sich statt dessen auf externe Programme
(Plugins genannt), die all die schmutzige Arbeit tun.

### 5.1.2. Was sind Plugins?

Plugins sind kompilierte Programme oder Scripts (Perl-Scripts,
Shell-Scripts, usw.), die von einer Kommandozeile aus laufen können, um
den Status eines Hosts oder Service zu prüfen. Icinga benutzt die
Ergebnisse von Plugins, um den aktuellen Status von Hosts oder Services
in Ihrem Netzwerk zu ermitteln.

Icinga wird ein Plugin immer dann ausführen, wenn die Notwendigkeit
besteht, den Status eines Hosts oder Service zu prüfen. Das Plugin tut
*etwas* (beachten Sie den sehr allgemeinen Ausdruck), um die Prüfung
auszuführen und dann einfach die Ergebnisse an Icinga zurückzuliefern.
Icinga wird die Ergebnisse verarbeiten, die es vom Plugin erhält, und
dann notwendige Aktionen ausführen (starten von
[Eventhandlern](eventhandlers.md "7.3. Eventhandler"), senden von
[Benachrichtigungen](notifications.md "5.11. Benachrichtigungen"),
etc).

### 5.1.3. Plugins als eine Abstraktionsschicht

![](../images/plugins.png)

Plugins arbeiten wie eine Abstraktionsschicht zwischen der
Überwachungslogik im Icinga-Dämon und den eigentlichen Services und
Hosts, die überwacht werden.

Der Vorteil dieses Typs von Plugin-Architektur ist, dass Sie fast alles
überwachen können, was Ihnen einfällt. Wenn Sie den Prozess der
Überwachung automatisieren können, können Sie es mit Icinga überwachen.
Es gibt bereits eine Menge von Plugins, die erzeugt wurden, um
grundlegende Ressourcen wie z.B. Prozessorauslastung, Plattenbelegung,
Ping-Raten usw. zu überwachen. Wenn Sie etwas anderes überwachen
möchten, werfen Sie einen Blick in die Dokumentation zu [Plugins
schreiben](pluginapi.md "11.1. Nagios Plugin API") und erstellen Sie
ein eigenes. Es ist einfach!

Der Nachteil dieses Typs von Plugin-Architektur ist die Tatsache, dass
Icinga absolut keine Ahnung davon hat, was Sie überwachen. Sie könnten
Netzwerkverkehr-Statistiken, Datenfehler-Raten, Raumtemperatur,
CPU-Spannung, Lüftergeschwindigkeit, Prozessorauslastung,
Plattenbelegung überwachen oder die Fähigkeit Ihres superphantastischen
Toasters, am Morgen Ihr Brot ordnungsgemäß zu bräunen... Icinga versteht
nicht die Besonderheiten dessen, was überwacht wird - es verfolgt
lediglich Veränderungen des *Zustands* dieser Ressourcen. Nur die
Plugins selbst wissen genau, was sie überwachen und wie die eigentlichen
Prüfungen auszuführen sind.

### 5.1.4. Welche Plugins sind verfügbar?

Es gibt bereits zahlreiche Plugins, um viele verschiedene Arten von
Geräten und Services zu überwachen, u.a.:

-   HTTP, POP3, IMAP, FTP, SSH, DHCP

-   CPU-Auslastung, Plattenbelegung, Speicherauslastung, Anzahl Benutzer

-   Unix/Linux, Windows- und Netware-Server

-   Router und Switches

-   etc.

### 5.1.5. Plugins beschaffen

Plugins werden nicht mit Icinga verteilt, aber Sie finden die
offiziellen Nagios-Plugins zum Download und viele weitere Plugins, die
von Nagios-Benutzern erstellt und gewartet werden, an folgenden Stellen:

-   Monitoring Plugins Project:
    [https://www.monitoring-plugins.org](https://www.monitoring-plugins.org)

-   Monitoring Plugins Downloads Page:
    [https://www.monitoring-plugins.org/download.md](https://www.monitoring-plugins.org)

-   Icinga Exchange:
    [https://exchange.icinga.org](https://exchange.icinga.org)

Nach dem Herunterladen müssen Sie die Plugins installieren. Bitte lesen
Sie die Dokumentation (falls vorhanden), wie das zu tun ist. Sie könnte
wichtige Informationen über die Voraussetzungen wie z.B. zusätzliche
Pakete oder (Perl-) Module enthalten, wie das Plugin zu installieren ist
bzw. distributionsabhängige Hinweise.

Manchmal müssen Sie das Plugin kompilieren, wobei Sie den Vorgang durch
den Aufruf von "./configure" mit oder ohne Optionen vorbereiten. Bitte
prüfen Sie die Datei `config.log`{.filename} auf mögliche Fehler zu
fehlenden (devel-)Paketen vor dem Aufuf des eigentlichen
Compile-Vorgangs (meistens "make" oder "make all"). In den meisten
Fällen wird das Plugin durch den Aufruf von "make install" in das
Plugins-Verzeichnis (z.B. `/usr/local/icinga/libexec`{.filename})
kopiert.

Manchmal müssen Sie das Plugin auf Ihre Umgebung anpassen (z.B. den Pfad
zu "utils.pm"). Sie können stattdessen einen logischen Link erzeugen,
der auf das Plugin-Verzeichnis weist, so dass Sie nicht das Plugin
ändern müssen, um diese Änderung zu umgehen und spätere Updates zu
vereinfachen. Das könnte wie folgt geschehen:

~~~~ {.programlisting}
 $> mkdir /usr/local/nagios
 $> ln -s /usr/local/icinga/libexec /usr/local/nagios/libexec
~~~~

![[Anmerkung]](../images/note.png)

Anmerkung

Bei Verwendung von Paketen kann der Pfad zum Plugin-Verzeichnis anders
lauten (z.B. `/usr/lib/plugins`{.filename}), so dass Sie den Befehl
entsprechend anpassen müssen.

### 5.1.6. Zum Icinga-Benutzer wechseln

![[Wichtig]](../images/important.png)

Wichtig

Führen Sie Plugins immer mit dem Icinga-Benutzer aus, denn einige
Plugins erstellen temporäre Dateien. Wenn Sie Plugins mit einem anderen
Benutzer ausführen, dann kann der Icinga-Benutzer diese Dateien ggf.
nicht überschreiben. Wenn Sie einen anderen Benutzer verwenden, werden
Sie nicht feststellen, ob ist der Icinga-Benutzer überhaupt berechtigt
ist, auf bestimmte Dateien (z.B. Shared Libraries) zuzugreifen.

Rufen Sie das Plugin nicht mit einem relativen Pfad auf (z.B.
`./check_test_plugin`{.filename}). Benutzen Sie immer absolute Pfade,
denn so macht es auch Icinga (z.B.
`/usr/local/icinga/libexec/check_test_plugin`{.filename}).

Bitte beachten Sie, dass der Icinga-*Benutzer* eine andere Umgebung als
der Icinga-*Prozess* hat. Beim Benutzer wurden Login-Skripte durchlaufen
und es ist ein Terminal mit der Benutzer-Sitzung verbunden, so dass die
erfolgreiche Ausführung eines Plugins von der Kommandozeile aus nicht
(notwendigerweise) bedeutet, dass es funktioniert, wenn es vom Prozess
ausgeführt wird. Außerdem wird der Prozess per Default keine Shell
benutzen, sondern Aufrufe von popen/execvp ausführen, abhängig vom
Befehl (popen falls die Kommandozeile Metazeichen enthält, die Bedeutung
für die Shell haben wie z.B. `!$^&*()~[]\|{};<>?'"`{.literal}, execvp
falls keine Metazeichen vorhanden sind).

Wechseln Sie zum Icinga-Benutzer, der in `icinga.cfg`{.filename}
definiert ist, falls noch nicht geschehen, und bereinigen Sie die
Umgebung

~~~~ {.screen}
 #> su - icinga
 #> env -i
~~~~

Wenn Sie jetzt angemeldet sind, dann springen Sie zum Punkt "Anpassen
der Umgebung".

Bedingt durch das Sicherheitsbewusstsein des Packagers /
Systemadministrators könnte dies fehlschlagen, weil der Account für
Anmeldungen gesperrt ist. Bitten Sie Ihren Systemadministrator, das
vorübergehend zu ändern oder führen Sie einen der folgenden Punkte aus

-   ermitteln Sie die aktuelle Shell aus `/etc/passwd`{.filename} und
    ändern Sie diese durch Ausführen von

    ~~~~ {.screen}
     #> OLD_SHELL=`grep icinga /etc/passwd | sed 's/.*://'`
     #> usermod -s /bin/sh icinga
    ~~~~

    führen Sie die Befehle aus, nachdem Sie zum Icinga-Benutzer
    gewechselt sind und die Umgebung wie oben beschrieben bereinigt
    haben

    vergessen Sie nicht, die Shell-Einstellung nach dem Testen und
    verlassen der Sitzung wiederherzustellen

    ~~~~ {.screen}
     #> usermod -s $OLD_SHELL icinga
    ~~~~

-   führen Sie den Befehl über "sudo -u icinga" aus

    ~~~~ {.screen}
     #> sudo -u icinga /usr/local/icinga/libexec/sample-plugin.pl ...
    ~~~~

### 5.1.7. Anpassen der Umgebung

Einige Prüfungen (wie check\_oracle\_health) hängen davon ab, dass
verschiedene Umgebungsvariablen gesetzt sind. Setzen Sie diese nicht in
`.bashrc`{.filename} oder anderen benutzerabhängigen Dateien, sondern
wählen Sie dafür eine zentrale Stelle. Das Default-Init-Skript
durchläuft die Datei `/etc/sysconfig/icinga`{.filename} (wenn sie
vorhanden ist), so dass es ein idealer Platz wäre. Benutzen Sie dafür
nicht das Init-Skript selbst, weil Ihre Änderungen sonst bei Updates
ggf. verloren gehen.

Beispiel für `/etc/sysconfig/icinga`{.filename}

~~~~ {.programlisting}
 export ORACLE_HOME=/usr/lib/oracle/11.2/client64
 export LD_LIBRARY_PATH=$ORACLE_HOME/lib
 export PATH=$PATH:$ORACLE_HOME
~~~~

Nachdem Sie sich angemeldet haben, sind diese Variablen noch nicht
verfügbar, aber das ist ziemlich einfach

~~~~ {.screen}
 $> . /etc/sysconfig/icinga
~~~~

Bitte überprüfen Sie die Einstellungen

~~~~ {.screen}
 $> echo $ORACLE_HOME
 $> echo $LD_LIBRARY_PATH
 $> echo $PATH
~~~~

### 5.1.8. Wie benutze ich Plugin X?

Fast alle Plugins zeigen grundlegende Bedienungshinweise an, wenn sie
von der Kommandozeile mit der Option '-h' oder '--help' aufgerufen
werden. Wenn Sie z.B. wissen möchten, wie das Plugins check\_http
arbeitet bzw. welche Optionen es akzeptiert, sollten Sie folgenden
Befehl ausprobieren:

~~~~ {.screen}
 $> ./check_http --help
~~~~

### 5.1.9. Integration eines neuen Plugins

Nach der Installation des Plugins rufen Sie es mit den nötigen Optionen
von der Kommandozeile aus auf. Wenn dies funktioniert, können Sie es in
Icinga integrieren.

Stellen Sie sich vor, dass Sie den folgenden Aufruf benutzt haben:

~~~~ {.programlisting}
 /usr/local/icinga/libexec/sample-plugin.pl -H 192.168.1.2 -a argument1 -p parameter -n 5
~~~~

Die command-Definition enthält zwei Direktiven

-   command\_name: dies ist ein Kurzname, der den Befehl identifiziert.
    Lassen Sie uns *check\_sample* benutzen

-   command\_line: hier definieren Sie den auszuführenden Befehl. Sie
    könnten den Befehl angeben, den Sie auf der Kommandozeile benutzen,
    aber das wäre zu unflexibel. Normalerweise ändert sich das
    Plugin-Verzeichnis (/usr/local/icinga/libexec) nicht, so dass wir
    eine [\$USERn\$](macrolist.md#macrolist-user)-Variable benutzen
    können, die in der resource.cfg definiert werden. Die IP-Adresse
    ändert sich von Host zu Host. Es gibt das Makro
    [\$HOSTADDRESS\$](macrolist.md#macrolist-hostaddress), das wir
    dafür nutzen können. Die Werte der Optionen können sich ändern, so
    dass auch sie flexibel sein sollten. Das könnte zu folgender
    Definition führen:

~~~~ {.programlisting}
 define command{ 
    command_name check_sample
    command_line $USER1$/sample-plugin.pl -H $HOSTADDRESS$ -a $ARG1$ -p $ARG2$ -n $ARG3$
    }
~~~~

Dann müssen wir die check\_command-Direktive definieren, die Teil der
Host-/Service-Definition ist. Es beginnt mit dem Kurznamen gefolgt von
den Argumenten, die jeweils durch Ausrufezeichen voneinander getrennt
sind:

~~~~ {.programlisting}
 check_command check_sample!argument1!parameter!5
~~~~

Wie Sie sehen, wird die IP-Adresse nicht angegeben, denn sie wird aus
der Host-Definition genommen.

Das zusammensetzen in umgekehrter Reihenfolge zeigt, wie Icinga die
Informationen verarbeitet:

~~~~ {.programlisting}
 check_command check_sample!argument1!parameter!5
                                |         |     +-------------------------------------+
                                |         +---------------------------------+         |
                                +---------------------------------+         |         |
                                                                  |         |         |
 Host macro ----------------------------------------+             |         |         |
                                                    |             |         |         |
 User macro --------+                               |             |         |         |
                    |                               |             |         |         |
 command_line      $USER1$/sample-plugin.pl -H $HOSTADDRESS$ -a $ARG1$ -p $ARG2$ -n $ARG3$

resultiert in:

 /usr/local/icinga/libexec/sample-plugin.pl -H 192.168.1.2 -a argument1 -p parameter -n 5
~~~~

Neben den bereits genannten gibt es eine Vielzahl von
[Makros](macros.md "5.2. Makros verstehen und wie sie arbeiten"), die
die Arbeit erleichtern. Dabei gibt es einige Dinge anzumerken:

-   Alle Icinga-Makros benutzen Großbuchstaben und werden in
    Dollarzeichen (\$) eingeschlossen

-   Die meisten Makros haben einen bestimmten Gültigkeitsbereich. Wenn
    Sie versuchen, ein Makro außerhalb dieses Bereichs zu nutzen, dann
    werden Sie statt des erwarteten Wertes lediglich ein Dollarzeichen
    (\$) sehen

-   Die [\$USERn\$](macrolist.md#macrolist-user)-Makros können genutzt
    werden, um sensible Informationen wie z.B. Passwörter zu
    "verstecken", denn die Werte werden im Gegensatz zu den anderen
    Makros nicht im Web-Interface angezeigt. Außerdem können sie
    verwendet werden, um bestimmte Sonderzeichen nutzen zu können, die
    anderenfalls zu Schwierigkeiten führen. Ein Beispiel wäre
    `USER99=;`{.literal}. Auf diese Weise können Sie ein Semikolon
    benutzen, das sonst als Start eines Kommentars in Ihrer Definition
    behandelt würde

-   Nachdem es bei deutschsprachigen Personen oftmals zu Problemen
    kommt: [\$HOSTADDRESS\$](macrolist.md#macrolist-hostaddress) wird
    mit zwei "D" geschrieben

**NRPE und "dont\_blame\_nrpe=1"**

Die Benutzung von NRPE mit Argumenten erfordert etwas Aufmerksamkeit.
Wenn wir annehmen, dass Sie die Argumentverarbeitung auf dem entfernten
Rechner in der Datei `nrpe.cfg`{.filename} mit Hilfe von
"dont\_blame\_nrpe=1" (oder durch "allow\_arguments=1" in
`nsc.ini`{.filename}) aktiviert haben, dann können Sie Parameter vom
Icinga-Server an den entfernten Rechner übergeben. Lassen Sie uns
folgende Definitionen annehmen.

Auf dem Icinga-Server

~~~~ {.programlisting}
 define command{
    command_name check_nrpe
    command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -a $ARG2$
    }

 define service{
    ...
    check_command check_nrpe!check_process!cupsd
~~~~

Auf dem entfernten Rechner in der NRPE-Konfigurationsdatei

~~~~ {.programlisting}
...
command[check_process]=your_plugin "$ARG1$"
~~~~

Der Icinga-Prozess wird die Definitionen wie folgt auflösen

~~~~ {.programlisting}
 check_command check_nrpe!check_process!cupsd
                                |         |
                                |         +---------------------------+
                                +---------------------------+         |
                                                            |         |
 Host macro ----------------------------------+             |         |
                                              |             |         |
 User macro --------+                         |             |         |
                    |                         |             |         |
 command_line      $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -a $ARG2$

resultiert in:

 /usr/local/icinga/libexec/check_nrpe -H 192.168.1.2 -c check_process -a cupsd
~~~~

Auf dem entfernten Rechner erhält der NRPE-Prozess einen Aufruf mit zwei
Parametern: "check\_process" und "cupsd". Der erste wird entfernt, um
den Befehl festzulegen, der auszuführen ist, so dass nur **ein**
Argument an den Befehl übergeben wird!

![[Anmerkung]](../images/note.png)

Anmerkung

\$ARG1\$ auf dem entfernten Rechner ist **nicht** das gleiche wie auf
dem Icinga-Server!

### 5.1.10. Raw command line

Das klassische UI ermöglicht die Anzeige der Kommandozeile mit
aufgelösten Variablen einschließlich der Werte aus
`resource.cfg`{.filename}. Der Klick auf "ACTIVE" neben "Check type" in
den Host-/Service Check Details gibt Ihnen Zugriff auf diese
Informationen. Wenn Sie noch keine Prüfung definiert haben, dann wählen
Sie "View Config" aus den Hauptmenü auf der linken Seite und dann
"Command expansion". Bitte beachten Sie, dass der Benutzer über die
Direktive
[authorized\_for\_full\_command\_resolution](configcgi.md#configcgi-authorized_for_full_command_resolution)
in `cgi.cfg`{.filename} explizit dazu berechtigt sein muss, die Werte
der Variable aus `resource.cfg`{.filename} sehen zu dürfen. Außerdem
muss der Benutzer, unter dem der Web-Server läuft, Leseberechtigung auf
diese Datei besitzen.

Wenn Sie die Kommandozeile protokollieren möchten, dann müssen Sie
einige Direktiven in `icinga.cfg`{.filename} auf die folgenden Werte
ändern

~~~~ {.programlisting}
 #  16 = Host/service checks
 # 256 = Commands
 debug_level=272
 debug_verbosity=2
 max_debug_file_size=1000000000
~~~~

### 5.1.11. Schwellwert und Bereiche

Einige Plugins unterstützen Bereichsangaben für die Warn- und
Kritisch-Werte. Bitte überprüfen Sie die Dokumentation, ob das der Fall
für das Plugin ist, das Sie benutzen möchten. Das Folgende ist ein
Auszug der (englischsprachigen)
[Entwickler-Richtlinien](https://www.monitoring-plugins.org/doc/guidelines.md#THRESHOLDFORMAT):

Ein Bereich ist definiert als ein Start- und Endpunkt (inklusive) auf
einer numerischen Skala (ggf. bis zu +/--Unendlich).

Ein Schwellwert ist ein Bereich mit einem Alarmpegel (entweder Warning
oder Critical).

In der Theorie wird das Plugin eine Prüfung durchführen, die einen
numerischen Wert oder eine Metrik zurückliefert, die dann mit den
Warning- und Critical-Schwellwerten verglichen wird

Dies ist das generelle Format für Bereiche:

`[@]start:end`{.code}

Anmerkungen:

1.  start = end, falls :end nicht angegeben ist

2.  start und ":" ist nicht erforderlich, wenn start=0

3.  falls der Bereich vom Format "start:" ist und end nicht angegeben
    wurde, dann ist das Ende als +Unendlich anzunehmen

4.  um -Unendlich anzugeben, benutzen Sie "\~"

5.  Alarm erfolgt, wenn die Metrik außerhalb des durch Start- und Ende
    angegebenen Bereichs liegt (Endpunkte gehören *nicht* zum Bereich)

6.  wenn der Bereich mit "@" beginnt, dann ist zu alamieren, wenn die
    Metrik innerhalb des Bereichs liegt (einschließlich der Endpunkte)

![[Anmerkung]](../images/note.png)

Anmerkung

Nicht alle Plugin unterstützen (bisher) die Bereichsnotation.

Beispiele

**Bereichsdefinition**

**Alarm, wenn x...**

10

\< 0 oder \> 10, (außerhalb des Bereichs von {0 .. 10})

10:

\< 10, (außerhalb {10 .. Unendlich})

\~:10

\> 10, (außerhalb des Bereichs von {-Unendlich .. 10})

10:20

\< 10 oder \> 20, (außerhalb des Bereichs von {10 .. 20})

@10:20

\>= 10 and \<= 20, (im Bereich von {10 .. 20})

Kommandozeilenbeispiele

**Kommandozeile**

**Erklärung**

check\_stuff -w10 -c20

kritisch, wenn "stuff" größer als 20, andernfalls warnen, wenn größer
als 10 (außerdem kritisch, wenn "stuff" kleiner als 0)

check\_stuff -w\~:10 -c\~:20

das Gleiche wie oben, allerdings ist "stuff" kleiner als Null OK!

check\_stuff -w10: -c20

kritisch, wenn "stuff" größer als 20, andernfalls warnen, wenn"stuff"
kleiner als 10 (außerdem kritisch, wenn "stuff" kleiner als 0)

check\_stuff -c1:

kritisch, wenn "stuff" kleiner als 1

check\_stuff -w\~:0 -c10

kritisch, wenn "stuff" größer als 10; warnen, wenn "stuff" größer als 0

check\_stuff -c5:6

der einzig nicht-kritische Bereich ist 5:6

check\_stuff -c@10:20

kritisch, wenn "stuff" zwischen 10 und 20 **[1]**

check\_stuff -w20:30 -c10:40

warnen, wenn "stuff" kleiner als 20 oder größer als 30, kritisch, wenn
"stuff" kleiner als 10 oder größer als 40 **[2]**

![[Anmerkung]](../images/note.png)

Anmerkung

[1]: Bei der Kommandozeile in den Entwickler-Richtlinien fehlt "@",
anderenfalls wäre die Erklärung falsch (und es gäbe kein Beispiel für
die @-Notation)

[2]: Bitte beachten Sie, dass das letzte Beispiel geschachtelte Bereiche
benutzt. Das mag nicht bei allen Plugins funktionieren, die
Bereichsangaben unterstützen. Es wurde mit check\_snmp getestet

### 5.1.12. Aktivieren der Definition

Prüfen Sie die Konfiguration mit "/etc/init.d/icinga show-errors" und
bereinigen Sie eventuelle Fehler, bevor Sie Icinga mit
"/etc/init.d/icinga restart" neu starten. Warten Sie, bis das Objekt
geprüft wurde und betrachten Sie die Status-Details. Vielleicht gibt es
Fehler.

-   "...resulted in a return code of 127" / "out of bounds"

    Das bedeutet, dass das Plugin nicht an der angegebenen Position
    gefunden wurde oder innerhalb des Plugins eine Datei aufgerufen
    wurde, die nicht gefunden wurde. Wenn Sie \$USERn\$-Makros beim
    Aufruf des Plugins benutzen, dann stellen Sie sicher, dass das
    Makros wirklich auf die Position verweist, wo das Plugin zu finden
    ist (ist das Makro in resource.cfg definiert?).
    Benachrichtigungsbefehle rufen oft ein Mail-Programm auf. Stellen
    Sie sicher, dass der Pfad zum Mail-Programm korrekt ist.

-   "...resulted in a return code of 126"

    Meistens handelt es sich um ein Berechtigungsproblem. Der Benutzer
    kann ggf. das Plugin nicht ausführen bzw. darauf und/oder auf
    zugehörige Dateien zugreifen.

-   "...resulted in a return code of 13"

    Meistens handelt es sich um ein Berechtigungsproblem. Der Benutzer
    kann ggf. das Plugin nicht ausführen bzw. darauf und/oder auf
    zugehörige Dateien zugreifen. Das kann passieren, wenn Sie als root
    ein Plugin ausgeführt haben, das temporäre Dateien anlegt. Der
    Icinga-Benutzer ist nicht berechtigt, diese Dateien zu
    überschreiben.

-   (null)

    Der interne Aufruf von execvp lieferte nichts zurück.

### 5.1.13. Plugin API

Informationen zu technischen Aspekten von Plugins sowie zur Erstellung
Ihrer eigenen Plugins finden Sie
[hier](pluginapi.md "11.1. Nagios Plugin API").

* * * * *

  ---------------------------- -------------------------- ---------------------------------------------
  [Zurück](ch05.md)          [Nach oben](ch05.md)      [Weiter](macros.md)
  Kapitel 5. Die Grundlagen    [Zum Anfang](index.md)    5.2. Makros verstehen und wie sie arbeiten
  ---------------------------- -------------------------- ---------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
