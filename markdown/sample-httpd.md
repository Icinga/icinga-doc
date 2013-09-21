httpd.conf
==========

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
