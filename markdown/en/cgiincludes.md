![Icinga](../images/logofullsize.png "Icinga")

7.24. Custom CGI Headers and Footers (Classic UI)

[Prev](checkscheduling.md) 

Chapter 7. Advanced Topics

 [Next](modified_attr.md)

* * * * *

7.24. Custom CGI Headers and Footers (Classic UI)
-------------------------------------------------

7.24.1. [Introduction](cgiincludes.md#introduction_cgiincludes)

7.24.2. [How Does It Work?](cgiincludes.md#howitworks)

### 7.24.1. Introduction

If you're doing custom installs of Icinga for clients, you may want to
have a custom header and/or footer displayed in the output of the
[Classic UI
modules](cgis.md "6.1. Icinga Classic UI: Information On The Modules")
(CGIs). This is particularly useful for displaying support contact
information, etc. to the end user.

It is important to note that, unless they are executable, custom header
and footer files are not pre-processed in any way before they are
displayed. The contents of the header and footer include files are
simply read and displayed in the Classic UI module's output. That means
they can only contain information a web browser can understand (HTML,
JavaScript, etc.).

If the custom header and footer files are executable, then the files are
executed and their output returned to the user, so they should output
valid HTML. Using this you can run your own custom designed Classic UI
module to insert data into the Icinga display. This has been used to
insert graphs from rrdtool using ddraw and command menus into the Icinga
display pane. The execuable customer header and footer files are run
with the same Classic UI module environment as the main Icinga Classic
UI module, so your files can parse the query information, authenticated
user information, etc. to produce appropriate output.

### 7.24.2. How Does It Work?

You can include custom headers and footers in the output of the Classic
UI modules by dropping some appropriately named HTML files in the *ssi/*
subdirectory of the Icinga HTML directory (i.e.
*/usr/local/icinga/share/ssi*).

Custom headers are included immediately after the \<BODY\>\> tag in the
Classic UI module output, while custom footers are included immediately
before the closing \</BODY\> tag.

There are two types of customer headers and footers:

-   Global headers/footers. These files should be named
    *common-header.ssi* and *common-footer.ssi*, respectively. If these
    files exist, they will be included in the output of all Classic UI
    modules.

-   CGI-specific headers/footers. These files should be named in the
    format *CGINAME-header.ssi* and *CGINAME-footer.ssi*, where
    *CGINAME* is the physical name of the Classic UI module without the
    .cgi extension. For example, the header and footer files for the
    [alert summary Classic UI module](cgis.md#cgis-summary_cgi)
    (summary.cgi) would be named *summary-header.ssi* and
    *summary-footer.ssi*, respectively.

You are not required to use any custom headers or footers. You can use
only a global header if you wish. You can use only CGI-specific headers
and a global footer if you wish. Whatever you want. Really.

* * * * *

  ------------------------------------------ -------------------- -----------------------------
  [Prev](checkscheduling.md)               [Up](ch07.md)       [Next](modified_attr.md)
  7.23. Service and Host Check Scheduling    [Home](index.md)    7.25. Modified attributes
  ------------------------------------------ -------------------- -----------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
