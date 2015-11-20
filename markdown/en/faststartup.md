[Prev](tuning.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](largeinstalltweaks.md)

* * * * *

8.4. Fast Startup Options
-------------------------

8.4.1. [Introduction](faststartup.md#introduction)

8.4.2. [Background](faststartup.md#background)

8.4.3. [Evaluating Startup Times](faststartup.md#evalstartuptime)

8.4.4. [Pre-Caching Object
Configuration](faststartup.md#precacheobjectconfig)

8.4.5. [Skipping Circular Path
Tests](faststartup.md#skipcircularpathtests)

8.4.6. [Putting It All Together](faststartup.md#puttogether)

### 8.4.1. Introduction

There are a few things you can do that can decrease the amount of time
it take Icinga to startup (or restart). These speedups involve easing
some of the burden involved in processing your configuration files.

Using these techniques is particularly useful when you have one or more
of the following:




### 8.4.2. Background

Whenever Icinga starts/restarts it has to process your configuration
files before it can get down to the business of monitoring. This
configuration startup process involves a number of steps:










Some of these steps can be quite time-consuming when you have large or
complex configurations. Is there a way to speed any of these steps up?
Yes!

### 8.4.3. Evaluating Startup Times

Before we get on to making things faster, we need to see what's possible
and whether or not we should even bother with the whole thing. This is
**--test-scheduling** command line switch to get timing and scheduling
information.

There is an additional option **-S** or **--show-scheduling**. This will
add information about the scheduling queue to the output.

An example of the output (abbreviated to only show relevant portions) is
shown below. For this example, we're using an Icinga config that has 25
hosts defined and just over 10,000 services.

</code></pre> 
 #> /usr/local/icinga/bin/icinga -s /usr/local/icinga/etc/icinga.cfg

Icinga 1.13
Copyright (c) 2009 Nagios Core Development Team and Community Contributors
Copyright (c) 1999-2009 Ethan Galstad
Last Modified: 12-16-2009
License: GPL


Timing information on object configuration processing is listed
object configuration would be useful.

Object Config Source: Config files (uncached)

----------------------------------


Timing information on configuration verification is listed below.

----------------------------------
Object Relationships: 1.400807 sec
</code></pre>

Okay, let's see what happened. Looking at the totals, it took roughly
**11.6** seconds to process the configuration files and another **56**
seconds to verify the config. That means that every time we start or
restart Icinga with this configuration, it will take nearly **68
seconds** of startup work before it can monitor anything! That's not
acceptable if we have to restart Icinga on a semi-regular basis.

What can we do about this? Take another look at the output and you'll
see that Icinga estimates that we could save about **8.4** seconds off
the configuration processing time and another **54.7** off the
verification times. In total, Icinga thinks we could save **63 seconds**
of the normal startup time if some optimizations were taken.

Whoa! From **68 seconds** to just **5 seconds**? Yep, read on for how to
do it.

### 8.4.4. Pre-Caching Object Configuration

Icinga can spend quite a bit of time parsing your config files,
especially if you make use of the template features such as inheritance,
etc. In order to reduce the time it takes to parse your config, you can
have Icinga pre-process and pre-cache your config files for future use.

When you run Icinga with the **-p** command line option, Icinga will
read your config files in, process them, and save them to a pre-cached
object config file (specified by the
[precached\_object\_file](configmain.md#configmain-precached_object_file)
directive). This pre-cached config file will contain pre-processed
configuration entries that are easier/faster for Icinga to process in
the future.

You must use the **-p** command line option along with either the **-v**
or **-s** command line options, as shown below. This ensures that your
configuration is verified before the precached file is created.

</code></pre> 
</code></pre>

The size of your precached config file will most likely be significantly
larger than the sum of the sizes of your object config files. This is
normal and by design.

![](../images/fast-startup1.png)

Once the precached object configuration file have been created, you can
start Icinga and tell it to use the precached config file instead of
your object config file(s) by using the **-u** command line option.

</code></pre> 
</code></pre>

![](../images/important.gif) If you modify your configuration files, you
will need to re-verify and re-cache your configuration files before
restarting Icinga. If you don't re-generate the precached object file,
Icinga will continue to use your old configuration because it is now
reading from the precached file, rather than your source configuration
files.

![](../images/fast-startup2.png)

### 8.4.5. Skipping Circular Path Tests

The second (and most time-intensive) portion of the configuration
startup phase is the circular path check. In the example above, it took
nearly a minute to perform this step of the configuration verification.

What is the circular path check and why does it take so long? The
circular patch check is designed to ensure that you don't define any
circular paths in your host, host dependency, or service dependency
definitions. If a circular path existed in your config files, Icinga
could end up in a deadlock situation. The most likely reason for the
check taking so long is that we're not using an efficient algorithm. A
much more efficient algorithm for detecting circular paths would be most
welcomed. Hint: That means all you CompSci graduate students who have
been emailing me about doing your thesis on Icinga can contribute some
code back. :-)

If you want to skip the circular path check when Icinga starts, you can
add the -x command line option like this:

</code></pre> 
</code></pre>

![](../images/important.gif) It is of utmost importance that you verify
your configuration before starting/restarting Icinga when skipping
circular path checks. Failure to do so could lead to deadlocks in the
Icinga logic. You have been warned.

### 8.4.6. Putting It All Together

Follow these steps if you want to make use of potential speedups from
pre-caching your configuration and skipping circular path checks.

​1. Verify your configuration and create the precache file with the
following command:

</code></pre> 
</code></pre>

​2. Stop Icinga if it is currently running.

​3. Start Icinga like so to use the precached config file and skip
circular path checks:

</code></pre> 
</code></pre>

​4. When you modify your original configuration files in the future and
need to restart Icinga to make those changes take place, repeat step 1
to re-verify your config and regenerate your cached config file. Once
that is done you can restart Icinga through the web interface or by
sending a SIGHUP signal. If you don't re-generate the precached object
file, Icinga will continue to use your old confguration because it is
now reading from the precached file, rather than your source
configuration files.

​5. That's it! Enjoy the increased startup speed.

* * * * *

[Prev](tuning.md) | [Up](ch08.md) | [Next](largeinstalltweaks.md)

8.3. Tuning Icinga For Maximum Performance  |<=== [Index](index.md) ===>|  8.5. Large Installation Tweaks

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
