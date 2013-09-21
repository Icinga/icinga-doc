contacts.cfg
============

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
