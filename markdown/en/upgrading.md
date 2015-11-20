[Prev](howtos.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](upgrading_idoutils.md)

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
diffed config files in `sample-config/updates/` as well as
`module/idoutils/config/updates`, e.g.
`cgi.cfg_added_1.7_to_1.8.cfg`.

On the core, unknown macros are not left on the output anymore, logging
a warning instead. Either fix your config (i.e. wrong macros, escape
dollar signs with another one) or set keep\_unknown\_macros=1 in
icinga.cfg to revert to the old behaviour.

The Classic UI has removed the WAP interface (statuswml.cgi) as well as
3D statusmap (statuswrl.cgi) not being actively developed and used
anymore. Due to that change, the host configuration attributes
"vrml\_image" and "3dcoords" have been deprecated on the Core as well.

Please have a look at the section "CHANGES" in the
`changelog` as well.

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

Starting with 1.9, the directive `event_profiling_enabled` in
`icinga.cfg` is deprecated.

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
Please keep in mind that `configure` requires the same parameters
safe location.

Become the icinga user. Debian/Ubuntu users might use
`sudo -s icinga`.

<pre><code>
 $> su -l icinga
</code></pre>

Get the latest Icinga version from
[https://www.icinga.org/](http://www.icinga.org/) and extract it. Then
run configure like you did with the old version.

<pre><code>
 #> ./configure --with-command-group=icinga-cmd
</code></pre>

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the default has changed so you might have to
disable the compilation of IDOUtils explicitly.

<pre><code>
 #> ./configure --with-command-group=icinga-cmd --disable-idoutils
</code></pre>

Compile the source.

<pre><code>
 #> make all
</code></pre>

backup! Don't use `make install-config` and/or
`make install-webconf` and/or
config files.

<pre><code>
 #> make install install-base install-cgis install-html install-init \
</code></pre>

or decide what you want to upgrade by just typing 'make' which shows all
available options. Check your config and restart Icinga.

<pre><code>
 #> /etc/init.d/icinga checkconfig
 #> /etc/init.d/icinga restart
</code></pre>

That's it!

**Icinga 0.8.0 to Icinga 1.13**

*Archived Logfilename*

There was a small misspelling bug in Icinga 0.8.0 resulting in archived
logfile names beginning with a capital **"I"** like in
**'Icinga-\$date'**". This was fixed in version 0.8.1. and newer.

If you experience this problem then please use the following script to
fix the file names

<pre><code>
 #> cd /usr/local/icinga/var/archives

 for oldfilename in `find ./ -name "Icinga-*"`
 do
 done
</code></pre>

**Upgrading to Apache 2.4**

Starting with Apache 2.4 the default web configuration folder changed
from `/etc/apache2/conf.d` to
`/etc/apache2/conf-available`. If you want to migrate then
just move the file(s), enable the configuration(s) and reload the web
server:

</code></pre> 
#> mv /etc/apache2/conf.d/icinga*.conf /etc/apache2/conf-available
#> a2enconf icinga icinga-web
#> service apache2 reload
</code></pre>

![[Note]](../images/note.png)

Note

Following `a2enconf` you have to specify the configuration.
The example assumes that you have installed both Icinga Classic UI and
Icinga Web.

You have to enable the CGI module as well

</code></pre> 
#> a2emod cgi
</code></pre>

### 2.10.2. Upgrading from Nagios 3.x Releases

We try to be compatible with the configuration files of the current
Nagios 3.x versions so there should be very little you have to do to
"upgrade" from Nagios 3.x to Icinga 1.13. Assuming you've already
installed Nagios from source code as described in the Nagios quickstart
guide, you can install Icinga quite easily.

If you are upgrading from Nagios 3.0.x you might need to install PHP:

*Debian / Ubuntu*

</code></pre> 
 #> apt-get install php5 libapache2-mod-php5
</code></pre>

*Fedora / RedHat*

</code></pre> 
 #> yum install php mod_php
</code></pre>

*openSuSE / SLES*

Use Yast to install the packages *php5* and *apache2-mod\_php5* or use
zypper

<pre><code>
 #> zypper install php5 apache2-mod_php5
</code></pre>

Make sure you have a good backup of your existing Nagios installation
and configuration files. If anything goes wrong or doesn't work, this
will allow you to rollback to your old version.

Please install Icinga according to the [quickstart
guide](quickstart.md "2.3. Quickstart Installation Guides"). Please
note that






Become the icinga user. Debian/Ubuntu users might use
`sudo -s icinga`.

</code></pre> 
 $ su -l nagios
</code></pre>

Get the latest Icinga version from
[https://www.icinga.org/](http://www.icinga.org/download/)

</code></pre> 
 #> wget https://github.com/Icinga/icinga-core/releases/download/v1.13/icinga-1.13.tar.gz
</code></pre>

Extract the tarball and change to the directory just created

</code></pre> 
 #> tar xzf icinga-1.13.tar.gz
</code></pre>

Start the Icinga-configure-script with the options you used the last
time with Nagios. You'll find the call in the file config.log. Example:

</code></pre> 
 #> ./configure --with-command-group=nagcmd
</code></pre>

Compile the Icinga source code.

</code></pre> 
 #> make all
</code></pre>

Install the programs, documentation, classic web interface and the init
script. Your existing config files will not be overwritten.

</code></pre> 
 #> make install
 #> make install-cgis
 #> make install-init
</code></pre>

or simply

</code></pre> 
 #> make fullinstall
</code></pre>

![[Important]](../images/important.png)

Important

Not till Icinga 1.5.0 `make install-config` is NOT included in
`make fullinstall` anymore to avoid accidental overwriting of
your config files.

Instead of using "`make install-config`" copy your configuration
files from `<Nagios-path>/etc/` to
`<Icinga-path>/etc/`. Before starting Icinga you have to
alter some things:






Copy other relevant files from your Nagios installation to the new
location. If you are unsure about the path then please have a look at
`nagios.cfg` and/or `icinga.cfg`.





Verify your configuration files, correct errors (if any) and start
Icinga.

</code></pre> 
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
 #> /etc/init.d/icinga start
</code></pre>


Please keep in mind that



### 2.10.3. Upgrading from Nagios 2.x Releases

It shouldn't be too difficult to upgrade from Nagios 2.x to Icinga 1.13.
The upgrade is essentially the same as what is described above for
upgrading from Nagios 3.x releases. You will, however, have to change
your configuration files a bit so they work with Icinga 1.13:








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














Note that different RPMs or APT packages may install Icinga in different
ways and in different locations. Make sure you've backed up all your
critical Nagios files before removing the original RPM or APT package,
so you can revert back if you encounter problems.

* * * * *

[Prev](howtos.md) | [Up](ch02.md) | [Next](upgrading_idoutils.md)

2.9. Links to other published Howtos  |<=== [Index](index.md) ===>|  2.11. Upgrading IDOUtils Database

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
