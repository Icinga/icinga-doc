[Prev](verifyconfig.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](ch05.md)

* * * * *

4.2. Starting and Stopping Icinga
---------------------------------

There are different ways to start, stop, and restart Icinga. Depending
on your installation, the most common example will be shown... In case
of using the init script make sure you have performed

<pre><code>
 #> make install-init
</code></pre>

or

<pre><code>
 #> make fullinstall
</code></pre>

![[Tip]](../images/tip.png)

Tip

Always make sure you're [verified your
configuration](verifyconfig.md "4.1. Verifying Your Configuration")
before you (re)start Icinga.

**Starting Icinga**








**Restarting Icinga**

Restarting/reloading is necessary if you modify your configuration files
and want those changes to take effect.










**Stopping Icinga**







**Logging Options in /usr/local/icinga/etc/icinga.cfg**

Logging options for daemon:

If you want messages to be logged to the daemon log file (usually
icinga.log). Default option is 1 (yes), the other valid option is 0 (no)

<pre><code>
use_daemon_log=0/1
</code></pre>

Logging options for syslog:

If you want messages to be logged to the syslog facility, as well as the
Icinga log file set this option to 1. If not, set it to 0.

<pre><code>
use_syslog=0/1
</code></pre>

**Miscellaneous options**

If you experience long delays between starting Icinga and the first
checks you can use several other options which are shown
[here](faststartup.md "8.4. Fast Startup Options"). How to have a look
at the scheduling queue (-S) is described there as well.

* * * * *

[Prev](verifyconfig.md) | [Up](ch04.md) | [Next](ch05.md)

4.1. Verifying Your Configuration  |<=== [Index](index.md) ===>|  Chapter 5. The Basics

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
