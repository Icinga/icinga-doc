![Icinga](../images/logofullsize.png "Icinga")

8.2. Enhanced Classic UI Security and Authentication

[Prev](security.md) 

Chapter 8. Security and Performance Tuning

 [Next](tuning.md)

* * * * *

8.2. Enhanced Classic UI Security and Authentication
----------------------------------------------------

8.2.1. [Introduction](cgisecurity.md#introduction_cgisecurity)

8.2.2. [Additional Techniques](cgisecurity.md#additionaltechniques)

8.2.3. [Implementing Digest
Authentication](cgisecurity.md#implementationdigest)

8.2.4. [Implementing Forced TLS/SSL](cgisecurity.md#implementationssl)

8.2.5. [Implementing IP subnet
lockdown](cgisecurity.md#implementationlockdown)

8.2.6. [Important Notes](cgisecurity.md#importantnotes)

### 8.2.1. Introduction

![](../images/security.png)

This is intended to be an introduction for implementation of stronger
authentication and server security focused around the Classic UI web
interface.

There are many ways to enhance the security of your monitoring server
and Icinga environment. This should not be taken as the end all approach
to security. Instead, think of it as an introduction to some of the
techniques you can use to tighten the security of your system. As
always, you should do your own research and use the best techniques
available. Treat your monitoring server as it were the most important
server in your network and you shall be rewarded.

### 8.2.2. Additional Techniques

-   **Stronger Authentication using Digest Authentication** . If you
    have followed the [quickstart
    guides](quickstart.md "2.3. Quickstart Installation Guides"),
    chances are that you are using Apache's [Basic
    Authentication](http://httpd.apache.org/docs/2.2/mod/mod_auth_basic).
    Basic Authentication will send your username and password in "clear
    text" with every http request. Consider using a more secure method
    of authentication such as [Digest
    Authentication](http://httpd.apache.org/docs/2.2/mod/mod_auth_digest)
    which creates a MD5 Hash of your username and password to send with
    each request.

-   **Forcing TLS/SSL for all Web Communication** . Apache provides
    [TLS/SSL](http://en.wikipedia.org/wiki/Transport_Layer_Security)
    through the [mod\_ssl](http://httpd.apache.org/docs/2.2/mod/mod_ssl)
    module. TLS/SSL provides a secure tunnel between the client and
    server that prevents eavesdropping and tampering using strong
    publickey/privatekey cryptography.

-   **Locking Down Apache Using Access Controls** . Consider locking
    down access to the Icinga box to your IP address, IP address range,
    or IP subnet. If you require access outside your network you could
    use VPN or SSH Tunnels. This is a easy and strong to limit access to
    HTTP/HTTPS on your system.

### 8.2.3. Implementing Digest Authentication

The implementation of Digest Authentication is simple. You will have to
create the new type of password file using the
['htdigest'](http://httpd.apache.org/docs/2.2/programs/htdigest) tool,
then modify the Apache configuration for Icinga (typically
/etc/httpd/conf.d/icinga.conf).

Create a new passwords file using the
['htdigest'](http://httpd.apache.org/docs/2.2/programs/htdigest) tool.
The difference that you will notice if you are familiar with
['htpasswd'](http://httpd.apache.org/docs/2.2/programs/htpasswd) tools
is the requirement to supply a 'realm' argument. Where 'realm' in this
case refers to the value of the 'AuthName' directive in the Apache
configuration.

~~~~ {.screen}
 htdigest -c /usr/local/icinga/etc/.digest_pw "Icinga Access" icingaadmin
~~~~

Next, edit the Apache configuration file for Icinga (typically
/etc/httpd/conf.d/icinga.conf) using the following example.

~~~~ {.programlisting}
## BEGIN APACHE CONFIG SNIPPET - ICINGA.CONF
ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
<Directory "/usr/local/icinga/sbin">
   Options ExecCGI
   AllowOverride None
   Order allow,deny
   Allow from all
   AuthType Digest
   AuthName "Icinga Access"
   AuthDigestFile /usr/local/icinga/etc/.digest_pw
   Require valid-user
</Directory>

Alias /icinga "/usr/local/icinga/share"
<Directory "/usr/local/icinga/share">
   Options None
   AllowOverride None
   Order allow,deny
   Allow from all
   AuthType Digest
   AuthName "Icinga Access"
   AuthDigestFile /usr/local/icinga/etc/.digest_pw
   Require valid-user
</Directory>
## END APACHE CONFIG SNIPPETS
~~~~

Then, restart the Apache service so the new settings can take effect.

~~~~ {.screen}
 /etc/init.d/httpd restart
~~~~

### 8.2.4. Implementing Forced TLS/SSL

Make sure you've installed Apache and OpenSSL. By default you should
have [mod\_ssl](http://httpd.apache.org/docs/2.2/mod/mod_ssl) support if
you are still having trouble you may find help reading Apache's [TLS/SSL
Encryption Documentation](http://httpd.apache.org/docs/2.0/ssl).

Next, verify that TLS/SSL support is working by visiting your Icinga Web
Interface using HTTPS (https://your.domain/Icinga). If it is working you
can continue on to the next steps that will force using HTTPS and block
all HTTP requests for the Icinga Web Interface. If you are having
trouble visit Apache's [TLS/SSL Encryption
Documentation](http://httpd.apache.org/docs/2.0/ssl) and
[Google](http://www.google.com) for troubleshooting your specific Apache
installation.

Next, edit the Apache configuration file for Icinga (typically
/etc/httpd/conf.d/icinga.conf) by adding the 'SSLRequireSSL' directive
to both the 'sbin' and 'share' directories.

~~~~ {.programlisting}
## BEGIN APACHE CONFIG SNIPPET - ICINGA.CONF
ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
<Directory "/usr/local/icinga/sbin">
   ...
   SSLRequireSSL
   ...
</Directory>

Alias /icinga "/usr/local/icinga/share"
<Directory "/usr/local/icinga/share">
   ...
   SSLRequireSSL
   ...
</Directory>
## END APACHE CONFIG SNIPPETS
~~~~

Restart the Apache service so the new settings can take effect.

~~~~ {.screen}
 /etc/init.d/httpd restart
~~~~

### 8.2.5. Implementing IP subnet lockdown

The following example will show how to lock down Icinga CGIs to a
specific IP address, IP address range, or IP subnet using Apache's
[access controls](http://httpd.apache.org/docs/2.2/howto/access).

Edit the Apache configuration file for Icinga (typically
/etc/httpd/conf.d/icinga.conf) by using the 'Allow', 'Deny', and 'Order'
directives using the following as an example.

~~~~ {.programlisting}
## BEGIN APACHE CONFIG SNIPPET - ICINGA.CONF
ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
<Directory "/usr/local/icinga/sbin">
   ...
   AllowOverride None
   Order deny,allow
   Deny from all
   Allow from 127.0.0.1 10.0.0.25               # Allow single IP addresses
   Allow from 10.0.0.0/255.255.255.0            # Allow network/netmask pair
   Allow from 10.0.0.0/24                       # Allow network/nnn CIDR spec
   ...
</Directory>

Alias /icinga "/usr/local/icinga/share"
<Directory "/usr/local/icinga/share">
   ...
   AllowOverride None
   Order deny,allow
   Deny from all
   Allow from 127.0.0.1 10.0.0.25               # Allow single IP addresses
   Allow from 10.0.0.0/255.255.255.0            # Allow network/netmask pair
   Allow from 10.0.0.0/24                       # Allow network/nnn CIDR spec
   ...
</Directory>
## END APACHE CONFIG SNIPPET
~~~~

### 8.2.6. Important Notes

-   **Digest Authentication sends data in the clear but not your
    username and password** .

-   **Digest Authentication is not as universally supported as Basic
    Authentication** .

-   **TLS/SSL has potential for "man-in-the-middle attacks"** . MITM
    attacks are vulnerable if an attacker is able to insert itself
    between the server and client such as in a Phishing attack, ISP
    monitoring, or corporate LAN firewall certificate resigning. So read
    up on certificate verification!

-   **Apache access controls only protect the HTTP/HTTPS protocols** .
    Look into
    [IPtables](http://www.netfilter.org/projects/iptables/index) for
    strong system wide firewall control.

-   **Most importantly, Security is a moving target so stay informed and
    do research** ! Perhaps by listening to a Podcast such as "[Security
    Now!](http://www.grc.com/securitynow.htm)".

* * * * *

  ------------------------------- -------------------- ---------------------------------------------
  [Prev](security.md)           [Up](ch08.md)       [Next](tuning.md)
  8.1. Security Considerations    [Home](index.md)    8.3. Tuning Icinga For Maximum Performance
  ------------------------------- -------------------- ---------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
