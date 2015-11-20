[Prev](upgrading.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](monitoring-overview.md)

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
diffed config files in `module/idoutils/config/updates` e.g.
`ido2db.cfg_added_1.7_to_1.8.cfg`.

![[Note]](../images/note.png)

Note

Depending on the changes to be done and the size of your database it may
take a while to update your database. Please try to be patient and don't
abort the script as it may leave the data being corrupt.

The upgrade files can be found next to the database install files in
`/path/to/icinga-src/module/idoutils/db/yourrdbm/upgrade/`.
The syntax is as follows:

`<rdbm>-upgrade-<version>.sql`

where \<rdbm\> could be mysql, pgsql or oracle and \<version\> points to
the version you want to upgrade to.

![[Note]](../images/note.png)

Note

If you are upgrading from an older version and there are other versions
in between be advised that you need to apply those upgrade files with
incremental steps!

have to upgrade to 1.12.0 first and then apply the upgrade to 1.13.0.










### 2.11.1. Upgrading IDOUtils to 1.13

Starting with 1.13, the directive `broker_module` in
`icinga.cfg` is deprecated. Use a module object definition
inside `module/idoutils.cfg` instead.

Please have a look at the section "CHANGES" in the
`changelog` as well.

* * * * *

[Prev](upgrading.md) | [Up](ch02.md) | [Next](monitoring-overview.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
