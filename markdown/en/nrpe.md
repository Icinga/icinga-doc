![Icinga](../images/logofullsize.png "Icinga")

10.2. NRPE

[Prev](addons.md) 

Chapter 10. Additional software

 [Next](nsca.md)

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

-   Icinga should be up and running on the monitoring server

-   a C-compiler (like gcc) is installed on the local host. If not:

    ~~~~ {.programlisting}
     #> yum install gcc       # RHEL / Fedora / CentOS
     #> apt-get install gcc   # Debian / Ubuntu
     #> zypper install gcc    # SLES / openSuSE (or use YaST instead)
    ~~~~

-   openssl is (optionally) installed on both the local host. If not:

    ~~~~ {.programlisting}
     #> yum install openssl openssl-devel       # RHEL / Fedora / CentOS
     #> apt-get install openssl openssl-devel   # Debian / Ubuntu
     #> zypper install openssl openssl-devel    # SLES / openSuSE (or use YaST instead)
    ~~~~

### 10.2.3. Download

![[Note]](../images/note.png)

Note

Instead of installing NRPE from scratch you may want to use a package
which might be available for your OS.

If you are planning to install from source then please use the official
release tarball using something like

~~~~ {.programlisting}
 #> wget http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz -O nrpe.tgz
 #> tar xzf nrpe.tgz
~~~~

![[Important]](../images/important.png)

Important

Please don't use git snapshots unless you have an issue which might be
solved in the current developer version.

### 10.2.4. Optional changes

The maximum length of data to be transmitted is set to 2,048 bytes, the
maximal length of plugin output is set to 512 bytes. If that is not
sufficient then you have to alter the appropriate value in
`nrpe/include/common.h`{.filename} (and recompile NRPE!)

~~~~ {.programlisting}
 #define MAX_INPUT_BUFFER        2048    /* max size of most buffers we use */
 #define MAX_PLUGINOUTPUT_LENGTH 512 
~~~~

Please keep in mind that you have to recompile the programs if you
change these values at a later stage.

Due to the setting of the following define in
`include/common.h`{.filename} (in Icinga core) the max. value cannot
exceed 8,192 bytes.

~~~~ {.programlisting}
 #define MAX_EXTERNAL_COMMAND_LENGTH     8192   /* max length of an external command */
~~~~

### 10.2.5. Compile on the Icinga server

Change to the newly created directory and call configure and make

~~~~ {.programlisting}
 #> cd nrpe-2.15
 #> ./configure 
 #> make all
 #> make install-plugin
~~~~

![[Note]](../images/note.png)

Note

If you want to use SSL at a later stage then you have to use
"`./configure --enable-ssl`{.literal}" instead. There are other options
to specify the location of SSL files if they are not found
automatically.

If the user or group running the daemon deviate from "icinga" or the
port to be used is not the default 5666 you can use several options to
specify different values (`--with-nrpe-user=`{.literal}\<user\>,
`--with-nrpe-group=`{.literal}\<group\>,
`--with-nrpe-port=`{.literal}\<port\>). For a complete list of the
options available call "`./configure -h`{.literal}".
"`make install-plugin`{.literal}" will copy `check_nrpe`{.filename} to
the plugin directory.

![[Note]](../images/note.png)

Note

You may want to check if SSL is included using
"`ldd src/check_nrpe`{.literal}" and "`ldd         src/nrpe`{.literal}".

### 10.2.6. First test

Startup the daemon and call the plugin

~~~~ {.programlisting}
 #> /usr/src/nrpe-2.15/src/nrpe -n \
    -c /usr/src/nrpe-2.15/sample-config/nrpe.cfg -d
 #> /usr/local/icinga/libexec/check_nrpe -H 127.0.0.1 -n
~~~~

This should return the version of NRPE. If you receive the message
"CHECK\_NRPE: Error receiving data from daemon" the monitoring server
was not found in `nrpe.cfg`{.filename} (directive allowed\_hosts).
Multiple IP addresses are separated by commas.

Stop the daemon

~~~~ {.programlisting}
 #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
~~~~

### 10.2.7. Remote system(s)

The configuration and installation on the Icinga server is finished so
far. The second part has to be done on the remote host(s) running the
NRPE daemon which listens for incoming requests, executing them and
returning the results to the Icinga server.

