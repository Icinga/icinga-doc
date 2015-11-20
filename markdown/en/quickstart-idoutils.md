[Prev](quickstart-icinga-freebsd.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](quickstart-idoutils-freebsd.md)

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





### 2.6.2. Prerequisites

During portions of the installation you'll need to have **root** access
to your machine.

Make sure you've installed the following packages on your system before
continuing. IDOUtils use the [libdbi](http://libdbi.sourceforge.net) and
the libdbi-drivers for several databases. The development libraries are
also required. The following examples will show how to install the
IDOUtils with the libdbi using MySQL or PostgreSQL.









**Optional**

At one time or another you may need to use SNMP-based checks so it is a
good idea to install the required packages now. Otherwise some plugins
are not compiled i.e. not available when you need them and it would
require a recompile of the plugins.

### 2.6.3. New features for the IDOUtils:



























### 2.6.4. Install Packages

You can install your packages by running the following commands (as root
or sudo).

![[Note]](../images/note.png)

Note

Unfortunately sometimes the names of packages change between different
releases of the same distribution so if you get a message that one of
the packages cannot be found then please use the search option of your
package manager to get the new name:






















































### 2.6.5. Create Account Information

Become the root user.

</code></pre> 
 $> su -l
</code></pre>

Create a new *Icinga* user account and give it a password.

</code></pre> 
</code></pre>

On some distributions you'll need to add the group in a single step:

</code></pre> 
 #> /usr/sbin/groupadd icinga
</code></pre>

For sending commands from the classic web interface to Icinga, you'll
need to create a new group icinga-cmd. Add the webuser and the
Icingauser to this group:

</code></pre> 
 #> /usr/sbin/groupadd icinga-cmd
 #> /usr/sbin/usermod -a -G icinga-cmd icinga
 #> /usr/sbin/usermod -a -G icinga-cmd www-data
</code></pre>

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

</code></pre> 
 #> cd /usr/src
</code></pre>

Get the current source from the [Icinga
Website](http://www.icinga.org/). Don't forget to download the
[Monitoring Plugins](https://www.monitoring-plugins.org).

### 2.6.7. Compile and Install Icinga with IDOUtils

Extract the Icinga source code tarball

</code></pre> 
 #> cd icinga-1.13
</code></pre>

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

</code></pre> 
 #> ./configure --with-command-group=icinga-cmd
</code></pre>

![[Note]](../images/note.png)

Note

Starting with Apache 2.4 the web configuration folder changed from
`/etc/apache2/conf.d` to
`/etc/apache2/conf-available` so depending on your
distribution (testing versions of Debian / Ubuntu ) you might have to
add this option to the call of configure

</code></pre> 
#> ./configure --with-httpd-conf=/etc/apache2/conf-available
</code></pre>

Also with PostgreSQL you should not use the argument --enable-pgsq
because it is not supported yet.

![[Important]](../images/important.png)

Important

Compiling on Solaris might fail upon unresolved library dependencies on
gethostbyname. In that case run this before running configure:

</code></pre> 
 #> export LIBS=-lsocket -lnsl
</code></pre>













### 2.6.8. Compile and Install

Compile the Icinga source code. There is also an extra option for
IDOUtils (*make idoutils*) if you need to recompile only this module. To
see available options, only use "make".

</code></pre> 
 #> make all
</code></pre>

Install binaries, init script, sample config files, some eventhandlers,
and set permissions on the external command directory.

</code></pre> 
 #> make install
 #> make install-init
 #> make install-config
 #> make install-eventhandlers
 #> make install-commandmode
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

Install IDOUtils and applicable event broker modules only using the
primary "make install" target. Do not manually copy and overwrite the
existing module as this will result in a segfault on icinga core which
is using `idomod.so` directly preventing usage of a temporary
copy explicitly. This is useful for [OMD.](http://omdistro.org/)


### 2.6.9. Customise Configuration

Sample configuration files have been installed by using "make
install-config" into `/usr/local/icinga/etc/`. You'll need to
make just one change before you proceed...

Edit the */usr/local/icinga/etc/objects/contacts.cfg* config file with
your favourite editor and change the email address associated with the
*icingaadmin* contact definition to the address you'd like to use for
receiving alerts.

</code></pre> 
 #> vi /usr/local/icinga/etc/objects/contacts.cfg
</code></pre>

</code></pre> 
 #> cd /usr/local/icinga/etc/
 #> mv idomod.cfg-sample idomod.cfg
 #> mv ido2db.cfg-sample ido2db.cfg
</code></pre>

If you want to enable SSL-encryption and you configured the IDOUtils
with ./configure --enable-ssl, you have to change idomod.cfg as follows:

<pre><code>
 use_ssl=1
 output_type=tcpsocket
 output=127.0.0.1
</code></pre>

(don't forget to adjust the ip-address if your database isn't located on
localhost) and ido2db.cfg in the following way:

<pre><code>
 use_ssl=1
</code></pre>

![[Note]](../images/note.png)

Note

configuration has to be the same on all nodes!!!

### 2.6.10. Enable the idomod event broker module

![[Important]](../images/important.png)

Important

Under normal circumstances the following module definition is already
present in the `modules` subdirectory so there is no need to
edit the main config file

<pre><code>
 define module{
</code></pre>

### 2.6.11. Creation of Database and IDOUtils

![[Note]](../images/note.png)

Note

If you just installed a new database system then you have to start the
database server before you can create a database. In case of MySQL you
might use `/etc/init.d/mysqld start` (or
`/etc/init.d/mysql`, depending on your distribution).





































### 2.6.12. Configure the Classic Web Interface

Icinga ships with the classic web interface ("the CGIs") which can be
installed via

</code></pre> 
 #> make cgis
 #> make install-cgis
 #> make install-html
</code></pre>

If you are interested in the new Icinga Web, please refer to [Install
Icinga Web
Interface](icinga-web-scratch.md "6.5. Installation of the Icinga Web Frontend").

Install the Icinga classic web config file in the Apache conf.d
directory.

</code></pre> 
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

</code></pre> 
#> a2enconf icinga
</code></pre>

Create an *icingaadmin* account for logging into the Icinga classic web
need it later.

</code></pre> 
 #> htpasswd -c /usr/local/icinga/etc/htpasswd.users icingaadmin
</code></pre>

To change the password of an existing user or to add a new user, take
this command:

</code></pre> 
 #> htpasswd /usr/local/icinga/etc/htpasswd.users <USERNAME>
</code></pre>

![[Note]](../images/note.png)

Note

Depending on your distribution/Apache-version you may have to use
*htpasswd2* instead.

Reload/Restart Apache to make the new settings take effect.







### 2.6.13. Compile and Install the Monitoring Plugins

Extract the plugins source code tarball.

</code></pre> 
</code></pre>

Compile and install the plugins by changing install directory to
`/usr/local/icinga`

</code></pre> 
 #> ./configure --prefix=/usr/local/icinga \
</code></pre>

### 2.6.14. Adjusting the SELinux settings

RHEL and derived distributions like Fedora and CentOS are shipped with
activated SELinux (Security Enhanced Linux) running in "enforcing" mode.
This may lead to "Internal Server Error" messages when you try to invoke
the Icinga-CGIs.

Check if SELinux runs in enforcing mode

</code></pre> 
 #> getenforce
</code></pre>

Set SELinux in "permissive" mode

</code></pre> 
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

### 2.6.15. Start IDOUtils and Icinga

IDOUtils must be started and running *before* Icinga is started.

*Start IDOUtils:*





*Stop IDOUtils:*





Verify the sample Icinga configuration files.

</code></pre> 
</code></pre>

If there are no errors, start Icinga.





### 2.6.16. Configure Icinga Startup

Add Icinga to the list of system services and have it automatically
start when the system boots (make sure you have installed the init
script before).





### 2.6.17. Login to the Classic Web Interface

You should now be able to access the Icinga classic web interface at the
URL below. You'll be prompted for the username ( *icingaadmin* ) and
password you specified earlier.

</code></pre> 
 http://localhost/icinga/
</code></pre>

or

</code></pre> 
</code></pre>

Click on the "Service Detail" navbar link to see details of what's being
monitored on your local machine. It will take a few minutes for Icinga
to check all the services associated with your machine.

### 2.6.18. Other Modifications

Make sure your system's firewall rules are configured to allow access to
the web server if you want to access the Icinga classic interface
remotely.

</code></pre> 
 #> iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
</code></pre>

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

[Prev](quickstart-icinga-freebsd.md) | [Up](ch02.md) | [Next](quickstart-idoutils-freebsd.md)

2.5. Icinga Quickstart FreeBSD  |<=== [Index](index.md) ===>|  2.7. Icinga and IDOUtils Quickstart on FreeBSD

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
