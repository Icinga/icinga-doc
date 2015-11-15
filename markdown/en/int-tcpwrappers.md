![Icinga](../images/logofullsize.png "Icinga")

9.3. TCP Wrapper Integration

[Prev](int-snmptrap.md) 

Chapter 9. Integration With Other Software

 [Next](int-mklivestatus.md)

* * * * *

9.3. TCP Wrapper Integration
----------------------------

9.3.1. [Introduction](int-tcpwrappers.md#introduction)

9.3.2. [Defining A
Service](int-tcpwrappers.md#servicedefinitiontcpwrapper)

9.3.3. [Configuring TCP
Wrappers](int-tcpwrappers.md#configtcpwrappers)

9.3.4. [Writing The Script](int-tcpwrappers.md#tcpwrapperscript)

9.3.5. [Finishing Up](int-tcpwrappers.md#finish)

### 9.3.1. Introduction

![](../images/tcpwrappers.png)

This document explains how to easily generate alerts in Icinga for
connection attempts that are rejected by TCP wrappers. For example, if
an unauthorized host attempts to connect to your SSH server, you can
receive an alert in Icinga that contains the name of the host that was
rejected. If you implement this on your Linux/Unix boxes, you'll be
surprised how many port scans you can detect across your network.

These directions assume:

1.  You are already familiar with [passive
    checks](passivechecks.md "5.7. Passive Checks") and how they work.

2.  You are already familiar with [volatile
    services](volatileservices.md "7.4. Volatile Services") and how
    they work.

3.  The host which you are generating alerts for (i.e. the host you are
    using TCP wrappers on) is a remote host (called *firestorm* in this
    example). If you want to generate alerts on the same host that
    Icinga is running you will need to make a few modifications to the
    examples we provide.

4.  You have installed the [NSCA daemon](addons.md#addons-nsca) on
    your monitoring server and the NSCA client (*send\_nsca*) on the
    remote machine that you are generating TCP wrapper alerts from.

### 9.3.2. Defining A Service

If you haven't done so already, create a [host
definition](objectdefinitions.md#objectdefinitions-host) for the
remote host (*firestorm*).

Next, define a service in one of your [object configuration
files](configobject.md "3.3. Object Configuration Overview") for the
TCP wrapper alerts on host *firestorm*. The service definition might
look something like this:

~~~~ {.programlisting}
 define service{
        host_name                       firestorm
        service_description             TCP Wrappers
        is_volatile                     1
        active_checks_enabled           0
        passive_checks_enabled          1
        max_check_attempts              1
        check_command                   check_none
        ...
        }
~~~~

There are some important things to note about the above service
definition:

1.  The *volatile* option is enabled. We want this option enabled
    because we want a notification to be generated for every alert that
    comes in.

2.  Active checks of the service as disabled, while passive checks are
    enabled. This means that the service will never be actively checked
    by Icinga - all alert information will have to be received passively
    from an external source.

3.  The *max\_check\_attempts* value is set to 1. This guarantees you
    will get a notification when the first alert is generated.

### 9.3.3. Configuring TCP Wrappers

Now you're going to have to modify the */etc/hosts.deny* file on
*firestorm*. In order to have the TCP wrappers send an alert to the
monitoring host whenever a connection attempt is denied, you'll have to
add a line similiar to the following:

~~~~ {.programlisting}
 ALL: ALL: RFC931: twist (/usr/local/icinga/libexec/eventhandlers/handle_tcp_wrapper %h %d) &
~~~~

This line assumes that there is a script called *handle\_tcp\_wrapper*
in the */usr/local/icinga/libexec/eventhandlers/* directory on
*firestorm*. We'll write that script next.

### 9.3.4. Writing The Script

The last thing you need to do is write the *handle\_tcp\_wrapper* script
on *firestorm* that will send the alert back to the Icinga server. It
might look something like this:

~~~~ {.programlisting}
#!/bin/sh
 
/usr/local/icinga/libexec/eventhandlers/submit_check_result firestorm "TCP Wrappers" 2 "Denied $2-$1" > /dev/null 2> /dev/null
~~~~

Notice that the *handle\_tcp\_wrapper* script calls the
*submit\_check\_result* script to actually send the alert back to the
monitoring host. Assuming your Icinga server is called *monitor*, the
*submit check\_result* script might look like this:

~~~~ {.programlisting}
#!/bin/sh
# Arguments
#       $1 = name of host in service definition
#       $2 = name/description of service in service definition
#       $3 = return code
#       $4 = output

/bin/echo -e "$1\t$2\t$3\t$4\n" | /usr/local/icinga/bin/send_nsca monitor -c /usr/local/nagios/etc/send_nsca.cfg
~~~~

### 9.3.5. Finishing Up

You've now configured everything you need to, so all you have to do is
restart the *inetd* process on *firestorm* and restart Icinga on your
monitoring server. That's it! When the TCP wrappers on *firestorm* deny
a connection attempt, you should be getting alerts in Icinga. The plugin
output for the alert will look something like the following:

~~~~ {.screen}
Denied sshd2-sdn-ar-002mnminnP321.dialsprint.net 
~~~~

* * * * *

  ----------------------------- -------------------- --------------------------------
  [Prev](int-snmptrap.md)     [Up](ch09.md)       [Next](int-mklivestatus.md)
  9.2. SNMP Trap Integration    [Home](index.md)    9.4. MKLiveStatus Integration
  ----------------------------- -------------------- --------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
