NAME-IDOUTILS-Datenbank aktualisieren
=====================================

Es mag einen Bug im Datenbankschema geben, der behoben wurde. Wenn Sie
eine ältere NAME-IDOUTILS-Version aktualisieren, dann müssen Sie
außerdem diese Anpassungen manuell ausführen. Wenn Sie rpm/deb-Pakete
benutzen, lesen Sie bitte die Hinweise und/oder fragen Sie den
Maintainer, ob er diese Anpassungen in der Installationsroutine
hinzugefügt hat.

> **Note**
>
> Seit 1.8 finden Sie neue Konfigurationsoptionen, die in einer neuen
> Version hinzugefügt wurden, in `module/idoutils/config/updates`, z.B.
> `ido2db.cfg_added_1.7_to_1.8.cfg`.

> **Note**
>
> Abhängig von den Änderungen und der Größe Ihrer Datenbank kann es eine
> Weile dauern, die Anpassungen durchzuführen. Bitte haben Sie ein wenig
> Geduld und brechen Sie das Script nicht ab, weil sonst ggf. Ihre Daten
> unbrauchbar sind.

Die Update-Dateien finden Sie zusammen mit den
Datenbank-Installationsdateien in
`/path/to/icinga-src/module/idoutils/db/DeineDB/upgrade`

Die Syntax ist wie folgt

`<rdbm>-upgrade-<version>.sql`

wobei \<rdbm\> mysql, pgsql oder oracle sein kann und \<version\> zeigt
auf die Version, auf die Sie aktualisieren wollen.

> **Note**
>
> Wenn Sie eine ältere Version aktualisieren wollen und zwischen dieser
> und der aktuellen noch andere Versionen liegen, dann sollten Sie
> beachten, dass Sie auch die dazwischen liegenden Updates inkrementell
> installieren müssen!

Sie haben z.B. 1.0RC1 installiert und möchten auf 1.0.1 aktualisieren -
Sie müssen dann zuerst auf 1.0 Stable updaten und dann die Aktualierung
auf 1.0.1 durchführen.

1.  Sichern Sie Ihre aktuelle Datenbank vor der Aktualisierung!

2.  Prüfen Sie die laufende NAME-IDOUTILS-Version und die Zielversion.
    Prüfen Sie, ob zwischen diesen beiden Versionen noch andere
    Versionen liegen und aktualisieren Sie ggf. schrittweise.

3.  Führen Sie die Aktualisierung(en) mit einem Benutzer durch, der über
    die notwendigen Berechtigungen verfügt. Sie können das
    upgradedb-Script verwenden, aber das wird nicht empfohlen (betrifft
    nur MySQL).

-   **MySQL:**

         $ mysql -u root -p <dbname> < /path/to/icinga-src/module/idoutils/db/mysql/upgrade/mysql-upgrade-<version>.sql

-   **PostgreSQL:**

         # su - postgres
         $ psql -U icinga -d icinga < /path/to/icinga-src/module/idoutils/db/pgsql/upgrade/pgsql-upgrade-<version>.sql

-   **Oracle:**

         # su - oracle
         $ cd /path/to/icinga-src/module/idoutils/db/oracle/upgrade
         $ sqlplus dbuser/dbpass
         SQL> @oracle-upgrade-<version>.sql

Upgrading NAME-IDOUTILS
Upgrading NAME-IDOUTILS to 1.9
------------------------------

Seit 1.9 ist die Direktive `enable_sla` in `ido2db.cfg` veraltet.

NAME-IDOUTILS verwendet eine Socket Queue sowie SQL-Transakationen für
grosse Objekt Dumps um Core Reload Probleme zu minimieren.

Bitte lesen Sie auch den Abschnitt "CHANGES" in `changelog`.

Upgrading NAME-IDOUTILS to 1.8
------------------------------

Es gibt wichtige Korrekturen für redundante Indizes in MySQL, sowie
fehlende Indizies generell für bessere Performance (z.B. in Icinga Web).
Weiters kommt eine neue Zelle zur Tabelle programstatus hinzu, um die
neue "globale disable notification expire time" zu unterstützen.

Bitte lesen Sie auch den Abschnitt "CHANGES" in `changelog`.

Aktualisierung der NAME-IDOUTILS auf 1.7
----------------------------------------

