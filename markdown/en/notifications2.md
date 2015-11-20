[Prev](notifications.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch06.md)

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
(postfix: `/etc/postfix/main.cf`, directive "relayhost";
sendmail: `/etc/mail/sendmail.cf`, directive "DS"), allow
relaying on your central mail server for mails coming from your Icinga
server and verify that you can send mails from your Icinga server using
the user running Icinga.

If you cannot send messages from the command line on your Icinga server
then there is no sense in reading on.

**Prerequisites**





















### 5.12.2. Some examples

We will define some services containing only some directives assuming
that the other (required) things were defined using a template and show
some things to look for:

<pre><code>
 define service {

 define service {
 define service {
</code></pre>




### 5.12.3. Troubleshooting

If notifications don't seem to work there are several things to check:









* * * * *

[Prev](notifications.md) | [Up](ch05.md) | [Next](ch06.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
