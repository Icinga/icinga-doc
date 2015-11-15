![Icinga](../images/logofullsize.png "Icinga")

5.12. Notifications: Examples and troubleshooting

[Prev](notifications.md) 

Chapter 5. The Basics

 [Next](ch06.md)

* * * * *

5.12. Notifications: Examples and troubleshooting
-------------------------------------------------

5.12.1. [Introduction](notifications2.md#introduction)

5.12.2. [Some examples](notifications2.md#examples)

5.12.3. [Troubleshooting](notifications2.md#troubleshooting)

### 5.12.1. Introduction

Object definitions of
[hosts](objectdefinitions.md#objectdefinitions-host),
[services](objectdefinitions.md#objectdefinitions-service), and
[contacts](objectdefinitions.md#objectdefinitions-contact) / [contact
groups](objectdefinitions.md#objectdefinitions-contactgroup) were
shown in the chapter "Configuring Icinga", the several checks being made
to determine whether a notification will be sent or not were described
in the section
"[Notifications](notifications.md "5.11. Notifications")".

Despite all the explanations it seems that there is still some level of
uncertainty so we'll try to show an example using mail as one way of
communication.

![[Important]](../images/important.png)

Important

Icinga does **not** provide any method to notify any contact you define
so setting up mail, sms, pager, or whichever way you may choose is
entirely up to you and not part of this documentation. Regarding mail
you have to install a mail program (postfix, sendmail, or any other MTA
you feel comfortable with), set up relaying on the Icinga server
(postfix: `/etc/postfix/main.cf`{.filename}, directive "relayhost";
sendmail: `/etc/mail/sendmail.cf`{.filename}, directive "DS"), allow
relaying on your central mail server for mails coming from your Icinga
server and verify that you can send mails from your Icinga server using
the user running Icinga.

If you cannot send messages from the command line on your Icinga server
then there is no sense in reading on.

**Prerequisites**

-   As stated above you need a working way to send messages from the
    command line. If that doesn't work then you have to fix it first!

-   You need at least one contact definition like the following:

    ~~~~ {.programlisting}
     define contact {
            contact_name                    jdoe
            host_notifications_enabled      1
            host_notification_period        24x7
            host_notification_options       d,u,r
            host_notification_commands      host-notify-by-email
            service_notifications_enabled   1
            service_notification_period     workhours
            service_notification_options    w,u,c,r
            service_notification_commands   notify-by-email
            email                           jdoe@some.domain.name
            }
    ~~~~

    The definition contains all required directives and one
    semi-optional (email).

    -   Notifications are enabled for both hosts and services

    -   Notifications will be sent during the time period "24x7" for
        hosts and during "workhours" for services. These time periods
        require appropriate [time period
        definitions](objectdefinitions.md#objectdefinitions-timeperiod).
        We'll assume that "24x7" means 24 hours 7 days a week and
        "workhours" monday to friday from 9 a.m. to 5 p.m. Please note
        that "notification\_period" is different from "check\_period" as
        specified in host and service definitions. It specifies the time
        period in which messages will be sent if all checks described in
        "[Notifications](notifications.md "5.11. Notifications")" have
        been passed successfully.

    -   Messages will be sent for hosts changing to UNREACHABLE and DOWN
        states and when returning back to an UP state. Services changing
        to WARNING, CRITICAL, and UNREACHABLE and returning back to an
        OK state will send notifications as well.

    -   Hosts and services use different commands to notify the contact.

    -   Apart from "email" you can specify several other addresses which
        might be used to notify the contact.

-   You need different command definitions for "host-notify-by-email"
    and "notify-by-email". The definitions shown were taken from the
    Icinga sample config files. The command line was reformatted.

    ~~~~ {.programlisting}
     # 'notify-host-by-email' command definition
     define command {
            command_name   notify-host-by-email
            command_line   /usr/bin/printf "%b" "***** Icinga *****\n\n \
                           Notification Type: $NOTIFICATIONTYPE$\n \
                           Host: $HOSTNAME$\n \
                           State: $HOSTSTATE$\n \
                           Address: $HOSTADDRESS$\n \
                           Info: $HOSTOUTPUT$\n\n \
                           Date/Time: $LONGDATETIME$\n" \
                           | /usr/bin/mailx -s \
                             "** $NOTIFICATIONTYPE$ Host Alert: \
                             $HOSTNAME$ is $HOSTSTATE$ **" \
                             $CONTACTEMAIL$
            }

     # 'notify-service-by-email' command definition
     define command {
            command_name   notify-service-by-email
            command_line   /usr/bin/printf "%b" "***** Icinga *****\n\n \
                           Notification Type: $NOTIFICATIONTYPE$\n\n \
                           Service: $SERVICEDESC$\n \
                           Host: $HOSTALIAS$\n \
                           Address: $HOSTADDRESS$\n \
                           State: $SERVICESTATE$\n\n \
                           Date/Time: $LONGDATETIME$\n\n \
                           Additional Info:\n\n \
                           $SERVICEOUTPUT$\n" 
                           | /usr/bin/mailx -s \
                             "** $NOTIFICATIONTYPE$ Service Alert: \
                             $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **" \
                             $CONTACTEMAIL$
            }
    ~~~~

    ![[Note]](../images/note.png)

    Note

    Please verify that the programs (`printf`{.filename},
    `mailx`{.filename}) actually exist at the given locations. They may
    differ between distributions.

    There are many
    [macros](macrolist.md "5.3. Standard Macros in Icinga") which can
    be inserted to add information to the notifications.

    ![[Note]](../images/note.png)

    Note

    Several macros have a limited scope, e.g. CONTACT\* macros are not
    available within event handlers.

    You are free to write your own notification command adding or
    removing macros as needed. Just ensure that it contains the
    information the addressee requires. You may want to write a
    sophisticated script which checks a database to determine the way a
    contact can be reached depending on the time the notification is
    sent (via mail during working hours, additionally via sms during
    non-working hours, not at all during holidays).

### 5.12.2. Some examples

We will define some services containing only some directives assuming
that the other (required) things were defined using a template and show
some things to look for:

~~~~ {.programlisting}
 define service {
        use                      service_template
        host_name                san_host
        service_description      spare_disks
        notification_period      24x7
        notification_interval    60
        notification_options     c,w,r
        check_command            check_spare!2!1
        contacts                 jdoe
        contact_groups           admins
        }

 define service {
        use                      service_template
        host_name                login_host
        service_description      users
        notification_period      workhours
        notification_interval    0
        notification_options     c,r
        check_command            check_user!20!50
        contacts                 jdoe
        }        
       
 define service {
        use                      service_template
        host_name                app_host
        service_description      memory
        notification_period      workhours
        notification_interval    10
        notification_options     c,w,r,s,r,f,n
        check_command            check_memory!90%!95%
        contacts                 admins
        }
~~~~

-   The first service monitors the number of spare discs within a disc
    shelf. Normally there are two discs available. Having only one
    should generate a warning, dropping to zero is considered critical.
    Notifications will be sent at all times, repeating the non-OK state
    every 60 minutes. John Doe is not part of the admins group so he is
    specified separately.

-   The second service monitors the number of users logged in. Exceeding
    20 users generates a warning, above 50 users is critical. The shop
    is closed after working hours and users are logged off automatically
    after some idle time so there is no need for notifications at other
    times. Please note that a warning will *not* send a notification
    because that is not specified in the notification options! There
    will be only one notification in case of a non-OK state, even if the
    state changes between WARNING and CRITICAL.

-   The last service checks the amount of memory on a machine running
    batch jobs all the time. Warnings will be generated above 90% RAM
    usage and if beyond 95% it is considered critical. Sending out
    messages in a ten minute interval seems to be a good idea but
    sending them only during workhours might be insufficient. **But**:
    although there are a lot of notification options specified the
    admins group will not get any messages at all! The reason? Please
    check the meaning of each possible value of "notification\_options"
    for yourself by looking at the object definition of hosts /
    services.

### 5.12.3. Troubleshooting

If notifications don't seem to work there are several things to check:

-   Has the host/service state already turned into a "hard" state? Check
    the state looking at the host/service details

-   Is the macro valid in the context where you are using it?

-   Is the program to send messages (mail / pager / ...) up and running?
    Is it possible to send messages from the command line with the
    account used to run the Icinga process to the address specified in
    the contact definition? Note: For security reasons the login shell
    might be disabled so you may have to change that temporarily

-   Instead of sending messages you can redirect the output to a file by
    changing "`| /usr/bin/mail ...`{.literal}" to something like
    "`> /tmp/notification.log`{.literal}" to verify that all macros are
    resolved correctly

-   Check the Icinga log, mail log, and system log for messages

-   Edit `icinga.cfg`{.filename} and change the following directives

    ~~~~ {.programlisting}
     debug_level=32                  # notifications
     debug_verbosity=2               # very detailed
     max_debug_file_size=1000000000  # max 1GB of debug file
    ~~~~

    Restart Icinga and send a custom notification via the classic UI to
    check the settings.

* * * * *

  ----------------------------- -------------------- -----------------------------
  [Prev](notifications.md)    [Up](ch05.md)       [Next](ch06.md)
  5.11. Notifications           [Home](index.md)    Chapter 6. User Interfaces
  ----------------------------- -------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
