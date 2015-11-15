![Icinga](../images/logofullsize.png "Icinga")

2.11. Upgrading IDOUtils Database

[Prev](upgrading.md) 

Chapter 2. Getting Started

 [Next](monitoring-overview.md)

* * * * *

2.11. Upgrading IDOUtils Database
---------------------------------

2.11.1. [Upgrading IDOUtils to
1.13](upgrading_idoutils.md#upgrade1.13)

There may be a bug within the database scheme which has been fixed. If
you are upgrading from an older IDOUtils version you also need to apply
those fixes manually. If you are using rpm/deb packages please read the
notes and/or ask the maintainer if he has added those modifications to
the install routine.

![[Note]](../images/note.png)

Note

Starting with 1.8, you will find newly added config options in version
diffed config files in `module/idoutils/config/updates`{.filename} e.g.
`ido2db.cfg_added_1.7_to_1.8.cfg`{.filename}.

![[Note]](../images/note.png)

Note

Depending on the changes to be done and the size of your database it may
take a while to update your database. Please try to be patient and don't
abort the script as it may leave the data being corrupt.

The upgrade files can be found next to the database install files in
`/path/to/icinga-src/module/idoutils/db/yourrdbm/upgrade/`{.literal}.
The syntax is as follows:

`<rdbm>-upgrade-<version>.sql`{.literal}

where \<rdbm\> could be mysql, pgsql or oracle and \<version\> points to
the version you want to upgrade to.

![[Note]](../images/note.png)

Note

If you are upgrading from an older version and there are other versions
in between be advised that you need to apply those upgrade files with
incremental steps!

E.g. you have 1.11.7 installed and want to upgrade to 1.13.0 - you will
have to upgrade to 1.12.0 first and then apply the upgrade to 1.13.0.

1.  Backup your current database before upgrading!

2.  Check current IDOUtils version and the target version. Check if
    there are any version in between and upgrade incremental if
    necessary.

3.  Apply the upgrade(s) using a rdbm user with appropriate rights. You
    may use the upgradedb script, but this is not recommended (for MySQL
    only).

-   **MySQL**

    ~~~~ {.programlisting}
     $ mysql -u root -p <dbname> < /path/to/icinga-src/module/idoutils/db/mysql/upgrade/mysql-upgrade-<version>.sql
    ~~~~

-   **Postgresql**

    ~~~~ {.programlisting}
     # su - postgres
     $ psql -U icinga -d icinga < /path/to/icinga-src/module/idoutils/db/pgsql/upgrade/pgsql-upgrade-<version>.sql
    ~~~~

-   **Oracle**

    ~~~~ {.programlisting}
     # su - oracle
     $ cd /path/to/icinga-src/module/idoutils/db/oracle/upgrade
     $ sqlplus dbuser/dbpass
     SQL> @oracle-upgrade-<version>.sql
    ~~~~

### 2.11.1. Upgrading IDOUtils to 1.13

Starting with 1.13, the directive `broker_module`{.literal} in
`icinga.cfg`{.filename} is deprecated. Use a module object definition
inside `module/idoutils.cfg`{.filename} instead.

Please have a look at the section "CHANGES" in the
`changelog`{.filename} as well.

* * * * *

  ------------------------------ -------------------- -----------------------------------
  [Prev](upgrading.md)         [Up](ch02.md)       [Next](monitoring-overview.md)
  2.10. Upgrading (to) Icinga    [Home](index.md)    2.12. Monitoring Overview
  ------------------------------ -------------------- -----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
