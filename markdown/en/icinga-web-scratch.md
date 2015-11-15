![Icinga](../images/logofullsize.png "Icinga")

6.5. Installation of the Icinga Web Frontend

[Prev](cgicmd.md) 

Chapter 6. User Interfaces

 [Next](upgrading_icingaweb.md)

* * * * *

6.5. Installation of the Icinga Web Frontend
--------------------------------------------

6.5.1. [Introduction](icinga-web-scratch.md#introduction)

6.5.2. [Prerequisites](icinga-web-scratch.md#prerequisites)

6.5.3. [The installation](icinga-web-scratch.md#install)

6.5.4. [Settings](icinga-web-scratch.md#settings)

6.5.5. [Use It!](icinga-web-scratch.md#useit)

6.5.6. [Test & Errors?](icinga-web-scratch.md#webtroubleshooting)

### 6.5.1. Introduction

The new Icinga Web is under heavy development so please keep in mind
that some information in this howto might change without any further
notice. If you require more detailed information about installing,
please check doc/INSTALL.

More information about the overall architecture can be found on our
website:
[https://www.icinga.org/architecture/](http://www.icinga.org/architecture/).
If you want know more about Icinga web development and the module
architecture, please check out the development wiki of Icinga Web:
[Icinga
Wiki](https://dev.icinga.org/projects/icinga-development/wiki#24-Icinga-Web)

This installation guide describes the installation of Icinga Web with
MySQL or PostgreSQL as underlying database. Icinga Web also supports
Oracle as database backend.

### 6.5.2. Prerequisites

-   **MySQL**

    Based on the fact that you have a running MySQL and PHP (with PEAR
    and CLI) environment and Icinga and IDOUtils are running as well,
    you can continue with the second step. Otherwise:

    -   **Ubuntu / Debian**

        ~~~~ {.screen}
         #> apt-get install php5 php5-cli php-pear php5-xmlrpc php5-xsl php5-mysql php-soap php5-gd php5-ldap php5-mysql
        ~~~~

        ![[Note]](../images/note.png)

        Note

        Newer PHP versions (\>= 5.5) are delivered with a separate JSON
        package (due to licensing reasons) so you might have to install
        that as well.

        Check if the module is already there:

        ~~~~ {.programlisting}
         #> php -m | grep -i json
        ~~~~

        *`If the               above statement doesn't show a module please issue:`*

        ~~~~ {.programlisting}
         #> apt-get install php5-json
        ~~~~

    -   **Fedora / RHEL / CentOS**

        ~~~~ {.screen}
         #> yum install php php-cli php-pear php-xmlrpc php-xsl php-pdo php-soap php-gd php-ldap php-mysql
        ~~~~

        ![[Note]](../images/note.png)

        Note

        Make sure you have a repository/packages for PHP 5.2.x -
        RHEL/CentOS (CentOS \<= 5.4) only support 5.1.6 out of the box.
        For running Icinga web you need at least php 5.2.3 and pcre 7.6
        - you can use an external repository, pre-built packages or
        compile php and pcre yourself. Precompiled PCRE and PHP packages
        can be installed e.g. from [Les RPM de
        Remi](http://blog.famillecollet.com/pages/Config-en) or
        [http://www.jasonlitka.com/category/yum-repo-news/](http://www.jasonlitka.com/category/yum-repo-news)

    -   **OpenSuSE**

        Please use yast to install the packages "php5", "php5-pear",
        "php5-xmlrpc", "php5-xsl", "php5-json", "php5-sockets",
        "php5-soap", "php5-gettext", "php5-pdo", "php5-ldap", "php5-gd",
        "php5-mysql" and "apache2-mod\_php5". The CLI is contained in
        the php5 package.

        ![[Note]](../images/note.png)

        Note

        At least in SLES10 SP2 the function "hash\_hmac" is missing.

        If zypper is installed then you can use it instead of yast

        ~~~~ {.screen}
         #> zypper install php5 php5-pear php5-xmlrpc php5-xsl php5-json php5-sockets \
            php5-soap php5-gettext php5-pdo php5-ldap php5-gd php5-mysql apache2-mod_php5
        ~~~~

        Installing Icinga with IDOUtils is described in the [Icinga with
        IDOUtils Quickstart
        Guide](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")

-   **PostgreSQL**

    Based on the fact that you have a running PostgreSQL and PHP (with
    PEAR and CLI) environment and Icinga and IDOUtils are running as
    well, you can continue with the second step. Otherwise:

    -   **Ubuntu / Debian**

        ~~~~ {.screen}
         #> apt-get install php5 php5-cli php-pear php5-xmlrpc php5-xsl php-soap php5-gd php5-ldap php5-pgsql
        ~~~~

    -   **Fedora / RHEL / CentOS**

        ~~~~ {.screen}
         #> yum install php php-cli php-pear php-xmlrpc php-xsl php-pdo php-gd php-ldap php-pgsql
        ~~~~

        ![[Note]](../images/note.png)

        Note

        Make sure you have a repository/packages for PHP 5.2.x -
        RHEL/CentOS (CentOS \<= 5.4) only support 5.1.6 out of the box.
        For running Icinga web you need at least php 5.2.3 and pcre 7.6
        - you can use an external repository, pre-built packages or
        compile php and pcre yourself. Precompiled PCRE and PHP packages
        can be installed e.g. from [Les RPM de
        Remi](http://blog.famillecollet.com/pages/Config-en) or
        [http://www.jasonlitka.com/category/yum-repo-news/](http://www.jasonlitka.com/category/yum-repo-news)

    -   **OpenSuSE**

        Please use yast to install the packages "php5", "php5-pear",
        "php5-xmlrpc", "php5-xsl", "php5-json", "php5-sockets",
        "php5-soap", "php5-gettext", "php5-pdo", "php5-ldap", "php5-gd",
        "php5-pgsql" and "apache2-mod\_php5". The CLI is contained in
        the php5 package.

        ![[Note]](../images/note.png)

        Note

        At least in SLES10 SP2 the function "hash\_hmac" is missing.

        If zypper is installed then you can use it instead of yast

        ~~~~ {.screen}
         #> zypper install php5 php5-pear php5-xmlrpc php5-xsl php5-json php5-sockets \
            php5-soap php5-gettext php5-pdo php5-ldap php5-gd php5-pgsql apache2-mod_php5
        ~~~~

        Installing Icinga with IDOUtils is described in the [Icinga with
        IDOUtils Quickstart
        Guide](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")

### 6.5.3. The installation

-   Please download the archive from
    [http://www.icinga.org/download/](http://www.icinga.org/download/).
    If your need a function only available in the latest developer
    version then clone from the icinga-web.git to get the freshest
    branch:

    ~~~~ {.screen}
     #> git clone git://git.icinga.org/icinga-web.git
    ~~~~

    Unpack your tarball:

    ~~~~ {.screen}
     #> tar xzvf icinga-web-1.13.tar.gz
    ~~~~

    Then change to the directory:

    ~~~~ {.screen}
     #> cd icinga-web-1.13
    ~~~~

    Icinga Web provides several configure options e.g.

    ~~~~ {.screen}
     #> ./configure
                    --prefix=/usr/local/icinga-web
                    --with-web-user=www-data
                    --with-web-group=www-data
                    --with-web-path=/icinga-web
                    --with-web-apache-path=/etc/apache2/conf.d
                    --with-db-type=mysql
                    --with-db-host=localhost
                    --with-db-port=3306
                    --with-db-name=icinga_web
                    --with-db-user=icinga_web
                    --with-db-pass=icinga_web
                    --with-conf-dir=etc/conf.d
                    --with-log-dir=log
                    --with-api-subtype=TYPE DB driver or network connection
                    --with-api-host=HOST Host to connect (DB or other) (default localhost)
                    --with-api-port=PORT Port for connection (default 3306)
                    --with-api-socket=PATH Path to socket (default none)
    ~~~~

    ![[Note]](../images/note.png)

    Note

    Keep in mind that you configure the Icinga Web database, not the
    Icinga IDOUtils database! User and group name of the web process
    depend on the distribution used.

    ![[Note]](../images/note.png)

    Note

    Starting with Apache 2.4 (testing versions of Debian / Ubuntu) the
    default web configuration folder has changed from
    `/etc/apache2/conf.d`{.filename} to
    `/etc/apache2/conf-available`{.filename} so you might have to add
    this option to the call of configure

    ~~~~ {.screen}
    #> ./configure --with-web-apache-path=/etc/apache2/conf-available
    ~~~~

    Please use:

    ~~~~ {.screen}
     #> ./configure --help
    ~~~~

    to see all configure options.

    To configure Icinga Web for PostgreSQL please execute the following
    command:

    ~~~~ {.screen}
     #> ./configure --with-db-type=pgsql --with-db-port=5432
    ~~~~

    If Icinga is running using pgsql as well then please supply the
    api-options as well:

    ~~~~ {.screen}
     #> ./configure --with-db-type=pgsql --with-db-port=5432 \
        --with-api-subtype=pgsql --with-api-port=5432
    ~~~~

    Per default the Icinga Webinterface will be installed to
    `/usr/local/icinga-web`{.filename} using:

    ~~~~ {.screen}
     #> ./configure
     #> make install
    ~~~~

    This may take a while so please be patient ;-).

    Install the new Apache configuration

    ~~~~ {.screen}
     #> make install-apache-config
    ~~~~

    ![[Note]](../images/note.png)

    Note

    Starting with Apache 2.4 (testing versions of Debian / Ubuntu ) you
    have to enable the module

    ~~~~ {.screen}
    #> a2enconf icinga-web
    ~~~~

    If you don't need an alias, you can alternatively use the old
    behaviour setting a symlink instead:

    ~~~~ {.screen}
     #> make install-javascript
    ~~~~

    Make reports after install:

    ~~~~ {.screen}
     #> make install-done

     Installation of icinga-web succeeded.
     Please check the new Apache2 configuration (etc/apache2/icinga-web.conf).
    ~~~~

    Other useful target:

    ~~~~ {.screen}
     #> make icinga-reset-password
    ~~~~

    Reset password for any account on icinga-web.

-   **Adjusting the SELinux settings**

    RHEL and derived distributions like Fedora and CentOS are shipped
    with activated SELinux (Security Enhanced Linux) running in
    "enforcing" mode. This may lead to "Internal Server Error" messages
    when you try to invoke the Icinga-CGIs.

    Check if SELinux runs in enforcing mode

    ~~~~ {.screen}
     #> getenforce
    ~~~~

    Set SELinux in "permissive" mode

    ~~~~ {.screen}
     #> setenforce 0
    ~~~~

    To make this change permanent you have to adjust this setting in
    */etc/selinux/config* and restart the system.

    Instead of deactivating SELinux or setting it into permissive mode
    you can use the following commands to run the CGIs in
    enforcing/targeted mode. The *semanage* command will automatically
    add entries to
    `/etc/selinux/targeted/contexts/files/file_contexts.local`{.filename}.

    ~~~~ {.programlisting}
     #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga-web/app(/.*)?'
     #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga-web/lib(/.*)?'
     #> semanage fcontext -a -t httpd_sys_content_t '/usr/local/icinga-web/pub(/.*)?'
     #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga-web/app/cache(/.*)?'
     #> semanage fcontext -a -t httpd_sys_rw_content_t '/usr/local/icinga-web/log(/.*)?'
    ~~~~

    Once you have defined the necessary contexts you have to apply the
    settings:

    ~~~~ {.programlisting}
     #> chcon -R /usr/local/icinga-web
    ~~~~

    For details please take a look at
    [http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/](http://www.linuxquestions.org/questions/blog/sag47-492023/selinux-and-icinga-34926/).

-   **PHP dependencies**

    Test the php dependencies with:

    ~~~~ {.screen}
     #> make testdeps
    ~~~~

    All required tests should pass successfully. Maybe you have to alter
    the `php.ini`{.filename} for the framework.

    In case of the gpc\_magic\_quote setting, you have to disable both
    entries (apache and cli `php.ini`{.filename}). If you use php \<
    5.3.0, you have to set "safe\_mode" to "off". The locations depend
    on the distributions used.

    ~~~~ {.screen}
     #> vi /etc/php5/apache/php.ini
    ~~~~

    ~~~~ {.programlisting}
       magic_quotes_gpc = off
       safe_mode = off
    ~~~~

    ~~~~ {.screen}
     #> vi /etc/php5/cli/php.ini
    ~~~~

    ~~~~ {.programlisting}
       magic_quotes_gpc = off
    ~~~~

    ![[Note]](../images/note.png)

    Note

    If one of these files is missing you'll get an agavi error
    complaining about the setting of "magic\_quotes\_qpc" because the
    default is "ON".

-   **Database creation**

    Icinga Web requires its own database e.g. icinga\_web. You can use
    the one from Icinga IDOUtils but it is recommended to keep this
    separated for upgrading purposes.

    **Create a database user**

    The user must have default data privileges like SELECT, UPDATE,
    INSERT, DELETE.

    -   **MySQL**

        ~~~~ {.screen}
         # mysql -u root -p

         mysql> CREATE DATABASE icinga_web;

            GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga_web.* TO 'icinga_web'@'localhost' IDENTIFIED BY 'icinga_web';

                quit
        ~~~~

    -   **PostgreSQL**

        ~~~~ {.screen}
         #> su - postgres

         $ psql

         postgres=# CREATE USER icinga_web;

         postgres=# ALTER USER icinga_web WITH PASSWORD 'icinga_web' CREATEDB;

         <Ctrl>+<D>
        ~~~~

    **Create Database**

    Icinga Web ships with Doctrine so you can initialise or drop the
    database directly using 'make'.

    ~~~~ {.screen}
     #> make db-initialize      - creates a spick-and-span database
    ~~~~

    ~~~~ {.screen}
     #> make db-drop            - drops your database with a security query to avoid casualties
    ~~~~

    To use the database creation commands you have to grant privileges
    to the user who will execute the commands on your dbms. If the user
    defined via configure is a low-privileged one, 'make' asks about a
    more privileged one e.g. a root user. If this does not work for you,
    alter 'etc/build.properties' to match the requirements of a root
    user.

    So a simple database install looks like this:

    ~~~~ {.screen}
     #> make db-initialize
    ~~~~

    **Manually create Database**

    If you require manual database creation e.g. for package building,
    you can extract the needed SQL script from
    \</path/to/icinga-web/etc/schema/\>

    and then import the script into your freshly created database:

    -   **MySQL**

        ~~~~ {.screen}
         $ mysql -u root -p icinga_web  < /path/to/icinga-web/etc/schema/mysql.sql
        ~~~~

    -   **Oracle**

        ~~~~ {.screen}
         #> su - oracle
         $ sqlplus dbuser/dbpass
         SQL> @oracle.sql
        ~~~~

    -   **Postgresql**

        ~~~~ {.screen}
         #> su - postgres
         $ psql -U icinga_web -d icinga_web < /path/to/icinga-web/etc/schema/pgsql.sql
        ~~~~

        Please edit the file `pg_hba.conf`{.filename} and add the
        following lines:

        ~~~~ {.screen}
         #> vi /etc/postgresql/9.x/main/pg_hba.conf
        ~~~~

        ~~~~ {.programlisting}
         # database administrative login by UNIX sockets
         local all postgres ident

         # TYPE DATABASE USER CIDR-ADDRESS METHOD
         #icinga_web
         local icinga_web icinga_web trust

         # "local" is for Unix domain socket connections only
         local all all trust

         # IPv4 local connections
         host all all 127.0.0.1/32 trust

         # IPV6 local connections
         host all all ::1/128 trust
        ~~~~

        Please keep in mind to restart PostgreSQL afterwards:

        ~~~~ {.screen}
         #> /etc/init.d/postgresql reload
        ~~~~

### 6.5.4. Settings

There are two different sections:

\* Settings of Icinga Web, especially database settings

\* Settings of the Icinga API which is mandatory as data source

-   **Settings of Icinga Web**

    Normally you can set the database credentials during configure, but
    if you want to recheck or even change them, please adapt those to
    your needs.

    ![[Note]](../images/note.png)

    Note

    You may find it easier to use syntax highlighting while editing xml
    structures to differ between comments and xml tags.

    Edit `/etc/vim/vimrc`{.filename}

    ~~~~ {.screen}
     " Vim5 and later versions support syntax highlighting. Uncommenting the next
     " line enables syntax highlighting by default.
     syntax on
    ~~~~

    or `/etc/nanorc`{.filename}

    ~~~~ {.screen}
     ## HTML
     include "/usr/share/nano/html.nanorc"
    ~~~~

    ~~~~ {.screen}
     #> vi app/config/databases.xml
    ~~~~

    ![[Note]](../images/note.png)

    Note

    Optional: Your specific Icinga database settings can be set in
    `etc/conf.d/database.xml`{.filename} (or where your web\_conf\_path
    directive points to) and will be used in the first place. This won't
    get overwritten during upgrade process. There are two databases :
    'icinga\_web' (for internal use, created above) and 'icinga', which
    is the database ido2db writes to. (if using oracle, you must use
    icingaOracle as the dsn driver)

    ~~~~ {.programlisting}
       <databases default="icinga_web">
          <database name="icinga_web" class="AgaviDoctrineDatabase">

             <!--
                Doctrine dsn strings:

                http://www.doctrine-project.org/documentation/manual/1_1/en/introduction-to-connections
             -->
             <!-- ##### MySQL ##### -->
             <ae:parameter name="dsn">mysql://icinga_web:icinga_web@127.0.0.1:3306/icinga_web</ae:parameter>
             <!-- ##### PostgreSQL ##### -->
             <ae:parameter name="dsn">pgsql://icinga_web:icinga_web@localhost:5432/icinga_web</ae:parameter>

             <!-- Generic credentials  -->
             <!-- <ae:parameter name="username">icinga_web</ae:parameter> -->
             <!-- <ae:parameter name="password">icinga_web</ae:parameter> -->

             <!-- DB encoding type -->
             <ae:parameter name="charset">utf8</ae:parameter>

             <!--
                Doctrine_Manager configuration
             -->
             <ae:parameter name="manager_attributes">
                <!-- This allows lazy loading of the models -->
                <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
             </ae:parameter>

             <!-- The path to our models -->
             <ae:parameter name="load_models">%core.module_dir%/AppKit/lib/database/models/generated</ae:parameter>
             <ae:parameter name="models_directory">%core.module_dir%/AppKit/lib/database/models</ae:parameter>

          </database>

          <-- The ido2db  icinga database-->
          <database name="icinga" class="AgaviDoctrineDatabase">

             <!--
                Doctrine dsn strings:

                http://www.doctrine-project.org/documentation/manual/1_1/en/introduction-to-connections
             -->
             <!-- ##### MySQL ##### -->
             <ae:parameter name="dsn">mysql://icinga:icinga@127.0.0.1:3306/icinga</ae:parameter>
             <!-- ##### PostgreSQL ##### -->
             <ae:parameter name="dsn">pgsql://icinga:icinga@localhost:5432/icinga</ae:parameter>

             <!-- Generic credentials  -->
             <!-- <ae:parameter name="username">icinga</ae:parameter> -->
             <!-- <ae:parameter name="password">icinga</ae:parameter> -->

             <!-- DB encoding type -->
             <ae:parameter name="charset">utf8</ae:parameter>

             <!--
                Doctrine_Manager configuration
             -->
             <ae:parameter name="manager_attributes">
                <!-- This allows lazy loading of the models -->
                <ae:parameter name="Doctrine_Core::ATTR_MODEL_LOADING">CONSERVATIVE</ae:parameter>
             </ae:parameter>

             <!-- The path to our models -->
             <ae:parameter name="load_models">%core.module_dir%/Api/lib/database/models/generated</ae:parameter>
             <ae:parameter name="models_directory">%core.module_dir%/Api/lib/database/models</ae:parameter>

          </database>
       </databases>
          
    ~~~~

    In the `access.xml`{.filename} you can specify the locations of your
    command pipe and the access credentials and method (ssh or via local
    console). Also you define here, which icinga instance is mapped to
    which host.

    ~~~~ {.programlisting}
            <!-- Map your instances to hosts here -->
            <instances>
                <instance name="default">localhost</instance>
            </instances>
            <!-- default location of the icinga pipe -->
            <defaults>
                <access>
                    <write>
                        <files>
                            <resource name="icinga_pipe">/usr/local/icinga/var/rw/icinga.cmd</resource>
                        </files>
                    </write>
                </access>
            </defaults>

            <!-- Hosts that can be accessed via the console interface -->
            <hosts>
                <host name="localhost">
                    <type>local</type>
                    <!-- Only allow access to these files, folders or executables -->
                    <access useDefaults="true">
                        <read>
                            <files>
                                <resource name="test">test</resource>
                            </files>
                        </read>
                    </access>
                </host>

                <!--  Example for ssh connection with user/password auth -->
                <host name="remot_host">
                    <type>ssh</type>
                    <ssh-config>
                        <host>localhost</host>
                        <port>22</port>
                        <auth>
                            <type>password</type>
                            <user>john</user>
                            <password>doe</password>
                        </auth>
                    </ssh-config>

                    <access useDefaults="true" />

                </host>
          </hosts>
          
    ~~~~

    ![[Note]](../images/note.png)

    Note

    After changing those configs you need to clear the config cache
    again!

    ~~~~ {.screen}
     #> rm -rf app/cache/config/*.php
    ~~~~

    or /path/to/clearcache.sh

    ~~~~ {.screen}
     #> /usr/local/icinga-web/bin/clearcache.sh
    ~~~~

-   **Apache settings**

    This should be prepared:

    -   mod\_rewrite enabled, maybe you have to create a link:

        ~~~~ {.screen}
         #> ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
        ~~~~

        Using OpenSuSE or SLES you can use "a2enmod rewrite" to activate
        the module. If that doesn't work you have to edit the file
        "`/etc/sysconfig/apache2`{.filename}". The module "rewrite" has
        to be appended to the line "APACHE\_MODULES=...".

        Using Debian or Ubuntu "a2enmod rewrite" activates the module as
        well.

        The httpd of RHEL / Fedora / CentOS already supports rewriting
        so you don't have to change anything in this regard.

    ![[Note]](../images/note.png)

    Note

    The file `.htaccess`{.filename} has been removed in 1.9 and the
    options have been moved to the Apache configuration file.

    Go to the webservers configuration directory. Look if the created
    config by **make install-apache-config** suits to your
    configuration. Or create new aliases (maybe in
    `/etc/apache2/conf.d/icinga-web.conf`{.filename}) :

    ~~~~ {.screen}
    #> cat /etc/apache2/icinga-web.conf

    # icinga-web apache configuration
    # - Enable all options .htaccess
    # - Add extjs library to alias
    #

    Alias /icinga-web/js/ext3 /usr/local/icinga-web/lib/ext3
    Alias /icinga-web /usr/local/icinga-web/pub

    <Directory /usr/local/icinga-web/lib/ext3>
        Order allow,deny
        Allow from all
    </Directory>

    <Directory /usr/local/icinga-web/pub>
        DirectoryIndex index.php
        Options FollowSymLinks
        AllowOverride all
        Order allow,deny
        Allow from all
    </Directory>
    ~~~~

    Clear cache:

    ~~~~ {.screen}
    #> rm /usr/local/icinga-web/app/cache/config/*.php
    ~~~~

    or /path/to/clearcache.sh

    ~~~~ {.screen}
    #> /usr/local/icinga-web/bin/clearcache.sh
    ~~~~

    Restart your Webserver:

    ~~~~ {.screen}
    #> service apache2 restart
    ~~~~

    or

    ~~~~ {.screen}
    #> /etc/init.d/apache2 restart
    ~~~~

    or

    ~~~~ {.screen}
    #> /etc/init.d/httpd restart
    ~~~~

### 6.5.5. Use It!

**Please ensure that your RDBMS, Apache, IDOUtils and Icinga are
running!**

Go to the webpath (http://localhost/icinga-web/) and check if the
webinterface starts without exceptions (database connections web and
api). You can login with user 'root' and password 'password'.

Have fun! :-)

### 6.5.6. Test & Errors?

![[Note]](../images/note.png)

Note

The following section tries to give some hints on common problems but
due to the nature of "written" material the [wiki
page](https://wiki.icinga.org/display/testing/Icinga+Web+Testing) will
most probably be more current than this manual so if you don't find a
solution here then have a look over there.

The following collection shows some useful information how to resolve
errors - and what you should provide when reporting an error to the
mailing lists or http://www.icinga-portal.org:

-   Always provide the version - package, current tar.gz, or GIT?

-   Add your browser and the version

-   If the problem is related to the data source, provide extensive
    information about IDOUtils, Core (version, debug logs)

Where to look?

-   Apache Error Logs, PHP Errors, PHP files cannot be found

-   `/var/log/messages`{.filename},
    `/path/to/icinga/var/icinga.log`{.filename} Changes on Icinga Web
    Config (e.g. API IDOUtils credentials changed) are not used?

-   Delete the config cache in `app/cache/config/*.php`{.filename}

Use /path/to/clearcache.sh

~~~~ {.screen}
#> /usr/local/icinga-web/bin/clearcache.sh
~~~~

Icinga Web shows a blank page?

-   Apache Error Logs =\> mod\_rewrite enabled, php dependencies ok?
    'make testdeps'. Using Debian you may find something like the
    following: ".htaccess: Invalid command 'RewriteEngine', perhaps
    misspelled or defined by a module not included in the server
    configuration"

-   .htaccess/vhost config =\> paths not correct?

-   "I cannot see my newly installed cronk?" or "after upgrade, I cannot
    access the reporting cronk"

    Starting with 1.8.2, a new session cache was added which may cause
    irritations when upgrading icinga web / installing a new cronk or
    module. The resolution is rather simple

    -   clear the xml cache

    -   reset the users application state (top right corner -\>
        preferences)

    -   logout and re-login (top right corner)

        ![](../images/icinga-web-user-prefs-logout.png)

Icinga Web does not show any data?

-   DB access denied =\> check if the icinga web database connection
    settings are correct

IDOUtils DB does not get filled with data?

-   "Error writing to data sink" =\> check IDOUtils (ido2db runs 2x -
    ok?), ido2db.cfg debug\_level=-1, debug\_verbosity=2, restart
    IDOUtils and look for errors in ido2db.debug

-   Nothing there =\> Check icinga.log if IDOMOD gets loaded if not
    enable the Event Broker Module in icinga.cfg like described in the
    Icinga Core with [IDOUtils Quickstart
    Guide](quickstart-idoutils.md "2.6. Icinga with IDOUtils Quickstart")

-   IDOUtils DB-Schema is the current one? =\> If not check the upgrade
    path and docs of IDOUtils

-   Sockets correctly defined? =\> unix-socket or tcp-socket, the last
    one with or without SSL

**Testing the Web (make sure PHPUnit is installed):**

~~~~ {.screen}
 $> make test
~~~~

![[Note]](../images/note.png)

Note

If you are using your root account for testing then make sure in advance
that the specified web user has a valid shell. Otherwise some tests
might fail. Depending on the version used you might experience wrong
permissions on `/usr/local/icinga-web/log`{.filename} resulting in
Icinga-Web showing "loading" coming to no end!

![[Note]](../images/note.png)

Note

Remember - changing the php settings in `php.ini`{.filename} requires an
Apache reload/restart!

-   PHP Fatal error: Allowed memory size of ... bytes exhausted (tried
    to allocate ... bytes) =\> Check your `php.ini`{.filename} (both
    apache2 and cli) and adjust memory\_limit to 128M or higher

-   PHP Fatal error: Uncaught exception 'AgaviCacheException' with
    message 'Failed to write cache file
    /usr/local/icinga-web/app/cache/config/config\_handlers.xml\_development\_\_xxxx.php"
    generated from configuration file
    /usr/local/icinga-web/app/config/config\_handlers.xml". Please make
    sure you have set correct write permissions for directory
    /usr/local/icinga-web/app/cache.... =\> Check
    `/etc/php5/apache/php.ini`{.filename}, set safe\_mode = off.

    ![[Note]](../images/note.png)

    Note

    This may also be an SELinux issue.

-   [PHP Error] strtotime(): It is not safe to rely on the system's
    timezone settings. You are \*required\* to use the date.timezone
    setting or the date\_default\_timezone\_set() function. In case you
    used any of those methods and you are still getting this warning,
    you most likely misspelled the timezone identifier. We selected
    'Europe/Berlin' for 'CEST/2.0/DST' instead [line 1548 of
    /home/xxx/icinga/icinga-web/lib/doctrine/lib/Doctrine/Record.php] =
    \> You have to define date.timezone in your `php.ini`{.filename}.

-   500 internal server error! Uncaught exception AgaviException thrown!
    Your default timezone is 'System/Localtime', ... =\> You have to
    define date.timezone in your `php.ini`{.filename}.

-   Could not connect to API. The API Connector returned the following
    message: getConnection failed: Database connection failed:
    SQLSTATE[28000] [1045] Access denied for user 'icinga'@'localhost'
    (using password: YES)) =\> check your IDOUtils DB credentials in
    ido2db.cfg and add those to Icinga Web configuration as preferred DB
    credentials for IDO (see above). With 1.0.3 you can set those values
    directly during configure

-   touch: cannot touch '/usr/local/icinga-web/.../cache/testfile.txt':
    Permission denied =\> Your configuration in the xml files will be
    pre-cached by the framework. It therefore needs special permissions
    on the caching directories. By running icingaWebTesting.php in
    etc/tests you will be asked to automatically fix this.

-   PHP Fatal error: Uncaught exception '...' with message 'Couldn't
    locate driver named mysql' =\> Make sure that the php pdo is
    installed and loaded in an appropriate way, even if make testdeps
    tells everything is fine.

-   Login is not shown =\> enable short\_open\_tag in your php.ini =\>
    edit open\_basedir in your `php.ini`{.filename} and add icinga web
    location and parent location of icinga api (e.g.
    `/usr/local/icinga/share/`{.filename})

-   Empty Icinga Web? =\> If mod\_rewrite is enabled and 'index.php'
    appears in the request url the portal does not work. Try to remove
    the index.php from your url and everything should work

-   Login possible but Icinga Web keeps loading data...

-   Request failed, Resource /icinga-web/appkit/ext/application State
    could not be loaded - is the url correct? =\> mod\_rewrite enabled ?

-   Counts in the Status Cronk do not match your configuration? =\>
    Check with the Backend, e.g. IDOUtils DB, selecting the counts for
    the status tables.

-   No Data shown in Cronks? =\> Make sure that all permissions are set
    correctly, especially the log/. Furthermore, you can debug the data
    in your browser.

If you have any updates on that please do not hesitate to report back!
:-)

* * * * *

  --------------------------------------------------------------- -------------------- ----------------------------------------------------
  [Prev](cgicmd.md)                                             [Up](ch06.md)       [Next](upgrading_icingaweb.md)
  6.4. Executing Classic UI modules (CGIs) on the command line    [Home](index.md)    6.6. Upgrading Icinga Web and Icinga Web Database
  --------------------------------------------------------------- -------------------- ----------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
