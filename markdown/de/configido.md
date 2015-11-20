 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

12.3. Konfiguration der IDOUtils
--------------------------------

12.3.1. [IDOMOD
Konfigurationsoptionen](configido.md#configido-idomod_options)

12.3.2. [IDO2DB
Konfigurationsoptionen](configido.md#configido-ido2db_options)

![[Anmerkung]](../images/note.png)

Anmerkung

Dies sollte als "in Bearbeitung" angesehen werden.

[Änderungen an den Core-Dateien](configido.md#configido_)

[Änderungen in idomod.cfg](configido.md#configido-idomod)

[Hinweise zu Performance und
Fehlersuche](configido.md#configido-hints)

[Änderungen in ido2db.cfg](configido.md#configido-ido2db)

[idomod.cfg
Konfigurationsoptionen](configido.md#configido-idomod_options "12.3.1. IDOMOD Konfigurationsoptionen")

[ido2db.cfg
Konfigurationsoptionen](configido.md#configido-ido2db_options "12.3.2. IDO2DB Konfigurationsoptionen")

**Core**

Die Konfiguration beginnt mit dem Setzen der Direktive "broker\_options"
in `icinga.cfg`. In den meisten Fällen ist dieser Wert in der
Datei bereits vorhanden, muss aber ggf. aktiviert werden (durch das
Entfernen des führenden Hash-Zeichens).

![[Wichtig]](../images/important.png)

Wichtig

Bitte beachten Sie, dass diese Einstellung **alle** Event-Broker-Module
beeinflusst! (Details siehe
[http://www.mail-archive.com/nagios-users@lists.sourceforge.net/msg24002.md).](http://www.mail-archive.com/nagios-users@lists.sourceforge.net/msg24002.md))

Aktivieren Sie das idomod-Event-Broker-Modul. Bitte beachten Sie, dass
die folgende Modul-Definition unter normalen Umständen bereits im
`modules`-Unterverzeichnis existiert, so dass keine
Notwendigkeit besteht, die Hauptkonfigurationsdatei zu ändern.

Falls nicht, dann kann die Definition des Broker-Moduls mit Hilfe einer
[module-Definition](objectdefinitions.md#objectdefinitions-module)
erfolgen, die der folgenden ähnelt:

<pre><code>
 define module {
 }
</code></pre>

**idomod.cfg**

Bitte überprüfen Sie die Einstellungen, bevor Sie Icinga (neu)starten.

Die Direktive "output\_type" sollte auf "unixsocket" (default) oder
"tcpsocket" gesetzt werden, abhängig davon, ob der IDO2DB-Daemon auf
einen lokalen oder entfernten Rechner läuft. Bitte setzen Sie den Wert
von "output" entsprechend (und außerdem "tcp\_port", falls zutreffend).
Die anderen Optionen sind auf Werte gesetzt, die für einen ersten
Betrieb funktionieren. Falls es während der Laufzeit Schwierigkeiten
gibt, dann sollten Sie einen Blick auf die folgenden Zeilen werfen:

**Hinweise zu Performance und Fehlersuche**











































**ido2db.cfg**
























### 12.3.1. IDOMOD Konfigurationsoptionen

**Instanzname**

Format:

**instance\_name=\<name\>**

Example:

**instance\_name=default**

Diese Option legt den "Namen" fest, der mit dieser Icinga-Instanz
verbunden ist und wird benutzt, um Daten von mehreren Instanzen zu
unterscheiden. Standard ist 'default' (ohne Anführungszeichen).

**Ausgabetyp**

Format:

**output\_type**=**\<file\>|\<tcpsocket\>|\<unixsocket\>**

Beispiel:

**output\_type=unixsocket**

Diese Option legt fest, welchen Typ von "Abfluss" das IDO-NEB-Modul für
die Datenausgabe nutzen soll.

Mögliche Werte sind:




**Ausgabe**

Format:

**output=****\<ip address\>|\<file name\>**

Beispiel:

**output=/usr/local/icinga/var/ido.sock**

Diese Option legt Namen und Pfad der Datei oder des UNIX-Domain-Socket
fest, wohin die Daten geschickt werden sollen, wenn als Ausgabetyp
"file" oder "unixsocket" angegeben wurde. Wenn der Ausgabetyp
"tcpsocket" ist, dann wird diese Option dazu genutzt, die IP-Adresse
oder den FQDN des Hosts anzugeben, mit dem sich das Modul verbinden
soll, um die Daten zu senden.

**TCP-port**

Format:

**tcp\_port=\<n\>**

Beispiel:

**tcp\_port=5668**

Diese Option legt fest, mit welchem Port sich das Modul verbinden soll,
um die Daten zu senden. Diese Option ist nur gültig, wenn als
Ausgabetype "tcpsocket" angegeben wurde.

**Verschlüsselung benutzen**

Format:

**use\_ssl=**

Beispiel:

**use\_ssl=0**

Diese Option legt fest, ob das Modul SSL benutzen wird, um den
Netzwerkverkehr zwischen Modul und ido2db-Daemon zu verschlüsseln. Beide
Seiten müssen dieses Feature aktivieren, das von SSL-Bibliotheken wie
openssl oder Kerberos abhängt.

Diese Option ist nur gültig, wenn als Ausgabetype "tcpsocket" angegeben
wurde.

**Größe des Ausgabepuffers**

Format:

**output\_buffer\_items=\<n\>**

Beispiel:

**output\_buffer\_items=5000**

Diese Option legt die Größe des Ausgabepuffers fest, der verhindern
soll, dass Daten bei einem vorübergehenden Verbindungsabbruch zum
"Abfluss" verlorengehen. Die angegebene Zahl gibt die Zahl von Zeilen
(jeweils mit variabler Länge) an, die gepuffert werden.

**Pufferdatei**

Format:

**buffer\_file=\<file name\>**

Beispiel:

**buffer\_file=/usr/local/icinga/var/idomod.tmp**

Diese Option legt den Namen einer Datei fest, die zur Speicherung von
gepufferten Daten benutzt wird, die nicht an den IDO2DB-Daemon gesendet
werden konnten, während Icinga heruntergefahren wird. Vor dem Ende wird
das IDO-NEB-Modul alle gepufferten Daten in diese Datei schreiben, damit
sie später verarbeitet werden können. Wenn Icinga (neu)startet, wird das
IDO-NEB-Modul den Inhalt dieser Datei lesen und ihn an den IDO2DB-Daemon
zur weiteren Verarbeitung senden.

**Datenrotationsintervall**

Format:

**file\_rotation\_interval=\<seconds\>**

Beispiel:

**file\_rotation\_interval=14400**

Diese Option legt fest, wie oft (in Sekunden) die Datei von Icinga
rotiert wird. Dateirotation wird von Icinga erledigt, indem der durch
die "file\_rotation\_command"-Option angegebene Befehl ausgeführt wird.
Diese Option hat keine Auswirkung, wenn als Ausgabetyp ein Socket
angegeben wurde.

**Dateirotationsbefehl**

Format:

**file\_rotation\_command=\<command\>**

Beispiel:

**file\_rotation\_command=rotate\_ido\_log**

Diese Option gibt den Befehl an (wie in Icinga definiert), der zur
Rotation der Ausgabedatei benutzen werden soll im Intervall, das durch
die Option "file\_rotation\_interval" angegeben wurde. Diese Option hat
keine Auswirkung, wenn als Ausgabetyp ein Socket angegeben wurde.

Die Datei 'misccommands.cfg' enthält eine Beispiel-command-Definition,
die Sie zur Rotation der Log-Datei nutzen können.

**Dateirotations-Timeout**

Format:

**file\_rotation\_timeout=\<seconds\>**

Beispiel:

**file\_rotation\_timeout=60**

Diese Option legt die maximale Anzahl von Sekunden fest, die der
Rotationsbefehl laufen darf, bevor er abgebrochen wird.

**Reconnect-Intervall**

Format:

**reconnect\_interval=\<seconds\>**

Beispiel:

**reconnect\_interval=15**

Diese Option legt fest, in welchem Intervall (in Sekunden) das
IDO-NEB-Modul versuchen wird, einen Verbindungsaufbau durchzuführen,
wenn die Verbindung zur Ausgabedatei oder zum Socket verloren gegangen
ist.

**Reconnect-Warnintervall**

Format:

**reconnect\_warning\_interval=\<seconds\>**

Beispiel:

**reconnect\_warning\_interval=15**

Diese Option legt fest, in welchem Intervall (in Sekunden) eine
Warnmeldung in die Icinga-Protokolldatei geschrieben wird, wenn die
Verbindung zur Ausgabedatei oder zum Socket nicht wieder aufgebaut
werden kann.

**Datenverarbeitungsoptionen**

Format:

**data\_processing\_options=\<n\>**

Beispiel:

**data\_processing\_options=-1**

![[Achtung]](../images/caution.png)

Achtung

Ändern Sie nicht den Wert dieser Option, wenn Sie die Auswirkungen nicht
kennen!!!

Diese Option lefgt fest, welche Daten vom IDO-NEB-Modul verarbeitet
werden.

Lesen Sie den Source-Code
(`module/idoutils/include/idomod.h`) und suchen Sie nach
"IDOMOD\_PROCESS\_", um festzulegen, welche Werte hier zu benutzen sind.

Die Werte aus dem Source-Code sollten addiert werden, um den benötigten
Wert zu ermitteln. Der Wert "-1" bewirkt, dass alle Daten verarbeitet
werden.

Generell stehen die folgenden Werte zur Berechnung zur Verfügung:

<pre><code>
 #
 #
 # You may use the Online Calculator by Gerhard Lausser:
 # http://labs.consol.de/nagios/ndo-data-processing-options/
 # (please note that there is a checkbox for everything!)
 #
 # The default setting will remove everything not used by default.
 #
 # 67108863-(2+64+128) = 67108863-194 = 67108669

 data_processing_options=67108669

 # If you are planning to use NagVis you may want to use the following setting:
 #
 #data_processing_options=4061953
 #
</code></pre>

**Konfigurationsausgabeoptionen**

Format:

**config\_output\_options=\<0|1|2|3\>**

Beispiel:

**config\_output\_options=2**

Diese Option legt fest, welche Arten der Icinga-Konfigurationsdaten vom
IDO-NEB-Modul ausgegeben werden. Die Werte werden addiert. Hinweis: "2"
ist der bevorzugte Wert.

Mögliche Werte sind:





**Debug-Level**

Format:

**debug\_level=\<-1|0|1|2\>**

Beispiel:

**debug\_level=0**

Diese Option legt fest, wieviel (falls überhaupt)
Debugging-Informationen in die Debug-Datei geschrieben werden. Addieren
Sie die Werte, um mehrere Arten von Informationen zu erhalten.

Mögliche Werte sind:





**Debug-Ausführlichkeit**

Format:

**debug\_verbosity=\<0|1|2\>**

Beispiel:

**debug\_verbosity=1**

Diese Option legt fest, wie ausführlich die Debug-Protokollausgaben sein
werden.

Mögliche Werte sind:




**Name der Debug-Datei**

Format:

**debug\_file=\<file name\>**

Beispiel:

**debug\_file=/usr/local/icinga/var/idomod.debug\>**

Diese Option legt fest, an welche Stelle der Daemon die
Debugging-Informationen schreiben soll.

**Maximale Größe der Debug-Datei**

Format:

**max\_debug\_file\_size=\<bytes\>**

Beispiel:

**max\_debug\_file\_size=100000000**

Diese Option legt die maximale Größe (in Bytes) der Debug-Protokolldatei
fest. Falls die Datei diese Größe überschreitet, wird sie in eine Datei
mit der Endung `.old` umbenannt. Eine bereits bestehende
Datei mit dieser Endung wird automatisch gelöscht. Dies soll dazu
beitragen, dass die Dateisystemauslastung während des Debugging nicht
außer Kontrolle gerät.

**Ausgeben des Zustands von benutzerdefinierten Variablen**

Format:

**dump\_customvar\_status=0|1**

Example:

**dump\_customvar\_status=1**

Benutzerdefinierte Variablen werden als benötigte Informationen sowohl
beim Core-Start als auch während der Laufzeit (weil es Änderungen durch
externe Befehle geben könnte) ausgegeben. Weil diese Änderungen bei
jeder Host/Service/Kontakt-Statusaktualisierung passieren können, ohne
dass es eine Möglichkeit gibt, diese durch
"data\_processing\_options"-Einstellungen zu filtern, wurde diese
Konfigurationsoption hinzugefügt. In den meisten Situationen werden
diese Informationen nicht benötigt, so dass die Option standardmäßig
deaktiviert ist.

### 12.3.2. IDO2DB Konfigurationsoptionen

**Sperrdatei**

Format:

**lock\_file=\<file name\>**

Beispiel:

**lock\_file=ido2db.lock**

Dies ist die Sperrdatei, die IDO2DB benutzen wird, um die PID-Nummer zu
speichern, wenn es im Daemon-Modus läuft.

**IDO2DB-Benutzer/Gruppe**

Format:

**ido2db\_user=\<user name\>**

**ido2db\_group=\<group name\>**

Beispiel:

**ido2db\_user=icinga** **ido2db\_group=icinga-cmd**

Diese Optionen legen Benutzer/Gruppe fest, mit denen der Daemon läuft.
Sie können für jede Option jeweils eine Zahl (uid/gid) oder einen Namen
angeben.

**Socket-Typ**

Format:

**socket\_type=\<unix|tcp\>**

Beispiel:

**socket\_type=unix**

Diese Option legt fest, welchen Socket-Typ der Daemon anlegt, um
Verbindungen zu akzeptieren.

**Socket-Name**

Format:

**socket\_name=\<file name\>**

Beispiel:

**socket\_name=/usr/local/icinga/rw/ido.sock**

Diese Option legt den Namen und Pfad des UNIX-Domain-Socket fest, den
der Daemon anlegt, um Verbindungen zu akzeptieren. Diese Option ist nur
gültig, wenn der Socket-Typ den Wert "unix" hat.

**Socket Permissions**

Format:

**socket\_perm=\<n\>**

Beispiel:

**socket\_perm=0755**

Diese Option setzt die Berechtigungen auf den UNIX-Domain- Socket. Sie
ist nur gültig wenn als Socket-Typ "unix" gewählt wurde. Standardmäßig
werden die Berechtigungen auf 0755 gesetzt.

**TCP-Port**

Format:

**tcp\_port=\<n\>**

Beispiel:

**tcp\_port=5668**

Diese Option legt fest, mit welchem Port sich das Modul verbindet, um
Ausgaben zu senden. Diese Option ist nur gültig, wenn der Socket-Typ den
Wert "tcp" hat.

**Verschlüsselung benutzen**

Format:

**use\_ssl=**

Beispiel:

**use\_ssl=0**

Diese Option legt fest, ob das Modul SSL benutzen wird, um den
Netzwerkverkehr zwischen Modul und ido2db-Daemon zu verschlüsseln. Beide
Seiten müssen dieses Feature aktivieren, das von SSL-Bibliotheken wie
openssl oder Kerberos abhängt.

Diese Option ist nur gültig, wenn als Ausgabetype "tcp" angegeben wurde.

**Libdbi- Treiber Verzeichnis**

Format:

**libdbi\_driver\_dir=@LIBDBIDRIVERDIR@**

Beispiel:

**libdbi\_driver\_dir=/usr/local/lib/dbd**

![[Anmerkung]](../images/note.png)

Anmerkung

!!!EXPERIMENTAL!!! Diese Option ist nur valid wenn libdbi als
Datenbankabstraktionsschicht einkompiliert wurde (also nicht Oracle!).
Normalerweise findet libdbi den richtigen Pfad während der Kompilierung.
Wenn Sie den Pfad ändern möchten, aktivieren Sie diese Option und ändern
Sie die Pfadangabe.

**Datenbank-Server-Typ**

Format:

**db\_servertype=\<type\>**

Beispiel:

**db\_servertype=mysql**

Diese Option legt fest, mit welchem Typ von DB-Server sich der Daemon
verbinden soll. Unterstützte Datenbanken sind MySQL, PostgreSQL und
Oracle

Mögliche Werte sind:




**Datenbank-Host**

Format:

**db\_host=\<host name|ip address\>**

Beispiel:

**db\_host=localhost**

Diese Option legt fest, auf welchem Host der DB-Server läuft.

**MySQL:**Der Hostname oder die IP-Adresse des MySQL-Datenbank-Servers.
Benutzen Sie eine leere Zeichenkette oder "localhost", um mit einem
MySQL-Server auf der lokalen Maschine zu verbinden.

**PostgreSQL:**Wenn dies mit einem Slash (/) beginnt, dann handelt es
sich um Unix-Domain-Kommunikation anstatt um TCP/IP-Kommunikation; der
Wert ist der Name des Verzeichnisses, in dem die Socket-Datei angelegt
wird. Das Standardverhalten, wenn kein Host angegeben ist, besteht
darin, sich mit einem Unix-Domain-Socket in /tmp zu verbinden (bzw. das
Verzeichnis, das bei der Erstellung von PostgreSQL angegeben wurde).

**Oracle:**Diese Einstellung wird ignoriert.

**Datenbank-Port**

Format:

**db\_port=\<n\>**

Beispiel:

**db\_port=3306**

Diese Option gibt den Port an, auf dem der DB-Server läuft.

Übliche Werte sind:




**MySQL:**Der Port auf der entfernten Maschine, zu dem verbunden werden
soll.

**PostgreSQL:**Der Port auf dem Datenbank-Host, oder die
Namenserweiterung der Socket-Datei bei Unix-Domain-Verbindungen.

**Oracle:**Die ocilib wird diesen Wert ignorieren, Sie müssen daher die
`tnsnames.ora` anpassen.

**Datenbank-Socket**

Format:

**db\_socket=\<file name\>**

Beispiel:

**db\_socket=/var/lib/mysql/mysql.sock**

Die Direktive "db\_socket" erlaubt es, eine abweichende Socket-Position
anzugeben. Diese wird an libdbi-MySQL als mysql\_unix\_socket
weitergeben, während PostgreSQL den Port überschreibt und ocilib-Oracle
diese Einstellung ignoriert.

![[Anmerkung]](../images/note.png)

Anmerkung

Diese Einstellung überschreibt db\_port und macht den Wert dadurch
nutzlos!

**Datenbankname**

Format:

**db\_name=\<name\>**

Beispiel:

**db\_name=icinga**

Diese Option gibt den Namen der Datenbank an, die benutzt werden soll.

![[Anmerkung]](../images/note.png)

Anmerkung

Oracle mit ocilib setzt voraus, dass `tnsnames.ora` mit Host,
Port und Datenbankinformation gefüllt ist. Dann können Sie eins der
folgenden benutzen:



**Datenbank-Präfix**

Format:

**db\_prefix=\<name\>**

Beispiel:

**db\_prefix=icinga\_**

Legt den Präfix fest (falls überhaupt), der Tabellennamen vorangesetzt
werden soll. Wenn Sie den Tabellenpräfix ändert, dann müssen SIe auch
das SQL-Skript zur Erzeugung der Datenbank anpassen!

![[Anmerkung]](../images/note.png)

Anmerkung

Oracle wird diesen Präfix ignorieren, weil die Länge von Tabellennamen
auf 30 Stellen begrenzt ist.

**Datenbank-Benutzer/Passwort**

Format:

**db\_user=\<user name\>**

**db\_pass=\<password\>**

Beispiel:

**db\_user=icinga** **db\_pass=icinga**

Dies sind Benutzername/Passwort, die für die Authenfizierung an der DB
verwendet werden. Der Benutzer benötigt mindestens SELECT-, INSERT-,
UPDATE- und DELETE-Privilegien auf der Datenbank.

**Debug level**

Format:

**debug\_level=\<-1|0|1|2\>**

Beispiel:

**debug\_level=0**

Diese Option legt fest, wieviel (falls überhaupt) Debugging-Informatioen
in die Debug-Datei geschrieben werden. Addieren Sie die Werte, um
mehrere Arten von Informationen zu erhalten.

Mögliche Werte sind:





**Debug verbosity**

Format:

**debug\_verbosity=\<0|1|2\>**

Beispiel:

**debug\_verbosity=1**

Diese Option legt fest, wie ausführlich die Debug-Protokollausgaben sein
werden.

Mögliche Werte sind:




**Debug file name**

Format:

**debug\_file=\<file name\>**

Beispiel:

**debug\_file=/usr/local/icinga/var/idomod.debug\>**

Diese Option legt fest, an welche Stelle der Daemon die
Debugging-Informationen schreiben soll.

**Maximum debug file size**

Format:

**max\_debug\_file\_size=\<bytes\>**

Beispiel:

**max\_debug\_file\_size=100000000**

Diese Option legt die maximale Größe (in Bytes) der Debug-Protokolldatei
fest. Falls die Datei diese Größe überschreitet, wird sie in eine Datei
mit der Endung `.old` umbenannt. Eine bereits bestehende
Datei mit dieser Endung wird automatisch gelöscht. Dies soll dazu
beitragen, dass die Dateisystemauslastung während des Debugging nicht
außer Kontrolle gerät.

**Lesbarer Debug-Zeitstempel**

Format:

**debug\_readable\_timestamp=\<0|1\>**

Beispiel:

**debug\_readable\_timestamp=0**

Diese Option erlaubt Ihnen, einen (menschlich) lesbaren statt des
Standard-Unix-Zeitstempels auszugeben.

Mögliche Werte sind:



**OCI-Fehler nach Syslog**

Format:

**oci\_errors\_to\_syslog=\<0|1\>**

Beispiel:

**oci\_errors\_to\_syslog=0**

IDO2DB registriert eine Fehlerbehandlungsroutine in ocilib, die per
Default alle Meldungen in die Debug-Protokolldatei und ins Syslog
schreibt. Beim Wert 0 wird die Ausgabe ins Syslog deaktiviert, so dass
die Meldungen nur in die Debug-Protokolldatei ausgegeben werden (falls
debug\_level entsprechend gesetzt ist).

**Oracle-Trace-Level**

Format:

**oracle\_trace\_level=\<0|1|4|8|12\>**

Beispiel:

**oracle\_trace\_level=0**

Diese Einstellung aktiviert einen Oracle-Session-Trace für jede
ido2db-Verbindung mit Hilfe von trace event. Der Wert muss einen der
momenten unterstützten Werte (1,4,8,12) oder 0 für ausgeschaltet. Dies
erfordert explizit das "alter session"-Privileg, Select-Rechte auf
v\$session und v\$process werden empfohlen.

Mögliche Werte sind:






* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
