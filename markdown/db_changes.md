Datenbank-Anpassungen/Änderungen
================================

**Ändern des Instance-Namens**

Möglicherweise möchten Sie den Instance-Namen ändern. Es gibt einige
Schritte, die im folgenden Abschnitt beschrieben sind. Danke an
[ralfk](https://dev.icinga.org/users/210), der uns diese Anleitung
geliefert hat.

-   Stoppen Sie NAME-ICINGA und die ido2db-Daemonen (denn anderenfalls
    wird statt einer Änderung automatisch ein neuer Instanzname zur
    Datenbank hinzugefügt)

         #> /etc/init.d/icinga stop
         #> /etc/init.d/ido2db stop

-   Ändern Sie den Instanznamen in der Datei
    `/usr/local/icinga/etc/idomod.cfg`

         instance_name=newinstance

-   Ändern Sie den Instanznamen in der Datenbanktabelle
    "icinga\_instances" bzw. "instances"

    **NAME-MYSQL/NAME-POSTGRES**

         SQL> UPDATE icinga_instances SET instance_name='NEWNAME' WHERE instance_name='OLDNAME';

    **NAME-ORACLE**

         SQL> UPDATE instances SET instance_name='NEWNAME' WHERE instance_name='OLDNAME';

-   Ändern Sie den Instanznamen in der command pipe-Konfiguration in
    einer der folgenden Dateien (Updatesichere Datei an erster Stelle)

    -   `./etc/conf.d/access.xml`

    -   `./app/modules/Api/config/access.xml`

-   Löschen Sie den Web-Cache

         #> /usr/local/icinga-web/bin/clearcache.sh

-   Starten Sie NAME-ICINGA und die ido2db-Daemonen

         #> /etc/init.d/ido2db start
         #> /etc/init.d/icinga start

NAME-IDOUTILS
Instanznamen ändern