### 10.2.8. Prerequisites on the remote host(s)

-   Make sure that the necessary plugins are available. Take a look at
    the [quickstart
    guide](quickstart-icinga.md "2.4. Icinga Quickstart") if you are
    unsure on how to install them.

-   You can copy the folder `nrpe-2.15`{.filename} including the
    sub-directories from the Icinga server. One way would be

    ~~~~ {.programlisting}
     #> cd /usr/src/
     #> scp -pr <Icinga-server>:/$PWD/nrpe-2.15 .
    ~~~~

    ![[Note]](../images/note.png)

    Note

    If the architecture of your remote host differs from your Icinga
    server you will have to recompile the sources. This is true if you
    are using different CPUs (i386/Itanium/PA-RISC/...) and/or different
    OS versions (32-Bit/64-Bit). If this is the case then you have to
    install a C-Compiler and OpenSSL (if you want to use SSL) before you
    can start to compile.

    ~~~~ {.programlisting}
     #> cd nrpe-2.15
     #> make distclean
     #> ./configure     # please use the same options as on the Icinga server 
     #> make all
    ~~~~

    Edit the config file `sample-config/nrpe.cfg`{.filename} and change
    the setting of "allowed\_hosts=\<IP address\>" to the IP address of
    your Icinga server. Multiple IP addresses are separated by commas.

### 10.2.9. Second test

Startup the daemon on the remote host

~~~~ {.programlisting}
 #> /usr/src/nrpe-2.15/src/nrpe -n \
    -c /usr/src/nrpe-2.15/sample-config/nrpe.cfg -d
~~~~

and execute the plugin on the Icinga server once more, this time using
the IP address of the remote host

~~~~ {.programlisting}
 #> /usr/local/icinga/libexec/check_nrpe -H <IP remote host> -n
~~~~

This should return the version of NRPE. If you receive the message
"CHECK\_NRPE: Error receiving data from daemon" the specified host was
not found in `nrpe.cfg`{.filename} (directive allowed\_hosts) on the
remote host.

Stop the daemon on the remote host

~~~~ {.programlisting}
 #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
~~~~

### 10.2.10. Installation on the remote host

Independent from the method the NRPE process is running on the remote
host you need a config file containing the commands to be called. You
install it issuing

~~~~ {.programlisting}
 #> make install-daemon-config
~~~~

There are two ways to run the nrpe process, one as a standalone daemon,
the other using xinetd (which is recommended).

-   **nrpe daemon**

    First install the daemon

    ~~~~ {.programlisting}
     #> make install-daemon
    ~~~~

    If you choose to use xinetd the daemon will be started
    automatically. Otherwise you have to start the daemon manually

    ~~~~ {.programlisting}
     #> /usr/local/icinga/bin/nrpe -c /usr/local/icinga/etc/nrpe.cfg
    ~~~~

