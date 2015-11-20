[Prev](addons.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](nsca.md)

* * * * *

10.2. NRPE
----------

10.2.1. [Introduction](nrpe.md#introduction)

10.2.2. [Prerequisites](nrpe.md#prerequisites)

10.2.3. [Download](nrpe.md#download)

10.2.4. [Optional changes](nrpe.md#optionalchanges)

10.2.5. [Compile on the Icinga server](nrpe.md#compile)

10.2.6. [First test](nrpe.md#firsttest)

10.2.7. [Remote system(s)](nrpe.md#remotesystem)

10.2.8. [Prerequisites on the remote
host(s)](nrpe.md#prerequisitesremotehost)

10.2.9. [Second test](nrpe.md#secondtest)

10.2.10. [Installation on the remote host](nrpe.md#remotehostinstall)

10.2.11. [Third test](nrpe.md#thirdtest)

10.2.12. [Troubleshooting](nrpe.md#troubleshooting)

10.2.13. [Security](nrpe.md#security)

10.2.14. [Definition of local checks](nrpe.md#localcheckdefinition)

10.2.15. [Definitions on the Icinga
server](nrpe.md#icingaserverdefinitions)

10.2.16. [More Troubleshooting](nrpe.md#moretroubleshooting)

10.2.17. [Upgrading](nrpe.md#upgrading)

### 10.2.1. Introduction

Nagios Remote Plugin Executor (or NRPE for short) is an addon used to
execute plugins to monitor "local" resources on remote (Linux/Unix)
systems. Some resources cannot (or should not) be monitored via SNMP or
using other agents across the network so you have to check them using
programs installed locally on the machines to be monitored and transmit
the results back to the Icinga server. In contrast to NSCA this is done
actively, i.e. initiated by the Icinga server.

![[Note]](../images/note.png)

Note

Using [NSClient++](http://www.nsclient.org) instead of NRPE on the
remote host you can execute checks on Windows machines as well.

You can use *check\_by\_ssh* to execute plugins on remote machines but
there is a drawback to this approach. Setting up an SSH session consumes
CPU resources on both the local and the remote machine which may become
a performance issue if your are monitoring a lot of hosts and/or
services this way. Using NRPE is a bit less secure than SSH but in many
cases the performance may outweigh the security difference. SSL can be
actived though if you need a more secure connection.

**Figure 10.1. NRPE**

![NRPE](../images/nrpe.png)

\

*check\_nrpe* is a plugin executed by the local Icinga server like any
other plugin. It calls the NRPE process which is running as a daemon on
the remote machine. The daemon itself executes the plugin on the same
machine and transmits the information gathered back to the check\_nrpe
plugin which in turn delivers it to Icinga.

![[Note]](../images/note.png)

Note

Depending on the CPU / OS of the remote machine you may have to compile
NRPE and the plugins on several platforms.

Using NRPE you will mostly monitor resources located on the same machine
like CPU load, disk space, memory usage, processes running etc. but it
can also be used to check resources which may not be reachable directly
from the monitoring server itself. The machine running the NRPE daemon
is acting as a relay in this case.

**Figure 10.2. NRPE remote**

![NRPE remote](../images/nrpe_remote.png)

\

The following instructions are partially based on documentation found in
the original NRPE package by Ethan Galstad.

### 10.2.2. Prerequisites






### 10.2.3. Download

![[Note]](../images/note.png)

Note

Instead of installing NRPE from scratch you may want to use a package
which might be available for your OS.

If you are planning to install from source then please use the official
release tarball using something like

<pre><code>
 #> wget http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz -O nrpe.tgz
 #> tar xzf nrpe.tgz
</code></pre>

![[Important]](../images/important.png)

Important

Please don't use git snapshots unless you have an issue which might be
solved in the current developer version.

### 10.2.4. Optional changes

The maximum length of data to be transmitted is set to 2,048 bytes, the
maximal length of plugin output is set to 512 bytes. If that is not
sufficient then you have to alter the appropriate value in
`nrpe/include/common.h` (and recompile NRPE!)

<pre><code>
</code></pre>

Please keep in mind that you have to recompile the programs if you
change these values at a later stage.

Due to the setting of the following define in
`include/common.h` (in Icinga core) the max. value cannot
exceed 8,192 bytes.

<pre><code>
</code></pre>

### 10.2.5. Compile on the Icinga server

Change to the newly created directory and call configure and make

<pre><code>
 #> cd nrpe-2.15
 #> make all
 #> make install-plugin
</code></pre>

![[Note]](../images/note.png)

Note

If you want to use SSL at a later stage then you have to use
"`./configure --enable-ssl`" instead. There are other options
to specify the location of SSL files if they are not found
automatically.

If the user or group running the daemon deviate from "icinga" or the
port to be used is not the default 5666 you can use several options to
specify different values (`--with-nrpe-user=`\<user\>,
`--with-nrpe-group=`\<group\>,
`--with-nrpe-port=`\<port\>). For a complete list of the
options available call "`./configure -h`".
"`make install-plugin`" will copy `check_nrpe` to
the plugin directory.

![[Note]](../images/note.png)

Note

You may want to check if SSL is included using

### 10.2.6. First test

Startup the daemon and call the plugin

<pre><code>
 #> /usr/src/nrpe-2.15/src/nrpe -n \
 #> /usr/local/icinga/libexec/check_nrpe -H 127.0.0.1 -n
</code></pre>

This should return the version of NRPE. If you receive the message
"CHECK\_NRPE: Error receiving data from daemon" the monitoring server
was not found in `nrpe.cfg` (directive allowed\_hosts).
Multiple IP addresses are separated by commas.

Stop the daemon

<pre><code>
 #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
</code></pre>

### 10.2.7. Remote system(s)

The configuration and installation on the Icinga server is finished so
far. The second part has to be done on the remote host(s) running the
NRPE daemon which listens for incoming requests, executing them and
returning the results to the Icinga server.

### 10.2.8. Prerequisites on the remote host(s)









### 10.2.9. Second test

Startup the daemon on the remote host

<pre><code>
 #> /usr/src/nrpe-2.15/src/nrpe -n \
</code></pre>

and execute the plugin on the Icinga server once more, this time using
the IP address of the remote host

<pre><code>
 #> /usr/local/icinga/libexec/check_nrpe -H <IP remote host> -n
</code></pre>

This should return the version of NRPE. If you receive the message
"CHECK\_NRPE: Error receiving data from daemon" the specified host was
not found in `nrpe.cfg` (directive allowed\_hosts) on the
remote host.

Stop the daemon on the remote host

<pre><code>
 #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
</code></pre>

### 10.2.10. Installation on the remote host

Independent from the method the NRPE process is running on the remote
host you need a config file containing the commands to be called. You
install it issuing

<pre><code>
 #> make install-daemon-config
</code></pre>

There are two ways to run the nrpe process, one as a standalone daemon,
the other using xinetd (which is recommended).
























### 10.2.11. Third test

Switch to the Icinga server, change to the Icinga user and run another
test

<pre><code>
 $> /usr/local/icinga/libexec/check_nrpe -H <IP remote server>
</code></pre>

This should return the version of NRPE another time. If this test fails
then there is no sense in continuing. Instead verify the settings in
`nrpe.cfg/nrpe.xinet` on the remote server. Check for
messages in your syslog (e.g. `/var/log/messages`) on the
remote server as well.

### 10.2.12. Troubleshooting

Check that the nrpe process is running on the remote server

















Activate "debug=1" in `nrpe.cfg`, restart the daemon (if
applicable) and look for messages in the syslog / `nrpe.log`.

### 10.2.13. Security

Read the `SECURITY` file for more information on the security
risks of running NRPE, along with an explanation of what kind of
protection the encryption provides you.

### 10.2.14. Definition of local checks

Some things have been predefined in `etc/nrpe.cfg` on the
remote host

<pre><code>
 # command[<command_name>]=<command_line>
 command[check_users]=/usr/local/icinga/libexec/check_users -w 5 -c 10
 command[check_load]=/usr/local/icinga/libexec/check_load -w 1.5,1.1,0.9 -c 3.0,2.2,1.9
 command[check_hda1]=/usr/local/icinga/libexec/check_disk -w 20% -c 10% -p /dev/hda1
 command[check_zombie_procs]=/usr/local/icinga/libexec/check_procs -w 5 -c 10 -s Z
</code></pre>

The first line shows the general format

String

Description

command

tag showing that the following is a definition for a command

\<command\_name\>

link between the command definition on the Icinga server and the command
on the remote host

\<command\_line\>

call of the plugin including all necessary arguments

### 10.2.15. Definitions on the Icinga server

Now we switch over to the Icinga server to create some object
definitions. First add a command definition to your configuration
(unless you already have it). As usual the name of the config file is up
to you but most people have a file called `commands.cfg`.

<pre><code>
 define command{
</code></pre>

We assume that you already have a host definition like the following

<pre><code>
 define host{
</code></pre>

These example service definitions will use the sample commands shown
above.

The following service will monitor the number of currently logged in
users on the remote host

<pre><code>
 define service{
</code></pre>

"`check_nrpe`" is the link between the service directive
"`check_command`" and the directive "`command_name`"
in the command definition on the Icinga server. The
"`command_line`" in the command definition shows that
"`check_nrpe`" is called. "`check_users`" is passed
as the first argument. The nrpe process on the remote host takes this
argument and searches for an appropriate definition in
`nrpe.cfg`. The command is executed and the result is
transferred back to the check\_nrpe-plugin.

The following service will monitor the CPU load on the remote host

<pre><code>
 define service{
</code></pre>

The following service will monitor the free drive space on /dev/hda1 on
the remote host

<pre><code>
 define service{
</code></pre>

The following service will monitor the total number of processes on the
remote host

<pre><code>
 define service{
</code></pre>

The following service will monitor the number of zombie processes on the
remote host

<pre><code>
 define service{
</code></pre>

Restart Icinga to include the definitions in your running configuration

<pre><code>
 #> /etc/init.d/icinga restart
</code></pre>

After some time your plugins should have been called.

### 10.2.16. More Troubleshooting

Some errors during the initial setup have been mentioned already.
Unfortunately you may encounter others errors. Below you'll find hints
for some of the more common errors with the NRPE addon.





















If you still have problems then set "debug=1" in `nrpe.cfg`
on the remote host. Remember to restart the NRPE process if it is
running as a standalone daemon. Execute the check on the monitoring
server. Afterwards you should see debugging information in the syslog
(e.g. `/var/log/messages`) which might help resolving the
problem.

You might as well get help using one of the mailing lists or forums
([https://www.icinga.org/support/](http://www.icinga.org/support/)).

### 10.2.17. Upgrading











* * * * *

[Prev](addons.md) | [Up](ch10.md) | [Next](nsca.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