*Beginnend mit Icinga 1.7 wurden Ort und Name der idomod shared-Library
von `$bindir/idomod.o` in `$libdir/idomod.so` geändert. Bitte beachten
Sie, dass auch die Endung ".o" in ".so" geändert wurde. Abhängig von der
verwendeten Methode müssen Sie entweder den Aufruf im
"broker\_module"-Eintrag in `icinga.cfg` ODER die Moduldefinition in
`module/idomod.cfg` anpassen.* Die alte Datei `idomod.o` wird entfernt,
falls sie gefunden wird. Sie erhalten auch eine Warnung beim Aufruf von
"make install-idoutils" über diese Änderung.

Bitte lesen Sie auch den Abschnitt "CHANGES for users" in `changelog`.

Aktualisierung der NAME-IDOUTILS auf 1.5
----------------------------------------

**Oracle**

> **Note**
>
> Zum Einsatz von NAME-IDOUTILS 1.5.0 mit NAME-ORACLE benötigen Sie
> OCILIB 3.9.2 - installieren Sie nicht 3.9.0 oder 3.9.1, denn diese
> Version sind fehlerbehaftet.

Passen Sie `oracle-upgrade-1.5.0.sql` an und definieren Sie Ihre
Tablespaces ähnlich den folgenden Zeilen. Sie können auch Ihre
bestehenden Tablespace-Namen für alle Definitionen benutzen.

     /* set real TBS names on which you have quota, no checks are implemented!*/
     define DATATBS='icinga';
     define LOBTBS='icinga';
     define IXTBS='icinga';