-   **inetd/xinetd**

    If you want the daemon to be started by (x)inetd you have to extend
    /etc/services, alter/copy another file and restart (x)inetd. If the
    package is not installed then please do the following

    ~~~~ {.programlisting}
     #> yum install xinetd       # RHEL / Fedora / CentOS
     #> apt-get install xinetd   # Debian / Ubuntu
     #> zypper install xinetd    # SLES / openSuSE (or use YaST instead)
    ~~~~

    ![[Note]](../images/note.png)

    Note

    The setting of "server\_port" specified in `nrpe.cfg`{.filename} is
    ignored when you use inetd/xinetd.

    ~~~~ {.programlisting}
     #> echo "nrpe 5666/tcp # nrpe" >> /etc/services
    ~~~~

    Depending on the superserver which is installed on your system there
    are three alternatives

    -   inetd WITH tcpwrappers

        Add entries to your `/etc/hosts.allow`{.filename} and
        `/etc/hosts.deny`{.filename} file to enable TCP wrapper
        protection for the nrpe service. This is optional, although
        highly recommended. Add
        "`nrpe stream tcp nowait             `{.literal}\<user\>
        `/usr/sbin/tcpd `{.literal}\<nrpe-binary\>` -c `{.literal}\<nrpe-cfg\>`             --inetd`{.literal}"
        to `/etc/inetd.conf`{.filename}, e.g.

        ~~~~ {.programlisting}
         #> echo "nrpe stream tcp nowait icinga /usr/sbin/tcpd /usr/local/icinga/bin/nrpe \
            -c /usr/local/icinga/etc/nrpe.cfg --inetd" >> /etc/inetd.conf
         #> /etc/init.d/inetd restart
        ~~~~

    -   inetd WITHOUT tcpwrappers

        Add "`nrpe stream tcp nowait `{.literal}\<user\>
        \<nrpe-binary\>` -c             `{.literal}\<nrpe-cfg\>` --inetd`{.literal}"
        to `/etc/inetd.conf`{.filename}, e.g.

        ~~~~ {.programlisting}
         #> echo "nrpe stream tcp nowait icinga /usr/local/icinga/bin/nrpe \
            -c /usr/local/icinga/etc/nrpe.cfg --inetd" >> /etc/inetd.conf
         #> /etc/init.d/inetd restart
        ~~~~

    -   xinetd (recommended)

        Consider editing the config file `nrpe.xinetd`{.filename} in the
        `sample-config`{.filename} folder and replacing the address
        following \<only\_from\> by the IP address of the Icinga server
        (where check\_nrpe will be running). Multiple IP addresses are
        separated by spaces.

        Add entries to your `/etc/hosts.allow`{.filename} and
        `/etc/hosts.deny`{.filename} file to enable TCP wrapper
        protection for the nrpe service. This is optional, although
        highly recommended. Copy the file to your xinetd folder and
        restart the xinetd process

        ~~~~ {.programlisting}
         #> make install-xinetd
         #> /etc/init.d/xinetd restart
        ~~~~

### 10.2.11. Third test

Switch to the Icinga server, change to the Icinga user and run another
test

~~~~ {.programlisting}
 #> su - icinga
 $> /usr/local/icinga/libexec/check_nrpe -H <IP remote server>
~~~~

This should return the version of NRPE another time. If this test fails
then there is no sense in continuing. Instead verify the settings in
`nrpe.cfg/nrpe.xinet`{.filename} on the remote server. Check for
messages in your syslog (e.g. `/var/log/messages`{.filename}) on the
remote server as well.

### 10.2.12. Troubleshooting

Check that the nrpe process is running on the remote server

-   when installed as standalone daemon

    ~~~~ {.programlisting}
     #> ps -ef | grep -v grep | grep nrpe
    ~~~~

    If not, then

    -   start it as mentioned above

    -   check that the file `/usr/local/icinga/etc/nrpe.cfg`{.filename}
        is present

    -   the *allowed\_hosts* directive in the file
        `/usr/local/icinga/etc/nrpe.cfg`{.filename} contains an entry
        for the IP address of the Icinga server. Multiple IP addresses
        are separated by commas.

-   when installed using xinetd

    ~~~~ {.programlisting}
     #> netstat -at | grep -v grep | grep nrpe
    ~~~~

    The output should be showing something like

    ~~~~ {.programlisting}
     tcp 0 0 *:nrpe *:* LISTEN
    ~~~~

    If not then verify that

    -   you added the nrpe entry to your /etc/services file

    -   the file `/etc/xinetd.d/nrpe`{.filename} is present

    -   the *only\_from* directive in the file
        `/etc/xinetd.d/nrpe`{.filename} contains an entry for the IP
        address of the Icinga server. Multiple IP addresses are
        separated by spaces.

    -   xinetd is installed and started

    -   the system log files don't show any errors about xinetd and/or
        nrpe and fix any problems that are reported

Activate "debug=1" in `nrpe.cfg`{.filename}, restart the daemon (if
applicable) and look for messages in the syslog / `nrpe.log`{.literal}.

### 10.2.13. Security

Read the `SECURITY`{.filename} file for more information on the security
risks of running NRPE, along with an explanation of what kind of
protection the encryption provides you.

### 10.2.14. Definition of local checks

Some things have been predefined in `etc/nrpe.cfg`{.filename} on the
remote host

