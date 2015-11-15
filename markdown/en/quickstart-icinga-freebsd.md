![Icinga](../images/logofullsize.png "Icinga")

2.5. Icinga Quickstart FreeBSD

[Prev](quickstart-icinga.md) 

Chapter 2. Getting Started

 [Next](quickstart-idoutils.md)

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
machine within 20 minutes.

No advanced installation options are discussed here - just the basics
that will work for most of the users who want to get started.

This guide will give you examples for installation on [FreeBSD]() 7.2.

Later distributions of FreeBSD may inherit from these examples.

**What You'll End Up With**

If you follow these instructions, here's what you'll end up with:

-   Icinga and the plugins will be installed underneath
    /usr/local/icinga

-   Icinga will be configured to monitor a few aspects of your local
    system (CPU load, disk usage, etc.)

-   The Icinga classic web interface will be accessible at
    `http://localhost/icinga/`{.uri} or
    `http://yourdomain.com/icinga`{.uri}

**Prerequisites**

During portions of the installation you'll need to have **root** access
to your machine.

Make sure you've installed the following packages on your system before
continuing.

-   [Apache](http://www.apache.org)

-   GCC compiler

-   C/C++ development libraries

-   [GD](http://www.boutell.com/gd/) development libraries

**Install ports**

You can install these ports by running the following commands (as root):

Please update your ports before doing so.

~~~~ {.programlisting}
 #> cd /usr/ports/devel/libtool22/ && make deinstall && make clean && make && make install 
 #> cd /usr/ports/graphics/jpeg && make deinstall && make clean && make && make install
 #> cd /usr/ports/graphics/png && make deinstall && make clean && make && make install
 #> cd /usr/ports/graphics/gd && make deinstall && make clean && make && make install
~~~~

![[Note]](../images/note.png)

Note

Please make sure you have Apache installed - the process will not be
discussed here, however the lead is *\# cd /usr/ports/www/apache22 &&
make clean && make*.

**Create Account Information**

Become the root user.

~~~~ {.programlisting}
 $> su -l
~~~~

Create a new *icinga* user account without a password and without the
ability to log-in (set no password when asked):

~~~~ {.programlisting}
 #> adduser -D -w no -s nologin
~~~~

For sending commands from the classic web interface to Icinga, you'll
need to create a new group icinga-cmd and add the webuser (www) and the
Icingauser to this group:

~~~~ {.programlisting}
 #> pw groupadd -n icinga-cmd -M icinga,www 
~~~~

**Download Icinga and the Plugins**

Change to your local source directory i.e. \~/src

~~~~ {.programlisting}
 #> mkdir ~/src
 #> cd ~/src
~~~~

Get the current source from the [Icinga
Website](http://www.icinga.org/).

Don't forget to download the [Monitoring
Plugins](https://www.monitoring-plugins.org).

**Compile and install Icinga**

Extract the Icinga source code tarball (or change directory to the GIT
snapshot)

~~~~ {.programlisting}
 #> cd ~/src/ 
 #> tar xvzf icinga-1.13.tar.gz 
 #> cd icinga-1.13
~~~~

Run the Icinga configure script. You will get help by using the --help
flag.

~~~~ {.programlisting}
 #> ./configure --with-httpd-conf=/usr/local/etc/apache22/Includes/ \
    --with-gd-lib=/usr/local/lib/ \
    --with-gd-inc=/usr/local/include/ \
    --with-command-group=icinga-cmd
~~~~

Compile the Icinga source code. To see available options, only use
"make".

~~~~ {.programlisting}
 #> make all
~~~~

Install binaries, init script, sample config files, some eventhandlers,
and set permissions on the external command directory.

~~~~ {.programlisting}
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
 #> make install-commandmode 
~~~~

or shorter

~~~~ {.programlisting}
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

The Icinga-API will be installed during "make install" so if you are
required to install it manually please try:

~~~~ {.programlisting}
 #> make install-api
~~~~

This will be mandatory for Icinga Web.

Don't start Icinga yet - there's still more that needs to be done...

**Customise Configuration**

Sample configuration files have been installed using

~~~~ {.programlisting}
 #> make install-config
~~~~

into /usr/local/icinga/etc/. You'll need to make just one change before
you proceed...

Edit the */usr/local/icinga/etc/objects/contacts.cfg* config file with
your favourite editor and change the email address associated with the
*icingaadmin* contact definition to the address you'd like to use for
receiving alerts.

~~~~ {.programlisting}
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
~~~~

**Install and configure the Classic Web Interface**

Icinga ships with the Classic Web Interface ("the CGIs") which can be
installed via

~~~~ {.programlisting}
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

~~~~ {.programlisting}
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

~~~~ {.programlisting}
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
~~~~

If you want to change it later or want to add another user, use the
following command:

~~~~ {.programlisting}
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
~~~~

Reload/Restart Apache to make the new settings take effect.

~~~~ {.programlisting}
 #> /usr/local/etc/rc.d/apache22 reload
~~~~

**Compile and Install the Monitoring Plugins**

Extract the plugins source code tarball.

~~~~ {.programlisting}
 #> cd ~/src 
 #> tar xvzf nagios-plugins-2.1.tar.gz
 #> cd nagios-plugins-2.1 
~~~~

Compile and install the plugins by changing install directory to
/usr/local/icinga

~~~~ {.programlisting}
 #> ./configure --prefix=/usr/local/icinga \
    --with-cgiurl=/icinga/cgi-bin \
    --with-nagios-user=icinga --with-nagios-group=icinga
 #> make 
 #> make install 
~~~~

**Start Icinga**

Add Icinga to the list of system services and have it automatically
start when the system boots (make sure you have installed the init
script before).

~~~~ {.programlisting}
 #> echo icinga_enable=\"YES\" >> /etc/rc.conf
~~~~

Verify the sample Icinga configuration files.

~~~~ {.programlisting}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
~~~~

If there are no errors, start Icinga.

~~~~ {.programlisting}
 #> /usr/local/etc/rc.d/icinga start
~~~~

**Login to the Classic Web Interface**

You should now be able to access the Icinga classic web interface at the
URL below. You'll be prompted for the username ( *icingaadmin*) and
password you specified earlier.

~~~~ {.programlisting}
 http://localhost/icinga/
~~~~

or

~~~~ {.programlisting}
 http://yourdomain.com/icinga/
~~~~

Click on the "Service Detail" navbar link to see details of what's being
monitored on your local machine. It will take a few minutes for Icinga
to check all the services associated with your machine.

**Other Modifications**

Make sure your system's firewall rules are configured to allow access to
the web server if you want to access the Icinga classic interface
remotely.

~~~~ {.programlisting}
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

* * * * *

  --------------------------------- -------------------- ---------------------------------------
  [Prev](quickstart-icinga.md)    [Up](ch02.md)       [Next](quickstart-idoutils.md)
  2.4. Icinga Quickstart            [Home](index.md)    2.6. Icinga with IDOUtils Quickstart
  --------------------------------- -------------------- ---------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
