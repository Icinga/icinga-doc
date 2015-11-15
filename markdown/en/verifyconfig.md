![Icinga](../images/logofullsize.png "Icinga")

4.1. Verifying Your Configuration

[Prev](ch04.md) 

Chapter 4. Running Icinga

 [Next](startstop.md)

* * * * *

4.1. Verifying Your Configuration
---------------------------------

Every time you modify your configuration files, you also have to restart
Icinga. It is important to run a sanity check on your configuration
files because in case of an error Icinga will not be (re)started.

In order to verify your configuration, run Icinga using the **-v**
command line option:

~~~~ {.screen}
 #> /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
~~~~

If you've forgotten to enter some critical data or misconfigured things,
Icinga will show a warning or error message that should point you to the
location of the problem.

Error messages generally print out the line in the configuration file
that seems to be the source of the problem.

On errors, Icinga will often exit the pre-flight check and return to the
command prompt after printing only the first error that it has
encountered.

This is done because one error might lead to consecutive errors as the
remainder of the configuration data is verified.

If you get any error messages you'll need to go and edit your
configuration files to remedy the problem. Warning messages can
*generally* be safely ignored, since they are only recommendations and
not requirements.

Instead of specifying the paths to binary and config file you can issue

~~~~ {.screen}
 #> /etc/init.d/icinga checkconfig
~~~~

which results in just a non-zero return code if your config contains any
errors. This might be useful if you want to restart Icinga
automatically.

Using

~~~~ {.screen}
 #> /etc/init.d/icinga show-errors
~~~~

the command will create a file containing the errors found. If there are
any the contents of the file is shown.

Once you've verified your configuration files and fixed possible errors
you can go ahead with [Section 4.2, “Starting and Stopping
Icinga”](startstop.md "4.2. Starting and Stopping Icinga").

* * * * *

  ---------------------------- -------------------- ------------------------------------
  [Prev](ch04.md)            [Up](ch04.md)       [Next](startstop.md)
  Chapter 4. Running Icinga    [Home](index.md)    4.2. Starting and Stopping Icinga
  ---------------------------- -------------------- ------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