~~~~ {.programlisting}
 # command[<command_name>]=<command_line>
 command[check_users]=/usr/local/icinga/libexec/check_users -w 5 -c 10
 command[check_load]=/usr/local/icinga/libexec/check_load -w 1.5,1.1,0.9 -c 3.0,2.2,1.9
 command[check_hda1]=/usr/local/icinga/libexec/check_disk -w 20% -c 10% -p /dev/hda1
 command[check_zombie_procs]=/usr/local/icinga/libexec/check_procs -w 5 -c 10 -s Z
 command[check_total_procs]=/usr/local/icinga/libexec/check_procs -w 150 -c 200 
~~~~

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
to you but most people have a file called `commands.cfg`{.filename}.

~~~~ {.programlisting}
 define command{
    command_name        check_nrpe
    command_line        $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
   }
~~~~

We assume that you already have a host definition like the following

~~~~ {.programlisting}
 define host{
    use                 generic-host     ; Inherit default values from a template
    host_name           remotehost       ; The name we're giving to this server
    alias               Linux Host       ; A longer name for the server
    address             192.168.0.1      ; IP address of the server
    }
~~~~

These example service definitions will use the sample commands shown
above.

The following service will monitor the number of currently logged in
users on the remote host

~~~~ {.programlisting}
 define service{
    use                 generic-service
    host_name           remotehost
    service_description Current Users
    check_command       check_nrpe!check_users
    }
~~~~

"`check_nrpe`{.literal}" is the link between the service directive
"`check_command`{.literal}" and the directive "`command_name`{.literal}"
in the command definition on the Icinga server. The
"`command_line`{.literal}" in the command definition shows that
"`check_nrpe`{.literal}" is called. "`check_users`{.literal}" is passed
as the first argument. The nrpe process on the remote host takes this
argument and searches for an appropriate definition in
`nrpe.cfg`{.filename}. The command is executed and the result is
transferred back to the check\_nrpe-plugin.

The following service will monitor the CPU load on the remote host

~~~~ {.programlisting}
 define service{
    use                 generic-service
    host_name           remotehost
    service_description CPU Load
    check_command       check_nrpe!check_load
    }
~~~~

The following service will monitor the free drive space on /dev/hda1 on
the remote host

~~~~ {.programlisting}
 define service{
    use                 generic-service
    host_name           remotehost
    service_description /dev/hda1 Free Space
    check_command       check_nrpe!check_hda1
    }
~~~~

The following service will monitor the total number of processes on the
remote host

~~~~ {.programlisting}
 define service{
    use                 generic-service
    host_name           remotehost
    service_description Total Processes
    check_command       check_nrpe!check_total_procs
    }
~~~~

The following service will monitor the number of zombie processes on the
remote host

~~~~ {.programlisting}
 define service{
    use                 generic-service
    host_name           remotehost
    service_description Zombie Processes
    check_command       check_nrpe!check_zombie_procs
    }
~~~~

Restart Icinga to include the definitions in your running configuration

~~~~ {.programlisting}
 #> /etc/init.d/icinga restart
~~~~

After some time your plugins should have been called.

### 10.2.16. More Troubleshooting

Some errors during the initial setup have been mentioned already.
Unfortunately you may encounter others errors. Below you'll find hints
for some of the more common errors with the NRPE addon.

-   "NRPE: Command timed out after x seconds"

    The command that was run by the NRPE daemon did not finish executing
    within the specified time. You can increase the timeout for commands
    by editing the NRPE configuration file and changing the value of the
    command\_timeout variable. Use the -t command line option to specify
    a longer timeout for the check\_nrpe plugin. The following example
    will increase the timeout to 30 seconds:

    ~~~~ {.programlisting}
     /usr/local/icinga/libexec/check_nrpe -H localhost -c somecommand -t 30
    ~~~~

    If you're running the NRPE daemon as a standalone daemon (and not
    under inetd or xinetd), you'll need to restart it in order for the
    new timeout to be recognised.

