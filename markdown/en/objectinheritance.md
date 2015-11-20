[Prev](modified_attr.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](objecttricks.md)

* * * * *

7.26. Object Inheritance
------------------------

7.26.1.
[Introduction](objectinheritance.md#objectinheritance-introduction)

7.26.2. [Basics](objectinheritance.md#objectinheritance-basics)

7.26.3. [Local Variables vs. Inherited
Variables](objectinheritance.md#objectinheritance-localvsinveritedvars)

7.26.4. [Inheritance
Chaining](objectinheritance.md#objectinheritance-inheritancechaining)

7.26.5. [Using Incomplete Object Definitions as
Templates](objectinheritance.md#objectinheritance-templates)

7.26.6. [Custom Object
Variables](objectinheritance.md#objectinheritance-customobjectvariables)

7.26.7. [Cancelling Inheritance of String
Values](objectinheritance.md#objectinheritance-cancel_string)

7.26.8. [Additive Inheritance of String
Values](objectinheritance.md#objectinheritance-add_string)

7.26.9. [Implied
Inheritance](objectinheritance.md#objectinheritance-implied_inheritance)

7.26.10. [Implied/Additive Inheritance in
Escalations](objectinheritance.md#objectinheritance-implied_escalations)

7.26.11. [Important
values](objectinheritance.md#objectinheritance-important_values)

7.26.12. [Multiple Inheritance
Sources](objectinheritance.md#objectinheritance-multiple_templates)

7.26.13. [Precedence With Multiple Inheritance
Sources](objectinheritance.md#objectinheritance-multipleinheritancesources)

### 7.26.1. Introduction

This documentation attempts to explain object inheritance and how it can
be used in your [object
definitions](objectdefinitions.md "3.4. Object Definitions").

If you are confused about how recursion and inheritance work after
reading this, take a look at the sample object config files provided in
the Icinga distribution. If that still doesn't help, drop an email
message with a *detailed* description of your problem to the
*icinga-users* mailing list.

### 7.26.2. Basics

There are three variables affecting recursion and inheritance that are
present in all object definitions. They are *"indicated"* as follows...

</code></pre>

The first variable is *name*. Its just a "template" name that can be
referenced in other object definitions so they can inherit the objects
properties/variables. Template names must be unique amongst objects of
the same type, so you can't have two or more host definitions that have
"hosttemplate" as their template name.

The second variable is *use*. This is where you specify the name of the
template object that you want to inherit properties/variables from. The
name you specify for this variable must be defined as another object's
template named (using the *name* variable).

The third variable is *register*. This variable is used to indicate
whether or not the object definition should be "registered" with Icinga.
By default, all object definitions are registered. If you are using a
partial object definition as a template, you would want to prevent it
from being registered (an example of this is provided later). Values are
as follows: 0 = do NOT register object definition, 1 = register object
definition (this is the default). This variable is NOT inherited; every
(partial) object definition used as a template must explicitly set the
*register* directive to be *0*. This prevents the need to override an
inherited *register* directive with a value of *1* for every object that
should be registered.

### 7.26.3. Local Variables vs. Inherited Variables

One important thing to understand with inheritance is that "local"
object variables always take precedence over variables defined in the
template object. Take a look at the following example of two host
definitions (not all required variables have been supplied):

 define host{

 define host{
</code></pre>

You'll note that the definition for host *bighost1* has been defined as
having *hosttemplate1* as its template name. The definition for host
*bighost2* is using the definition of *bighost1* as its template object.
Once Icinga processes this data, the resulting definition of host
*bighost2* would be equivalent to this definition:

 define host{
</code></pre>

You can see that the *check\_command* and *notification\_options*
variables were inherited from the template object (where host *bighost1*
was defined). However, the *host\_name* and *max\_check\_attempts*
variables were not inherited from the template object because they were
defined locally. Remember, locally defined variables override variables
that would normally be inherited from a template object. That should be
a fairly easy concept to understand.

![[Tip]](../images/tip.png)

Tip

If you would like local string variables to be appended to inherited
string values, you can do so. Read more about how to accomplish this
[below](objectinheritance.md#objectinheritance-add_string "7.26.8. Additive Inheritance of String Values").

### 7.26.4. Inheritance Chaining

Objects can inherit properties/variables from multiple levels of
template objects. Take the following example:

 define host{

 define host{

 define host{
</code></pre>

You'll notice that the definition of host *bighost3* inherits variables
from the definition of host *bighost2*, which in turn inherits variables
from the definition of host *bighost1*. Once Icinga processes this
configuration data, the resulting host definitions are equivalent to the
following:

 define host{

 define host{

 define host{
</code></pre>

There is no inherent limit on how "deep" inheritance can go, but you'll
probably want to limit yourself to at most a few levels in order to
maintain sanity.

### 7.26.5. Using Incomplete Object Definitions as Templates

It is possible to use imcomplete object definitions as templates for use
by other object definitions. By "incomplete" definition, I mean that all
required variables in the object have not been supplied in the object
definition. It may sound odd to use incomplete definitions as templates,
but it is in fact recommended that you use them. Why? Well, they can
serve as a set of defaults for use in all other object definitions. Take
the following example:

 define host{

 define host{

 define host{
</code></pre>

Notice that the first host definition is incomplete because it is
missing the required *host\_name* variable. We don't need to supply a
host name because we just want to use this definition as a generic host
template. In order to prevent this definition from being registered with
Icinga as a normal host, we set the *register* variable to 0.

The definitions of hosts *bighost1* and *bighost2* inherit their values
from the generic host definition. The only variable we've chosed to
override is the *address* variable. This means that both hosts will have
the exact same properties, except for their *host\_name* and *address*
variables. Once Icinga processes the config data in the example, the
resulting host definitions would be equivalent to specifying the
following:

 define host{

 define host{
</code></pre>

At the very least, using a template definition for default variables
will save you a lot of typing. It'll also save you a lot of headaches
later if you want to change the default values of variables for a large
number of hosts.

### 7.26.6. Custom Object Variables

Any [custom object
variables](customobjectvars.md "3.5. Custom Object Variables") that
you define in your host, service, or contact definition templates will
be inherited just like other standard variables. Take the following
example:

 define host{

 define host{
</code></pre>

The host *bighost1* will inherit the custom host variables
*\_customvar1* and *\_snmp\_community*, as well as their respective
values, from the *generichosttemplate* definition. The effective result
is a definition for *bighost1* that looks like this:

 define host{
</code></pre>

### 7.26.7. Cancelling Inheritance of String Values

In some cases you may not want your host, service, or contact
definitions to inherit values of string variables from the templates
they reference. If this is the case, you can specify "**null**" (without
quotes) as the value of the variable that you do not want to inherit.
Take the following example:

 define host{

 define host{
</code></pre>

In this case, the host *bighost1* will not inherit the value of the
*event\_handler* variable that is defined in the *generichosttemplate*.
The resulting effective definition of *bighost1* is the following:

 define host{
</code></pre>

### 7.26.8. Additive Inheritance of String Values

Icinga gives preference to local variables instead of values inherited
from templates. In most cases local variable values override those that
are defined in templates. In some cases it makes sense to allow Icinga
to use the values of inherited *and* local variables together.

This "additive inheritance" can be accomplished by prepending the local
variable value with a plus sign (**+**). This features is only available
for standard (non-custom) variables that contain string values. Take the
following example:

 define host{

 define host{
</code></pre>

In this case, the host *linuxserver1* will append the value of its local
*hostgroups* variable to that from *generichosttemplate*. The resulting
effective definition of *linuxserver1* is the following:

 define host{
</code></pre>

### 7.26.9. Implied Inheritance

Normally you have to either explicitly specify the value of a required
variable in an object definition or inherit it from a template. There
are a few exceptions to this rule, where Icinga will assume that you
want to use a value that instead comes from a related object. For
example, the values of some service variables will be copied from the
host the service is associated with if you don't otherwise specify them.

The following table lists the object variables that will be implicitly
inherited from related objects if you don't explicitly specify their
value in your object definition or inherit them from a template.

**Object Type**

**Object Variable**

**Implied Source**

**Services**

*contact\_groups*

*contact\_groups* in the associated host definition

*contacts*

*contacts* in the associated host definition

*notification\_interval*

*notification\_interval* in the associated host definition

*notification\_period*

*notification\_period* in the associated host definition

**Host Escalations**

*contact\_groups*

*contact\_groups* in the associated host definition

*contacts*

*contacts* in the associated host definition

*notification\_interval*

*notification\_interval* in the associated host definition

*escalation\_period*

*notification\_period* in the associated host definition

**Service Escalations**

*contact\_groups*

*contact\_groups* in the associated service definition

*contacts*

*contacts* in the associated service definition

*notification\_interval*

*notification\_interval* in the associated service definition

*escalation\_period*

*notification\_period* in the associated service definition

![[Note]](../images/note.png)

Note

These values are inherited in case of an object changing its state so
"in the associated ... definition" only means the one host/service
combination failing/recovering although it is possibly to execute a
service for one or more host groups.

### 7.26.10. Implied/Additive Inheritance in Escalations

Service and host escalation definitions can make use of a special rule
that combines the features of implied and additive inheritance. If
escalations 1) do not inherit the values of their *contact\_groups* or
*contacts* directives from another escalation template and 2) their
*contact\_groups* or *contacts* directives begin with a plus sign (+),
then the values of their corresponding host or service definition's
*contact\_groups* or *contacts* directives will be used in the additive
inheritance logic.

Confused? Here's an example:

 define host{

 define hostescalation{
</code></pre>

This is a much simpler equivalent to:

 define hostescalation{
</code></pre>

### 7.26.11. Important values

Service templates can make use of a special rule which gives precedence
to their check\_command value. If the check\_command is prefixed with an
exclamation mark (!), then the template's check\_command is marked as
important and will be used over the check\_command defined for the
service (this is styled after CSS syntax, which uses ! as an important
attribute).

Why is this useful? It is mainly useful when setting a different
check\_command for distributed systems. You may want to set a freshness
threshold and a check\_command that forces the service into a failed
state, but this doesn't work with the normal templating system. Using
this important flag allows the custom check\_command to be written, but
a general distributed template can be used to overrule the
check\_command when used on a central Icinga-erver.

For instance:

# On master
define service {
# On slave
define service {
# Service definition, used by master and slave
define service {
</code></pre>

![[Note]](../images/note.png)

Note

Please note that only one level of inheritance is possible using
important values. That means that you cannot inherit the check\_command
from one template to another and from the latter to a service.

<pre><code>
</code></pre>

### 7.26.12. Multiple Inheritance Sources

Thus far, all examples of inheritance have shown object definitions
inheriting variables/values from just a single source. You are also able
to inherit variables/values from multiple sources for more complex
configurations, as shown below.

# Generic host template
define host{

# Development web server template
define host{

# Development web server
define host{
</code></pre>

![](../images/multiple-templates1.png)

In the example above, *devweb1* is inheriting variables/values from two
sources: *generic-host* and *development-server*. You'll notice that a
*check\_interval* variable is defined in both sources. Since
*generic-host* was the first template specified in *devweb1*'s *use*
directive, its value for the *check\_interval* variable is inherited by
the *devweb1* host. After inheritance, the effective definition of
*devweb1* would be as follows:

# Development web server
define host{
</code></pre>

### 7.26.13. Precedence With Multiple Inheritance Sources

When you use multiple inheritance sources, it is important to know how
Icinga handles variables that are defined in multiple sources. In these
cases Icinga will use the variable/value from the first source that is
specified in the *use* directive. Since inheritance sources can
themselves inherit variables/values from one or more other sources, it
can get tricky to figure out what variable/value pairs take precedence.

Consider the following host definition that references three templates:

 # Development web server
</code></pre>

If some of those referenced templates themselves inherit
variables/values from one or more other templates, the precendence rules
are shown to the right.

Testing, trial, and error will help you better understand exactly how
things work in complex inheritance situations like this. :-)

![](../images/multiple-templates2.png)

* * * * *

[Prev](modified_attr.md) | [Up](ch07.md) | [Next](objecttricks.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
