![Icinga](../images/logofullsize.png "Icinga")

7.18. Using The Embedded Perl Interpreter

[Prev](recurring_downtimes.md) 

Chapter 7. Advanced Topics

 [Next](adaptive.md)

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
executes - not just plugins. This documentation discusses the embedded
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

-   Icinga will spend much less time running your Perl plugins because
    it no longer forks to execute the plugin (each time loading the Perl
    interpreter). Instead, it executes your plugin by making a library
    call.

-   It greatly reduces the system impact of Perl plugins and/or allows
    you to run more checks with Perl plugin than you otherwise would be
    able to. In other words, you have less incentive to write plugins in
    other languages such as C/C++, or Expect/TCL, that are generally
    recognised to have development times at least an order of magnitude
    slower than Perl (although they do run about ten times faster also -
    TCL being an exception).

-   If you are not a C programmer, then you can still get a huge amount
    of mileage out of Icinga by letting Perl do all the heavy lifting
    without having Icinga slow right down. Note however, that the ePN
    will not speed up your plugin (apart from eliminating the
    interpreter load time). If you want fast plugins then consider Perl
    XSUBs (XS), or C *after* you are sure that your Perl is tuned and
    that you have a suitable algorithm (Benchmark.pm is *invaluable* for
    comparing the performance of Perl language elements).

-   Using the ePN is an excellent opportunity to learn more about Perl.

### 7.18.2. Disadvantages

The disadvantages of ePN (embedded Perl Icinga) are much the same as
Apache mod\_perl (i.e. Apache with an embedded interpreter) compared to
a plain Apache:

-   A Perl program that works *fine* with plain Icinga may *not* work
    with the ePN. You may have to modify your plugins to get them to
    work.

    ![[Important]](../images/important.png)

    Important

    Please note that you might introduce memory leaks so you shouldn't
    run your plugin without having tested/verified it using
    `new_mini_epn`{.filename} (to be found in the `contrib`{.filename}
    folder).

-   Perl plugins are harder to debug under an ePN than under a plain
    Icinga.

-   Your ePN will have a larger SIZE (memory footprint) than a plain
    Icinga.

-   Some Perl constructs cannot be used or may behave differently than
    what you would expect.

-   You may have to be aware of 'more than one way to do it' and choose
    a way that seems less attractive or obvious.

-   You will need greater Perl knowledge (but nothing very esoteric or
    stuff about Perl internals - unless your plugin uses XSUBS).

### 7.18.3. Using The Embedded Perl Interpreter

If you want to use the embedded Perl interpreter to run your Perl
plugins and scripts, here's what you'll need to do:

1.  Compile Icinga with support for the embedded Perl interpreter (see
    instructions below).

2.  Enable the
    [enable\_embedded\_perl](configmain.md#configmain-enable_embedded_perl)
    option in the main configuration file.

3.  Set the
    [use\_embedded\_perl\_implicitly](configmain.md#configmain-use_embedded_perl_implicitly)
    option to fit your needs. This option determines whether or not the
    Perl interpreter should be used by default for individual Perl
    plugins and scripts.

4.  Optionally enable or disable certain Perl plugins and scripts from
    being run using the embedded Perl interpreter. This can be useful if
    certain Perl scripts have problems being running under the Perl
    interpreter. See instructions below for more information on doing
    this.

### 7.18.4. Compiling Icinga With Embedded Perl

If you want to use the embedded Perl interpreter, you'll first need to
compile Icinga with support for it. To do this, simply run the configure
script with the addition of the *--enable-embedded-perl* option. If you
want the embedded interpreter to cache internally compiled scripts, add
the *--with-perlcache* option as well. Example:

~~~~ {.screen}
 ./configure --enable-embedded-perl --with-perlcache  otheroptions...
~~~~

Once you've rerun the configure script with the new options, make sure
to recompile Icinga.

Packagers might use another option to specify the location of the
`p1.pl`{.filename} file:

~~~~ {.screen}
 ./configure --with-p1-file-dir=<path>
~~~~

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

~~~~ {.programlisting}
 # icinga: +epn
~~~~

To tell Icinga to NOT use the embedded Perl interpreter for a particular
script, add this line to the Perl script:

~~~~ {.programlisting}
 # icinga: -epn
~~~~

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

  ----------------------------------- -------------------- ----------------------------
  [Prev](recurring_downtimes.md)    [Up](ch07.md)       [Next](adaptive.md)
  7.17. Recurring Downtimes           [Home](index.md)    7.19. Adaptive Monitoring
  ----------------------------------- -------------------- ----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