-   "Connection refused or timed out"

    This error can indicate several things:

    -   There is a firewall that is blocking the communication between
        the monitoring host (which runs the check\_nrpe plugin) and the
        remote host (which runs the NRPE daemon). Verify that the
        firewall rules (e.g. iptables) that are running on the remote
        host allow for communication and make sure there isn't a
        physical firewall that is located between the monitoring host
        and the remote host.

    -   If you are using the standalone daemon: The IP address specified
        in `nrpe.cfg`{.filename} (allowed\_hosts=...) on the remote
        server doesn't match the IP address of the monitoring server. If
        it does then you might have forgotten to restart the daemon
        after the last change.

    -   If you are using the xinetd version: The IP address specified in
        `/etc/xinetd.d/nrpe`{.filename} (only\_from=...) on the remote
        server doesn't match the IP address of the monitoring server. If
        it does then you might have forgotten to restart the xinetd
        process after the last change.

    -   The NRPE daemon is not installed or running on the remote host.
        Verify that the NRPE daemon is running as a standalone daemon or
        under inetd/xinetd with one of the following commands:

        ~~~~ {.programlisting}
         ps axuw | grep nrpe       # if run as standalone daemon
         netstat -at | grep nrpe   # if run via xinetd
        ~~~~

-   "CHECK\_NRPE: Received 0 bytes from daemon. Check the remote server
    logs for an error message."

    First thing you should do is check the remote server logs for an
    error message. Seriously. :-) This error could be due to the
    following problem:

    -   The check\_nrpe plugin was unable to complete an SSL handshake
        with the NRPE daemon. An error message in the logs should
        indicate whether or not this was the case. Check the versions of
        OpenSSL that are installed on the monitoring host and remote
        host. If you're running a commercial version of SSL on the
        remote host, there might be some compatibility problems.

-   "NRPE: Unable to read output"

    This error indicates that the command that was run by the NRPE
    daemon did not return any character output. This could be an
    indication of the following problems:

    -   The path of the plugin to be run is incorrect on the remote
        host. If you change the definition in `nrpe.cfg`{.filename},
        remember to restart the daemon.

    -   The plugin that is specified in the command line is
        malfunctioning. Run the command line manually to make sure the
        plugin returns some kind of text output. DON'T run the command
        as root!

-   "NRPE: Command 'x' not defined"

    The command 'x' was not defined in the NRPE configuration file on
    the remote host. Please add the command definition for x. See the
    existing command definitions in the NRPE configuration file for more
    information on doing this. If you're running the NRPE daemon as a
    standalone daemon (and not under inetd or xinetd), you'll need to
    restart it in order for the new command to be recognised.

If you still have problems then set "debug=1" in `nrpe.cfg`{.filename}
on the remote host. Remember to restart the NRPE process if it is
running as a standalone daemon. Execute the check on the monitoring
server. Afterwards you should see debugging information in the syslog
(e.g. `/var/log/messages`{.filename}) which might help resolving the
problem.

You might as well get help using one of the mailing lists or forums
([https://www.icinga.org/support/](http://www.icinga.org/support/)).

### 10.2.17. Upgrading

-   Upgrading the Icinga server

    Download the software

    ~~~~ {.programlisting}
     #> cd /usr/src
     #> wget "http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz" -O nrpe.tgz
     #> tar xzf nrpe.tgz
    ~~~~

    Then compile the software and install the plugin

    ~~~~ {.programlisting}
     #> cd nrpe-2.15
     #> make distclean
     #> ./configure     # use the same options as during the first run
     #> make all
     #> make install-plugin
    ~~~~

-   Upgrading the remote host

    Download the software

    ~~~~ {.programlisting}
     #> cd /usr/src
     #> wget "http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz" -O nrpe.tgz
     #> tar xzf nrpe.tgz
    ~~~~

    Then compile the software and install the daemon process

    ~~~~ {.programlisting}
     #> cd nrpe-2.15
     #> make distclean
     #> ./configure     # use the same options as during the first run
     #> make all
     ### kill the process if running as standalone daemon
     #> kill `ps -ef | grep "sample-config/nrpe.cfg" | grep -v grep | awk '{print $2}'`
     #> make install-daemon
     ### start the daemon if running as standalone daemon
     #> /usr/src/nrpe/src/nrpe -n \
        -c /usr/src/inrpe/sample-config/nrpe.cfg -d
    ~~~~

* * * * *

  ---------------------- -------------------- --------------------
  [Prev](addons.md)    [Up](ch10.md)       [Next](nsca.md)
  10.1. Icinga Addons    [Home](index.md)    10.3. NSCA
  ---------------------- -------------------- --------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
