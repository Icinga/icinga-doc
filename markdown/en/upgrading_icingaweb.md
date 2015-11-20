[Prev](icinga-web-scratch.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](icinga-web-config.md)

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
Icinga Web. Please keep in mind that `configure` requires the
that in a safe location.

![[Note]](../images/note.png)

Note

Starting with 1.9, the tackle cronk in Icinga Web is deprecated.

![[Note]](../images/note.png)

Note

Since 1.9 the file `.htaccess` has been removed and all
Rewrite rules are now located in the main Apache configuration.

Please update your Apache configuration `icinga-web.conf`
(etc/conf.d/icinga-web.conf in the source tarball) or run
`make install-apache-config`.

When updating an existing installation the old `.htaccess` files
in `/usr/local/icinga-web/pub/` and
`/usr/local/icinga-web/pub/soap/` (or where you installed Icinga
Web) should be removed.

![[Note]](../images/note.png)

Note

Starting with 1.8.2, a new session cache was added which may cause
irritations when upgrading icinga web / installing a new cronk or
module. If you experience a behaviour like "I cannot see my newly
installed cronk?" or "after upgrade, I cannot access the reporting
cronk" the resolution is rather simple





![[Note]](../images/note.png)

Note

Please note that there were some major changes starting with Icinga 1.5
that may require some additional actions:





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

</code></pre> 
 #> git clone git://git.icinga.org/icinga-web.git
</code></pre>

Unpack your tarball:

</code></pre> 
 #> tar xzvf icinga-web-1.13.tar.gz
</code></pre>

Then change to the directory:

</code></pre> 
 #> cd icinga-web-1.13
</code></pre>

Icinga Web provides several configure options e.g.

</code></pre> 
</code></pre>

![[Note]](../images/note.png)

Note

Keep in mind that you configure the Icinga-Web database not the Icinga
IDOUtils database! User and group name of the web process depend on the
distribution used.

Please use:

</code></pre> 
 #> ./configure --help
</code></pre>

to see all configure options.

![[Note]](../images/note.png)

Note

Using no options the installer expects the Icinga API to be found at
/usr/local/icinga/share/icinga-api.

Per default the Icinga Web will be updated to
`/usr/local/icinga-web` using:

</code></pre> 
 #> ./configure
 #> make upgrade
</code></pre>

![[Note]](../images/note.png)

Note

After changing any configs you need to clear the config cache!

</code></pre> 
 #> rm -rf app/cache/config/*.php
</code></pre>

or /path/to/clearcache.sh

</code></pre> 
 #> /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

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
`/path/to/icinga-web/etc/schema/updates/`. The syntax is as
follows:

`<rdbm>_<old-version>_to_<new-version>.sql`

where \<rdbm\> could be mysql, pgsql or oracle and \<newversion\> points
to the version you want to upgrade to.

![[Note]](../images/note.png)

Note

If you are upgrading from an older version and there are other versions
in between be advised that you need to apply those upgrade files with
incremental steps!










That's all.

* * * * *

[Prev](icinga-web-scratch.md) | [Up](ch06.md) | [Next](icinga-web-config.md)

6.5. Installation of the Icinga Web Frontend  |<=== [Index](index.md) ===>|  6.7. Configuration Overview of Icinga Web

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
