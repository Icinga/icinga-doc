 ![Icinga](../images/logofullsize.png "Icinga") 

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
`module/idoutils/config/updates`, z.B.
`ido2db.cfg_added_1.7_to_1.8.cfg`.

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von den Änderungen und der Größe Ihrer Datenbank kann es eine
Weile dauern, die Anpassungen durchzuführen. Bitte haben Sie ein wenig
Geduld und brechen Sie das Script nicht ab, weil sonst ggf. Ihre Daten
unbrauchbar sind.

Die Update-Dateien finden Sie zusammen mit den
Datenbank-Installationsdateien in
`/path/to/icinga-src/module/idoutils/db/DeineDB/upgrade`

Die Syntax ist wie folgt

`<rdbm>-upgrade-<version>.sql`

wobei \<rdbm\> mysql, pgsql oder oracle sein kann und \<version\> zeigt
auf die Version, auf die Sie aktualisieren wollen.

![[Anmerkung]](../images/note.png)

Anmerkung

Wenn Sie eine ältere Version aktualisieren wollen und zwischen dieser
und der aktuellen noch andere Versionen liegen, dann sollten Sie
beachten, dass Sie auch die dazwischen liegenden Updates inkrementell
installieren müssen!

Sie müssen dann zuerst auf 1.0 Stable updaten und dann die Aktualierung
auf 1.0.1 durchführen.










### 2.11.1. Upgrading IDOUtils to 1.13

Seit 1.13 ist die Direktive `broker_module` in
`icinga.cfg` veraltet. Benutzen Sie stattdessen die module
Object Konfiguration in `modules/idoutils.cfg`.

Bitte lesen Sie auch den Abschnitt "CHANGES" in `changelog`.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
