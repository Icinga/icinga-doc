Changelog of the NAME-WEB
=========================

**NAME-WEB 1.0.3 18/08/2010**

\* Unify configure switches

\* Added external version for configure

\* Change login text to some more 'generic' (fixes \#714)

\* Changed icinga-api path to unify icinga style (fixes \#445)

\* Simplified js redirect

\* Adding apache configuration for including

\* Adding api connection switches (fixes \#630)

\* Fixed release string in HelloCronk

\* Configure handling (ref \#630)

\* Substitude web:module.xml for api connection

\* Doc for icinga-api connections

\* Cleaned up namespaces

\* Cleaned up icinga.xml

\* Prepared version in configure

\* Added normalizing in module configuration

\* Files for Makefile

\* Fix for 'groupsonly' cronk filter (Thanks to Birger)

\* Modularized css and js files

\* Global module namespace for module config

\* Rewritten config namespace

\* Reorganized the icon structure

\* Fix for preferences settings for not logged in users

\* Readded stateful log cronk

\* Purge userprefs from the userpref screen

\* Adding default welcome cronk setting

\* Added hideable bars on cronk portal

\* Fixed portlet resize issue (fixes \#383)

\* Better commands, sending commands to its instances (fixes \#561)

\* Adding per user grid attributes (fixes \#567)

\* Check valid session and warn if expired (fixes \#606)

\* Changed process of grid count queries

\* Activated clean traget (clean-\>distclean) (fixes \#634)

\* Bugfix for AM/PM times (fixes \#360)

\* Adding xtype to Cronk.factory to avoid empty cronks after reload

\* Adding new icinga-throbber (Thanks Karo)

\* Added position field for categories

\* Adding charts template based on Ext pie charts

\* Makefile files regeneration

\* Splitted the xml templates into directories

\* Finished host- / servicegroup to templates, Splitting templates into
parts

\* Icinga stateinfo class text wrapper

\* Fixed Makefile files.mk (\#fixes 619)

\* Several IE compatibility fixes

\* Adding new TacticalOverview template implementation

\* Fixed Portlet view. Maybe persistence problems can occur

\* Added disappeared validator in User/Edit.xml for altering connection

\* Removed premilinary (and forgotten) email RegExp with a real one

\* Recreated configure.ac for new version

\* Add make-tarball for make create-tarball(-nightly)it is now possible
to create git archived tarballs including submodules

\* make create-tarball, creates normal tgz+md5

\* make create-tarball-nightly, creates tgz+md5 with
\$date-\$shortcommithash

\* Disabled cache for squish loader, works better at the moment

**NAME-WEB 1.0.1 30/06/2010**

\* Core code reduced and made more robust

\* Core code detatached to its owning modules

\* Module framework defined, extractor and installer

\* Principals now works in one step (one function code)

\* Instances included

\* Ajax driven filters, made some new filters

\* REST/Json api interface (web/api,
[URL-ICINGA-DEVissues/305](https://dev.icinga.org/issues/305))

\* New summary cronk (faster, faster, faster)

\* New cronk list (also categories, faster, faster, faster)

\* Single click in the web interface

\* Translation (not complete)

**NAME-WEB 0.9.1-beta- 03/03/2010**

\* Added some Icinga specific principal target classes

\* Finished editing of principal targets for users and groups

\* Added editing models for principals

\* Finished principal target filtering in xml templates

\* Added default Icinga filter targets

\* Moved icinga lib to a new place

\* Added principal target toolkit for api search queries

\* Finished principal target framework

\* Added full command specification

\* Fixed filter window bug (\#232)

\* Added host- / service status filter

\* Host- / serviceinfo info icons

\* ExtJs update to version 3.1

\* DB field for class length 80 (principal target)

\* CVs different for host and service (schema changes)

\* Make fix for files (make)

\* Removed temp files

\* Changes status icon files (from icinga theme, smaller)

\* Added some more state (flapping, downtime)

\* Makefile bin permission (\#245)

\* Drop decision for phing

\* Adapted the phing db targets to gnu make

\* Some makefile fixes, help text, targets

\* Updated phing to stable version 2.3.3

\* Added AC options for db installing

\* AC rewrites build.properties for phing

\* Database.xml is now substituted by AC

\* Write some doc for the new install process

\* Stateful framework is running

\* Changed cookie encoding method to json

\* Tabpanel is persistent

\* Cookie write filter merges the data

\* Static content (tactical overview)

\* ExtJS persistent fixes

\* Portal is persistent (column models)

\* Portal columns determined when dragging over

\* Tactical overview

\* Portalcronks height persistent

\* Async cronk creation (Render hidden, render, show)

\* Tactical overview template engine (ready)

\* Wrapped static content into a div

\* Auto refresh grid panels (settings)

\* Grid filters are persistent

\* Default font style

\* Head elements (still missing ???)

\* Auth framework changed (Multiple, simultaneous)

\* Checked persistent, user specific data

\* Reducing mass persistent data of filter settings

\* Implemented categories for the cronks

\* Cronks for usergroups only (\#262)

**NAME-WEB 0.9.1-alpha-16/12/2009**

\* Updated install-fromscratch.txt: Apache settings ...

\* Removed the yui top menu and implemented top nav with ExtJ

\* Removed yui

\* Removed unused libraries (gc-prettify, jquery, firebug-lite)

\* Cherry-picked Hendriks makefile changes

\* Changed installer toolkit to make basic installs

\* Installer fixes: paths and permissions

\* Added explicit bin owner for webfiles

\* Added rabbit dropping script to clear temp and bak files

\* Added deflate to htaccess

\* Fixed guest users for the menuextender (adding items before admin
submenu)

\* Commands should work (Templates, Ajax proc, command factory, auth,
...)

\* Changing API result keys to uppercase

\* Opera array type fixes (notification baloon)

\* Added AC macro to detect the web user

\* Global xml replacements within the templates (view proc)

\* Updating ExtJS to 3.0.3

\* Removed php notice warnings (isset, undef vars)

\* Fixed make error (\#206)

**NAME-WEB 0.9.0-alpha -28/10/2009**

\* This is the initial release, prototyping, testing, think about
features

Changelog NAME-WEB
