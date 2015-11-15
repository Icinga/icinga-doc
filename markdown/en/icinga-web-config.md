![Icinga](../images/logofullsize.png "Icinga")

6.7. Configuration Overview of Icinga Web

[Prev](upgrading_icingaweb.md) 

Chapter 6. User Interfaces

 [Next](icinga-web-introduction.md)

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
`app/config`{.filename}, site specific configuration files below the web
configuration folder (per default `etc/conf.d`{.filename}) which will
not be overridden during the next upgrade process. The folder may be
changed during installation using --with-conf-dir. The files are named
identically as the ones in `app/config`{.filename}.

Icinga operates in modules, every module has its own configuration file.
This is also done with the libraries. If you need information about the
cronk library, take a look into `app/modules/Cronks/lib`{.filename} (for
js things `app/modules/Cronks/lib/js`{.filename}).

A sample module looks like this:

~~~~ {.programlisting}
tree -d -L 1 app/modules/AppKit/
app/modules/AppKit/
|-- actions
|-- config
|-- lib
|-- models
|-- templates
|-- validate
|-- views
~~~~

### 6.7.2. Index

  ------------------------------------------------------------- ------------------------------- ------------------------------------------------------------------------
  **Filename**                                                  **Location**                    **Note**
  [access.xml](icinga-web-config.md#configweb-access)         app/modules/Api/config/         Controls commands and where Icinga commands goes to
  [auth.xml](icinga-web-config.md#configweb-auth)             app/modules/AppKit/config/      Authentication configuration
  cronks.xml                                                    app/modules/Cronks/config/      System cronk and categories which are not changeable by users
  [databases.xml](icinga-web-config.md#configweb-databases)   app/config/                     Upgrade safe database connections
  [factories.xml](icinga-web-config.md#configweb-factories)   app/config/                     Agavi system config, storage and session configuration
  icinga.xml                                                    app/config/                     Icinga settings, e.g. version and prefixes / version name
  [logging.xml](icinga-web-config.md#configweb-logging)       app/config/                     Disable log levels or write new logfiles
  module\_appkit.xml                                            app/modules/AppKit/config/      Overwrite settings for AppKit module (ajax timeout, SQL query logging)
  module\_cronks.xml                                            app/modules/Cronks/config/      Overwrite settings for Cronks module
  module\_reporting.xml                                         app/modules/Reporting/config/   Overwrite settings for Reporting (multiple JasperServer ...)
  module\_web.xml                                               app/modules/Web/config/         Overwrite setting for Web module
  [settings.xml](icinga-web-config.md#configweb-settings)     app/config/                     Change agavi core settings (Title, availability, debug-mode, ...)
  sla.xml                                                       app/modules/Api/config/         SLA settings for the provider (Only used by tackle view)
  exclude\_customvars.xml                                       app/modules/Api/config/         Exclude sensitive customvars from API queries
  translation.xml                                               app/config/                     Default language, date and time formats and settings
  module.xml                                                    app/modules/Appkit/config/      Overwrite user preferences using userpreferences.xml (in etc/conf.d)
  ------------------------------------------------------------- ------------------------------- ------------------------------------------------------------------------

  : Table 6.1. Configuration files

-   [Global Configuration
    Section](icinga-web-config.md#globalconfig "6.7.3. Global Configuration Section")

    -   [access.xml](icinga-web-config.md#configweb-access)

    -   [databases.xml](icinga-web-config.md#configweb-databases)

    -   [factories.xml](icinga-web-config.md#configweb-factories)

        -   [Session Cookie
            Lifetime](icinga-web-config.md#configweb-session-lifetime)

    -   [logging.xml](icinga-web-config.md#configweb-logging)

    -   [settings.xml](icinga-web-config.md#configweb-settings)

    -   [translation.xml](icinga-web-config.md#configweb-translation)

    -   [views.xml](icinga-web-config.md#configweb-views)

-   [Change default Timezone](icinga-web-config.md#configweb-timezone)

-   [Change user
    preferences](icinga-web-config.md#configweb-userprefs)

-   [Module
    Configuration](icinga-web-config.md#moduleconfig "6.7.5. Module Configuration")

-   [Authentication](icinga-web-config.md#configweb-auth)

-   [Customised
    Configuration](icinga-web-config.md#customconfig "6.7.6. Customised Configuration")

### 6.7.3. Global Configuration Section

**app/config**

Here you find the global configuration files for e.g. the web session,
the Icinga web path and the database information. Site specific
configuration files from the web config folder (per default
`etc/conf.d`{.filename}) are included automatically.

The main interesting files (in alphabetical order):

-   *access.xml*

    The `access.xml`{.filename} config file has two main purposes:

    -   Define hosts that can be accessed by icinga-web (via system or
        ssh) and define files/binaries that can be written to/read
        from/executed

    -   Map icinga instances to these hosts

    The `access.xml`{.filename} config will be used by icinga-webs
    console-handler implementation and provides additional security, as
    it prevents arbitary execution/manipulation of files in the last
    instance.

    **Sections**

    -   *Instances*

        Setting up instances happens in the \<instances\> section:

        Example: Map instance 'default' to host 'localhost'

        ~~~~ {.screen}
        <!-- Map your instances to hosts here -->
         <instances>
            <instance name="default">localhost</instance>
         </instances>
        ~~~~

        Allowed subelements

        -   instance: Only 'instance' is allowed as a subelement, this
            node maps an instance name determined by the attribute
            "name" to a host (see later), determined by the value of
            this tag:

            ~~~~ {.screen}
             <instance name="%icinga instance name%">%host name%</instance>
            ~~~~

    -   *Defaults*

        The default section defines default values for host settings,
        i.e. which files can be read/written to/executed by default.
        Also the default host used by icinga-web will be defined here.

        Allowed subelements

        -   defaultHost: Defines the host that will be used for actions,
            if no host is defined. At this time (v1.6), this is only
            important for some modules and doesn't affect icinga-web's
            basic featureset.

            ~~~~ {.screen}
             <defaultHost>localhost</defaultHost>
            ~~~~

            The host must be defined in the hosts section

        -   access: Icinga-Web (and modules, if written correctly) don't
            access non architecture-level system resources directly, but
            via a console-interface, which handles security. In the
            access section you define, which system resources may be
            accessed by this handler and where they are located. Also
            you give system resources a resource name. For example, the
            console handler only accesses the icinga pipe through the
            'icinga\_pipe' symbol name.

            The access section allows four sub-elements: 'readwrite',
            'read', 'write', 'execute', which define the access level to
            resources located underneath. Resources themselves are
            defined under the 'folders' or 'files' tags and encapsulated
            by 'resource': The following example allows r/w access to
            Icinga's `objects`{.filename} folder and the
            `icinga.cfg`{.filename} file. Write, read, and execute
            follow the same scheme so the 'readwrite' tag is to be
            replaced with the appropriate tag.

        ~~~~ {.screen}
         <readwrite>
            <folders>
               <resource name="icinga_objects">/usr/local/icinga/etc/objects</resource>
            </folders>
            <files>
               <resource name="icinga_cfg">/usr/local/icinga/etc/icinga.cfg</resource>
            </files>
         </readwrite>
        ~~~~

        As mentioned above, each resource maps a resource symbol (name)
        to a path. This is optional, but recommended. If a symbol exists
        more than once, the last will be used.

        ![[Note]](../images/note.png)

        Note

        *Custom default definitions in your config folder*

        If you override a custom section, like readwrite, all previously
        set definitions will be ignored and must be redefined if you
        want to use them. This doesn't affect module configurations.

    -   *Hosts*

        The hosts section is the section where access methods and
        credentials, but also specific rights for hosts are defined.

        Allowed subelements:

        -   host: Defines a single host and gives him a name which can
            be used to reference this host (like in the instances
            section).

            ~~~~ {.screen}
             <!-- Example for ssh connection with user/password auth -->
             <host name="vm_host1">
                <type>ssh</type>
                <ssh-config>
                   <host>localhost</host>
                   <port>22</port>
                   <auth>
                      <type>password</type>
                      <user>john_doe</user>
                      <password>foobar</password>
                   </auth>
                </ssh-config>

                <access useDefaults="true" />
             </host>
            ~~~~

            The 'host' tag has a bunch of subelements:

        -   type: Either local or ssh. Defines if commands will be
            executed directly on the machine icinga-web is running on or
            via ssh.

        -   access: See the access section above. Additionally,
            'useDefaults' can be set in order to tell the
            CommandInterface that all default access definitions may be
            applied (if they are not overwritten in this section)

        -   ssh-config: (Only if type:ssh) This defines how the host
            will be accessed over ssh. There are three authentication
            methods for ssh: 'none', 'password' or 'key', which will be
            explained in the next session. No matter which method you
            choose, the 'host' and 'port' entries must be set on every
            host.

    -   *SSH-Config auth*

        This section explains the auth area of the ssh-config setting,
        which we introduced in the previous section. The elements
        underneath the 'auth' tag vary depending on the auth type
        chosen.

        -   Auth type: none

            This tells the Console-connection to only use a username for
            authentication:

            ~~~~ {.screen}
             <ssh-config>
                <host>localhost</host>
                <port>22</port>
                <auth>
                   <type>none</type>
                   <user>john_doe</user>
                </auth>
             </ssh-config>
            ~~~~

            In this example, only the username 'john\_doe' will be
            provided for authentication. This can be useful if your
            machines use automatic key authentication.

        -   Auth type: password

            This tells the console-connection to use a username and a
            password for authentication:

            ~~~~ {.screen}
             <ssh-config>
                <host>localhost</host>
                <port>22</port>
                <auth>
                   <type>password</type>
                   <user>john_doe</user>
                   <password>foobar</password>
                </auth>
             </ssh-config>
            ~~~~

            In this example, only username 'john\_doe' and the password
            'foobar' will be provided for authentication.

        -   Auth type: key

            ![[Important]](../images/important.png)

            Important

            Experimental! Try it out and open a ticket if you encounter
            any issues!

            This tells the Console-connection to use a key file for
            authentication, optionally secured with a password:

            ~~~~ {.screen}
             <ssh-config>
                <host>localhost</host>
                <port>22</port>
                <auth>
                   <type>key</type>
                   <user>testuser</user>
                   <private-key>/usr/local/icinga-web/app/modules/Api/lib/.ssh/host1_rsa</private-key>
                   <password>secret123</password>
                </auth>
             </ssh-config>
            ~~~~

            Here the private key defined in the 'private-key' tag will
            be used. You shouldn't and needn't to define this path in
            the hosts-access section!

-   `databases.xml`{.filename} - holds the connection information for
    your icinga-web database

    -   *General settings*

        The following settings are applicable to every database defined
        in Icinga Web

        If you look at the default icinga\_web database definition,
        you'll see most of the settings that exist on a generic database
        connection:

        ~~~~ {.screen}
        <db:database name="icinga_web" class="AppKitDoctrineDatabase">
            <ae:parameter name="dsn">mysql://icinga_web:icinga_web@localhost:3306/icinga_web</ae:parameter>
            <ae:parameter name="charset">utf8</ae:parameter>
            <ae:parameter name="manager_attributes">
                <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
            </ae:parameter>

            <ae:parameter name="load_models">%core.module_dir%/AppKit/lib/database/models/generated</ae:parameter>
            <ae:parameter name="models_directory">%core.module_dir%/AppKit/lib/database/models</ae:parameter>
            <ae:parameter name="date_format"><![CDATA[YYYY-MM-DD HH24:MI:SS]]></ae:parameter>


            <ae:parameter name="caching">
                <ae:parameter name="enabled">false</ae:parameter>
                <ae:parameter name="driver">apc</ae:parameter>
                <ae:parameter name="use_query_cache">true</ae:parameter>
                <ae:parameter name="use_result_cache">true</ae:parameter>
                <ae:parameter name="result_cache_lifespan">60</ae:parameter>
            </ae:parameter>

        </db:database>
        ~~~~

        -   Database identifier

            ~~~~ {.screen}
            <db:database name="%Database name%" class="%Handler%">
               ...
            </db:database>
            ~~~~

            With the db:database tag you let Icinga Web know about a
            database, this tag must have two attributes:

            -   name: The name for your database. At this time (\>=
                v1.5) 'icinga-web' is reserved for the internal
                icinga-web database, containing user information,
                credentials, persistence settings, etc. and 'icinga',
                which represents the database ido2db writes its Icinga
                information to.

            -   class: Always use AppKitDoctrineDatabase, only the
                'icinga' database required 'IcingaDoctrineDatabase' (see
                later)

        -   dsn (Data Source Name):

            Defines the credentials, type and location of the database:

            For MySQL, PostgreSQL, and Oracle:

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="dsn">%driver%://%username%:%password%@%host%:%port%/%database name%</ae:parameter>
                ...
            </db:database>
            ~~~~

            For sqlite3:

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="dsn">sqlite:///%path to your db file%</ae:parameter>
                ...
            </db:database>
            ~~~~

            ![[Note]](../images/note.png)

            Note

            SQLite database files must be read and writeable for the
            webserver's user, as well as the folder that contains the
            file.

            -   %driver%: The database backend to use

                -   mysql: A MySQL database

                -   pgsql: A PostgreSQL database

                -   oracle: An Oracle database accessed via the
                    [oci8](http://www.php.net/manual/de/book.oci8.php)
                    driver.

                    Don't use the pdo driver, as this one is far away
                    from being ready for productive use.

                -   icingaOracle: Special implementation that must be
                    used when using an Icinga database (some table names
                    are different, and name length limits must be
                    automatically respected to ensure no developers are
                    killing themselves during development).

            -   %username%: The username to use for db-authentication

            -   %password%: The password to use for db-authentication

            -   %host%: The host of your db-server

            -   %port%: The port of your db-server

                -   mysql-default: 3306

                -   postgresql-default: 5432

                -   oracle-default: 1521

            -   %database name%: The name of your database

        -   charset

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="charset">utf8</ae:parameter>
                ...
            </db:database>
            ~~~~

            In general, your database charset should be utf8.

        -   manager\_attributes, load\_models, models\_directory

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="manager_attributes">
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                </ae:parameter>
                ...
            </db:database>
            ~~~~

            You can safely ignore this section and just copy it, this
            only handles doctrine specific settings (in particular, how
            database models will be loaded and where they are located.
            If you want to know more, look at the [doctrine
            documentation](http://www.doctrine-project.org/projects/orm/1.2/docs/manual/introduction-to-models/en#autoloading-models)).

        -   date\_formate

            This is required to properly access oracle databases and
            sets the date format to use for this database.

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="date_format"><![CDATA[YYYY-MM-DD HH24:MI:SS]]></ae:parameter>
                ...
            </db:database>
            ~~~~

        -   Caching

            ~~~~ {.screen}
            <db:database ...>
                ...
                <ae:parameter name="caching">
                    <ae:parameter name="enabled">false</ae:parameter>
                    <ae:parameter name="driver">apc</ae:parameter>
                    <ae:parameter name="use_query_cache">true</ae:parameter>
                    <ae:parameter name="use_result_cache">true</ae:parameter>
                    <ae:parameter name="result_cache_lifespan">60</ae:parameter>
                </ae:parameter>
            <db:database>
            ~~~~

            If you use apc or memcache, you can cache either database
            queries or results. While query caching almost never is a
            bad thing (if you're not developing), result cache is a
            rather specific case - as you might get outdated data from
            your database. **So never use it for your Icinga database!**

            -   enabled: Turn caching on or off for this database

            -   driver: apc or memcache, though memcache is experimental
                (so try it out !)

            -   use\_query\_cache: Cache queries (only the sql used to
                request, not the results)

            -   use\_result\_cache: Cache database results (**danger!**)

            -   result\_cache\_lifespan: How long results should be
                cached in seconds when using use\_result\_cache

    -   *The icinga\_web database*

        You must have an icinga\_web database which holds information
        about users, credentials, view-persistence, etc. This database
        must be called 'icinga\_web'. All settings are described in the
        previous section.

    -   *The icinga database*

        From icinga-web v1.5, the icinga-api will be accessed via
        doctrine (previously there was an own project, the
        'icinga-api'). In the following, only special and additional
        settings will be explained. If not mentioned otherwise, all
        rules from ['General
        settings'](icinga-web-config.md#configweb-general) apply.

        -   Database identifier

            The icinga database identifier must use
            IcingaDoctrineDatabase as the 'class' attribute and 'icinga'
            as the database name, see:

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
            </db:database>
            ~~~~

        -   dsn

            You can use the same credentials as in
            `ido2db.cfg`{.filename} but for security reasons, it's
            highly advised to create a read only user especially for
            icinga-web. Below is an example which values from
            `ido2db.cfg`{.filename} fit.

            ~~~~ {.screen}
                <ae:parameter name="dsn">mysql://db_user:db_pass@db_host:db_port/db_name</ae:parameter>
            ~~~~

        -   prefix

            Defines the prefix like defined in Icinga's
            `ido2db.cfg`{.filename}

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
                <ae:parameter name="prefix">icinga_</ae:parameter>
            ...
            </db:database>
            ~~~~

            For Oracle, add a blank value.

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
                <ae:parameter name="prefix"></ae:parameter>
            ...
            </db:database>
            ~~~~

        -   use\_retained

            Whether to use retained or original data dumps (see the
            value in `idomod.cfg`{.filename})

            ~~~~ {.screen}
            <db:database name="icinga" class="IcingaDoctrineDatabase">
            ...
                 <ae:parameter name="use_retained">true</ae:parameter>
            </db:database>
            ~~~~

    -   *Complete listing*

        ~~~~ {.screen}
        <?xml version="1.0" encoding="UTF-8"?>
         
        <databases xmlns:db="http://agavi.org/agavi/config/parts/databases/1.0" xmlns:ae="http://agavi.org/agavi/config/global/envelope/1.0">
            
            <db:database name="icinga_web" class="AppKitDoctrineDatabase">
                <ae:parameter name="dsn">mysql://icinga_web:icinga_web@localhost:3306/icinga_web</ae:parameter>
                <ae:parameter name="charset">utf8</ae:parameter>
                <ae:parameter name="manager_attributes">
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                </ae:parameter>

                <ae:parameter name="load_models">%core.module_dir%/AppKit/lib/database/models/generated</ae:parameter>
                <ae:parameter name="models_directory">%core.module_dir%/AppKit/lib/database/models</ae:parameter>
                <ae:parameter name="date_format"><![CDATA[YYYY-MM-DD HH24:MI:SS]]></ae:parameter>

                <ae:parameter name="caching">
                    <ae:parameter name="enabled">false</ae:parameter>
                    <ae:parameter name="driver">apc</ae:parameter>
                    <ae:parameter name="use_query_cache">true</ae:parameter>
                    <ae:parameter name="use_result_cache">true</ae:parameter>
                    <ae:parameter name="result_cache_lifespan">60</ae:parameter>
                </ae:parameter>

            </db:database>
            
            <db:database xmlns="http://agavi.org/agavi/config/parts/databases/1.0" name="icinga" class="IcingaDoctrineDatabase">
                <ae:parameter name="dsn">mysql://icinga:icinga@localhost:3306/icinga</ae:parameter>
                <ae:parameter name="prefix">icinga_</ae:parameter>
                <ae:parameter name="charset">utf8</ae:parameter>
                 <ae:parameter name="use_retained">true</ae:parameter>
                <ae:parameter name="manager_attributes">
                    <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
                </ae:parameter>
                <ae:parameter name="load_models">%core.module_dir%/Api/lib/database/models/generated</ae:parameter>
                <ae:parameter name="models_directory">%core.module_dir%/Api/lib/database/models</ae:parameter>
                <ae:parameter name="caching">
                    <ae:parameter name="enabled">false</ae:parameter>
                    <ae:parameter name="driver">apc</ae:parameter>
                    <ae:parameter name="use_query_cache">true</ae:parameter>
                </ae:parameter>

            </db:database>

        </databases>
        ~~~~

-   `factories.xml`{.filename} - Agavi system config, storage and
    session configuration

    holds the config for your web session, e.g. the
    session\_cookie\_lifetime-parameter

    **Session Cookie Lifetime**

    Example: change the session\_cookie\_lifetime

    The Session Lifetime is the time in seconds until the Icinga Web
    session expires. It can be configured in
    `etc/conf.d/factories.xml`{.filename}.

    ~~~~ {.programlisting}
    <ae:parameter name="session_cookie_lifetime">3600</ae:parameter>
    ~~~~

-   `logging.xml`{.filename} - holds the connection information for your
    icinga-web

-   `settings.xml`{.filename} - Icinga settings, e.g. version and
    prefixes / version name

    includes `icinga.xml`{.filename} as well (holds the config for your
    Icinga Web root-dir, Web path)

-   `translation.xml`{.filename} - Default language, date and time
    formats and settings

    If your time zone differs from GMT you may have to change the
    appropriate settings in `php.ini`{.filename} (or in
    `translation.xml`{.filename} if you are not able to change that
    one). Not adjusting the value might result in the following message:

    **Figure 6.1. Icinga Web instance down**

    ![Icinga Web instance down](../images/icinga-web-instance-down.png)

    \

    Set the directive to a valid value (e.g. 'Europe/Berlin').

-   `views.xml`{.filename} - allow sthe user to add and/or change API
    views.

### 6.7.4. Troubleshooting

-   I can't send commands!

    Make sure your webservers user has write access to the icinga pipe
    and make sure the icinga\_pipe symbol is located in the readwrite or
    write section of your host (or defaults). Make sure the path is
    correct

**Change Icinga Web timezone**

If the time(zone) in Icinga Web differs from your system time(zone),
please check the date.timezone entry in your `php.ini`{.filename}.
Alternatively check the entry in
`app/modules/AppKit/config/module.xml`{.filename} (e.g.
'Europe/Berlin'):

~~~~ {.programlisting}
#> vi app/modules/AppKit/config/module.xml
<ae:parameter name="date.timezone">Europe/Berlin</ae:parameter>
~~~~

**Change user preferences**

The file `module.xml`{.filename} contains several settings which can be
overwritten by custom settings to be placed in
`userpreferences.xml`{.filename} (in the `etc/config`{.filename}
folder).

### 6.7.5. Module Configuration

-   **app/modules/AppKit**

    Here lives the framework spun around: Authentication, Menus and so
    on.

    **Authentication**

    Example: LDAP authentication

    Look into `app/modules/AppKit/config/auth.xml`{.filename}.

    There is a provider like this:

    ~~~~ {.programlisting}
     <ae:parameter name="msad-ldap1">
                <ae:parameter name="auth_module">AppKit</ae:parameter>
                <ae:parameter name="auth_provider">Auth.Provider.LDAP</ae:parameter>
                <ae:parameter name="auth_enable">true</ae:parameter>
                <ae:parameter name="auth_authoritative">true</ae:parameter>
                <ae:parameter name="auth_create">true</ae:parameter>
                <ae:parameter name="auth_update">true</ae:parameter>

                <ae:parameter name="auth_map">
                    <ae:parameter name="user_firstname">givenName</ae:parameter>
                    <ae:parameter name="user_lastname">sn</ae:parameter>
                    <ae:parameter name="user_email">mail</ae:parameter> 
                </ae:parameter>

                <ae:parameter name="ldap_dsn">ldap://ad.icinga.org</ae:parameter>
                <ae:parameter name="ldap_basedn">DC=ad,DC=icinga,DC=org</ae:parameter>
                <ae:parameter name="ldap_binddn">ldap@AD.ICINGA.ORG</ae:parameter>
                <ae:parameter name="ldap_bindpw"><![CDATA[XXXXXXXXX]]></ae:parameter>
                <ae:parameter name="ldap_userattr">uid</ae:parameter>
                <ae:parameter name="ldap_filter_user"><![CDATA[(&(sAmAccountName=__USERNAME__))]]></ae:parameter>
            </ae:parameter>
    ~~~~

    The `auth.xml`{.filename} holds the documentation for the global
    config. The LDAP authentication should be done with some basic LDAP
    knowledge.

    You can also duplicate the provider to provide more authentication
    bases. You can split the auth into authentication and authorising
    parts if you want. If you have new providers, please share them and
    let the auth database grow!

    Please store your custom authentication configuration in
    `auth.xml`{.filename} (in the `etc/config`{.filename} folder)!

-   **app/modules/Cronks**

    All the cronks are implemented there: Grids, iframes. All of them
    are simple html sites which hold ExtJS component codes. If you need
    to add a new cronk, this module is your friend.

    If you want to develop a new cronk take a look at
    [HowToDevelopCronks](https://dev.icinga.org/projects/icinga-development/wiki/HowToDevelopCronks)

    To change the configuration, go to the Cronks module.

    ~~~~ {.programlisting}
    #> ls app/modules/Cronks/config
    autoload.xml  config_handlers.xml  cronks.xml  module.xml  validators.xml
    ~~~~

    -   `module.xml`{.filename} - to define new categories in which the
        cronks appears, module.xml holds all the information

    -   `cronks.xml`{.filename} - to make new cronks accessible or
        define new iframe cronks

-   **app/modules/Web**

    Or better:**Icinga**. This module holds all Icinga related stuff,
    IcingaAPI2Json, status information.

### 6.7.6. Customised Configuration

**Notes**

When creating and/or editing configuration files, keep the following in
mind:

-   Lines that start with a \<!-- and end with --\> character are taken
    to be comments and are not processed

-   Variable names are case-sensitive

![[Note]](../images/note.png)

Note

After changing those configs you need to clear the config cache!

~~~~ {.programlisting}
 #> rm -rf app/cache/config/*.php
~~~~

or

~~~~ {.programlisting}
 #> /usr/local/icinga-web/bin/clearcache.sh
~~~~

You need more information? Please have a look at our [Development
Wiki.](https://dev.icinga.org/projects/icinga-development/wiki/)

* * * * *

  ---------------------------------------------------- -------------------- ---------------------------------------
  [Prev](upgrading_icingaweb.md)                     [Up](ch06.md)       [Next](icinga-web-introduction.md)
  6.6. Upgrading Icinga Web and Icinga Web Database    [Home](index.md)    6.8. Introduction to Icinga Web
  ---------------------------------------------------- -------------------- ---------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
