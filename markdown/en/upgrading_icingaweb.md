![Icinga](../images/logofullsize.png "Icinga")

6.6. Upgrading Icinga Web and Icinga Web Database

[Prev](icinga-web-scratch.md) 

Chapter 6. User Interfaces

 [Next](icinga-web-config.md)

* * * * *

6.6. Upgrading Icinga Web and Icinga Web Database
-------------------------------------------------

6.6.1. [Upgrading Icinga
Web](upgrading_icingaweb.md#upgradingicingaweb)

6.6.2. [The Upgrade](upgrading_icingaweb.md#upgrade)

6.6.3. [Upgrading the Icinga Web
Database](upgrading_icingaweb.md#upgradedatabase)

### 6.6.1. Upgrading Icinga Web

If there's a new Icinga Web version available on https://www.icinga.org/
you should consider updating. Newer versions contain bugfixes, minor or
major, which makes it even more important to get the latest and the
greatest. If you already installed Icinga Web; using the installing
guide it should be rather easy to install newer version.

Make sure you'll have a safe backup of your Icinga Web installation and
your configs (if you stored your customised configuration in
\*.site.xml- Files, they won't be overwritten during the upgrade
process!). If anything goes wrong you can restore your old setup rather
easy.

Regular updates of Icinga Web are possible by just by re-installing
Icinga Web. Please keep in mind that `configure`{.code} requires the
same parameters as before - look it up in `config.log`{.code} and save
that in a safe location.

![[Note]](../images/note.png)

Note

Starting with 1.9, the tackle cronk in Icinga Web is deprecated.

![[Note]](../images/note.png)

Note

Since 1.9 the file `.htaccess`{.filename} has been removed and all
Rewrite rules are now located in the main Apache configuration.

Please update your Apache configuration `icinga-web.conf`{.code}
(etc/conf.d/icinga-web.conf in the source tarball) or run
`make install-apache-config`{.code}.

When updating an existing installation the old `.htaccess`{.code} files
in `/usr/local/icinga-web/pub/`{.code} and
`/usr/local/icinga-web/pub/soap/`{.code} (or where you installed Icinga
Web) should be removed.

![[Note]](../images/note.png)

Note

Starting with 1.8.2, a new session cache was added which may cause
irritations when upgrading icinga web / installing a new cronk or
module. If you experience a behaviour like "I cannot see my newly
installed cronk?" or "after upgrade, I cannot access the reporting
cronk" the resolution is rather simple

-   clear the xml cache

-   reset the users application state (top right corner -\> preferences)

-   logout and re-login (top right corner)

    ![](../images/icinga-web-user-prefs-logout.png)

![[Note]](../images/note.png)

Note

Please note that there were some major changes starting with Icinga 1.5
that may require some additional actions:

-   The `*.site.xml`{.filename} files for local configuration changes
    were removed, configurations are now in `etc/conf.d/`{.filename} (or
    defined during installation with --with-conf-dir (--with-conf-folder
    up to Icinga 1.6.x)

-   The log folder is now under `log/`{.filename} (or defined during
    installation with the --with-log-folder)

-   The icinga-api was removed, doctrine is now used for all database
    transactions (`icinga-io.xml`{.filename} is now
    `databases.xml`{.filename})

-   Commands are now sent through the internal console-handler (because
    the icinga-api has been removed)

If you are using Icinga-Web \<= 1.4x then we suggest to do a fresh
installation instead of an upgrade. It's better to copy your old
configuration files into the new structure because there are many
changed and removed files we might not care about while upgrading.

![[Note]](../images/note.png)

Note

If you are using the PNP template extensions for Icinga Web, make sure
to upgrade them as well (and clear the cache afterwards!)

### 6.6.2. The Upgrade

Please download the archive from
[http://www.icinga.org/download/](http://www.icinga.org/download/). If
you have an issue fixed in the current developer version then please
take your clone from the icinga-web.git to get the freshest branch:

~~~~ {.screen}
 #> git clone git://git.icinga.org/icinga-web.git
~~~~

Unpack your tarball:

~~~~ {.screen}
 #> tar xzvf icinga-web-1.13.tar.gz
~~~~

Then change to the directory:

~~~~ {.screen}
 #> cd icinga-web-1.13
~~~~

Icinga Web provides several configure options e.g.

~~~~ {.screen}
 #> ./configure 
                --prefix=/usr/local/icinga-web 
                --with-web-user=www-data 
                --with-web-group=www-data 
                --with-web-path=/icinga-web 
                --with-web-apache-path=/etc/apache2/conf.d 
                --with-db-type=mysql 
                --with-db-host=localhost 
                --with-db-port=3306 
                --with-db-name=icinga_web 
                --with-db-user=icinga_web 
                --with-db-pass=icinga_web 
                --with-icinga-api=/usr/local/icinga/share/icinga-api 
                --with-api-type=APICON API type (default CONNECTION_IDO)
                --with-api-subtype=TYPE DB driver or network connection
                --with-api-host=HOST Host to connect (DB or other) (default localhost)
                --with-api-port=PORT Port for connection (default 3306)
                --with-api-socket=PATH Path to socket (default none)
~~~~

![[Note]](../images/note.png)

Note

Keep in mind that you configure the Icinga-Web database not the Icinga
IDOUtils database! User and group name of the web process depend on the
distribution used.

Please use:

~~~~ {.screen}
 #> ./configure --help
~~~~

to see all configure options.

![[Note]](../images/note.png)

Note

Using no options the installer expects the Icinga API to be found at
/usr/local/icinga/share/icinga-api.

Per default the Icinga Web will be updated to
`/usr/local/icinga-web`{.filename} using:

~~~~ {.screen}
 #> ./configure
 #> make upgrade
~~~~

![[Note]](../images/note.png)

Note

After changing any configs you need to clear the config cache!

~~~~ {.screen}
 #> rm -rf app/cache/config/*.php
~~~~

or /path/to/clearcache.sh

~~~~ {.screen}
 #> /usr/local/icinga-web/bin/clearcache.sh
~~~~

Any errors? Take a look
[here.](icinga-web-scratch.md#webtroubleshooting "6.5.6. Test & Errors?")

### 6.6.3. Upgrading the Icinga Web Database

This is mandatory if there were upgrades to the schema. If there are no
schema upgrade sqls to the current released version shipped, there's
nothing more to do. If you are upgrading from an older Icinga Web
database version you also need to apply those fixes manually. If you are
using rpm/deb packages please read the notes and/or ask the maintainer
if he has added those modifications to the install routine.

![[Note]](../images/note.png)

Note

Depending on the changes to be done and the size of your database it may
take a while to update your database. Please try to be patient and don't
abort the script as it may leave the data being corrupt.

The upgrade files can be found next to the database install files in
`/path/to/icinga-web/etc/schema/updates/`{.literal}. The syntax is as
follows:

`<rdbm>_<old-version>_to_<new-version>.sql`{.literal}

where \<rdbm\> could be mysql, pgsql or oracle and \<newversion\> points
to the version you want to upgrade to.

![[Note]](../images/note.png)

Note

If you are upgrading from an older version and there are other versions
in between be advised that you need to apply those upgrade files with
incremental steps!

1.  Backup your current database before upgrading!

2.  Check current Icinga Web database version and the target version.
    Check if there are any version in between and upgrade incremental if
    necessary.

3.  Apply the upgrade(s) using a rdbm user with appropriate rights.

-   **MySQL**

    ~~~~ {.screen}
     $ mysql -u root -p icinga_web < /path/to/icinga-web/etc/schema/updates/mysql_<oldversion>_to_<newversion>.sql
    ~~~~

    **Postgresql**

    ~~~~ {.screen}
     #> su - postgres
     $ psql -U icinga_web -d icinga_web < /path/to/icinga-web/etc/schema/updates/pgsql_<oldversion>_to_<newversion>.sql
    ~~~~

-   **Oracle**

    ~~~~ {.screen}
     #> su - oracle
     $ sqlplus dbuser/dbpass
     SQL> @oracle_<oldversion>_to_<newversion>.sql
    ~~~~

That's all.

* * * * *

  ----------------------------------------------- -------------------- --------------------------------------------
  [Prev](icinga-web-scratch.md)                 [Up](ch06.md)       [Next](icinga-web-config.md)
  6.5. Installation of the Icinga Web Frontend    [Home](index.md)    6.7. Configuration Overview of Icinga Web
  ----------------------------------------------- -------------------- --------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
