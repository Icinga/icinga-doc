![Icinga](../images/logofullsize.png "Icinga")

8.1. Security Considerations

[Prev](ch08.md) 

Chapter 8. Security and Performance Tuning

 [Next](cgisecurity.md)

* * * * *

8.1. Security Considerations
----------------------------

8.1.1. [Introduction](security.md#introduction)

8.1.2. [Best Practices](security.md#bestpractices)

### 8.1.1. Introduction

![](../images/security.png)

This is intended to be a brief overview of some things you should keep
in mind when installing Icinga, so as set it up in a secure manner.

Your monitoring box should be viewed as a backdoor into your other
systems. In many cases, the Icinga server might be allowed access
through firewalls in order to monitor remote servers. In most all cases,
it is allowed to query those remote servers for various information.
Monitoring servers are always given a certain level of trust in order to
query remote systems. This presents a potential attacker with an
attractive backdoor to your systems. An attacker might have an easier
time getting into your other systems if they compromise the monitoring
server first. This is particularly true if you are making use of shared
SSH keys in order to monitor remote systems.

If an intruder has the ability to submit check results or external
commands to the Icinga daemon, they have the potential to submit bogus
monitoring data, drive you nuts you with bogus notifications, or cause
event handler scripts to be triggered. If you have event handler scripts
that restart services, cycle power, etc. this could be particularly
problematic.

Another area of concern is the ability for intruders to sniff monitoring
data (status information) as it comes across the wire. If communication
channels are not encrypted, attackers can gain valuable information by
watching your monitoring information. Take as an example the following
situation: An attacker captures monitoring data on the wire over a
period of time and analyzes the typical CPU and disk load usage of your
systems, along with the number of users that are typically logged into
them. The attacker is then able to determine the best time to compromise
a system and use its resources (CPU, etc.) without being noticed.

Here are some tips to help ensure that you keep your systems secure when
implementing a Icinga-based monitoring solution...

### 8.1.2. Best Practices

1.  **Use a Dedicated Monitoring Box** . We would recommend that you
    install Icinga on a server that is dedicated to monitoring (and
    possibly other admin tasks). Protect your monitoring server as if it
    were one of the most important servers on your network. Keep running
    services to a minimum and lock down access to it via TCP wrappers,
    firewalls, etc. Since the Icinga server is allowed to talk to your
    servers and may be able to poke through your firewalls, allowing
    users access to your monitoring server can be a security risk.
    Remember, its always easier to gain root access through a system
    security hole if you have a local account on a box.

    ![](../images/security3.png)

2.  **Don't Run Icinga As Root** . Icinga doesn't need to run as root,
    so don't do it. You can tell Icinga to drop privileges after startup
    and run as another user/group by using the
    [icinga\_user](configmain.md#configmain-icinga_user) and
    [icinga\_group](configmain.md#configmain-icinga_group) directives
    in the main config file. If you need to execute event handlers or
    plugins which require root access, you might want to try using
    [sudo](http://www.courtesan.com/sudo/sudo).

3.  **Lock Down The Check Result Directory** . Make sure that only the
    *icinga* user is able to read/write in the [check result
    path](configmain.md#configmain-check_result_path). If users other
    than *icinga* (or *root*) are able to write to this directory, they
    could send fake host/service check results to the Icinga daemon.
    This could result in annoyances (bogus notifications) or security
    problems (event handlers being kicked off).

4.  **Lock Down The External Command File** . If you enable [external
    commands](extcommands.md "7.1. External Commands"), make sure you
    set proper permissions on the */usr/local/icinga/var/rw* directory.
    You only want the Icinga user (usually *icinga*) and the web server
    user (usually *nobody*, *httpd*, *apache2*, or *www-data*) to have
    permissions to write to the command file. If you've installed Icinga
    on a machine that is dedicated to monitoring and admin tasks and is
    not used for public accounts, that should be fine. If you've
    installed it on a public or multi-user machine (not recommended),
    allowing the web server user to have write access to the command
    file can be a security problem. After all, you don't want just any
    user on your system controlling Icinga through the external command
    file. In this case, we would suggest only granting write access on
    the command file to the *icinga* user and using something like
    [CGIWrap](http://cgiwrap.sourceforge.net/) to run the CGIs as the
    *icinga* user instead of *nobody*.

5.  **Require Authentication In The CGIs** . We would strongly suggest
    requiring authentication for accessing the CGIs. Once you do that,
    read the documentation on the default rights that authenticated
    contacts have, and only authorize specific contacts for additional
    rights as necessary. Instructions on setting up authentication and
    configuring authorization rights can be found
    [here](cgiauth.md "6.2. Authentication And Authorization In The Classic UI").
    If you disable the CGI authentication features using the
    [use\_authentication](configcgi.md#configcgi-use_authentication)
    directive in the CGI config file, the [command
    CGI](cgis.md#cgis-cmd_cgi) will refuse to write any commands to
    the [external command
    file](configmain.md#configmain-command_file). After all, you don't
    want the world to be able to control Icinga do you?

6.  **Implement Enhanced CGI Security Measures** . We would strongly
    suggest that you consider implementing enhanced security measures
    for the CGIs as described
    [here](cgisecurity.md "8.2. Enhanced Classic UI Security and Authentication").
    These measures can help ensure that the username/password you use to
    access the Icinga web interface are not intercepted by third
    parties.

7.  **Use Full Paths In Command Definitions** . When you define
    commands, make sure you specify the *full path* (not a relative one)
    to any scripts or binaries you're executing.

8.  **Hide Sensitive Information With \$USERn\$ Macros** . The CGIs read
    the [main config
    file](configmain.md "3.2. Main Configuration File Options") and
    [object config
    file(s)](configobject.md "3.3. Object Configuration Overview"), so
    you don't want to keep any sensitive information (usernames,
    passwords, etc) in there. If you need to specify a username and/or
    password in a command definition use a \$USERn\$
    [macro](macros.md "5.2. Understanding Macros and How They Work")
    to hide it. \$USERn\$ macros are defined in one or more [resource
    files](configmain.md#configmain-resource_file). The CGIs will not
    attempt to read the contents of resource files, so you can set more
    restrictive permissions (600 or 660) on them. See the sample
    *resource.cfg* file in the base of the Icinga distribution for an
    example of how to define \$USERn\$ macros.

9.  **Strip Dangerous Characters From Macros** . Use the
    [illegal\_macro\_output\_chars](configmain.md#configmain-illegal_macro_output_chars)
    directive to strip dangerous characters from the \$HOSTOUTPUT\$,
    \$SERVICEOUTPUT\$, \$HOSTPERFDATA\$, and \$SERVICEPERFDATA\$ macros
    before they're used in notifications, etc. Dangerous characters can
    be anything that might be interpreted by the shell, thereby opening
    a security hole. An example of this is the presence of backtick (\`)
    characters in the \$HOSTOUTPUT\$, \$SERVICEOUTPUT\$,
    \$HOSTPERFDATA\$, and/or \$SERVICEPERFDATA\$ macros, which could
    allow an attacker to execute an arbitrary command as the icinga user
    (one good reason not to run Icinga as the root user).

    ![](../images/security1.png)

10. **Secure Access to Remote Agents** . Make sure you lock down access
    to agents (NRPE, NSClient, SNMP, etc.) on remote systems using
    firewalls, access lists, etc. You don't want everyone to be able to
    query your systems for status information. This information could be
    used by an attacker to execute remote event handler scripts or to
    determine the best times to go unnoticed.

11. **Secure Communication Channels** . Make sure you encrypt
    communication channels between different Icinga installations and
    between your Icinga servers and your monitoring agents whenever
    possible. You don't want someone to be able to sniff status
    information going across your network. This information could be
    used by an attacker to determine the best times to go unnoticed.

    ![](../images/security2.png)

* * * * *

  --------------------------------------------- -------------------- -------------------------------------------------------
  [Prev](ch08.md)                             [Up](ch08.md)       [Next](cgisecurity.md)
  Chapter 8. Security and Performance Tuning    [Home](index.md)    8.2. Enhanced Classic UI Security and Authentication
  --------------------------------------------- -------------------- -------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
