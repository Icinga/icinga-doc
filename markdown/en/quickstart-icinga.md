[Prev](quickstart.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](quickstart-icinga-freebsd.md)

* * * * *

2.4. Icinga Quickstart
----------------------

2.4.1. [Introduction](quickstart-icinga.md#introduction)

2.4.2. [Prerequisites](quickstart-icinga.md#prerequisites)

2.4.3. [Install packages](quickstart-icinga.md#installpackages)

2.4.4. [Create Account
Information](quickstart-icinga.md#createaccount)

2.4.5. [Download Icinga and the
Plugins](quickstart-icinga.md#downloadicingaandplugins)

2.4.6. [Compile and install
Icinga](quickstart-icinga.md#compileinstall)

2.4.7. [Customise Configuration](quickstart-icinga.md#customiseconfig)

2.4.8. [Configure the Classic Web
Interface](quickstart-icinga.md#configclassicui)

2.4.9. [Compile and Install the Monitoring
Plugins](quickstart-icinga.md#compileinstallplugins)

2.4.10. [Adjusting the SELinux
settings](quickstart-icinga.md#selinuxsettings)

2.4.11. [Start Icinga](quickstart-icinga.md#starticinga)

2.4.12. [Login to the Classic Web
Interface](quickstart-icinga.md#loginclassicui)

2.4.13. [Other Modifications](quickstart-icinga.md#othermods)

2.4.14. [You're Done](quickstart-icinga.md#done)

### 2.4.1. Introduction

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

This guide will give you examples for currently three different Linux
distributions: [Fedora](http://fedoraproject.org/),
[Ubuntu](http://www.ubuntu.com/) and
[openSuSE](http://www.opensuse.org/). Similar distributions may work as
well. That should include [RedHat](http://www.redhat.com/),
[CentOS](http://www.centos.org/), [Debian](http://www.debian.org/) and
[SLES](http://www.novell.com/products/server/).

For instructions on how to install Icinga on FreeBSD please read [Icinga
on
FreeBSD](quickstart-icinga-freebsd.md "2.5. Icinga Quickstart FreeBSD")
instead.

Other distributions may inherit from these examples.

![[Important]](../images/important.png)

Important

If you are planning to use a database with IDOUtils, or wish to use the
new web interface then please read [Icinga with
IDOUtils](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")
instead!

**What You'll End Up With**

If you follow these instructions, here's what you'll end up with:




### 2.4.2. Prerequisites

During portions of the installation you'll need to have **root** access
to your machine.

Make sure you've installed the following packages on your system before
continuing.





**Optional**

At one time or another you may need to use SNMP-based checks so it is a
good idea to install the required packages now. Otherwise some plugins
are not compiled i.e. not available when you need them and it would
require a recompile of the plugins.

### 2.4.3. Install packages

You can install these packages by running the following commands (as
root or using `sudo`).

![[Note]](../images/note.png)

Note

Unfortunately sometimes the names of packages change between different
releases of the same distribution so if you get a message that one of
the packages cannot be found then please use the search option of your
package manager to get the new name:
























### 2.4.4. Create Account Information

Become the root user.

<pre><code>
 $> su -l
</code></pre>

Create a new *icinga* user account and give it a password:

<pre><code>
</code></pre>

On some distributions you'll need to add the group in a single step:

<pre><code>
 #> /usr/sbin/groupadd icinga
</code></pre>

For sending commands from the classic web interface to Icinga, you'll
need to create a new group icinga-cmd. Add the webuser and the Icinga
user to this group:

<pre><code>
 #> /usr/sbin/groupadd icinga-cmd
 #> /usr/sbin/usermod -a -G icinga-cmd icinga
 #> /usr/sbin/usermod -a -G icinga-cmd www-data
</code></pre>

(or www, wwwrun, apache, depending on the distribution)

![[Note]](../images/note.png)

Note

Some usermod-versions (e.g. in OpenSuSE 11 and SLES 11, resp.) are
lacking the option -a. In this case please omit the option -a.

![[Note]](../images/note.png)

Note

Solaris only supports groupnames with max. 8 characters, please use
icingcmd instead of icinga-cmd.

### 2.4.5. Download Icinga and the Plugins

Change to your local source directory i.e. /usr/src

<pre><code>
 #> cd /usr/src
</code></pre>

Get the current source from the [Icinga
Website](http://www.icinga.org/).

Don't forget to download the [Monitoring
Plugins](https://www.monitoring-plugins.org/).

### 2.4.6. Compile and install Icinga

Extract the Icinga source code tarball (or change directory to the GIT
snapshot)

<pre><code>
 #> cd /usr/src/
 #> tar xvzf icinga-1.13.tar.gz
 #> cd icinga-1.13
</code></pre>

Run the Icinga configure script. You will get help by using the --help
flag.

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the default has changed so you have to disable
the compilation of IDOUtils explicitly.

<pre><code>
 #> ./configure --with-command-group=icinga-cmd --disable-idoutils
</code></pre>

![[Note]](../images/note.png)

Note

Starting with Apache 2.4 the default web configuration folder changed
from `/etc/apache2/conf.d` to
`/etc/apache2/conf-available` so depending on your
distribution (testing versions of Debian / Ubuntu) you might have to add
this option to the call of configure

#> ./configure --with-httpd-conf=/etc/apache2/conf-available
</code></pre>

Current/upcoming distributions (RedHat/CentOS 7, Fedora 20, Debian
8/Jessie, Gentoo, etc.) support the usage of systemd instead of SysVinit
system.

Icinga 1.x already got the required systemd files patched into, and the
rpms natively install them. Installing from source may require the
following

#> ./configure [...] --with-systemd-unit-dir=/usr/lib/systemd/system --with-systemd-sysconfig-dir=/etc/sysconfig
#> make install-systemd
</code></pre>

Then enable the systemd service and start icinga.

#> systemctl enable icinga
#> systemctl start icinga
</code></pre>

Status

#> systemctl status icinga
</code></pre>

![[Note]](../images/note.png)

Note

There is no checkconfig/show-errors custom parameter in the systemd unit
available as known from SysVinit.

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
 #> make install-commandmode
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


### 2.4.7. Customise Configuration

Sample configuration files have been installed by using

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

### 2.4.8. Configure the Classic Web Interface

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

Install the Icinga Classic web config file in the Apache
`conf.d` directory (`conf-available` starting with
Apache 2.4).

<pre><code>
 #> make install-webconf
</code></pre>

![[Note]](../images/note.png)

Note

Starting with Icinga 1.9 the command 'make install-webconf-auth'
additionally installs the file `htpasswd.users` which
contains credentials for the user *icingaadmin* so you can skip the
following step. The password is *icingaadmin*.

![[Note]](../images/note.png)

Note

Starting with Apache 2.4 (testing versions of Debian / Ubuntu) you have
to enable the configuration

#> a2enconf icinga
</code></pre>

Enable the CGI module as well

#> a2enmod cgi
</code></pre>

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

![[Note]](../images/note.png)

Note

Depending on your distribution/Apache-version you may have to use
*htpasswd2* instead.

Reload/Restart Apache to make the new settings take effect.





### 2.4.9. Compile and Install the Monitoring Plugins

Extract the plugins source code tarball.

<pre><code>
 #> cd /usr/src
 #> tar xvzf nagios-plugins-2.1.tar.gz
</code></pre>

Compile and install the plugins by changing install directory to
/usr/local/icinga

<pre><code>
 #> ./configure \
 #> make
 #> make install
</code></pre>

### 2.4.10. Adjusting the SELinux settings

RHEL and derived distributions like Fedora and CentOS are shipped with
activated SELinux (Security Enhanced Linux) running in "enforcing" mode.
This may lead to "Internal Server Error" messages when you try to invoke
the Icinga-CGIs.

Check if SELinux runs in enforcing mode

 #> getenforce
</code></pre>

Set SELinux in "permissive" mode

 #> setenforce 0
</code></pre>

To make this change permanent you have to adjust this setting in
*/etc/selinux/config* and restart the system.

Instead of deactivating SELinux or setting it into permissive mode you
can use the following commands to run the CGIs in enforcing/targeted
mode. The *semanage* command will automatically add entries to
`/etc/selinux/targeted/contexts/files/file_contexts.local`.

<pre><code>
 #> semanage fcontext -a -t httpd_sys_script_exec_t '/usr/local/icinga/sbin(/.*)?'
 #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga/share(/.*)?'
 #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga/var(/.*)?'
</code></pre>

Once you have defined the necessary contexts you have to apply the
settings:

<pre><code>
 #> chcon -R /usr/local/icinga/sbin
 #> chcon -R /usr/local/icinga/share
 #> chcon -R /usr/local/icinga/var/rw
</code></pre>

For details please take a look at
[http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/).

### 2.4.11. Start Icinga

Add Icinga to the list of system services and have it automatically
start when the system boots (make sure you have installed the init
script before).















### 2.4.12. Login to the Classic Web Interface

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

### 2.4.13. Other Modifications

Make sure your system's firewall rules are configured to allow access to
the web server if you want to access the Icinga classic interface
remotely.

<pre><code>
 #> iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
</code></pre>

Setting up your mail transfer agent (MTA) like exim, sendmail or postfix
to allow Icinga sending notification emails won't be explained here.

### 2.4.14. You're Done

Congratulations! You successfully installed Icinga. Your journey into
monitoring has just begun.

You'll no doubt want to monitor more than just your local machine, so
check out the chapter on ["Getting
Started"](ch02.md "Chapter 2. Getting Started") about "Monitoring ..."

* * * * *

[Prev](quickstart.md) | [Up](ch02.md) | [Next](quickstart-icinga-freebsd.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
