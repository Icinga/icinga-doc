Installation
============

Prerequisites
-------------

In order to use the NAME-IDOUTILS addon you'll need to have the
following installed and working on your system:

-   NAME-ICINGA or NAME-NAGIOS

-   MySQL or Oracle or PostgreSQL

Version Compatibility
---------------------

In order to use the NAME-IDOUTILS addon, you'll need to be running at
least NAME-ICINGA 1.0 (stable) or NAME-NAGIOS 3.0 (stable).
NAME-IDOUTILS will not work with beta releases of NAME-NAGIOS 3.0.

Obtaining New Versions
----------------------

You can always obtain the latest version of the NAME-IDOUTILS addon by
visiting the NAME-ICINGA download site at:

http://www.NAME-ICINGA.org/download/

Bugs are bound to be present in this daemon and updates are always being
made to NAME-ICINGA, so its important that you stay up to date with the
latest version of NAME-IDOUTILS that works with the version of
NAME-ICINGA you have.

Compiling
---------

Compiling should be easy as pie.

If you haven't already, unpack the NAME-IDOUTILS tarball:

    tar xzvf NAME-IDOUTILS-1.4b9.tar.gz

Change to the NAME-IDOUTILS-\<version\> directory that has been created
and run the configure script:

    cd NAME-IDOUTILS-1.4b9/
    ./configure

Compile the components of the addon with the following command:

    make

Installation
------------

Since NAME-IDOUTILS 1.4b9 you are able to install NAME-IDOUTILS like
your NAME-ICINGA using a simple make target.

During this step all necessary binaries will be copied to your --prefix
path, especially to your --bindir which you specified during the
configure.

**To use with a NAME-NAGIOS 3.x Installation**

Since NAME-IDOUTILS 1.4b9 you are able to run

    make install

direct after `make`.

This will install the different binary files which belongs to the
NAME-IDOUTILS Project to your specified path (`--prefix` or
`--binddir`).

> **Note**
>
> `make install` will install ndomod and ndo2db for a NAME-NAGIOS 3.x
> installation per default.
>
> If you would install NAME-IDOUTILS for a NAME-NAGIOS 2.x Version, read
> Section 4.5.2

**To use with a NAME-NAGIOS 2.x Installation**

> **Note**
>
> `make install-2x` will install ndomod and ndo2db for a NAME-NAGIOS 2.x
> installation.
>
> If you would install NAME-IDOUTILS for a NAME-NAGIOS 3.x Version, read
> Section 4.5.1

That's it! Now its time to configure everything...

Currently, the NAME-IDOUTILS addon only supports MySQL as a database
backed. Support for PostgresQL will likely be added in the future.

> **Note**
>
> If you aren't already using it, I would suggest installing phpMyAdmin
> (http://www.phpmyadmin.net) to help manage your MySQL server and
> databases.

1.  First, you'll need to create a new database called "NAME-ICINGA", or
    whatever you'd like.

2.  Next, add a user that as SELECT, INSERT, UPDATE, and DELETE
    privileges on the database you just created. Keep this information
    handy, as you'll need it when you configure things.

3.  Finally, run the installation script to create the database tables
    necessary to hold the data the NDO2DB daemon. The script for doing
    this (installdb) can be found in the db/ subdirectory of the
    NAME-IDOUTILS distribution.

        cd db/
        ./installdb

Configuration
=============

Its time to configure the NAME-IDOUTILS addon components. Sample config
files are included in the config/ subdirectory of the NAME-IDOUTILS
distribution.

1.  First, add the following entry to your main NAME-ICINGA
    configuration file (usually
    /usr/local/NAME-ICINGA/etc/NAME-ICINGA.cfg):

        broker_module=/usr/local/NAME-ICINGA/bin/ndomod.o config_file=/usr/local/NAME-ICINGA/etc/ndomod.cfg

2.  Next, install the sample NDOUilts config files:

        make install-config

    This will install the distribution configuration files to your
    sysconfdir (usually /usr/local/NAME-ICINGA/etc/) as
    \<filename\>-sample.cfg.

    This will prevent to overwrite your personal changes. After adapting
    your personal changes to the newly created config files and rename
    them:

        mv /usr/local/NAME-ICINGA/etc/ndomod-sample.cfg /usr/local/NAME-ICINGA/etc/ndomod.cfg
        mv /usr/local/NAME-ICINGA/etc/ndo2db-sample.cfg /usr/local/NAME-ICINGA/etc/ndo2db.cfg

3.  Edit the ndomod.cfg and ndo2db.cfg config files to match your setup.
    You'll need to specify things like the database name, prefix,
    username/password, etc.

4.  Make sure the following entry appears in your main NAME-ICINGA
    configuration file (NAME-ICINGA.cfg).

    If you don't specify this option, NAME-ICINGA may not pass any data
    to the addon for storage in the database.

        event_broker_options=-1

> **Tip**
>
> To save some overall performance, you should think about which data
> you really need from the NAME-IDOUTILS.
>
> NAME-ICINGA itself produces a lot of timed event data which represents
> the NAME-ICINGA internal scheduling queue. You can safe yourself some
> trouble if you unregister your ndomod.o from this events.
>
> Just configure a less greedy ndo broker option like this:
>
>     data_processing_options=1048573

Getting things running
======================

Once things are configured, you can start things running.

1.  Start the NDO2DB daemon:

        /usr/local/NAME-ICINGA/bin/ndo2db -c /usr/local/NAME-ICINGA/etc/ndo2db.cfg

    or just use the init script by execute:

        /etc/init.d/ndo2db start

2.  Check the system logs and make sure the daemon started up okay

3.  Start NAME-ICINGA if its not running.

        /usr/local/NAME-ICINGA/bin/NAME-ICINGA -d /usr/local/NAME-ICINGA/etc/NAME-ICINGA.cfg

    > **Note**
    >
    > If NAME-ICINGA is already running, restart it by sending a SIGHUP
    > signal or using the NAME-ICINGA web interface.

4.  Check the NAME-ICINGA logs to make sure it started okay.

    You should see some log entries that say the ndomod.o module was
    loaded successfully and connected to the data sink.

    If the ndomod.o module didn't appear to load, check your NAME-ICINGA
    config files to make sure you added the appropriate broker module
    entries to your main config file.

    If there are errors connecting to the data sink, make sure the
    NDO2DB daemon is running.

5.  Check the system logs to make sure the NDO2DB daemon is working
    okay.

    You should see some log entries telling you that a connection was
    received (by the ndomod.o module loaded by NAME-ICINGA) and a
    connection to the database was successfully make.

    If there are errors, make sure you specified the appropriate
    database, username, password, and table prefix in your ndo2db.cfg
    config file.

    If there are errors relating to being unable to run a specific MySQL
    query, chances are that you either didn't create the appropriate
    database tables (outlined above in the configuration section) or
    your ndo2db.cfg config file entries don't match your setup.

    You'll need to restart the NDO2DB daemon if you make changes to the
    config file.

That's it - data from NAME-ICINGA should now be getting stored in
database!

\</section\>
