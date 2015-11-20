[Prev](security.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](tuning.md)

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

</code></pre> 
 htdigest -c /usr/local/icinga/etc/.digest_pw "Icinga Access" icingaadmin
</code></pre>

Next, edit the Apache configuration file for Icinga (typically
/etc/httpd/conf.d/icinga.conf) using the following example.

<pre><code>
ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
<Directory "/usr/local/icinga/sbin">
</Directory>

Alias /icinga "/usr/local/icinga/share"
<Directory "/usr/local/icinga/share">
</Directory>
## END APACHE CONFIG SNIPPETS
</code></pre>

Then, restart the Apache service so the new settings can take effect.

</code></pre> 
 /etc/init.d/httpd restart
</code></pre>

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

<pre><code>
ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
<Directory "/usr/local/icinga/sbin">
</Directory>

Alias /icinga "/usr/local/icinga/share"
<Directory "/usr/local/icinga/share">
</Directory>
## END APACHE CONFIG SNIPPETS
</code></pre>

Restart the Apache service so the new settings can take effect.

</code></pre> 
 /etc/init.d/httpd restart
</code></pre>

### 8.2.5. Implementing IP subnet lockdown

The following example will show how to lock down Icinga CGIs to a
specific IP address, IP address range, or IP subnet using Apache's
[access controls](http://httpd.apache.org/docs/2.2/howto/access).

Edit the Apache configuration file for Icinga (typically
/etc/httpd/conf.d/icinga.conf) by using the 'Allow', 'Deny', and 'Order'
directives using the following as an example.

<pre><code>
ScriptAlias /icinga/cgi-bin "/usr/local/icinga/sbin"
<Directory "/usr/local/icinga/sbin">
</Directory>

Alias /icinga "/usr/local/icinga/share"
<Directory "/usr/local/icinga/share">
</Directory>
## END APACHE CONFIG SNIPPET
</code></pre>

### 8.2.6. Important Notes






* * * * *

[Prev](security.md) | [Up](ch08.md) | [Next](tuning.md)

8.1. Security Considerations  |<=== [Index](index.md) ===>|  8.3. Tuning Icinga For Maximum Performance

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
