![Icinga](../images/logofullsize.png "Icinga")

2.10. Upgrading (to) Icinga

[Prev](howtos.md) 

Chapter 2. Getting Started

 [Next](upgrading_idoutils.md)

* * * * *

2.10. Upgrading (to) Icinga
---------------------------

2.10.1. [Upgrading from previous Icinga
Releases](upgrading.md#upgradepreviousrelease)

2.10.2. [Upgrading from Nagios 3.x
Releases](upgrading.md#upgradenagios3x)

2.10.3. [Upgrading from Nagios 2.x
Releases](upgrading.md#upgradenagios2x)

2.10.4. [Upgrading from an RPM
Installation](upgrading.md#upgradefromrpm)

![[Note]](../images/note.png)

Note

Starting with 1.8, you will find newly added config options in version
diffed config files in `sample-config/updates/`{.filename} as well as
`module/idoutils/config/updates`{.filename}, e.g.
`cgi.cfg_added_1.7_to_1.8.cfg`{.filename}.

On the core, unknown macros are not left on the output anymore, logging
a warning instead. Either fix your config (i.e. wrong macros, escape
dollar signs with another one) or set keep\_unknown\_macros=1 in
icinga.cfg to revert to the old behaviour.

The Classic UI has removed the WAP interface (statuswml.cgi) as well as
3D statusmap (statuswrl.cgi) not being actively developed and used
anymore. Due to that change, the host configuration attributes
"vrml\_image" and "3dcoords" have been deprecated on the Core as well.

Please have a look at the section "CHANGES" in the
`changelog`{.filename} as well.

![[Note]](../images/note.png)

Note

If you are using IDOUtils then you have to update it, too. Please take a
look at
[upgrading\_idoutils](upgrading_idoutils.md "2.11. Upgrading IDOUtils Database")
as well.

![[Note]](../images/note.png)

Note

If you are using Icinga Web then you have to update it, too. Please take
a look at
[upgrading\_icingaweb](upgrading_icingaweb.md "6.6. Upgrading Icinga Web and Icinga Web Database")
as well.

![[Note]](../images/note.png)

Note

Starting with 1.9, the directive `event_profiling_enabled`{.literal} in
`icinga.cfg`{.filename} is deprecated.

### 2.10.1. Upgrading from previous Icinga Releases

During development there may be cases where the handling of bugfixes
might touch the userspace. We try to avoid this as far as possible but
sometimes it is inevitable.

**Normal Icinga update Path**

If there's a new Icinga version available on
[https://www.icinga.org/](http://www.icinga.org/) you should consider
updating. Newer versions contain bugfixes, minor or major, which makes
it even more important to get the latest and the greatest. If you
already installed Icinga using the quickstart guides it's rather easy to
install newer versions. It's also possible to perform that without root
privileges by doing an install from source. It highly depends on your
likings.

Make sure you'll have a safe backup of your Icinga installation and
configs. If anything goes wrong you can restore your old setup rather
easy.

Regular updates of Icinga are possible just by re-installing Icinga.
Please keep in mind that `configure`{.code} requires the same parameters
as before - look it up in `config.log`{.filename} and store that in a
safe location.

Become the icinga user. Debian/Ubuntu users might use
`sudo -s icinga`{.code}.

~~~~ {.programlisting}
 $> su -l icinga
~~~~

Get the latest Icinga version from
[https://www.icinga.org/](http://www.icinga.org/) and extract it. Then
run configure like you did with the old version.

~~~~ {.programlisting}
 #> ./configure --with-command-group=icinga-cmd
~~~~

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the default has changed so you might have to
disable the compilation of IDOUtils explicitly.

~~~~ {.programlisting}
 #> ./configure --with-command-group=icinga-cmd --disable-idoutils
~~~~

Compile the source.

~~~~ {.programlisting}
 #> make all
~~~~

Please make sure that you don't overwrite your configs - always make a
backup! Don't use `make install-config`{.code} and/or
`make install-webconf`{.code} and/or
`make     install-webconf-auth`{.code}if you want to manually diff the
config files.

~~~~ {.programlisting}
 #> make install install-base install-cgis install-html install-init \
    install-commandmode install-idoutils
~~~~

or decide what you want to upgrade by just typing 'make' which shows all
available options. Check your config and restart Icinga.

~~~~ {.programlisting}
 #> /etc/init.d/icinga checkconfig
 #> /etc/init.d/icinga restart
~~~~

That's it!

**Icinga 0.8.0 to Icinga 1.13**

*Archived Logfilename*

There was a small misspelling bug in Icinga 0.8.0 resulting in archived
logfile names beginning with a capital **"I"** like in
**'Icinga-\$date'**". This was fixed in version 0.8.1. and newer.

If you experience this problem then please use the following script to
fix the file names

~~~~ {.programlisting}
 #> cd /usr/local/icinga/var/archives

 for oldfilename in `find ./ -name "Icinga-*"`
 do
   newfilename=`echo $oldfilename | sed -e 's/Icinga/icinga/g'`
   mv $oldfilename $newfilename
 done
~~~~

**Upgrading to Apache 2.4**

Starting with Apache 2.4 the default web configuration folder changed
from `/etc/apache2/conf.d`{.filename} to
`/etc/apache2/conf-available`{.filename}. If you want to migrate then
just move the file(s), enable the configuration(s) and reload the web
server:

~~~~ {.screen}
#> mv /etc/apache2/conf.d/icinga*.conf /etc/apache2/conf-available
#> a2enconf icinga icinga-web
#> service apache2 reload
~~~~

![[Note]](../images/note.png)

Note

Following `a2enconf`{.literal} you have to specify the configuration.
The example assumes that you have installed both Icinga Classic UI and
Icinga Web.

You have to enable the CGI module as well

~~~~ {.screen}
#> a2emod cgi
~~~~

### 2.10.2. Upgrading from Nagios 3.x Releases

We try to be compatible with the configuration files of the current
Nagios 3.x versions so there should be very little you have to do to
"upgrade" from Nagios 3.x to Icinga 1.13. Assuming you've already
installed Nagios from source code as described in the Nagios quickstart
guide, you can install Icinga quite easily.

If you are upgrading from Nagios 3.0.x you might need to install PHP:

*Debian / Ubuntu*

~~~~ {.screen}
 #> apt-get install php5 libapache2-mod-php5
~~~~

*Fedora / RedHat*

~~~~ {.screen}
 #> yum install php mod_php
~~~~

*openSuSE / SLES*

Use Yast to install the packages *php5* and *apache2-mod\_php5* or use
zypper

~~~~ {.programlisting}
 #> zypper install php5 apache2-mod_php5
~~~~

Make sure you have a good backup of your existing Nagios installation
and configuration files. If anything goes wrong or doesn't work, this
will allow you to rollback to your old version.

Please install Icinga according to the [quickstart
guide](quickstart.md "2.3. Quickstart Installation Guides"). Please
note that

-   the default prefix has changed to "/usr/local/icinga"

-   the environment macros start with ICINGA\_

    PNP4Nagios is aware of that since 0.6rc1 (2009.09.20) but the macros
    are needed in "sync" mode only.

    check\_multi includes support since v0.21 (2010.06.03), but you have
    to rerun the installation using
    '`configure         --with-nagios_name=icinga`{.code}' so that
    check\_multi contains the correct values. You can use the option
    "-s" instead to set certain values.

-   the configuration file names of the (enhanced) IDOUtils are named
    `idomod.cfg/ido2db.cfg`{.filename} instead of
    `ndomod.cfg/ndo2db.cfg`{.filename}

Become the icinga user. Debian/Ubuntu users might use
`sudo -s icinga`{.code}.

~~~~ {.screen}
 $ su -l nagios
~~~~

Get the latest Icinga version from
[https://www.icinga.org/](http://www.icinga.org/download/)

~~~~ {.screen}
 #> wget https://github.com/Icinga/icinga-core/releases/download/v1.13/icinga-1.13.tar.gz
~~~~

Extract the tarball and change to the directory just created

~~~~ {.screen}
 #> tar xzf icinga-1.13.tar.gz
 #> cd icinga-1.13 
~~~~

Start the Icinga-configure-script with the options you used the last
time with Nagios. You'll find the call in the file config.log. Example:

~~~~ {.screen}
 #> ./configure --with-command-group=nagcmd
~~~~

Compile the Icinga source code.

~~~~ {.screen}
 #> make all
~~~~

Install the programs, documentation, classic web interface and the init
script. Your existing config files will not be overwritten.

~~~~ {.screen}
 #> make cgis 
 #> make install
 #> make install-cgis
 #> make install-init
~~~~

or simply

~~~~ {.screen}
 #> make fullinstall
~~~~

![[Important]](../images/important.png)

Important

Not till Icinga 1.5.0 `make install-config`{.literal} is NOT included in
`make fullinstall`{.literal} anymore to avoid accidental overwriting of
your config files.

Instead of using "`make install-config`{.code}" copy your configuration
files from `<Nagios-path>/etc/`{.filename} to
`<Icinga-path>/etc/`{.filename}. Before starting Icinga you have to
alter some things:

-   The filename of the main config file has changed from
    `nagios.cfg`{.filename} to `icinga.cfg`{.filename}.
    ` #> mv nagios.cfg icinga.cfg`{.literal} should be sufficient to
    change that

-   You have to edit the main config file (`icinga.cfg`{.filename}) to
    change the directives named "nagios\_user" and "nagios\_group" to
    "icinga\_user" and "icinga\_group" respectively. Depending on the
    paths you're using you may have to change them as well.

    ~~~~ {.programlisting}
     #> sed -i 's/nagios/icinga/g' ./icinga.cfg/
    ~~~~

-   You have to edit the CGI config file (`cgi.cfg`{.filename}) to
    change the paths you're using.

    ~~~~ {.programlisting}
     #> sed -i 's/nagios/icinga/g' ./cgi.cfg/
    ~~~~

Copy other relevant files from your Nagios installation to the new
location. If you are unsure about the path then please have a look at
`nagios.cfg`{.filename} and/or `icinga.cfg`{.filename}.

-   `retention.dat`{.filename} (it contains certain status information,
    comments and other "sticky" stuff)

-   `nagios.log`{.filename} (rename it to `icinga.log`{.filename})

-   `archives/nagios-<date>.log`{.filename} files (Icinga is able to
    process both nagios-\<date\>.log and icinga-\<date\>.log files so
    you don't have to rename the files)

-   You don't have to copy `status.dat`{.filename} and/or
    `objects.cache`{.filename} because these files are recreated during
    startup. Please recreate `objects.precache`{.filename} before
    startup [if
    applicable](configmain.md#configmain-precached_object_file)
    instead of copying it

Verify your configuration files, correct errors (if any) and start
Icinga.

~~~~ {.screen}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
 #> /etc/init.d/icinga start
~~~~

That's it - you're done!

Please keep in mind that

-   the URL has changed to http://localhost/icinga/ (for the classic UI)

-   the name of the admin user has changed to icingaadmin

### 2.10.3. Upgrading from Nagios 2.x Releases

It shouldn't be too difficult to upgrade from Nagios 2.x to Icinga 1.13.
The upgrade is essentially the same as what is described above for
upgrading from Nagios 3.x releases. You will, however, have to change
your configuration files a bit so they work with Icinga 1.13:

-   The old *service\_reaper\_frequency* variable in the main config
    file has been renamed to
    [check\_result\_reaper\_frequency](configmain.md#configmain-check_result_reaper_frequency).

-   The old *\$NOTIFICATIONNUMBER\$* macro has been deprecated in favour
    of new
    [\$HOSTNOTIFICATIONNUMBER\$](macrolist.md#macrolist-hostnotificationnumber)
    and
    [\$SERVICENOTIFICATIONNUMBER\$](macrolist.md#macrolist-servicenotificationnumber)
    macros.

-   The old *parallelize* directive in service definitions is now
    deprecated and no longer used, as all service checks are run in
    parallel.

-   The old *aggregate\_status\_updates* option has been removed. All
    status file updates are now aggregated at a minimum interval of 1
    second.

-   Extended host and extended service definitions have been deprecated.
    They are still read and processed by Icinga, but it is recommended
    that you move the directives found in these definitions to your host
    and service definitions, respectively.

-   The old *downtime\_file* file variable in the main config file is no
    longer supported, as scheduled downtime entries are now saved in the
    [retention file](configmain.md#configmain-state_retention_file).
    To preserve existing downtime entries, stop Nagios 2.x and append
    the contents of your old downtime file to the retention file.

-   The old *comment\_file* file variable in the main config file is no
    longer supported, as comments are now saved in the [retention
    file](configmain.md#configmain-state_retention_file). To preserve
    existing comments, stop Nagios 2.x and append the contents of your
    old comment file to the retention file.

Also make sure to read the "[What's
New](whatsnew.md "1.2. What's New in Icinga 1.13")" section of the
documentation. It describes all the changes that were made to the Icinga
code since the latest stable release of Nagios 3.0.6. Quite a bit has
changed, so make sure you read it over.

### 2.10.4. Upgrading from an RPM Installation

If you currently have an RPM- or Debian/Ubuntu APT package-based
installation of Nagios and you would like to transition to installing
Icinga from the official source code distribution, here's the basic
process you should follow:

1.  Backup your existing Nagios installation

    -   Configuration files

        -   Main config file (usually `nagios.cfg`{.filename})

        -   Resource config file (usually `resource.cfg`{.filename})

        -   CGI config file (usually `cgi.cfg`{.filename})

        -   All your object definition files

    -   Retention file (usually `retention.dat`{.filename})

    -   Current Nagios log file (usually `nagios.log`{.filename})

    -   Archived Nagios log files (usually
        `nagios-<date>.log`{.filename})

2.  Uninstall the original RPM or APT package

3.  Install Icinga from source by following the [quickstart
    guide](quickstart.md "2.3. Quickstart Installation Guides")

4.  Restore your original Nagios configuration files, retention file,
    and log files

5.  [Verify](verifyconfig.md "4.1. Verifying Your Configuration") your
    configuration and
    [start](startstop.md "4.2. Starting and Stopping Icinga") Icinga

Note that different RPMs or APT packages may install Icinga in different
ways and in different locations. Make sure you've backed up all your
critical Nagios files before removing the original RPM or APT package,
so you can revert back if you encounter problems.

* * * * *

  --------------------------------------- -------------------- ------------------------------------
  [Prev](howtos.md)                     [Up](ch02.md)       [Next](upgrading_idoutils.md)
  2.9. Links to other published Howtos    [Home](index.md)    2.11. Upgrading IDOUtils Database
  --------------------------------------- -------------------- ------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
