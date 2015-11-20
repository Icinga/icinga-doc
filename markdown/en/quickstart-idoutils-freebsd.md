[Prev](quickstart-idoutils.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](icinga_packages.md)

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




If you are planning to install from source then please use the official
release tarball.

![[Important]](../images/important.png)

Important

Please don't use git snapshots unless you have an issue which might be
solved in the current developer version.

This guide is intended to provide you with simple instructions on how to
install Icinga from source (code) and have it monitoring your local
machine within 30 minutes.

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





**Prerequisites**

During portions of the installation you'll need to have **root** access
to your machine.

Make sure you've installed the following packages on your system before
continuing.









**Optional**

At one time or another you will likely use SNMP based checks so it might
be a good idea to install the required packages now. Otherwise the
plugins will not be compiled and are not available when you need them.

**New features for the IDOUtils:**













**Install the packages**

You can install the packages from the ports or you take older packages
(have a look at the [FreeBSD quickstart
quide](quickstart-icinga-freebsd.md "2.5. Icinga Quickstart FreeBSD")).

**Install ports**

You can install these ports by running the following commands (as root)
but it is recommended to use portupgrade or portmaster instead:

Please update your ports before doing so.

</code></pre> 
 #> cd /usr/ports/devel/libtool/ && make all install clean
 #> cd /usr/ports/graphics/jpeg && make all install clean
 #> cd /usr/ports/graphics/png && make all install clean
 #> cd /usr/ports/graphics/gd && make all install clean
</code></pre>

![[Note]](../images/note.png)

Note

discussed here, however the lead is *\# cd /usr/ports/www/apache22 &&
make clean && make*.

</code></pre> 
 #> cd /usr/ports/devel/libltdl && make all install clean <-- unless installed already
</code></pre>







**Create Account Information**

Become the root user.

</code></pre> 
 $> su -l
</code></pre>

Create a new *icinga* user account without a password and without the
ability to log-in (set no password when asked):

</code></pre> 
 #> adduser -D -w no -s nologin
</code></pre>

For sending commands from the classic web interface to Icinga, you'll
need to create a new group icinga-cmd and add the webuser (www) and the
Icingauser to this group:

</code></pre> 
</code></pre>

**Download Icinga and the plugins**

Change to your local source directory i.e. \~/src

</code></pre> 
 #> mkdir ~/src
 #> cd ~/src
</code></pre>

