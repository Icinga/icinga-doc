![Icinga](../images/logofullsize.png "Icinga")

2.11. IDOUtils-Datenbank aktualisieren

[Zurück](upgrading.md) 

Kapitel 2. Los geht's

 [Weiter](monitoring-overview.md)

* * * * *

2.11. IDOUtils-Datenbank aktualisieren
--------------------------------------

2.11.1. [Upgrading IDOUtils to
1.13](upgrading_idoutils.md#upgrade1.13)

Es mag einen Bug im Datenbankschema geben, der behoben wurde. Wenn Sie
eine ältere IDOUtils-Version aktualisieren, dann müssen Sie außerdem
diese Anpassungen manuell ausführen. Wenn Sie rpm/deb-Pakete benutzen,
lesen Sie bitte die Hinweise und/oder fragen Sie den Maintainer, ob er
diese Anpassungen in der Installationsroutine hinzugefügt hat.

![[Anmerkung]](../images/note.png)

Anmerkung

Seit 1.8 finden Sie neue Konfigurationsoptionen, die in einer neuen
Version hinzugefügt wurden, in
`module/idoutils/config/updates`{.filename}, z.B.
`ido2db.cfg_added_1.7_to_1.8.cfg`{.filename}.

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von den Änderungen und der Größe Ihrer Datenbank kann es eine
Weile dauern, die Anpassungen durchzuführen. Bitte haben Sie ein wenig
Geduld und brechen Sie das Script nicht ab, weil sonst ggf. Ihre Daten
unbrauchbar sind.

Die Update-Dateien finden Sie zusammen mit den
Datenbank-Installationsdateien in
`/path/to/icinga-src/module/idoutils/db/DeineDB/upgrade`{.code}

Die Syntax ist wie folgt

`<rdbm>-upgrade-<version>.sql`{.code}

wobei \<rdbm\> mysql, pgsql oder oracle sein kann und \<version\> zeigt
auf die Version, auf die Sie aktualisieren wollen.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie eine ältere Version aktualisieren wollen und zwischen dieser
und der aktuellen noch andere Versionen liegen, dann sollten Sie
beachten, dass Sie auch die dazwischen liegenden Updates inkrementell
installieren müssen!

Sie haben z.B. 1.0RC1 installiert und möchten auf 1.0.1 aktualisieren -
Sie müssen dann zuerst auf 1.0 Stable updaten und dann die Aktualierung
auf 1.0.1 durchführen.

1.  Sichern Sie Ihre aktuelle Datenbank vor der Aktualisierung!

2.  Prüfen Sie die laufende IDOUtils-Version und die Zielversion. Prüfen
    Sie, ob zwischen diesen beiden Versionen noch andere Versionen
    liegen und aktualisieren Sie ggf. schrittweise.

3.  Führen Sie die Aktualisierung(en) mit einem Benutzer durch, der über
    die notwendigen Berechtigungen verfügt. Sie können das
    upgradedb-Script verwenden, aber das wird nicht empfohlen (betrifft
    nur MySQL).

-   **MySQL:**

    ~~~~ {.programlisting}
     $ mysql -u root -p <dbname> < /path/to/icinga-src/module/idoutils/db/mysql/upgrade/mysql-upgrade-<version>.sql
    ~~~~

-   **PostgreSQL:**

    ~~~~ {.programlisting}
     # su - postgres
     $ psql -U icinga -d icinga < /path/to/icinga-src/module/idoutils/db/pgsql/upgrade/pgsql-upgrade-<version>.sql
    ~~~~

-   **Oracle:**

    ~~~~ {.programlisting}
     # su - oracle
     $ cd /path/to/icinga-src/module/idoutils/db/oracle/upgrade
     $ sqlplus dbuser/dbpass
     SQL> @oracle-upgrade-<version>.sql
    ~~~~

### 2.11.1. Upgrading IDOUtils to 1.13

Seit 1.13 ist die Direktive `broker_module`{.literal} in
`icinga.cfg`{.filename} veraltet. Benutzen Sie stattdessen die module
Object Konfiguration in `modules/idoutils.cfg`{.filename}.

Bitte lesen Sie auch den Abschnitt "CHANGES" in `changelog`{.filename}.

* * * * *

  ----------------------------- -------------------------- -------------------------------------
  [Zurück](upgrading.md)      [Nach oben](ch02.md)      [Weiter](monitoring-overview.md)
  2.10. Icinga aktualisieren    [Zum Anfang](index.md)    2.12. Monitoring-Überblick
  ----------------------------- -------------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
