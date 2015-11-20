[Prev](sample-resource.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](sample-commands.md)

* * * * *

13.5. httpd.conf
----------------

<pre><code>
# SAMPLE CONFIG SNIPPETS FOR APACHE WEB SERVER
#
# This file contains examples of entries that need
# to be incorporated into your Apache web server
# needed to fit your system.

ScriptAlias @cgiurl@ "@sbindir@"

<Directory "@sbindir@">
<Directory>

Alias @htmurl@ "@datadir@/"

<Directory "@datadir@/">
<Directory>
</code></pre>

* * * * *

[Prev](sample-resource.md) | [Up](ch13.md) | [Next](sample-commands.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
