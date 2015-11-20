[Prev](recurring_downtimes.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](adaptive.md)

* * * * *

7.18. Using The Embedded Perl Interpreter
-----------------------------------------

7.18.1. [Advantages](embeddedperl.md#pros)

7.18.2. [Disadvantages](embeddedperl.md#cons)

7.18.3. [Using The Embedded Perl
Interpreter](embeddedperl.md#interpreter)

7.18.4. [Compiling Icinga With Embedded
Perl](embeddedperl.md#compileicinga)

7.18.5. [Plugin-Specific Use of the Perl
Interpreter](embeddedperl.md#plugspecs)

7.18.6. [Developing Plugins For Use With Embedded
Perl](embeddedperl.md#devlopplugs)

**Introduction**

Icinga can be compiled with support for an embedded Perl interpreter.
This allows Icinga to execute Perl plugins much more efficiently that it
otherwise would, so it may be of interest to you if you rely heavily on
plugins written in Perl.

Without the embedded Perl interpreter, Icinga executes Perl (and
non-Perl) plugins by forking and executing the plugins as an external
command. When the embedded Perl interpreter is used, Icinga can execute
Perl plugins by simply making a library call.

![[Tip]](../images/tip.png)

Tip

The embedded Perl interpreter works with all Perl scripts that Icinga
Perl interpreter in relation to plugins used for host and service
checks, but it applies just the same to other types of Perl scripts you
may be using for other types of commands (e.g. notification scripts,
event handler scripts, etc.).

Stephen Davies contributed the original embedded Perl interpreter code
several years back. Stanley Hopcroft has been the primary person helping
to improve the embedded Perl interpreter code quite a bit and has
commented on the advantages/disadvanges of using it. He has also given
several helpful hints on creating Perl plugins that work properly with
the embedded interpreter.

It should be noted that "ePN", as used in this documentation, refers to
embedded Perl Icinga, or if you prefer, Icinga compiled with an embedded
Perl interpreter.

![](../images/epn.png)

### 7.18.1. Advantages

Some advantages of ePN (embedded Perl Icinga) include:





### 7.18.2. Disadvantages

The disadvantages of ePN (embedded Perl Icinga) are much the same as
Apache mod\_perl (i.e. Apache with an embedded interpreter) compared to
a plain Apache:










### 7.18.3. Using The Embedded Perl Interpreter

If you want to use the embedded Perl interpreter to run your Perl
plugins and scripts, here's what you'll need to do:





### 7.18.4. Compiling Icinga With Embedded Perl

If you want to use the embedded Perl interpreter, you'll first need to
compile Icinga with support for it. To do this, simply run the configure
script with the addition of the *--enable-embedded-perl* option. If you
want the embedded interpreter to cache internally compiled scripts, add
the *--with-perlcache* option as well. Example:

</code></pre>

Once you've rerun the configure script with the new options, make sure
to recompile Icinga.

Packagers might use another option to specify the location of the
`p1.pl` file:

 ./configure --with-p1-file-dir=<path>
</code></pre>

### 7.18.5. Plugin-Specific Use of the Perl Interpreter

You can specify which Perl plugins or scripts should or should not be
run under the embedded Perl interpreter. This is particularly useful if
you have troublesome Perl scripts which do not work well with the Perl
interpreter.

To *explicitly* tell Icinga whether or not to use the embedded Perl
interpreter for a particular perl script, add one of the following
entries to your Perl script/plugin...

To tell Icinga to use the Perl interpreter for a particular script, add
this line to the Perl script:

<pre><code>
 # icinga: +epn
</code></pre>

To tell Icinga to NOT use the embedded Perl interpreter for a particular
script, add this line to the Perl script:

<pre><code>
 # icinga: -epn
</code></pre>

Either line must be located within the first 10 lines of a script for
Icinga to detect it.

![[Tip]](../images/tip.png)

Tip

If you do not *explicitly* use the method above to tell Icinga whether
an individual plugin can be run under the Perl interpreter, Icinga will
make will a decision for you. This decision process is controlled by the
[use\_embedded\_perl\_implicitly](configmain.md#configmain-use_embedded_perl_implicitly)
variable. If the value is set to 1, all Perl plugins/scripts (that do
not explicitly enable/disable the ePN) will be run under the Perl
interpreter. If the value is 0, they will NOT be run under the Perl
interpreter.

### 7.18.6. Developing Plugins For Use With Embedded Perl

Information on developing plugins for use with the embedded Perl
interpreter can be found
[here](epnplugins.md "11.2. Developing Plugins For Use With Embedded Perl").

* * * * *

[Prev](recurring_downtimes.md) | [Up](ch07.md) | [Next](adaptive.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
