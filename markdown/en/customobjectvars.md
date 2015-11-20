[Prev](objectdefinitions.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](configcgi.md)

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





![[Important]](../images/important.png)

Important

Custom variables are replaced *during runtime*, neither during the
verification phase (icinga -v icinga.cfg) nor during the Icinga start up
process so placing them in host names, service descriptions, and several
other places of the object definition will lead to an error message
during verification like
Changing the directive "illegal\_object\_name\_chars" will *not* solve
this issue.

### 3.5.3. Examples

Here's an example of how custom variables can be defined in different
types of object definitions:

<pre><code>
define host{

define service{

define contact{
</code></pre>

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

[Prev](objectdefinitions.md) | [Up](ch03.md) | [Next](configcgi.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
