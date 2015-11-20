[Prev](ch03.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](configmain.md)

* * * * *

3.1. Configuration Overview
---------------------------

3.1.1. [Introduction](config.md#introduction_config)

3.1.2. [File names](config.md#config_filenames)

3.1.3. [Main Configuration File](config.md#mainconfigfile)

3.1.4. [Resource File(s)](config.md#resourcefile)

3.1.5. [Object Definition Files](config.md#objectdefinitionfiles)

3.1.6. [CGI Configuration File](config.md#cgiconfigfile)

### 3.1.1. Introduction

There are several different configuration files that you're going to
need to create or edit before you start monitoring anything. Be patient!
Configuring Icinga can take quite a while, especially if you're
first-time user. Once you figure out how things work, it'll all be well
worth your time. :-)

![[Note]](../images/note.png)

Note

Sample configuration files are installed in the */usr/local/icinga/etc/*
directory when you follow the [quickstart installation
guide](quickstart.md "2.3. Quickstart Installation Guides").

If you installed a package then the sample files might be missing. The
contents is listed
[here](sample-config.md "13.1. Sample configuration files and definitions")
for reference.

![](../images/configoverview.png)

### 3.1.2. File names

Names and locations of these configuration files are all up to you but
it is commonly accepted to have files called `icinga.cfg`,
`resource.cfg`, and `cgi.cfg` in the main config
directory.

The names of the object definition files may show the type of
definitions (`contacts.cfg, commands.cfg`,
`timeperiods.cfg`, `notifications.cfg`), the type
of hardware (`printer.cfg`, `switch.cfg`), or the
object which is described (`localhost.cfg`). If your
installation doesn't contain any of these files then there is no need to
panic. Using a web-based configuration tool, a database driven script,
or editing the files with your favourite editor the files may be in
separate folders per geographical location (country, branch, ...) and a
file per physical or logical unit (room, rack, application, development,
...), or the concept which seems to suit your needs best.

### 3.1.3. Main Configuration File

The main configuration file contains a number of directives that affect
how the Icinga daemon operates and links to several other files. This
config file is read by both the Icinga daemon and the CGIs. This is
where you're going to want to get started in your configuration
adventures.

Documentation for the main configuration file can be found
[here](configmain.md "3.2. Main Configuration File Options").

### 3.1.4. Resource File(s)

Resource files can be used to store user-defined macros. The main point
of having resource files is to use them to store sensitive configuration
information (like passwords), without making them available to the CGIs.

You can specify one or more optional resource files by using the
[resource\_file](configmain.md#configmain-resource_file) directive in
your main configuration file.

### 3.1.5. Object Definition Files

Object definition files are used to define hosts, services, hostgroups,
contacts, contactgroups, commands, etc. This is where you define all the
things you want to monitor and how you want to monitor them.

You can specify one or more object definition files by using the
[cfg\_file](configmain.md#configmain-cfg_file) and/or
[cfg\_dir](configmain.md#configmain-cfg_dir) directives in your main
configuration file, but it is advisable to stick to one type of
directive (*either* cfg\_dir *or* cfg\_file until you understand the
implications using both at a time).

An introduction to object definitions, and how they relate to each
other, can be found
[here](configobject.md "3.3. Object Configuration Overview").

Your object definition files can in turn include other files using the
[include\_file](configobject.md#configobject-include_file) or
[include\_dir](configobject.md#configobject-include_dir) directives.
These can only occur outside of the actual object definitions, and
behave very much like the
[cfg\_file=](configmain.md#configmain-cfg_file) and
[cfg\_dir=](configmain.md#configmain-cfg_dir) directives in the main
configuration file.

### 3.1.6. CGI Configuration File

The CGI configuration file contains a number of directives that affect
the operation of the
[CGIs](cgis.md "6.1. Icinga Classic UI: Information On The Modules").
It also contains a reference to the main configuration file, so the CGIs
know how you've configured Icinga and where your object definitions are
stored.

Documentation for the CGI configuration file can be found
[here](configcgi.md "3.6. CGI Configuration File Options").

* * * * *

[Prev](ch03.md) | [Up](ch03.md) | [Next](configmain.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
