![Icinga](../images/logofullsize.png "Icinga")

2.6. Icinga with IDOUtils Quickstart

[Prev](quickstart-icinga-freebsd.md) 

Chapter 2. Getting Started

 [Next](quickstart-idoutils-freebsd.md)

* * * * *

2.6. Icinga with IDOUtils Quickstart
------------------------------------

2.6.1. [Introduction](quickstart-idoutils.md#introduction_idoutils)

2.6.2. [Prerequisites](quickstart-idoutils.md#prerequisites_idoutils)

2.6.3. [New features for the
IDOUtils:](quickstart-idoutils.md#newfeatures_idoutils)

2.6.4. [Install
Packages](quickstart-idoutils.md#installpackages_idoutils)

2.6.5. [Create Account
Information](quickstart-idoutils.md#createaccount_idoutils)

2.6.6. [Download Icinga and the
Plugins](quickstart-idoutils.md#downloadicingaandplugins_idoutils)

2.6.7. [Compile and Install Icinga with
IDOUtils](quickstart-idoutils.md#compileinstallidoutils)

2.6.8. [Compile and
Install](quickstart-idoutils.md#compileinstall_idoutils)

2.6.9. [Customise
Configuration](quickstart-idoutils.md#customiseconfig_idoutils)

2.6.10. [Enable the idomod event broker
module](quickstart-idoutils.md#enableidomod)

2.6.11. [Creation of Database and
IDOUtils](quickstart-idoutils.md#createidoutilsdatabase)

2.6.12. [Configure the Classic Web
Interface](quickstart-idoutils.md#configclassicui_idoutils)

2.6.13. [Compile and Install the Monitoring
Plugins](quickstart-idoutils.md#compileinstallplugins_idoutils)

2.6.14. [Adjusting the SELinux
settings](quickstart-idoutils.md#selinuxsettings_idoutils)

2.6.15. [Start IDOUtils and
Icinga](quickstart-idoutils.md#startiido2dbandicinga)

2.6.16. [Configure Icinga
Startup](quickstart-idoutils.md#configstartup_idoutils)

2.6.17. [Login to the Classic Web
Interface](quickstart-idoutils.md#loginclassicui_idoutils)

2.6.18. [Other
Modifications](quickstart-idoutils.md#othermods_idoutils)

2.6.19. [You're Done](quickstart-idoutils.md#done_idoutils)

### 2.6.1. Introduction

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

This guide will give you examples for currently three different Linux
distributions: [Fedora](http://fedoraproject.org/),
[Ubuntu](http://www.ubuntu.com/) and
[openSuSE](http://www.opensuse.org/). Similar distributions may work as
well. That should include [RedHat](http://www.redhat.com/),
[CentOS](http://www.centos.org/), [Debian](http://www.debian.org/) and
[SLES](http://www.novell.com/products/server/).

Other distributions may inherit from these examples.

![[Important]](../images/important.png)

Important

If you are planning to use Icinga without IDOUtils please read
[Section 2.4, “Icinga
Quickstart”](quickstart-icinga.md "2.4. Icinga Quickstart") instead!

**What You'll End Up With**

If you follow these instructions, here's what you'll end up with:

-   Icinga and the plugins will be installed underneath
    /usr/local/icinga

-   Icinga will be configured to monitor a few aspects of your local
    system (CPU load, disk usage, etc.)

-   The Icinga classic web interface will be accessible at
    http://localhost/icinga/ or http://yourdomain.com/icinga

-   A database which is filled by Icinga using IDOUtils

### 2.6.2. Prerequisites

During portions of the installation you'll need to have **root** access
to your machine.

Make sure you've installed the following packages on your system before
continuing. IDOUtils use the [libdbi](http://libdbi.sourceforge.net) and
the libdbi-drivers for several databases. The development libraries are
also required. The following examples will show how to install the
IDOUtils with the libdbi using MySQL or PostgreSQL.

-   Apache

-   GCC compiler

-   C/C++ development libraries

-   [GD](http://www.boutell.com/gd/) development libraries

-   libdbi/libdbi-drivers, database like MySQL or PostgreSQL

    ![[Note]](../images/note.png)

    Note

    PostgreSQL: Due to changes on insert statements PostgreSQL 8.1 does
    no longer work (and is already
    [end-of-life](http://wiki.postgresql.org/wiki/PostgreSQL_Release_Support_Policy)
    since November 2010) so please use 8.2 or even better 8.4. String
    escaping in PostgreSQL 9.x is still in an experimental state (refer
    to [issue \#1974](https://dev.icinga.org/issues/1974)).

**Optional**

At one time or another you may need to use SNMP-based checks so it is a
good idea to install the required packages now. Otherwise some plugins
are not compiled i.e. not available when you need them and it would
require a recompile of the plugins.

### 2.6.3. New features for the IDOUtils:

-   **SSL-Encryption between idomod and ido2db**

    If you want to use SSL-encryption you'll need openssl and
    openssl-devel/libssl-dev (Ubuntu) to be installed!

    ![[Note]](../images/note.png)

    Note

    SSL has to be enabled on all idomod client, otherwise you will lose
    data!!!

-   **Oracle Database Support**

    If you want Oracle as RDBMS you'll need to install ocilib instead of
    libdbi.

    ![[Note]](../images/note.png)

    Note

    Using IDOUtils 1.5.0 with Oracle requires at least OCILIB 3.9.2 -
    don't install 3.9.0 or 3.9.1 as they remain buggy.

    ![[Note]](../images/note.png)

    Note

    More detailed instructions using IDOUtils with Oracle you can find
    in our wiki howto series about
    [Oracle](https://wiki.icinga.org/display/howtos/Icinga+and+Oracle).

    -   Oracle libraries and SDK (e.g. Instant Client)

        If you install from package, make sure the libraries are within
        PATH. Otherwise you need to set the Oracle libs during Icinga
        IDOUtils install using e.g.
        --with-oracle-lib=/path/to/instantclient

    -   ocilib instead of libdbi

    Get it from http://orclib.sourceforge.net/ and point configure to
    your Oracle libraries and header files e.g. from the Oracle instant
    client:

    ~~~~ {.screen}
     #> ./configure --with-oracle-headers-path=/path/to/instantclient/sdk/include \
        --with-oracle-lib-path=/path/to/instantclient/
     #> make
     #> make install
    ~~~~

    -   *Icinga 1.4*

        As of Icinga 1.4 the minimum expected Oracle version is Oracle
        10gR2. Older versions may work, but are not supported. Oracle
        scripts are designed to split data, index and lobs into
        different tablespaces. For this reason there is a new
        prerequisite to define the tablespace names you want to use. If
        you are working in a small environment, you can set all defines
        to the same real tablespace. You will find a new script
        `icinga_defines.sql`{.filename} which you have to adapt for your
        needs before applying `oracle.sql`{.filename}. For your
        convenience there is a new script
        `create_oracle_sys.sql`{.filename} included, which should help
        you to create the necessary tablespaces and an Icinga
        application user and must run as SYS. It will make use of
        `icinga_defines.sql`{.filename} as well. Object creation has
        been moved from `oracle.sql`{.filename} to the script
        `create_icinga_objects_oracle.sql`{.filename}.

        The former `oracle.sql`{.filename} has been redesigned as a
        master script to record all other scripts as includes and
        expects these includes within the current directory. For this
        reason you should start `sqlplus`{.filename} executing
        `oracle.sql`{.filename} within this directory. This way the
        creation of user and tablespaces and the creation of Icinga
        tables runs in one step. As an all-in-one sample you will find a
        new script `db/scripts/create_oracledb.sh`{.filename}. Edit
        variables to suit your needs and enjoy. If you prefer to do SYS
        steps for yourself, please uncomment
        `create_oracle_sys.sql`{.filename} and make sure that your
        database Icinga user and tables exist and are defined with the
        same (or more) rights and that the correct settings have been
        applied to `icinga_defines.sql`{.filename}.

    -   **Timezone support**

        All dates are stored as local timestamps in the database.
        Datatypes are TIMESTAMP for MySQL, LOCAL TIMESTAMP (0) for
        Oracle, and TIMESTAMP WITH TIME ZONE for PostgreSQL. IDO2DB will
        set session timezone to UTC and store all unix timestamps (which
        are UTC per definition) as UTC based values. Please make sure
        your system returns unix timestamps as real UTC based values
        (like "date -u '+%s'").

        ![[Note]](../images/note.png)

        Note

        Make sure your database session runs in the same timezone in
        which the existing dates have been stored (check your local
        timezone e.g. Oracle:"select sessiontimezone from dual;") if you
        are running the upgrade script. Additionally for your
        convenience in Oracle you should set your session timestamp
        format to the value you want, e.g "alter session set
        nls\_timestamp\_format='YYYY-MM-DD HH24:MI:SS';" or similar. Now
        you can view entries from different Icinga installations in
        different time zones which are stored in the same database and
        regardless from where you accessing it, all entries are returned
        in your local time zone.

### 2.6.4. Install Packages

You can install your packages by running the following commands (as root
or sudo).

![[Note]](../images/note.png)

Note

Unfortunately sometimes the names of packages change between different
releases of the same distribution so if you get a message that one of
the packages cannot be found then please use the search option of your
package manager to get the new name:

-   `yum search <package name>`{.code} ( *Fedora/RHEL/CentOS* )

-   `apt-cache search <package name>`{.code} ( *Debian/Ubuntu* )

-   `zypper search <package name>`{.code} ( *openSuSE/SLES* )

-   **Fedora/RHEL/CentOS:**

    ~~~~ {.screen}
     #> yum install httpd gcc glibc glibc-common gd gd-devel
     #> yum install libjpeg libjpeg-devel libpng libpng-devel
    ~~~~

    ![[Note]](../images/note.png)

    Note

    You may have to use libjpeg-turbo and libjpeg-turbo-devel instead

    -   **MySQL:**

        ~~~~ {.screen}
         #> yum install mysql mysql-server \
            libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql
        ~~~~

    -   **PostgreSQL:**

        ~~~~ {.screen}
         #> yum install postgresql postgresql-server \
            libdbi libdbi-devel libdbi-drivers libdbi-dbd-pgsql
        ~~~~

-   **Debian/Ubuntu:**

    ~~~~ {.screen}
     #> apt-get install apache2 build-essential libgd2-xpm-dev
     #> apt-get install libjpeg62 libjpeg62-dev libpng12 libpng12-dev
    ~~~~

    ![[Note]](../images/note.png)

    Note

    The numbers \<62/12\> might differ, depending on your distribution

    ![[Note]](../images/note.png)

    Note

    Starting with Debian 6.0 / Ubuntu 10.10 the packages are called
    libpng12-0 and libdbi0, as well as Debian 6.0 uses libdbi0-dev while
    Debian 7.0 will use libdbi-dev.

    -   **MySQL:**

        ~~~~ {.screen}
         #> apt-get install mysql-server mysql-client libdbi1 libdbi-dev libdbd-mysql
        ~~~~

    -   **PostgreSQL:**

        ~~~~ {.screen}
         #> apt-get install postgresql libdbi1 libdbi-dev libdbd-pgsql libpq-dev
        ~~~~

-   **openSuSE:**

    Please use YaST to install at least the packages gd, gd-devel,
    libjpeg, libjpeg-devel, libpng, libpng-devel and, optionally,
    net-snmp, net-snmp-devel and perl-Net-SNMP.

    Using zypper should work as well:

    ~~~~ {.screen}
     #> zypper install gd gd-devel libjpeg libjpeg-devel libpng libpng-devel
     #> zypper install net-snmp net-snmp-devel perl-Net-SNMP
    ~~~~

    ![[Note]](../images/note.png)

    Note

    The devel packages might be placed on the SDK DVDs.

    -   **MySQL:**

        Use YaST to install the packages for the RDBMS you want to use,
        i.e. "mysql", "mysql-devel", "mysql-client" and the libdbi
        packages "libdbi", "libdbi-devel", "libdbi-drivers" and
        "libdbi-dbd-mysql", or alternatively `zypper`{.filename}.

        ~~~~ {.screen}
         #> zypper install mysql mysql-devel mysql-client \
            libdbi libdbi-devel libdbi-drivers libdbi-dbd-mysql
        ~~~~

        ![[Note]](../images/note.png)

        Note

        In OpenSuSE 11 (SLES 11) the name of the package was changed
        from "mysql-devel" to "libmysqlclient-devel".

    -   **PostgreSQL:**

        Use YaST to install the packages for the RDBMS you want to use,
        i.e. "postgresql", "postgresql-devel", "postgresql-server" and
        the libdbi packages "libdbi", "libdbi-devel" and
        "libdbi-drivers", or alternatively `zypper`{.filename}.

        ~~~~ {.screen}
         #> zypper install postgresql postgresql-devel postgresql-server
         #> zypper install libdbi libdbi-devel libdbi-drivers
        ~~~~

    Using old OpenSuSE (SLES) versions including version 10 it is most
    likely that there aren't any libdbi packages so you have to download
    and compile the sources. Replace \<rdbm\> with your desired RDBM
    like mysql or pgsql. Remember that the Oracle driver is not yet
    working and read the appropriate section with ocilib instead of
    libdbi.

    1.  Download and extract the tar.gz files

        [http://libdbi.sourceforge.net/download.md](http://libdbi.sourceforge.net/download.md)

        [http://libdbi-drivers.sourceforge.net/download.md](http://libdbi-drivers.sourceforge.net/download.md)

        ~~~~ {.screen}
         #> tar xvzf libdbi-0.8.3.tar.gz
         #> tar xvzf libdbi-drivers-0.8.3-1.tar.gz
        ~~~~

    2.  Install libdbi. Maybe you have to specify additional options
        with configure (set --prefix=/usr ... )

        ~~~~ {.screen}
         #> cd libdbi-0.8.3
         #> ./configure --disable-docs
         #> make
         #> make install
        ~~~~

    3.  Install libdbi-drivers

        ~~~~ {.screen}
         #> cd libdbi-drivers-0.8.3-1
         #> ./configure --with-<rdbm> --disable-docs
         #> make
         #> make install
        ~~~~

        ![[Note]](../images/note.png)

        Note

        Using the 64-bit-versions you have to specify the paths to the
        include- and lib-dir explicitly:

        ~~~~ {.screen}
         #> ./configure --with-<rdbm> \
            --with-<rdbm>-incdir=/usr/include/<rdbm>/ \
            --with-<rdbm>-libdir=/usr/lib64/ --disable-docs
        ~~~~

### 2.6.5. Create Account Information

Become the root user.

~~~~ {.screen}
 $> su -l
~~~~

Create a new *Icinga* user account and give it a password.

~~~~ {.screen}
 #> /usr/sbin/useradd -m icinga 
 #> passwd icinga 
~~~~

On some distributions you'll need to add the group in a single step:

~~~~ {.screen}
 #> /usr/sbin/groupadd icinga
~~~~

For sending commands from the classic web interface to Icinga, you'll
need to create a new group icinga-cmd. Add the webuser and the
Icingauser to this group:

~~~~ {.screen}
 #> /usr/sbin/groupadd icinga-cmd
 #> /usr/sbin/usermod -a -G icinga-cmd icinga
 #> /usr/sbin/usermod -a -G icinga-cmd www-data
~~~~

(or www, wwwrun, apache depending on the distribution)

![[Note]](../images/note.png)

Note

Some usermod-versions (e.g in OpenSuSE 11 and SLES 11, resp.) are
lacking the option -a. In this case please omit the option -a.

![[Important]](../images/important.png)

Important

Solaris only supports groupnames with max. 8 characters, please use
icingcmd instead of icinga-cmd.

### 2.6.6. Download Icinga and the Plugins

Change to your local source directory i.e. /usr/src

~~~~ {.screen}
 #> cd /usr/src
~~~~

Get the current source from the [Icinga
Website](http://www.icinga.org/). Don't forget to download the
[Monitoring Plugins](https://www.monitoring-plugins.org).

### 2.6.7. Compile and Install Icinga with IDOUtils

Extract the Icinga source code tarball

~~~~ {.screen}
 #> cd /usr/src/ 
 #> tar xvzf icinga-1.13.tar.gz 
 #> cd icinga-1.13
~~~~

![[Note]](../images/note.png)

Note

This absolute path is meant when we refer to '/path/to/icinga-src/' in
the following text.

Run the Icinga configure script and enable IDOUtils. You will get help
by using the --help flag:

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the default has changed so the IDOUtils will be
compiled automatically unless disabled explicitly.

~~~~ {.screen}
 #> ./configure --with-command-group=icinga-cmd
~~~~

![[Note]](../images/note.png)

Note

Starting with Apache 2.4 the web configuration folder changed from
`/etc/apache2/conf.d`{.filename} to
`/etc/apache2/conf-available`{.filename} so depending on your
distribution (testing versions of Debian / Ubuntu ) you might have to
add this option to the call of configure

~~~~ {.screen}
#> ./configure --with-httpd-conf=/etc/apache2/conf-available
~~~~

Also with PostgreSQL you should not use the argument --enable-pgsq
because it is not supported yet.

![[Important]](../images/important.png)

Important

Compiling on Solaris might fail upon unresolved library dependencies on
gethostbyname. In that case run this before running configure:

~~~~ {.screen}
 #> export LIBS=-lsocket -lnsl
~~~~

-   **With SSL-Encryption:**

    ~~~~ {.screen}
     #> ./configure --with-command-group=icinga-cmd --enable-idoutils --enable-ssl
    ~~~~

-   **With Oracle Database Support:**

    ~~~~ {.screen}
     #> ./configure --with-command-group=icinga-cmd --enable-idoutils --enable-oracle 
    ~~~~

    If you didn't install Oracle libraries to PATH, you can point
    configure there:

    ~~~~ {.screen}
     #> ./configure --with-command-group=icinga-cmd \
        --enable-idoutils --enable-oracle \
        --with-oracle-lib=/path/to/instantclient
    ~~~~

    If you didn't install ocilib to the default path (/usr/local) you
    can point configure to the lib/inc directories:

    ~~~~ {.screen}
     #> ./configure --with-command-group=icinga-cmd \
        --enable-idoutils --enable-oracle \
        --with-ocilib-lib=/path/to/ocilib/lib \
        --with-ocilib-inc=/path/to/ocilib/include
    ~~~~

    ![[Note]](../images/note.png)

    Note

    If you want to change RDBM from Oracle to others, you need to
    recompile and reinstall IDOUtils!

    ~~~~ {.screen}
     #> make distclean
     #> ./configure --enable-idoutils
    ~~~~

### 2.6.8. Compile and Install

Compile the Icinga source code. There is also an extra option for
IDOUtils (*make idoutils*) if you need to recompile only this module. To
see available options, only use "make".

~~~~ {.screen}
 #> make all
~~~~

Install binaries, init script, sample config files, some eventhandlers,
and set permissions on the external command directory.

~~~~ {.screen}
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
 #> make install-commandmode
 #> make install-idoutils 
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

Install IDOUtils and applicable event broker modules only using the
primary "make install" target. Do not manually copy and overwrite the
existing module as this will result in a segfault on icinga core which
is using `idomod.so`{.filename} directly preventing usage of a temporary
copy explicitly. This is useful for [OMD.](http://omdistro.org/)

Don't start Icinga yet - there's still more that needs to be done...

### 2.6.9. Customise Configuration

Sample configuration files have been installed by using "make
install-config" into `/usr/local/icinga/etc/`{.filename}. You'll need to
make just one change before you proceed...

Edit the */usr/local/icinga/etc/objects/contacts.cfg* config file with
your favourite editor and change the email address associated with the
*icingaadmin* contact definition to the address you'd like to use for
receiving alerts.

~~~~ {.screen}
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
~~~~

~~~~ {.screen}
 #> cd /usr/local/icinga/etc/
 #> mv idomod.cfg-sample idomod.cfg
 #> mv ido2db.cfg-sample ido2db.cfg
~~~~

If you want to enable SSL-encryption and you configured the IDOUtils
with ./configure --enable-ssl, you have to change idomod.cfg as follows:

~~~~ {.programlisting}
 use_ssl=1
 output_type=tcpsocket
 output=127.0.0.1
~~~~

(don't forget to adjust the ip-address if your database isn't located on
localhost) and ido2db.cfg in the following way:

~~~~ {.programlisting}
 use_ssl=1
 socket_type=tcp 
~~~~

![[Note]](../images/note.png)

Note

If SSL is enabled in ido2db but not in the different idomod clients -
data from those instances will be lost - that's guaranteed! SSL
configuration has to be the same on all nodes!!!

### 2.6.10. Enable the idomod event broker module

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

### 2.6.11. Creation of Database and IDOUtils

![[Note]](../images/note.png)

Note

If you just installed a new database system then you have to start the
database server before you can create a database. In case of MySQL you
might use `/etc/init.d/mysqld start`{.code} (or
`/etc/init.d/mysql`{.code}, depending on your distribution).

-   **MySQL:**

    Create Database, User, Grants:

    ~~~~ {.screen}
     # mysql -u root -p

     mysql> CREATE DATABASE icinga;

           GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icinga';

            quit
    ~~~~

    ![[Note]](../images/note.png)

    Note

    Starting with Icinga 1.8 the icinga user additionally needs EXECUTE
    privileges.

    Import database scheme for MySQL:

    ~~~~ {.screen}
     #> cd /path/to/icinga-src/module/idoutils/db/mysql
     #> mysql -u root -p icinga < mysql.sql
    ~~~~

    Edit the DB config file to customize IDOUtils

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

    Create database and User:

    ~~~~ {.screen}
     #> su - postgres
     
     $ psql
     postgres=# CREATE USER icinga;
     postgres=# ALTER USER icinga WITH PASSWORD 'icinga';
     postgres=# CREATE DATABASE icinga;
     postgres=# \q
     $ createlang plpgsql icinga;
    ~~~~

    Starting with PostgreSQL 9.1 "createlang ..." is obsolete.

    -   **Debian:**

        ~~~~ {.screen}
         #> vi /etc/postgresql/8.x/main/pg_hba.conf
        ~~~~

    -   **Fedora/RHEL/CentOS:**

        ~~~~ {.screen}
         #> vi /var/lib/pgsql/data/pg_hba.conf
        ~~~~

    Edit the config e.g. like this (local user must be trusted)

    ~~~~ {.programlisting}
     # database administrative login by UNIX sockets
     local    all        postgres                  ident
     # TYPE   DATABASE   USER       CIDR-ADDRESS   METHOD 
     #icinga
     local    icinga     icinga                    trust
     # "local" is for Unix domain socket connections only
     local    all        all                       trust
     # IPv4 local connections
     host     all        all        127.0.0.1/32   trust
     # IPV6 local connections
     host     all        all        ::1/128        trust
    ~~~~

    Reload and configure database scheme.

    ~~~~ {.screen}
     #> /etc/init.d/postgresql-8.x reload
    ~~~~

    ~~~~ {.screen}
     #> cd /path/to/icinga-src/module/idoutils/db/pgsql
     #> psql -U icinga -d icinga < pgsql.sql
    ~~~~

    Edit the DB config file to customize IDOUtils

    ~~~~ {.screen}
     #> vi /usr/local/icinga/etc/ido2db.cfg
    ~~~~

    ~~~~ {.programlisting}
     db_servertype=pgsql
     db_port=5432
     db_user=icinga
     db_pass=icinga
    ~~~~

-   **Oracle:**

    Create a database schema and username/password (refer to the Oracle
    documentation at http://www.oracle.com or consult your DBA). Import
    the database scheme with sqlplus (or your preferred method). Copy
    `module/idoutils/db/oracle/*`{.filename} to \$ORACLE\_HOME and edit
    `icinga_defines.sql`{.filename} to match tablespace and user
    credential information.

    ~~~~ {.screen}
     #> su - oracle
     $> sqlplus dbuser/dbpass
     SQL> @oracle.sql
    ~~~~

    Edit the DB config file to customize IDOUtils. Remember that Oracle
    ignores the db host, instead point db\_name to //DBSERVER/DBNAME

    ~~~~ {.screen}
     #> vi /usr/local/icinga/etc/ido2db.cfg
    ~~~~

    ~~~~ {.programlisting}
      db_servertype=oracle
      db_port=1521
      db_user=icinga
      db_pass=icinga
    ~~~~

### 2.6.12. Configure the Classic Web Interface

Icinga ships with the classic web interface ("the CGIs") which can be
installed via

~~~~ {.screen}
 #> make cgis
 #> make install-cgis
 #> make install-html
~~~~

If you are interested in the new Icinga Web, please refer to [Install
Icinga Web
Interface](icinga-web-scratch.md "6.5. Installation of the Icinga Web Frontend").

Install the Icinga classic web config file in the Apache conf.d
directory.

~~~~ {.screen}
 #> make install-webconf
~~~~

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the command 'make install-webconf-auth'
additionally installs the file `htpasswd.users`{.filename} which
contains credentials for the user *icingaadmin* so you can skip the
following step. The password is *icingaadmin*.

![[Note]](../images/note.png)

Note

Starting with Apache 2.4 (testing versions of Debian / Ubuntu) you have
to enable the configuration

~~~~ {.screen}
#> a2enconf icinga
~~~~

Create an *icingaadmin* account for logging into the Icinga classic web
interface. Remember the password you assign to this account - you'll
need it later.

~~~~ {.screen}
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
~~~~

To change the password of an existing user or to add a new user, take
this command:

~~~~ {.screen}
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
~~~~

![[Note]](../images/note.png)

Note

Depending on your distribution/Apache-version you may have to use
*htpasswd2* instead.

Reload/Restart Apache to make the new settings take effect.

-   **Fedora/RHEL/CentOS:**

    ~~~~ {.screen}
     #> service httpd restart
    ~~~~

-   **Ubuntu/openSuSE:**

    ~~~~ {.screen}
     #> service apache2 restart
    ~~~~

-   **Debian:**

    ~~~~ {.screen}
     #> /etc/init.d/apache2 reload
    ~~~~

### 2.6.13. Compile and Install the Monitoring Plugins

Extract the plugins source code tarball.

~~~~ {.screen}
 #> cd /usr/src 
 #> tar xvzf nagios-plugins-2.1.tar.gz 
 #> cd nagios-plugins-2.1  
~~~~

Compile and install the plugins by changing install directory to
`/usr/local/icinga`{.filename}

~~~~ {.screen}
 #> ./configure --prefix=/usr/local/icinga \
    --with-cgiurl=/icinga/cgi-bin \
    --with-nagios-user=icinga --with-nagios-group=icinga
 #> make 
 #> make install 
~~~~

### 2.6.14. Adjusting the SELinux settings

RHEL and derived distributions like Fedora and CentOS are shipped with
activated SELinux (Security Enhanced Linux) running in "enforcing" mode.
This may lead to "Internal Server Error" messages when you try to invoke
the Icinga-CGIs.

Check if SELinux runs in enforcing mode

~~~~ {.screen}
 #> getenforce
~~~~

Set SELinux in "permissive" mode

~~~~ {.screen}
 #> setenforce 0
~~~~

To make this change permanent you have to adjust this setting in
*/etc/selinux/config* and restart the system.

Instead of deactivating SELinux or setting it into permissive mode you
can use the following commands to run the CGIs in enforcing/targeted
mode. The *semanage* command will automatically add entries to
`/etc/selinux/targeted/contexts/files/file_contexts.local`{.filename}.

~~~~ {.programlisting}
 #> semanage fcontext -a -t httpd_sys_script_exec_t '/usr/local/icinga/sbin(/.*)?'
 #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga/share(/.*)?'
 #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga/var(/.*)?'
~~~~

Once you have defined the necessary contexts you have to apply the
settings:

~~~~ {.programlisting}
 #> chcon -R /usr/local/icinga/sbin
 #> chcon -R /usr/local/icinga/share
 #> chcon -R /usr/local/icinga/var/rw
~~~~

For details please take a look at
[http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/).

### 2.6.15. Start IDOUtils and Icinga

IDOUtils must be started and running *before* Icinga is started.

*Start IDOUtils:*

-   **Fedora/RHEL/CentOS/Ubuntu/openSuSE:**

    ~~~~ {.screen}
     #> service ido2db start
    ~~~~

-   **Debian:**

    ~~~~ {.screen}
     #> /etc/init.d/ido2db start
    ~~~~

*Stop IDOUtils:*

-   **Fedora/RHEL/CentOS/Ubuntu/openSuSE:**

    ~~~~ {.screen}
     #> service ido2db stop
    ~~~~

-   **Debian:**

    ~~~~ {.screen}
     #> /etc/init.d/ido2db stop
    ~~~~

Verify the sample Icinga configuration files.

~~~~ {.screen}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg 
~~~~

If there are no errors, start Icinga.

-   **Fedora/RHEL/CentOS/Ubuntu/openSuSE:**

    ~~~~ {.screen}
     #> service icinga start
    ~~~~

-   **Debian:**

    ~~~~ {.screen}
     #> /etc/init.d/icinga start
    ~~~~

### 2.6.16. Configure Icinga Startup

Add Icinga to the list of system services and have it automatically
start when the system boots (make sure you have installed the init
script before).

-   **Fedora/RHEL/CentOS/openSuSE:**

    ~~~~ {.screen}
     #> chkconfig --add icinga chkconfig icinga on
    ~~~~

-   **Debian/Ubuntu:**

    ~~~~ {.screen}
     #> update-rc.d icinga defaults
    ~~~~

### 2.6.17. Login to the Classic Web Interface

You should now be able to access the Icinga classic web interface at the
URL below. You'll be prompted for the username ( *icingaadmin* ) and
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

### 2.6.18. Other Modifications

Make sure your system's firewall rules are configured to allow access to
the web server if you want to access the Icinga classic interface
remotely.

~~~~ {.screen}
 #> iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
~~~~

Setting up your mail transfer agent (MTA) like exim, sendmail or postfix
to allow Icinga sending notification emails won't be explained here.

There are several tweaks for the IDOUtils (former NDOUtils of Nagios)
available.

### 2.6.19. You're Done

Congratulations! You successfully installed Icinga with IDOUtils. Your
journey into monitoring has just begun. You'll no doubt want to monitor
more than just your local machine, so check out the chapter on ["Getting
Started"](ch02.md "Chapter 2. Getting Started") about "Monitoring ..."

* * * * *

  ----------------------------------------- -------------------- -------------------------------------------------
  [Prev](quickstart-icinga-freebsd.md)    [Up](ch02.md)       [Next](quickstart-idoutils-freebsd.md)
  2.5. Icinga Quickstart FreeBSD            [Home](index.md)    2.7. Icinga and IDOUtils Quickstart on FreeBSD
  ----------------------------------------- -------------------- -------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
