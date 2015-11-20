[Prev](quickstart-icinga.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](quickstart-idoutils.md)

* * * * *

2.5. Icinga Quickstart FreeBSD
------------------------------

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
machine within 20 minutes.

that will work for most of the users who want to get started.

This guide will give you examples for installation on [FreeBSD]() 7.2.

Later distributions of FreeBSD may inherit from these examples.

**What You'll End Up With**

If you follow these instructions, here's what you'll end up with:




**Prerequisites**

During portions of the installation you'll need to have **root** access
to your machine.

Make sure you've installed the following packages on your system before
continuing.





**Install ports**

You can install these ports by running the following commands (as root):

Please update your ports before doing so.

<pre><code>
 #> cd /usr/ports/graphics/jpeg && make deinstall && make clean && make && make install
 #> cd /usr/ports/graphics/png && make deinstall && make clean && make && make install
 #> cd /usr/ports/graphics/gd && make deinstall && make clean && make && make install
</code></pre>

![[Note]](../images/note.png)

Note

discussed here, however the lead is *\# cd /usr/ports/www/apache22 &&
make clean && make*.

**Create Account Information**

Become the root user.

<pre><code>
 $> su -l
</code></pre>

Create a new *icinga* user account without a password and without the
ability to log-in (set no password when asked):

<pre><code>
 #> adduser -D -w no -s nologin
</code></pre>

For sending commands from the classic web interface to Icinga, you'll
need to create a new group icinga-cmd and add the webuser (www) and the
Icingauser to this group:

<pre><code>
</code></pre>

**Download Icinga and the Plugins**

Change to your local source directory i.e. \~/src

<pre><code>
 #> mkdir ~/src
 #> cd ~/src
</code></pre>

Get the current source from the [Icinga
Website](http://www.icinga.org/).

Don't forget to download the [Monitoring
Plugins](https://www.monitoring-plugins.org).

**Compile and install Icinga**

Extract the Icinga source code tarball (or change directory to the GIT
snapshot)

<pre><code>
 #> cd icinga-1.13
</code></pre>

Run the Icinga configure script. You will get help by using the --help
flag.

<pre><code>
 #> ./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
</code></pre>

Compile the Icinga source code. To see available options, only use
"make".

<pre><code>
 #> make all
</code></pre>

Install binaries, init script, sample config files, some eventhandlers,
and set permissions on the external command directory.

<pre><code>
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
</code></pre>

or shorter

<pre><code>
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

The Icinga-API will be installed during "make install" so if you are
required to install it manually please try:

<pre><code>
 #> make install-api
</code></pre>

This will be mandatory for Icinga Web.


**Customise Configuration**

Sample configuration files have been installed using

<pre><code>
 #> make install-config
</code></pre>

into /usr/local/icinga/etc/. You'll need to make just one change before
you proceed...

Edit the */usr/local/icinga/etc/objects/contacts.cfg* config file with
your favourite editor and change the email address associated with the
*icingaadmin* contact definition to the address you'd like to use for
receiving alerts.

<pre><code>
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
</code></pre>

**Install and configure the Classic Web Interface**

Icinga ships with the Classic Web Interface ("the CGIs") which can be
installed via

<pre><code>
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

<pre><code>
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

<pre><code>
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
</code></pre>

If you want to change it later or want to add another user, use the
following command:

<pre><code>
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
</code></pre>

Reload/Restart Apache to make the new settings take effect.

<pre><code>
 #> /usr/local/etc/rc.d/apache22 reload
</code></pre>

**Compile and Install the Monitoring Plugins**

Extract the plugins source code tarball.

<pre><code>
 #> tar xvzf nagios-plugins-2.1.tar.gz
</code></pre>

Compile and install the plugins by changing install directory to
/usr/local/icinga

<pre><code>
 #> ./configure --prefix=/usr/local/icinga \
</code></pre>

**Start Icinga**

Add Icinga to the list of system services and have it automatically
start when the system boots (make sure you have installed the init
script before).

<pre><code>
 #> echo icinga_enable=\"YES\" >> /etc/rc.conf
</code></pre>

Verify the sample Icinga configuration files.

<pre><code>
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
</code></pre>

If there are no errors, start Icinga.

<pre><code>
 #> /usr/local/etc/rc.d/icinga start
</code></pre>

**Login to the Classic Web Interface**

You should now be able to access the Icinga classic web interface at the
URL below. You'll be prompted for the username ( *icingaadmin*) and
password you specified earlier.

<pre><code>
 http://localhost/icinga/
</code></pre>

or

<pre><code>
 http://yourdomain.com/icinga/
</code></pre>

Click on the "Service Detail" navbar link to see details of what's being
monitored on your local machine. It will take a few minutes for Icinga
to check all the services associated with your machine.

**Other Modifications**

Make sure your system's firewall rules are configured to allow access to
the web server if you want to access the Icinga classic interface
remotely.

<pre><code>
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

* * * * *

[Prev](quickstart-icinga.md) | [Up](ch02.md) | [Next](quickstart-idoutils.md)

2.4. Icinga Quickstart  |<=== [Index](index.md) ===>|  2.6. Icinga with IDOUtils Quickstart

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
