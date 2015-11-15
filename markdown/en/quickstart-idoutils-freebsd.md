![Icinga](../images/logofullsize.png "Icinga")

2.7. Icinga and IDOUtils Quickstart on FreeBSD

[Prev](quickstart-idoutils.md) 

Chapter 2. Getting Started

 [Next](icinga_packages.md)

* * * * *

2.7. Icinga and IDOUtils Quickstart on FreeBSD
----------------------------------------------

**Introduction**

![[Note]](../images/note.png)

Note

Instead of installing Icinga from scratch you may want to use a package
which might be available for your OS. Please take a look at the [table
of packages](https://www.icinga.org/download/packages).

Please keep in mind that the upstream packages might be outdated so
using backport packages is a way to get a recent version. Please take a
look at wiki articles for detailed descriptions:

-   [Debian](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Debian)

-   [Ubuntu](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+Ubuntu)

-   [RHEL/CentOS](https://wiki.icinga.org/display/howtos/Setting+up+Icinga+with+IDOUtils+on+RHEL)

If you are planning to install from source then please use the official
release tarball.

![[Important]](../images/important.png)

Important

Please don't use git snapshots unless you have an issue which might be
solved in the current developer version.

This guide is intended to provide you with simple instructions on how to
install Icinga from source (code) and have it monitoring your local
machine within 30 minutes.

No advanced installation options are discussed here - just the basics
that will work for most of the users who want to get started.

This guide will give you examples for installation on [FreeBSD]()
8.1-RELEASE. Thanks to
["ScotchTape"](http://www.monitoring-portal.org/wbb/index.php?page=User&userID=8925)
for the adapted instructions.

Later distributions of FreeBSD may inherit from these examples.

![[Note]](../images/note.png)

Note

Meanwhile there's a FreeBSD port of Icinga (net-mgmt/icinga) so maybe
that's the one you want to install ;-).

**What You'll End Up With**

If you follow these instructions, here's what you'll end up with:

-   Icinga and the plugins will be installed underneath
    `/usr/local/icinga`{.filename}

-   Icinga will be configured to monitor a few aspects of your local
    system (CPU load, disk usage, etc.)

-   The Icinga classic web interface will be accessible at
    `http://localhost/icinga/`{.uri} or
    `http://yourdomain.com/icinga`{.uri}

-   a database being filled using the IDOUtils

**Prerequisites**

During portions of the installation you'll need to have **root** access
to your machine.

Make sure you've installed the following packages on your system before
continuing.

-   [Apache](http://www.apache.org)

-   GCC compiler

-   C/C++ development libraries

-   [GD](http://www.boutell.com/gd/) development libraries

-   libdbi-drivers, a database like MySQL, or PostgreSQL

    ![[Note]](../images/note.png)

    Note

    PostgreSQL: Due to changes on insert statements PostgreSQL 8.1 does
    no longer work (and is already
    [end-of-life](http://wiki.postgresql.org/wiki/PostgreSQL_Release_Support_Policy)
    since November 2010) so please use 8.2 or even better 8.4. String
    escaping in PostgreSQL 9.x is still in an experimental state (refer
    to [issue \#1974](https://dev.icinga.org/issues/1974)).

**Optional**

At one time or another you will likely use SNMP based checks so it might
be a good idea to install the required packages now. Otherwise the
plugins will not be compiled and are not available when you need them.

**New features for the IDOUtils:**

-   **SSL-encryption between idomod and ido2db**

    If you want to use **SSL-encryption**: it is already installed.

    ![[Note]](../images/note.png)

    Note

    SSL has to be activated on all idomod clients, otherwise you will
    lose data!!!

-   **Oracle database support**

    If you want to use Oracle as an RDBMS then we are sorry.
    Unfortunately it isn't that easy with FreeBSD.

    **Timezone support**

    All dates are stored as local timestamps in the database. Datatypes
    are TIMESTAMP for MySQL, LOCAL TIMESTAMP (0) for Oracle, and
    TIMESTAMP WITH TIME ZONE for PostgreSQL. IDO2DB will set session
    timezone to UTC and store all unix timestamps (which are UTC per
    definition) as UTC based values. Please make sure your system
    returns unix timestamps as real UTC based values (like "date -u
    '+%s'").

    ![[Note]](../images/note.png)

    Note

    Make sure your database session runs in the same timezone in which
    the existing dates have been stored (check your local timezone e.g.
    Oracle:"select sessiontimezone from dual;") if you are running the
    upgrade script. Additionally for your convenience in Oracle you
    should set your session timestamp format to the value you want, e.g
    "alter session set nls\_timestamp\_format='YYYY-MM-DD HH24:MI:SS';"
    or similar. Now you can view entries from different Icinga
    installations in different time zones which are stored in the same
    database and regardless from where you accessing it, all entries are
    returned in your local time zone.

**Install the packages**

You can install the packages from the ports or you take older packages
(have a look at the [FreeBSD quickstart
quide](quickstart-icinga-freebsd.md "2.5. Icinga Quickstart FreeBSD")).

**Install ports**

You can install these ports by running the following commands (as root)
but it is recommended to use portupgrade or portmaster instead:

Please update your ports before doing so.

~~~~ {.screen}
 #> cd /usr/ports/devel/libtool/ && make all install clean
 #> cd /usr/ports/graphics/jpeg && make all install clean
 #> cd /usr/ports/graphics/png && make all install clean
 #> cd /usr/ports/graphics/gd && make all install clean
~~~~

![[Note]](../images/note.png)

Note

Please make sure you have Apache installed - the process will not be
discussed here, however the lead is *\# cd /usr/ports/www/apache22 &&
make clean && make*.

~~~~ {.screen}
 #> cd /usr/ports/devel/gmake && make all install clean 
 #> cd /usr/ports/devel/libltdl && make all install clean <-- unless installed already
~~~~

-   **MySQL**

    ~~~~ {.screen}
     #> cd /usr/ports/databases/mysql51-server && make all install clean 
     #> cd /usr/ports/databases/libdbi-drivers && make all install clean
    ~~~~

    please choose the correct driver for the database used

-   **PostgreSQL**

    ~~~~ {.screen}
     #> cd /usr/ports/databases/postgresql84-server && make all install clean 
     #> cd /usr/ports/databases/libdbi-drivers && make all install clean
    ~~~~

    please choose the correct driver for the database used

**Create Account Information**

Become the root user.

~~~~ {.screen}
 $> su -l
~~~~

Create a new *icinga* user account without a password and without the
ability to log-in (set no password when asked):

~~~~ {.screen}
 #> adduser -D -w no -s nologin
~~~~

For sending commands from the classic web interface to Icinga, you'll
need to create a new group icinga-cmd and add the webuser (www) and the
Icingauser to this group:

~~~~ {.screen}
 #> pw groupadd -n icinga-cmd -M icinga,www 
~~~~

**Download Icinga and the plugins**

Change to your local source directory i.e. \~/src

~~~~ {.screen}
 #> mkdir ~/src
 #> cd ~/src
~~~~

Get the current source from the [Icinga
Website](http://www.icinga.org/).

Don't forget to download the [Monitoring
Plugins](https://www.monitoring-plugins.org).

**Compile and install Icinga and IDOUtils**

Extract the Icinga source code tarball (or change directory to the GIT
snapshot)

~~~~ {.screen}
 #> cd ~/src/ 
 #> tar xvzf icinga-1.13.tar.gz 
 #> cd icinga-1.13
~~~~

![[Note]](../images/note.png)

Note

This absolute path is meant if we use the description
'/path/to/icinga-src/'.

Run the Icinga configure script. You will get help by using the --help
flag.

~~~~ {.screen}
 #> ./configure --with-command-group=icinga-cmd \
    --enable-idoutils CPPFLAGS=-I/usr/local/include \
    CFLAGS="-I/usr/local/include -L/usr/local/lib" \
    --with-dbi-lib=/usr/local/lib --with-dbi-inc=/usr/local/include
~~~~

![[Important]](../images/important.png)

Important

Appending *CPPFLAGS=-I/usr/local/include* is important for the IDOUtils
and the broker modul respectively.

![[Note]](../images/note.png)

Note

You should include `CFLAGS=..."`{.literal} like specified above.
Otherwise you might get the following lines in `icinga.log`{.filename}:

~~~~ {.screen}
 Error: Module ‘/usr/local/icinga/lib/idomod.so’ is using an old or unspecified version
 of the event broker API. Module will be unloaded.
 Event broker module ‘/usr/local/icinga/lib/idomod.so’ deinitialized successfully.
~~~~

More details on this error can be found
[here](http://www.mazej.net/icinga-idomod-o-is-using-an-old-or-unspecified-version-of-the-event-broker-api/).

**With SSL-encryption:**

~~~~ {.screen}
 #> ./configure --with-command-group=icinga-cmd \
    --enable-idoutils --enable-ssl CPPFLAGS=-I/usr/local/include \
    --with-dbi-lib=/usr/local/lib --with-dbi-inc=/usr/local/include
~~~~

Compile the Icinga source code. There is a separate option for IDOUtils
(*make idoutils*) if you just want to recompile this module. To see
possible option just call "make".

~~~~ {.screen}
 #> gmake all
~~~~

Install binaries, init script, sample config files, some eventhandlers,
and set permissions on the external command directory.

~~~~ {.screen}
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
 #> make install-commandmode 
~~~~

or shorter

~~~~ {.screen}
 #> make fullinstall
 #> make install-config
~~~~

![[Note]](../images/note.png)

Note

`make install-config`{.literal} is NOT included in
`make fullinstall `{.literal}anymore to avoid accidently overwriting of
your config files.

![[Note]](../images/note.png)

Note

`make install-eventhandlers`{.literal} will install some event handler
routines. To prevent undesired behaviour it is only included when you
use `make fullinstall`{.literal}.

![[Note]](../images/note.png)

Note

The Icinga-API served as a database abstraction layer written in PHP.
Starting with Icinga 1.5 it is replaced by an internal database
abstraction layer so Icinga-API doesn't have to be installed anymore.

Don't start Icinga yet - there's still more that needs to be done...

**Customise Configuration**

Sample configuration files have been installed using

~~~~ {.screen}
 #> gmake install-config
~~~~

into /usr/local/icinga/etc/. You'll need to make just one change before
you proceed...

Edit the */usr/local/icinga/etc/objects/contacts.cfg* config file with
your favourite editor and change the email address associated with the
*icingaadmin* contact definition to the address you'd like to use for
receiving alerts.

~~~~ {.screen}
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
~~~~

~~~~ {.screen}
 #> cd /usr/local/icinga/etc
 #> mv idomod.cfg-sample idomod.cfg
 #> mv ido2db.cfg-sample ido2db.cfg
~~~~

If you compiled the IDOUtils with SSL then you have to activate SSL in
`idomod.cfg`{.filename} setting

~~~~ {.programlisting}
 use_ssl=1
 output_type=tcpsocket
 output=127.0.0.1
~~~~

(adjust the IP address if your database is not running on localhost!)
and in `ido2db.cfg`{.filename} setting

~~~~ {.programlisting}
 use_ssl=1
 socket_type=tcp 
~~~~

![[Note]](../images/note.png)

Note

Don't forget to recompile all other idomod clients and to activate SSL
**otherwise you will lose data!!!**

**Activate the idomod event broker module**

![[Important]](../images/important.png)

Important

Under normal circumstances the following module definition is already
present in the `modules`{.filename} subdirectory so there is no need to
edit the main config file

~~~~ {.programlisting}
 define module{
        module_name    ido_mod
        path           /usr/local/icinga/lib/idomod.so
        module_type    neb
        args           config_file=/usr/local/icinga/etc/idomod.cfg
        }
~~~~

**Compile database and IDOUtils**

-   **MySQL:**

    *Create database, user, and permissions*

    ![[Note]](../images/note.png)

    Note

    If you just installed the RDBMS like decribed above then you have to
    start the database server before you can create a database. Having
    MySQL please use `/usr/local/etc/rc.d/mysql-server start`{.code} to
    start.

    ~~~~ {.screen}
     # mysql -u root -p

     mysql> CREATE DATABASE icinga;

           GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icinga';

            quit
    ~~~~

    ~~~~ {.screen}
     #> cd /path/to/icinga-src/module/idoutils/db/mysql
     #> mysql -u root -p icinga < mysql.sql
    ~~~~

    ~~~~ {.screen}
     #> vi /usr/local/icinga/etc/ido2db.cfg
    ~~~~

    ~~~~ {.programlisting}
     db_servertype=mysql
     db_port=3306
     db_user=icinga
     db_pass=icinga
    ~~~~

-   **PostgreSQL:**

    *To Do*

**Install and configure the Classic Web Interface**

Icinga ships with the Classic Web Interface ("the CGIs") which can be
installed via

~~~~ {.screen}
 #> cd /path/to/icinga-src
 #> make cgis
 #> make install-cgis
 #> make install-html
~~~~

If you are interested in the new Icinga Web, please refer to [Install
Icinga Web
Interface](icinga-web-scratch.md "6.5. Installation of the Icinga Web Frontend").

Install the Icinga Classic web config file in the Apache conf.d
directory.

![[Note]](../images/note.png)

Note

There is currently a bug in Icinga Makefile which directly prevents this
*make* command, please edit Makefile file in Icinga source directory and
change the line

~~~~ {.programlisting}
 $(INSTALL) -D -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
~~~~

to

~~~~ {.programlisting}
 $(INSTALL) -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
~~~~

~~~~ {.screen}
 #> make install-webconf
~~~~

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the command 'make install-webconf-auth'
additionally installs the file `htpasswd.users`{.filename} which
contains credentials for the user *icingaadmin* so you can skip the
following step. The password is *icingaadmin*.

Create an *icingaadmin* account for logging into the Icinga classic web
interface. If you want to change it later, use the same command.
Remember the password you assign to this account - you'll need it later.

~~~~ {.screen}
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
~~~~

If you want to change it later or want to add another user, use the
following command:

~~~~ {.screen}
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
~~~~

Reload/Restart Apache to make the new settings take effect.

~~~~ {.screen}
 #> /usr/local/etc/rc.d/apache22 reload
~~~~

**Compile and Install the Perl Plugins and Monitoring Plugins**

Extract the plugins source code tarball.

~~~~ {.screen}
 #> cd ~/src 
 #> tar xvzf nagios-plugins-2.1.tar.gz
 #> cd nagios-plugins-2.1 
~~~~

Compile and install the plugins by changing install directory to
/usr/local/icinga

~~~~ {.screen}
 #> ./configure --prefix=/usr/local/icinga --with-cgiurl=/icinga/cgi-bin \
    --with-nagios-user=icinga --with-nagios-group=icinga
 #> make 
 #> make install 
~~~~

![[Note]](../images/note.png)

Note

There is a port for the plugins but it will install them in a different
directory. You can set certain variables to tweak its make but you still
have to copy some things manually later on.

Compile and install the Perl plugin:

~~~~ {.screen}
 #> cd /usr/ports/net-mgmt/p5-Nagios-Plugin
 #> make all install clean
~~~~

**Starting IDOUtils and Icinga**

IDOUtils has to be started before Icinga

**Starting IDOUtils**

~~~~ {.screen}
 #> /usr/local/etc/rc.d/ido2db start
~~~~

**Stopping IDOUtils**

~~~~ {.screen}
 #> /usr/local/etc/rc.d/ido2db stop
~~~~

**Start Icinga**

Add Icinga to the list of system services and have it automatically
start when the system boots (make sure you have installed the init
script before).

~~~~ {.screen}
 #> echo icinga_enable=\"YES\" >> /etc/rc.conf
~~~~

Verify the sample Icinga configuration files.

~~~~ {.screen}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
~~~~

If there are no errors, start Icinga.

~~~~ {.screen}
 #> /usr/local/etc/rc.d/icinga start
~~~~

**Login to the Classic Web Interface**

You should now be able to access the Icinga classic web interface at the
URL below. You'll be prompted for the username ( *icingaadmin*) and
password you specified earlier.

~~~~ {.screen}
 http://localhost/icinga/
~~~~

or

~~~~ {.screen}
 http://yourdomain.com/icinga/
~~~~

Click on the "Service Detail" navbar link to see details of what's being
monitored on your local machine. It will take a few minutes for Icinga
to check all the services associated with your machine.

**Other Modifications**

Make sure your system's firewall rules are configured to allow access to
the web server if you want to access the Icinga classic interface
remotely.

~~~~ {.screen}
 #> TCP port 80
~~~~

Setting up your mail transfer agent (MTA) like exim, sendmail or postfix
to allow Icinga sending notification emails won't be explained here.

**You're Done**

Congratulations! You successfully installed Icinga. Your journey into
monitoring has just begun.

You'll no doubt want to monitor more than just your local machine, so
check out the chapter on ["Getting
Started"](ch02.md "Chapter 2. Getting Started") about "Monitoring ..."

Packages for Icinga

Compiler options for Icinga with IDOUtils

~~~~ {.programlisting}
./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
 --with-gd-lib=/usr/local/lib/ --with-gd-inc=/usr/local/include/ \
 --with-command-group=icinga-cmd --enable-idoutils \
 --with-dbi-inc=/usr/local/include --with-dbu-lib=/usr/local/lib \
 CPPFLAGS=-I/usr/local/include CFLAGS=-fPIC
~~~~

Compiler options for Monitoring Plugins plugins (ports)

~~~~ {.programlisting}
make install NAGIOSUSER=icinga NAGIOSGROUP=icinga \
 PREFIX=/usr/local/icinga
~~~~

* * * * *

  --------------------------------------- -------------------- -----------------------------------------------
  [Prev](quickstart-idoutils.md)        [Up](ch02.md)       [Next](icinga_packages.md)
  2.6. Icinga with IDOUtils Quickstart    [Home](index.md)    2.8. Icinga Packages for Linux Distributions
  --------------------------------------- -------------------- -----------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
