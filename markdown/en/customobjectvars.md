![Icinga](../images/logofullsize.png "Icinga")

3.5. Custom Object Variables

[Prev](objectdefinitions.md) 

Chapter 3. Configuring Icinga

 [Next](configcgi.md)

* * * * *

3.5. Custom Object Variables
----------------------------

3.5.1. [Introduction](customobjectvars.md#introduction)

3.5.2. [Custom Variable Basics](customobjectvars.md#basicscustomvars)

3.5.3. [Examples](customobjectvars.md#examples)

3.5.4. [Custom Variables As
Macros](customobjectvars.md#customvarsasmacros)

3.5.5. [Custom Variables And
Inheritance](customobjectvars.md#inheritancecustomvars)

### 3.5.1. Introduction

Users often request that new variables be added to host, service, and
contact definitions. These include variables for SNMP community, MAC
address, AIM username, Skype number, and street address. The list is
endless. The problem is that it makes Icinga less generic and more
infrastructure-specific. Icinga was intended to be flexible, which meant
things needed to be designed in a generic manner. Host definitions in
Icinga, for example, have a generic "address" variable that can contain
anything from an IP address to human-readable driving directions -
whatever is appropriate for the user's setup.

Still, there needs to be a method for admins to store information about
their infrastructure components in their Icinga configuration without
imposing a set of specific variables on others. Icinga attempts to solve
this problem by allowing users to define custom variables in their
object definitions. Custom variables allow users to define additional
properties in their host, service, and contact definitions, and use
their values in notifications, event handlers, and host and service
checks.

### 3.5.2. Custom Variable Basics

There are a few important things that you should note about custom
variables:

-   Custom variable names must begin with an underscore (\_) to prevent
    name collision with standard variables

-   Custom variable names are converted to all uppercase before use

-   Custom variables are
    [inherited](objectinheritance.md "7.26. Object Inheritance") from
    object templates like normal variables

-   Scripts can reference custom variable values with [macros and
    environment
    variables](macros.md "5.2. Understanding Macros and How They Work")

![[Important]](../images/important.png)

Important

Custom variables are replaced *during runtime*, neither during the
verification phase (icinga -v icinga.cfg) nor during the Icinga start up
process so placing them in host names, service descriptions, and several
other places of the object definition will lead to an error message
during verification like
"`<object> contains one or more illegal       characters.`{.literal}".
Changing the directive "illegal\_object\_name\_chars" will *not* solve
this issue.

### 3.5.3. Examples

Here's an example of how custom variables can be defined in different
types of object definitions:

~~~~ {.programlisting}
define host{
        host_name       linuxserver
        _mac_address    00:06:5B:A6:AD:AA       ; <-- Custom MAC_ADDRESS variable
        _rack_number    R32                     ; <-- Custom RACK_NUMBER variable
        ...
        }

define service{
        host_name       linuxserver
        description     Memory Usage
        _SNMP_community public                  ; <-- Custom SNMP_COMMUNITY variable
        _TechContact    Jane Doe                ; <-- Custom TECHCONTACT variable
        ....
        }

define contact{
        contact_name    john
        _AIM_username   john16                  ; <-- Custom AIM_USERNAME variable
        _YahooID        john32                  ; <-- Custom YAHOOID variable
        ...
        }
~~~~

### 3.5.4. Custom Variables As Macros

Custom variable values can be referenced in scripts and executables that
Icinga runs for checks, notifications, etc. by using
[macros](macros.md "5.2. Understanding Macros and How They Work") or
environment variables.

In order to prevent name collision among custom variables from different
object types, Icinga prepends "\_HOST", "\_SERVICE", or "\_CONTACT" to
the beginning of custom host, service, or contact variables,
respectively, in macro and environment variable names. The table below
shows the corresponding macro and environment variable names for the
custom variables that were defined in the example above.

**Object Type**

**Variable Name**

**Macro Name**

**Environment Variable**

Host

MAC\_ADDRESS

\$\_HOSTMAC\_ADDRESS\$

ICINGA\_\_HOSTMAC\_ADDRESS

Host

RACK\_NUMBER

\$\_HOSTRACK\_NUMBER\$

ICINGA\_\_HOSTRACK\_NUMBER

Service

SNMP\_COMMUNITY

\$\_SERVICESNMP\_COMMUNITY\$

ICINGA\_\_SERVICESNMP\_COMMUNITY

Service

TECHCONTACT

\$\_SERVICETECHCONTACT\$

ICINGA\_\_SERVICETECHCONTACT

Contact

AIM\_USERNAME

\$\_CONTACTAIM\_USERNAME\$

ICINGA\_\_CONTACTAIM\_USERNAME

Contact

YAHOOID

\$\_CONTACTYAHOOID\$

ICINGA\_\_CONTACTYAHOOID

### 3.5.5. Custom Variables And Inheritance

Custom object variables are
[inherited](objectinheritance.md "7.26. Object Inheritance") just like
standard host, service, or contact variables.

* * * * *

  --------------------------------- -------------------- --------------------------------------
  [Prev](objectdefinitions.md)    [Up](ch03.md)       [Next](configcgi.md)
  3.4. Object Definitions           [Home](index.md)    3.6. CGI Configuration File Options
  --------------------------------- -------------------- --------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
