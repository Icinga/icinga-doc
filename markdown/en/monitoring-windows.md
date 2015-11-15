![Icinga](../images/logofullsize.png "Icinga")

2.13. Monitoring Windows Machines

[Prev](monitoring-overview.md) 

Chapter 2. Getting Started

 [Next](monitoring-linux.md)

* * * * *

2.13. Monitoring Windows Machines
---------------------------------

2.13.1. [Introduction](monitoring-windows.md#introduction_win)

2.13.2. [Overview](monitoring-windows.md#overview)

2.13.3. [Steps](monitoring-windows.md#steps)

2.13.4. [What's Already Done For You](monitoring-windows.md#whatsdone)

2.13.5. [Prerequisites](monitoring-windows.md#prequisites)

2.13.6. [Installing the Windows
Agent](monitoring-windows.md#installwindowsagent)

2.13.7. [Configuring Icinga](monitoring-windows.md#configicinga)

2.13.8. [Password Protection](monitoring-windows.md#passwordprotect)

2.13.9. [Restarting Icinga](monitoring-windows.md#restarticinga)

2.13.10. [Troubleshooting](monitoring-windows.md#troubleshooting)

### 2.13.1. Introduction

This document describes how you can monitor "private" services and
attributes of Windows machines, such as:

-   Memory usage

-   CPU load

-   Disk usage

-   Service states

-   Running processes

-   etc.

Publicly available services that are provided by Windows machines (HTTP,
FTP, POP3, etc.) can be monitored easily by following the documentation
on [monitoring publicly available
services](monitoring-publicservices.md "2.18. Monitoring Publicly Available Services").

![[Note]](../images/note.png)

Note

These instructions assume that you've installed Icinga according to the
[quickstart
guide](quickstart.md "2.3. Quickstart Installation Guides"). The
sample configuration entries below reference objects that are defined in
the sample config files (*commands.cfg*, *templates.cfg*, etc.) that are
installed if you follow the quickstart.

If you installed a package then the sample files might be missing. The
contents is listed
[here](sample-config.md "13.1. Sample configuration files and definitions")
for reference.

### 2.13.2. Overview

![](../images/monitoring-windows.png)

Monitoring private services or attributes of a Windows machine requires
that you install an agent on it. This agent acts as a proxy between the
Icinga plugin that does the monitoring and the actual service or
attribute of the Windows machine. Without installing an agent on the
Windows box, Icinga would be unable to monitor private services or
attributes of the Windows box.

For this example, we will be installing the
[NSClient++](http://sourceforge.net/projects/nscplus) addon on the
Windows machine and using the *check\_nt* plugin to communicate with the
NSClient++ addon. The *check\_nt* plugin should already be installed on
the Icinga server if you followed the quickstart guide.

Other Windows agents (like
[NC\_Net](http://sourceforge.net/projects/nc-net)) could be used instead
of NSClient++ if you wish - provided you change command and service
definitions, etc. a bit. For the sake of simplicity we will only cover
using the NSClient++ addon in these instructions.

### 2.13.3. Steps

There are several steps you'll need to follow in order to monitor a new
Windows machine. They are:

1.  Perform first-time prerequisites

2.  Install a monitoring agent on the Windows machine

3.  Create new host and service definitions for monitoring the Windows
    machine

4.  Restart the Icinga daemon

### 2.13.4. What's Already Done For You

To make your life a bit easier, a few configuration tasks have already
been done for you:

-   A *check\_nt* command definition has been added to the
    *commands.cfg* file. This allows you to use the *check\_nt* plugin
    to monitor Window services.

-   A Windows server host template (called *windows-server*) has already
    been created in the *templates.cfg* file. This allows you to add new
    Windows host definitions in a simple manner.

The above-mentioned config files can be found in the
*/usr/local/icinga/etc/objects/* directory. You can modify the
definitions in these and other definitions to suit your needs better if
you'd like. However, we'd recommend waiting until you're more familiar
with configuring Icinga before doing so. For the time being, just follow
the directions outlined below and you'll be monitoring your Windows
boxes in no time.

### 2.13.5. Prerequisites

The first time you configure Icinga to monitor a Windows machine, you'll
need to do a bit of extra work. Remember, you only need to do this for
the \*first\* Windows machine you monitor.

Edit the main Icinga config file.

~~~~ {.screen}
#> vi /usr/local/icinga/etc/icinga.cfg
~~~~

Remove the leading hash (\#) sign from the following line in the main
configuration file:

~~~~ {.programlisting}
 #cfg_file=/usr/local/icinga/etc/objects/windows.cfg
~~~~

Save the file and exit.

What did you just do? You told Icinga to look to the
*/usr/local/icinga/etc/objects/windows.cfg* to find additional object
definitions. That's where you'll be adding Windows host and service
definitions. That configuration file already contains some sample host,
hostgroup, and service definitions. For the \*first\* Windows machine
you monitor, you can simply modify the sample host and service
definitions in that file, rather than creating new ones.

### 2.13.6. Installing the Windows Agent

Before you can begin monitoring private services and attributes of
Windows machines, you'll need to install an agent on those machines. We
recommend using the NSClient++ addon, which can be found at
[http://sourceforge.net/projects/nscplus](http://sourceforge.net/projects/nscplus).
These instructions will take you through a basic installation of the
NSClient++ addon, as well as the configuration of Icinga for monitoring
the Windows machine.

​1. Download the latest stable version of the NSClient++ addon from
[http://sourceforge.net/projects/nscplus](http://sourceforge.net/projects/nscplus)

​2. Unzip the NSClient++ files into a new C:\\NSClient++ directory

​3. Open a command prompt and change to the C:\\NSClient++ directory

​4. Register the NSClient++ system service with the following command:

~~~~ {.screen}
 nsclient++ /install
~~~~

​5. Open the services manager and make sure the NSClientpp service is
allowed to interact with the desktop (see the 'Log On' tab of the
services manager). If it isn't already allowed to interact with the
desktop, check the box to allow it to.

![](../images/nscpp.png)

​6. Edit the NSC.INI file (located in the C:\\NSClient++ directory) and
make the following changes:

-   Uncomment all the modules listed in the [modules] section, except
    for CheckWMI.dll and RemoteConfiguration.dll

-   Optionally require a password for clients by changing the 'password'
    option in the [Settings] section.

-   Uncomment the 'allowed\_hosts' option in the [Settings] section. Add
    the IP address of the Icinga server to this line, ip.add.ress/bits
    for a range or leave it blank to allow all hosts to connect.

-   Make sure the 'port' option in the [NSClient] section is uncommented
    and set to '12489' (the default port).

​7. Start the NSClient++ service with the following command:

~~~~ {.screen}
 nsclient++ /start
~~~~

​8. Success! The Windows server can now be added to the Icinga
monitoring configuration...

### 2.13.7. Configuring Icinga

Now it's time to define some [object
definitions](objectdefinitions.md "3.4. Object Definitions") in your
Icinga configuration files in order to monitor the new Windows machine.

Open the *windows.cfg* file for editing.

~~~~ {.screen}
#> vi /usr/local/icinga/etc/objects/windows.cfg
~~~~

Add a new [host](objectdefinitions.md#objectdefinitions-host)
definition for the Windows machine that you're going to monitor. If this
is the \*first\* Windows machine you're monitoring, you can simply
modify the sample host definition in *windows.cfg*. Change the
*host\_name*, *alias*, and *address* fields to appropriate values for
the Windows box.

~~~~ {.programlisting}
 define host{
        ; Inherit default values from a Windows server template
        use             windows-server   ; make sure you keep this line!
        host_name       winserver
        alias           My Windows Server
        address         192.168.1.2
        }
~~~~

Good. Now you can add some service definitions (to the same
configuration file) in order to tell Icinga to monitor different aspects
of the Windows machine. If this is the \*first\* Windows machine you're
monitoring, you can simply modify the sample service definitions in
*windows.cfg*.

![[Note]](../images/note.png)

Note

Replace "*winserver*" in the example definitions below with the name you
specified in the *host\_name* directive of the host definition you just
added.

Add the following service definition to monitor the version of the
NSClient++ addon that is running on the Windows server. This is useful
when it comes time to upgrade your Windows servers to a newer version of
the addon, as you'll be able to tell which Windows machines still need
to be upgraded to the latest version of NSClient++.

~~~~ {.programlisting}
 define service{
        use                     generic-service
        host_name               winserver
        service_description     NSClient++ Version
        check_command           check_nt!CLIENTVERSION
        }
~~~~

Add the following service definition to monitor the uptime of the
Windows server.

~~~~ {.programlisting}
 define service{
        use                     generic-service
        host_name               winserver
        service_description     Uptime
        check_command           check_nt!UPTIME
        }
~~~~

Add the following service definition to monitor the CPU utilization on
the Windows server and generate a CRITICAL alert if the 5-minute CPU
load is 90% or more or a WARNING alert if the 5-minute load is 80% or
greater.

~~~~ {.programlisting}
 define service{
        use                     generic-service
        host_name               winserver
        service_description     CPU Load
        check_command           check_nt!CPULOAD!-l 5,80,90
        }
~~~~

Add the following service definition to monitor memory usage on the
Windows server and generate a CRITICAL alert if memory usage is 90% or
more or a WARNING alert if memory usage is 80% or greater.

~~~~ {.programlisting}
 define service{
        use                     generic-service
        host_name               winserver
        service_description     Memory Usage
        check_command           check_nt!MEMUSE!-w 80 -c 90
        }
~~~~

Add the following service definition to monitor usage of the C:\\ drive
on the Windows server and generate a CRITICAL alert if disk usage is 90%
or more or a WARNING alert if disk usage is 80% or greater.

~~~~ {.programlisting}
 define service{
        use                     generic-service
        host_name               winserver
        service_description     C:\ Drive Space
        check_command           check_nt!USEDDISKSPACE!-l c -w 80 -c 90
        }
~~~~

Add the following service definition to monitor the W3SVC service state
on the Windows machine and generate a CRITICAL alert if the service is
stopped.

~~~~ {.programlisting}
 define service{
        use                     generic-service
        host_name               winserver
        service_description     W3SVC
        check_command           check_nt!SERVICESTATE!-d SHOWALL -l W3SVC
        }
~~~~

Add the following service definition to monitor the Explorer.exe process
on the Windows machine and generate a CRITICAL alert if the process is
not running.

~~~~ {.programlisting}
 define service{
        use                     generic-service
        host_name               winserver
        service_description     Explorer
        check_command           check_nt!PROCSTATE!-d SHOWALL -l Explorer.exe
        }
~~~~

![[Note]](../images/note.png)

Note

Well. To be honest it would be pretty dumb to monitor if the explorer is
running but it's quite easy to test if it works like expected ;-).

That's it for now. You've added some basic services that should be
monitored on the Windows box. Save the configuration file.

### 2.13.8. Password Protection

If you specified a password in the NSClient++ configuration file on the
Windows machine, you'll need to modify the *check\_nt* command
definition to include the password. Open the *commands.cfg* file for
editing.

~~~~ {.screen}
 #> vi /usr/local/icinga/etc/objects/commands.cfg
~~~~

Change the definition of the *check\_nt* command to include the "-s
PASSWORD" argument (where PASSWORD may be the password you specified on
the Windows machine) like this:

~~~~ {.programlisting}
 define command{
        command_name    check_nt
        command_line    $USER1$/check_nt -H $HOSTADDRESS$ -p 12489 -s $USER9$ -v $ARG1$ $ARG2$
        }
~~~~

Save the file.

![[Note]](../images/note.png)

Note

It's a bad idea to specify passwords in the "normal" configuration files
as they will be viewable via the web interface. You should use
[\$USERn\$](macrolist.md#macrolist-user) macros located in
`resource.cfg`{.filename} to store the passwords.

~~~~ {.programlisting}
$USER9$=averysecretpassword
~~~~

### 2.13.9. Restarting Icinga

You're done with modifying the Icinga configuration, so you'll need to
[verify your configuration
files](verifyconfig.md "4.1. Verifying Your Configuration") and
[restart Icinga](startstop.md "4.2. Starting and Stopping Icinga").

If the verification process produces any errors messages, fix your
configuration file before continuing. Make sure that you don't (re)start
Icinga until the verification process completes without any errors!

### 2.13.10. Troubleshooting

Sometimes it won't work. The easiest way is to execute the plugin as
Icinga user on the command line, something like

~~~~ {.screen}
 $> /usr/local/icinga/libexec/check_nt -H <ip address> -p <port> -s <password> -v UPTIME
~~~~

\<ip address\> is the address of the windows machine, \<port\> and
\<password\> the values defined in `nsc.ini`{.filename}. Please note
that an empty password might be specified as "" (two double quotes). The
result may be one of the following:

-   CRITICAL: Socket timeout after 10 seconds

    -   A firewall is blocking on the windows machine, on the Icinga
        server, or inbetween.

    -   The NSClient++ task is not running

    -   The port you specified is wrong

-   could not fetch information from server

    -   The port you specified is wrong (older NSClient versions)

-   NSCLIENT: wrong password

    -   the solution is left to the reader

* * * * *

  ----------------------------------- -------------------- ---------------------------------------
  [Prev](monitoring-overview.md)    [Up](ch02.md)       [Next](monitoring-linux.md)
  2.12. Monitoring Overview           [Home](index.md)    2.14. Monitoring Linux/Unix Machines
  ----------------------------------- -------------------- ---------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