> **Note**
>
> Detailliertere Informationen zu NAME-IDOUTILS mit NAME-ORACLE finden
> Sie in unserer Wiki-HowTo-Serie zu
> [NAME-ORACLE](https://wiki.icinga.org/display/howtos/Icinga+and+Oracle).

Aktualisierung der NAME-IDOUTILS auf 1.4
----------------------------------------

**Oracle**

-   Die minimal erforderliche Version ist NAME-ORACLE 10g R2. Ältere
    Versionen können ggf. ebenfalls funktionieren, werden aber nicht
    unterstützt.

-   Die optionale Trennung von Daten-, Index- und LOB-Tablespaces wird
    eingeführt. Passen Sie `oracle-upgrade-1.4.0.sql
            ` an und definieren Sie Ihre Tablespaces. Sie können auch
    Ihre bestehenden Tablespace-Namen für alle Definitionen benutzen.

    Aktionen:

    -   entfernen der Beschränkungen von Zahlenwerten

    -   entfernen der meisten bestehenden NOT NULL-Constraints

    -   benennen von Constraints

    -   anlegen von Index und LOBs in neuen Tablespaces

    -   Sequenzen auf NOCACHE setzen

    -   NAME-ORACLE-Funktion anpassen, um NO\_DATA-Exceptions zu
        erzeugen

> **Caution**
>
> Aktualisierung der NAME-IDOUTILS auf NAME-ORACLE 1.4 erfordert ein
> bisschen "Magie". Stellen Sie sicher, dass
>
> 1.  Sie den kompletten `upgrade`-Ordner kopieren
>
> 2.  Sie das Script `oracle-upgrade-1.4.0.sql` anpassen und die Werte
>     für DATA, LOB und IXT setzen
>
> 3.  Sie anschließend das Upgrade-Script starten
>
Aktualisieren der NAME-IDOUTILS auf 1.3
---------------------------------------

Mit NAME-IDOUTILS 1.3 wird die Verwendung der Tabelle dbversion im
IDOUtils Schema wieder eingeführt. Das Aktualisierungsskript stellt
sicher, dass die Tabelle dbversion die aktuelle Version enthält. Ido2db
vergleicht die Programversion mit der Datenbankversion und gibt einen
Fehler im Syslog aus, wenn die Versionen voneinander abweichen.

Verwenden Sie das Aktualisierungsskript für die NAME-IDOUTILS 1.3 unter
`module/idoutils/db/<rdbms>/<rdbm>-upgrade-1.3.sql` gegen Ihr aktuelles
Datenbankschema, bitte beachten Sie die inkrementelle Vorgehensweise wie
oben beschrieben.

Nach der Aktualisierung sollten Sie die Datenbank-Version prüfen.

     SQL> SELECT * FROM icinga_dbversion

> **Note**
>
> Der Oracle-Tabellenname lautet "dbversion" (anstatt
> "icinga\_dbversion").

Aktualisieren der NAME-IDOUTILS auf 1.0.3
-----------------------------------------

Es gab ein paar kleinere Änderungen:

-   display\_name wurde geändert zu varchar(255) für mysql/oracle

-   Update des pgsql schema, ersetzen von varchar(n) durch text

-   Geänderter Wert für Konfigdateivariablen bis 1024 Länge für
    MySQL/Oracle.

Bitte verwenden Sie das Update-Skript für ihre Datenbank wie oben
beschrieben.

Aktualisieren der NAME-IDOUTILS auf 1.0.2
-----------------------------------------

Es gab einen signifikanten Bug in den NAME-IDOUTILS, der erst in
NAME-ICINGA 1.0.2 bereinigt werden konnte.

Bei jedem Core Restart wurde die gesamte Menge an Objekten in der
Objekttabelle erneut hinzugefuegt, anstelle die alten weiterhin zu
verwenden und wie Relationen auf den neuesten Stand zu bringen.

Beispielsweise bei 4000 Objekten (Hosts, Services, Contacts, etc) hat
ein zweimaliger Core Restartet 4000+4000+4000 = 12000 Objekte bedeutet.

In Bezug auf die Konfiguration und die Statusdaten ist dies nicht
relevant, da deren Relationen zur Objekttabelle bei jeden Neustart
bereinigt werden.

Historische Daten allerdings behalten diese unterschiedliche Beziehung
zur Objekttabelle bei - vor und nach dem Restart sind die Relationen
unterschiedlich.

Diese Dateninkonsistenz ist natürlich nicht wünschenswert und es wurde
dementsprechend versucht, eine einfache Lösungsmöglichkeit zu finden.

Neben den normale SQL Scripts für 1.0.2 (z.B. mysql-upgrade-1.0.2.sql)
stehen erweiterte SQL Scripts zur Verfügung.

Das Script arbeitet jeweils auf einer historischen Tabelle und holt sich
mit Hilfe einer gestaffelten Query die notwendigen Daten aus den beiden
Tabellen - historisch 1..1 Objekte. Desweiteren werden kaputte Eintraege
zur Zeit des Restarts bereinigt.

Bitte verwenden Sie diese Scripts wie Sie möchten - wahlweise direkt
ausgeführt oder Schritt für Schritt, wie der Ablauf innerhalb des
Scripts ist. Beachten Sie allerdings bitte, dass diese Scripts ohne
Garantie auf ihr eigenes Risiko verwendet werden können.

Falls Sie lediglich Livedaten verwenden, ist unter Umständen eine
Neuinstallation des Datenbankschemas die einfachere Option.

\* \<rdbms\>-upgrade-1.0.2-fix-object-relations.sql

Das "normale" Upgrade Script ist in 1.0.2 nur für MySQL verfügbar. Es
wurden binäre Casts entfernt, da case sensistives Vergleichen auch mit
einer Anpassung der Collation erreicht werden kann und so massive
Performanceeinbrüche verhindert werden können.

\* mysql-upgrade-1.0.2.sql

Aktualisieren der NAME-IDOUTILS auf 1.0.1
-----------------------------------------

Bitte vergewissern Sie sich, dass Sie bereits auf Icinga NAME-IDOUTILS
1.0 aktualisiert haben, bevor Sie diesen Abschnitt weierlesen! Es gab
einige (große) Veränderungen für alle unterstützten RDBMS, deshalb lesen
Sie diesen Abschnitt bitte sehr sorgfältig. Alle Datenbank- Skripte sind
nun in entsprechenden Unterverzeichnissen zu finden. Für alle RDBMS
wurden mehr Indizes gesetzt, außerdem wurde die Größe der command\_line
Spalte in mehreren Tabellen, die 255 Zeichen überschritten, angepasst.

RDBMS spezifische Änderungen und HowTo's:

-   **MySQL:**

    Änderung der Datenbank-Engine von MYISAM zu InnoDB. Der Grund ist
    die Umgehung von Zeilen- Sperren/Transaktionen/Rollbacks im
    Gegensatz zu einer kleinen Geschwindigkeitseinbuße während der
    Inserts.

    Das Upgrade-Skript führt eine ALTER TABLE-Anweisung aus. Falls Ihnen
    diese Idee nicht gefällt, können Sie auch folgendes tun:

    -   Dump erstellen der existierenden Datenbank:

            # mysqldump -u root -p icinga > icinga.sql

    -   Ändern Sie alle Einträge von "MYISAM" zu "InnoDB"

    -   Import des angepassten Datensatzes in eine neue Datenbank (wenn
        Sie die alte Datenbank verwenden möchten, löschen Sie als erstes
        den originalen Datensatz und rekreieren Sie die Datenbank).

-   **PostgreSQL:**

    Der Tabelle systemcommands fehlte die Spalte der Namens Ausgabe.
    Diese wird während des Upgrades hinzugefügt.

-   **Oracle:**

    Um die Performance in mehreren Bereichen zu verbessern, muß der Wert
    für open\_cursors höher gesetzt werden (Standardwert ist 50). Das
    Aktualisierungsskript enthält zwei neue, in DML geschriebene,
    Prozeduren für die DELETE- Anweisungen.

    Darüber hinaus gab es umfangreiche Änderungen bezüglich der
    Autoincrement- Sequenz und der AFTER INSERT- Trigger (Emulation des
    MySQL Autoincrement auf Primärschlüssel). Die alte Routine wurde
    komplett verworfen, d.h. alle Trigger und die Autoincrement- Sequenz
    werden während des Updates entfernt. Als Ersatz werden für jede
    Tabelle neue Sequenzen hinzugefügt und in den IDOUtils für Oracle
    verwendet.

    Bei bestehenden Datensätzen wird dies beim Importieren zu Problemen
    führen. Die Sequenzen starten mit dem Wert 1 wo hingegen der primäre
    Key (id) einen Maximalwert gesetzt hat. Aus diesem Grund wird eine
    Basisfunktion bereitgestellt, die das folgende tut: Diese extrahiert
    den maximalen Wert der id plus eins aus der angegebenen Tabelle und
    verändert den jeweiligen Sequence Start auf diesen berechneten Wert.

    Bitte verwenden Sie diese Prozedur so, wie Sie es benötigen - auf
    alle Tabellen und Sequenzen oder auf separierte Teile. Die Prozedur
    ist auskommentiert, und wird ohne Garantie auf Datenkonsistenz zur
    Verfügung gestellt. Ziehen Sie Ihren DBA zu Rate, wenn Sie
    bestehende Datensätze importieren wollen.

Aktualisieren der NAME-IDOUTILS auf 1.0
---------------------------------------

Es gab einen Unique-Key-Fehler durch den Fork, der bei einigen Tabellen
zu doppelten und nutzlosen Zeilen führt. Dies betrifft die folgenden
Tabellen:

-   timedevents, timedeventqueue

-   servicechecks

-   systemcommands

Wenn Sie sich z.B. Definition der Tabelle servicechecks ansehen:

     mysql> show create table icinga_servicechecks;

sollten Sie etwa folgendes sehen

     PRIMARY KEY (`servicecheck_id`),
     KEY `instance_id` (`instance_id`),
     KEY `service_object_id` (`service_object_id`),
     KEY `start_time` (`start_time`)

Um die o.g. Definition zu etwas wie diesem

     PRIMARY KEY (`servicecheck_id`),
     UNIQUE KEY `instance_id` (`instance_id`,`service_object_id`,`start_time`,`start_time_usec`)

zu ändern, befolgen Sie bitte den folgenden Ablauf!

**Wenn Sie von NAME-IDOUTILS 1.0RC aktualisieren, dann benutzen Sie
bitte module/idoutils/db/mysql/mysql-upgrade-1.0.sql - wenn Sie von
einer älteren Version aktualisieren, dann führen Sie vorher die
notwendigen Schritte durch, um auf 1.0RC zu aktualisieren!**

Bitte sichern Sie Ihre Datenbank und stoppen Sie ido2db vor der
Ausführung des Patches!

1.  `/etc/init.d/ido2db stop`

2.  `mysql -u root -p icinga < /path/to/icinga-src/module/idoutils/db/mysql/mysql-upgrade-1.0.sql`

Der Patch erledigt das Folgende mit Hilfe von MySQL-Befehlen:

-   hinzufügen einer temporären Spalte 'active', um die aktualisierte
    Zeile zu kennzeichnen

-   ermitteln der benötigten Informationen zweier doppelter Zeilen
    basierend auf dem unique contraint, aktualisieren der zweiten Zeile
    und markieren durch first=inactive, second=active

-   löschen aller als 'inactive' gekennzeichneten Zeilen

-   entfernen der fehlerhaften Key-Definitionen

-   hinzufügen des Unique Key

-   entfernen der temporären Spalte 'active'

Diese Prozedur wird für jede Tabelle durchgeführt, so dass es eine Weile
dauern kann, abhängig von Ihren Tabellengrößen und/oder
DB-Spezifikationen.

Falls Sie vorher etwas an den Keys verändert haben, dann stellen Sie
sicher, dass Sie das gleiche DB-Schema wie in NAME-IDOUTILS 1.0RC
benutzen, andernfalls wird das Script fehlschlagen.
