![Icinga](../images/logofullsize.png "Icinga")

12.6. Datenbank-Anpassungen/Änderungen

[Zurück](db_model.md) 

Kapitel 12. IDOUtils

 [Weiter](ch13.md)

* * * * *

12.6. Datenbank-Anpassungen/Änderungen
--------------------------------------

**Ändern des Instance-Namens**

Möglicherweise möchten Sie den Instance-Namen ändern. Es gibt einige
Schritte, die im folgenden Abschnitt beschrieben sind. Danke an
[ralfk](https://dev.icinga.org/users/210), der uns diese Anleitung
geliefert hat.

-   Stoppen Sie Icinga und die ido2db-Daemonen (denn anderenfalls wird
    statt einer Änderung automatisch ein neuer Instanzname zur Datenbank
    hinzugefügt)

    ~~~~ {.programlisting}
     #> /etc/init.d/icinga stop
     #> /etc/init.d/ido2db stop
    ~~~~

-   Ändern Sie den Instanznamen in der Datei
    `/usr/local/icinga/etc/idomod.cfg`{.filename}

    ~~~~ {.programlisting}
     instance_name=newinstance
    ~~~~

-   Ändern Sie den Instanznamen in der Datenbanktabelle
    "icinga\_instances" bzw. "instances"

    **MySQL/PostgreSQL**

    ~~~~ {.programlisting}
     SQL> UPDATE icinga_instances SET instance_name='NEWNAME' WHERE instance_name='OLDNAME';
    ~~~~

    **Oracle**

    ~~~~ {.programlisting}
     SQL> UPDATE instances SET instance_name='NEWNAME' WHERE instance_name='OLDNAME';
    ~~~~

-   Ändern Sie den Instanznamen in der command pipe-Konfiguration in
    einer der folgenden Dateien (Updatesichere Datei an erster Stelle)

    -   `./etc/conf.d/access.xml`{.filename}

    -   `./app/modules/Api/config/access.xml`{.filename}

-   Löschen Sie den Web-Cache

    ~~~~ {.programlisting}
     #> /usr/local/icinga-web/bin/clearcache.sh
    ~~~~

-   Starten Sie Icinga und die ido2db-Daemonen

    ~~~~ {.programlisting}
     #> /etc/init.d/ido2db start
     #> /etc/init.d/icinga start
    ~~~~

* * * * *

  -------------------------------- -------------------------- -------------------------------------
  [Zurück](db_model.md)          [Nach oben](ch12.md)      [Weiter](ch13.md)
  12.5. IDOUtils Database Model    [Zum Anfang](index.md)    Kapitel 13. Icinga Beispieldateien
  -------------------------------- -------------------------- -------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
