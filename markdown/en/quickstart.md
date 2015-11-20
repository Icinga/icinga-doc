[Prev](newbie.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](quickstart-icinga.md)

* * * * *

2.3. Quickstart Installation Guides
-----------------------------------

**Introduction**

These quickstart guides will provide you with simple instructions on how
to install Icinga from source and have it monitoring your local machine
within 20 to 30 minutes. Advanced installation options and configuration
are discussed elsewhere.

Links to configuration tools and other addons can be found
[here](addons.md "10.1. Icinga Addons").

![[Note]](../images/note.png)

Note

Instead of installing Icinga from scratch you may want to use a package
which might be available for your OS. Please take a look at the [table
of packages](https://www.icinga.org/download/packages).

If you are planning to install from source then please use the official
release tarball.

![[Important]](../images/important.png)

Important

Please don't use git snapshots unless you have an issue which might be
solved in the current developer version.

Besides, a new quick install guide for using the IDOUtils of Icinga is
also available enabling you to use an RDBMS based on MySQL, Oracle, or
PostgreSQL, respectively.

**Guides**

Quickstart installation guides are currently available for various Linux
distributions (most common Fedora, Ubuntu, openSuSE). Because some
distributions are similar you may succeed to use these instructions for
RedHat, CentOS, Debian and SLES as well. Marcel Hecko provided a
quickstart quide for FreeBSD.

![[Note]](../images/note.png)

Note

Please note that sometimes names of packages change between different
versions of the same OS so if you don't find the packages mentioned it
might be a good idea to use your favourite search engine to find out the
correct name.

The [Quickstart guide for
Linux](quickstart-icinga.md "2.4. Icinga Quickstart") and [Quickstart
guide for
FreeBSD](quickstart-icinga-freebsd.md "2.5. Icinga Quickstart FreeBSD"),
resp., provide you with instructions on how to install Icinga, basic
plugins to check several things and the classical GUI accessible through
your web browser. The look and feel is quite similar to Nagios although
the GUI offers some enhancements (extended CSV export, submit commands
for a group of objects, etc.). There is no database involved and all
information is stored in flat files. Icinga Web is *not* available in
this setup.

Using the [Quickstart guide including
IDOUtils](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")
and [Quickstart guide including IDOUtils on
FreeBSD](quickstart-idoutils-freebsd.md "2.7. Icinga and IDOUtils Quickstart on FreeBSD"),
resp., you will get the things mentioned above plus a database (using
MySQL, Oracle, or PostgreSQL) to store current and historical
information. The database is *not* used to enable configuration via a
web interface. There are several
[addons](addons.md "10.1. Icinga Addons") specialised on this and
there are no plans for a builtin tool. The new web interface can be
installed when you use this setup. There are [separate
instructions](icinga-web-scratch.md "6.5. Installation of the Icinga Web Frontend")
on how to do this after you installed Icinga and IDOUtils.





If you are installing Icinga on an operating system or Linux
distribution that isn't listed above, read [Quickstart guide for
Linux](quickstart-icinga.md "2.4. Icinga Quickstart") for an overview
on what you'll need to do.

Command names, paths, etc. vary widely across different Operating
Systems/Distributions, so you'll likely need to tweak the installation
docs a bit to work for your particular case.

* * * * *

[Prev](newbie.md) | [Up](ch02.md) | [Next](quickstart-icinga.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
