![Icinga](../images/logofullsize.png "Icinga")

13.5. httpd.conf

[Zurück](sample-resource.md) 

Kapitel 13. Icinga Beispieldateien

 [Weiter](sample-commands.md)

* * * * *

13.5. httpd.conf
----------------

~~~~ {.programlisting}
# SAMPLE CONFIG SNIPPETS FOR APACHE WEB SERVER
#
# This file contains examples of entries that need
# to be incorporated into your Apache web server
# configuration file.  Customize the paths, etc. as
# needed to fit your system.

ScriptAlias @cgiurl@ "@sbindir@"

<Directory "@sbindir@">
#  SSLRequireSSL
   Options ExecCGI
   AllowOverride None
   Order allow,deny
   Allow from all
#  Order deny,allow
#  Deny from all
#  Allow from 127.0.0.1
   AuthName "Icinga Access"
   AuthType Basic
   AuthUserFile @HTTPAUTHFILE@
   Require valid-user
<Directory>

Alias @htmurl@ "@datadir@/"

<Directory "@datadir@/">
#  SSLRequireSSL
   Options None
   AllowOverride All
   Order allow,deny
   Allow from all
#  Order deny,allow
#  Deny from all
#  Allow from 127.0.0.1
   AuthName "Icinga Access"
   AuthType Basic
   AuthUserFile @HTTPAUTHFILE@
   Require valid-user
<Directory>
~~~~

* * * * *

  --------------------------------- -------------------------- ---------------------------------
  [Zurück](sample-resource.md)    [Nach oben](ch13.md)      [Weiter](sample-commands.md)
  13.4. resource.cfg                [Zum Anfang](index.md)    13.6. commands.cfg
  --------------------------------- -------------------------- ---------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
