[Prev](int-snmptrap.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](int-mklivestatus.md)

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





### 9.3.2. Defining A Service

If you haven't done so already, create a [host
definition](objectdefinitions.md#objectdefinitions-host) for the
remote host (*firestorm*).

Next, define a service in one of your [object configuration
files](configobject.md "3.3. Object Configuration Overview") for the
TCP wrapper alerts on host *firestorm*. The service definition might
look something like this:

<pre><code>
 define service{
</code></pre>

There are some important things to note about the above service
definition:




### 9.3.3. Configuring TCP Wrappers

Now you're going to have to modify the */etc/hosts.deny* file on
*firestorm*. In order to have the TCP wrappers send an alert to the
monitoring host whenever a connection attempt is denied, you'll have to
add a line similiar to the following:

<pre><code>
 ALL: ALL: RFC931: twist (/usr/local/icinga/libexec/eventhandlers/handle_tcp_wrapper %h %d) &
</code></pre>

This line assumes that there is a script called *handle\_tcp\_wrapper*
in the */usr/local/icinga/libexec/eventhandlers/* directory on
*firestorm*. We'll write that script next.

### 9.3.4. Writing The Script

The last thing you need to do is write the *handle\_tcp\_wrapper* script
on *firestorm* that will send the alert back to the Icinga server. It
might look something like this:

<pre><code>
#!/bin/sh
/usr/local/icinga/libexec/eventhandlers/submit_check_result firestorm "TCP Wrappers" 2 "Denied $2-$1" > /dev/null 2> /dev/null
</code></pre>

Notice that the *handle\_tcp\_wrapper* script calls the
*submit\_check\_result* script to actually send the alert back to the
monitoring host. Assuming your Icinga server is called *monitor*, the
*submit check\_result* script might look like this:

<pre><code>
#!/bin/sh
# Arguments

/bin/echo -e "$1\t$2\t$3\t$4\n" | /usr/local/icinga/bin/send_nsca monitor -c /usr/local/nagios/etc/send_nsca.cfg
</code></pre>

### 9.3.5. Finishing Up

You've now configured everything you need to, so all you have to do is
restart the *inetd* process on *firestorm* and restart Icinga on your
monitoring server. That's it! When the TCP wrappers on *firestorm* deny
a connection attempt, you should be getting alerts in Icinga. The plugin
output for the alert will look something like the following:

</code></pre>

* * * * *

[Prev](int-snmptrap.md) | [Up](ch09.md) | [Next](int-mklivestatus.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