Get the current source from the [Icinga
Website](http://www.icinga.org/).

Don't forget to download the [Monitoring
Plugins](https://www.monitoring-plugins.org).

**Compile and install Icinga and IDOUtils**

Extract the Icinga source code tarball (or change directory to the GIT
snapshot)

</code></pre> 
 #> cd icinga-1.13
</code></pre>

![[Note]](../images/note.png)

Note

This absolute path is meant if we use the description
'/path/to/icinga-src/'.

Run the Icinga configure script. You will get help by using the --help
flag.

</code></pre> 
 #> ./configure --with-command-group=icinga-cmd \
</code></pre>

![[Important]](../images/important.png)

Important

Appending *CPPFLAGS=-I/usr/local/include* is important for the IDOUtils
and the broker modul respectively.

![[Note]](../images/note.png)

Note

You should include `CFLAGS=..."` like specified above.
Otherwise you might get the following lines in `icinga.log`:

</code></pre> 
 Error: Module ‘/usr/local/icinga/lib/idomod.so’ is using an old or unspecified version
 of the event broker API. Module will be unloaded.
 Event broker module ‘/usr/local/icinga/lib/idomod.so’ deinitialized successfully.
</code></pre>

More details on this error can be found
[here](http://www.mazej.net/icinga-idomod-o-is-using-an-old-or-unspecified-version-of-the-event-broker-api/).

**With SSL-encryption:**

</code></pre> 
 #> ./configure --with-command-group=icinga-cmd \
</code></pre>

Compile the Icinga source code. There is a separate option for IDOUtils
(*make idoutils*) if you just want to recompile this module. To see
possible option just call "make".

</code></pre> 
 #> gmake all
</code></pre>

Install binaries, init script, sample config files, some eventhandlers,
and set permissions on the external command directory.

</code></pre> 
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
</code></pre>

or shorter

</code></pre> 
 #> make fullinstall
 #> make install-config
</code></pre>

![[Note]](../images/note.png)

Note

`make install-config` is NOT included in
`make fullinstall `anymore to avoid accidently overwriting of
your config files.

![[Note]](../images/note.png)

Note

`make install-eventhandlers` will install some event handler
routines. To prevent undesired behaviour it is only included when you
use `make fullinstall`.

![[Note]](../images/note.png)

Note

The Icinga-API served as a database abstraction layer written in PHP.
Starting with Icinga 1.5 it is replaced by an internal database
abstraction layer so Icinga-API doesn't have to be installed anymore.


**Customise Configuration**

Sample configuration files have been installed using

</code></pre> 
 #> gmake install-config
</code></pre>

into /usr/local/icinga/etc/. You'll need to make just one change before
you proceed...

Edit the */usr/local/icinga/etc/objects/contacts.cfg* config file with
your favourite editor and change the email address associated with the
*icingaadmin* contact definition to the address you'd like to use for
receiving alerts.

</code></pre> 
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
</code></pre>

</code></pre> 
 #> cd /usr/local/icinga/etc
 #> mv idomod.cfg-sample idomod.cfg
 #> mv ido2db.cfg-sample ido2db.cfg
</code></pre>

If you compiled the IDOUtils with SSL then you have to activate SSL in
`idomod.cfg` setting

<pre><code>
 use_ssl=1
 output_type=tcpsocket
 output=127.0.0.1
</code></pre>

(adjust the IP address if your database is not running on localhost!)
and in `ido2db.cfg` setting

<pre><code>
 use_ssl=1
</code></pre>

![[Note]](../images/note.png)

Note

Don't forget to recompile all other idomod clients and to activate SSL
**otherwise you will lose data!!!**

**Activate the idomod event broker module**

![[Important]](../images/important.png)

Important

Under normal circumstances the following module definition is already
present in the `modules` subdirectory so there is no need to
edit the main config file

<pre><code>
 define module{
</code></pre>

**Compile database and IDOUtils**















**Install and configure the Classic Web Interface**

Icinga ships with the Classic Web Interface ("the CGIs") which can be
installed via

</code></pre> 
 #> cd /path/to/icinga-src
 #> make cgis
 #> make install-cgis
 #> make install-html
</code></pre>

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

<pre><code>
 $(INSTALL) -D -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
</code></pre>

to

<pre><code>
 $(INSTALL) -m 644 sample-config/httpd.conf $(DESTDIR)$(HTTPD_CONF)/icinga.conf
</code></pre>

</code></pre> 
 #> make install-webconf
</code></pre>

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the command 'make install-webconf-auth'
additionally installs the file `htpasswd.users` which
contains credentials for the user *icingaadmin* so you can skip the
following step. The password is *icingaadmin*.

Create an *icingaadmin* account for logging into the Icinga classic web
interface. If you want to change it later, use the same command.

</code></pre> 
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
</code></pre>

If you want to change it later or want to add another user, use the
following command:

</code></pre> 
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
</code></pre>

Reload/Restart Apache to make the new settings take effect.

</code></pre> 
 #> /usr/local/etc/rc.d/apache22 reload
</code></pre>

**Compile and Install the Perl Plugins and Monitoring Plugins**

Extract the plugins source code tarball.

</code></pre> 
 #> tar xvzf nagios-plugins-2.1.tar.gz
</code></pre>

Compile and install the plugins by changing install directory to
/usr/local/icinga

</code></pre> 
 #> ./configure --prefix=/usr/local/icinga --with-cgiurl=/icinga/cgi-bin \
</code></pre>

![[Note]](../images/note.png)

Note

There is a port for the plugins but it will install them in a different
directory. You can set certain variables to tweak its make but you still
have to copy some things manually later on.

Compile and install the Perl plugin:

</code></pre> 
 #> cd /usr/ports/net-mgmt/p5-Nagios-Plugin
 #> make all install clean
</code></pre>

**Starting IDOUtils and Icinga**

IDOUtils has to be started before Icinga

**Starting IDOUtils**

</code></pre> 
 #> /usr/local/etc/rc.d/ido2db start
</code></pre>

**Stopping IDOUtils**

</code></pre> 
 #> /usr/local/etc/rc.d/ido2db stop
</code></pre>

**Start Icinga**

Add Icinga to the list of system services and have it automatically
start when the system boots (make sure you have installed the init
script before).

</code></pre> 
 #> echo icinga_enable=\"YES\" >> /etc/rc.conf
</code></pre>

Verify the sample Icinga configuration files.

</code></pre> 
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
</code></pre>

If there are no errors, start Icinga.

</code></pre> 
 #> /usr/local/etc/rc.d/icinga start
</code></pre>

**Login to the Classic Web Interface**

You should now be able to access the Icinga classic web interface at the
URL below. You'll be prompted for the username ( *icingaadmin*) and
password you specified earlier.

</code></pre> 
 http://localhost/icinga/
</code></pre>

or

</code></pre> 
 http://yourdomain.com/icinga/
</code></pre>

Click on the "Service Detail" navbar link to see details of what's being
monitored on your local machine. It will take a few minutes for Icinga
to check all the services associated with your machine.

**Other Modifications**

Make sure your system's firewall rules are configured to allow access to
the web server if you want to access the Icinga classic interface
remotely.

</code></pre> 
 #> TCP port 80
</code></pre>

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

<pre><code>
./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
 --with-gd-lib=/usr/local/lib/ --with-gd-inc=/usr/local/include/ \
 --with-command-group=icinga-cmd --enable-idoutils \
 --with-dbi-inc=/usr/local/include --with-dbu-lib=/usr/local/lib \
 CPPFLAGS=-I/usr/local/include CFLAGS=-fPIC
</code></pre>

Compiler options for Monitoring Plugins plugins (ports)

<pre><code>
make install NAGIOSUSER=icinga NAGIOSGROUP=icinga \
 PREFIX=/usr/local/icinga
</code></pre>

* * * * *

[Prev](quickstart-idoutils.md) | [Up](ch02.md) | [Next](icinga_packages.md)

2.6. Icinga with IDOUtils Quickstart  |<=== [Index](index.md) ===>|  2.8. Icinga Packages for Linux Distributions

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
