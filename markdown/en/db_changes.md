![Icinga](../images/logofullsize.png "Icinga")

12.6. Database changes/alterations

[Prev](db_model.md) 

Chapter 12. IDOUtils

 [Next](ch13.md)

* * * * *

12.6. Database changes/alterations
----------------------------------

**Change the instance name**

You may have the need to change the instance name. There are some steps
to be done which are described in this section. Thanks to
[ralfk](https://dev.icinga.org/users/210) who provided us with these
instructions.

-   Stop Icinga and ido2db daemons (since otherwise a new instance would
    automatically be added to DB instead of renaming it)

    ~~~~ {.programlisting}
     #> /etc/init.d/icinga stop
     #> /etc/init.d/ido2db stop
    ~~~~

-   Change the instance name in
    `/usr/local/icinga/etc/idomod.cfg`{.filename}

    ~~~~ {.programlisting}
     instance_name=newinstance
    ~~~~

-   Change the instance name in the database table "icinga\_instances"
    or "instances"

    **MySQL/PostgreSQL**

    ~~~~ {.programlisting}
     SQL> UPDATE icinga_instances SET instance_name='NEWNAME' WHERE instance_name='OLDNAME';
    ~~~~

    **Oracle**

    ~~~~ {.programlisting}
     SQL> UPDATE instances SET instance_name='NEWNAME' WHERE instance_name='OLDNAME';
    ~~~~

-   Change the instance name in the command pipe configuration in one of
    these files (upgrade safe file in first place)

    -   `./etc/conf.d/access.xml`{.filename}

    -   `./app/modules/Api/config/access.xml`{.filename}

-   Clear the Web Cache

    ~~~~ {.programlisting}
     #> /usr/local/icinga-web/bin/clearcache.sh
    ~~~~

-   Start Icinga and ido2db Daemons

    ~~~~ {.programlisting}
     #> /etc/init.d/ido2db start
     #> /etc/init.d/icinga start
    ~~~~

* * * * *

  -------------------------------- -------------------- -----------------------------
  [Prev](db_model.md)            [Up](ch12.md)       [Next](ch13.md)
  12.5. IDOUtils Database Model    [Home](index.md)    Chapter 13. Icinga Samples
  -------------------------------- -------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
