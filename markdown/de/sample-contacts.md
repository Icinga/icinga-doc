![Icinga](../images/logofullsize.png "Icinga")

13.7. contacts.cfg

[Zurück](sample-commands.md) 

Kapitel 13. Icinga Beispieldateien

 [Weiter](sample-localhost.md)

* * * * *

13.7. contacts.cfg
------------------

~~~~ {.programlisting}
###############################################################################
# CONTACTS.CFG - SAMPLE CONTACT/CONTACTGROUP DEFINITIONS
#
# NOTES: This config file provides you with some example contact and contact
#        group definitions that you can reference in host and service
#        definitions.
#       
#        You don't need to keep these definitions in a separate file from your
#        other object definitions.  This has been done just to make things
#        easier to understand.
#
###############################################################################



###############################################################################
###############################################################################
#
# CONTACTS
#
###############################################################################
###############################################################################

# Just one contact defined by default - the Icinga admin (that's you)
# This contact definition inherits a lot of default values from the 'generic-contact' 
# template which is defined elsewhere.

define contact{
   contact_name                    icingaadmin      ; Short name of user
   use            generic-contact      ; Inherit default values from generic-contact template (defined above)
   alias                           Icinga Admin      ; Full name of user

   email                           @icinga_user@@localhost   ; <<***** CHANGE THIS TO YOUR EMAIL ADDRESS ******
   }



###############################################################################
###############################################################################
#
# CONTACT GROUPS
#
###############################################################################
###############################################################################

# We only have one contact in this simple configuration file, so there is
# no need to create more than one contact group.

define contactgroup{
   contactgroup_name       admins
   alias                   Icinga Administrators
   members                 icingaadmin
   }
~~~~

* * * * *

  --------------------------------- -------------------------- ----------------------------------
  [Zurück](sample-commands.md)    [Nach oben](ch13.md)      [Weiter](sample-localhost.md)
  13.6. commands.cfg                [Zum Anfang](index.md)    13.8. localhost.cfg
  --------------------------------- -------------------------- ----------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
