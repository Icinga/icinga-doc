[Prev](upgrading_icingaweb.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](icinga-web-introduction.md)

* * * * *

6.7. Configuration Overview of Icinga Web
-----------------------------------------

6.7.1. [Where are my config
files?](icinga-web-config.md#configfilelocation)

6.7.2. [Index](icinga-web-config.md#confogfileindex)

6.7.3. [Global Configuration
Section](icinga-web-config.md#globalconfig)

6.7.4. [Troubleshooting](icinga-web-config.md#troubleshooting)

6.7.5. [Module Configuration](icinga-web-config.md#moduleconfig)

6.7.6. [Customised Configuration](icinga-web-config.md#customconfig)

### 6.7.1. Where are my config files?

The configuration files provided by Icinga Web are located below
`app/config`, site specific configuration files below the web
configuration folder (per default `etc/conf.d`) which will
not be overridden during the next upgrade process. The folder may be
changed during installation using --with-conf-dir. The files are named
identically as the ones in `app/config`.

Icinga operates in modules, every module has its own configuration file.
This is also done with the libraries. If you need information about the
cronk library, take a look into `app/modules/Cronks/lib` (for
js things `app/modules/Cronks/lib/js`).

A sample module looks like this:

<pre><code>
tree -d -L 1 app/modules/AppKit/
app/modules/AppKit/
|-- actions
|-- config
|-- lib
|-- models
|-- templates
|-- validate
|-- views
</code></pre>

### 6.7.2. Index

















### 6.7.3. Global Configuration Section

**app/config**

Here you find the global configuration files for e.g. the web session,
the Icinga web path and the database information. Site specific
configuration files from the web config folder (per default
`etc/conf.d`) are included automatically.

The main interesting files (in alphabetical order):






















































































































































### 6.7.4. Troubleshooting



**Change Icinga Web timezone**

If the time(zone) in Icinga Web differs from your system time(zone),
please check the date.timezone entry in your `php.ini`.
Alternatively check the entry in
`app/modules/AppKit/config/module.xml` (e.g.
'Europe/Berlin'):

<pre><code>
#> vi app/modules/AppKit/config/module.xml
<ae:parameter name="date.timezone">Europe/Berlin</ae:parameter>
</code></pre>

**Change user preferences**

The file `module.xml` contains several settings which can be
overwritten by custom settings to be placed in
`userpreferences.xml` (in the `etc/config`
folder).

### 6.7.5. Module Configuration






















### 6.7.6. Customised Configuration

**Notes**

When creating and/or editing configuration files, keep the following in
mind:



![[Note]](../images/note.png)

Note

After changing those configs you need to clear the config cache!

<pre><code>
 #> rm -rf app/cache/config/*.php
</code></pre>

or

<pre><code>
 #> /usr/local/icinga-web/bin/clearcache.sh
</code></pre>

You need more information? Please have a look at our [Development
Wiki.](https://dev.icinga.org/projects/icinga-development/wiki/)

* * * * *

[Prev](upgrading_icingaweb.md) | [Up](ch06.md) | [Next](icinga-web-introduction.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
