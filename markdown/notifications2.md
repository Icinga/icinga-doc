Benachrichtigungen: Beispiele und Fehlersuche
=============================================

Einführung
----------

Die Objektdefinitionen von [Hosts](#objectdefinitions-host),
[Services](#objectdefinitions-service) und
[Kontakten](#objectdefinitions-contact) /
[Kontaktgruppen](#objectdefinitions-contactgroup) wurden im Kapitel
"Icinga konfigurieren" gezeigt, die verschiedenen zu durchlaufenden
Tests, um festzustellen, ob eine Benachrichtigung versandt wird, wurden
im Abschnitt "[Benachrichtigungen](#notifications)" beschrieben.

Trotz all der Erklärungen scheint es immer noch einen Grad der
Unsicherheit zu geben, so dass wir versuchen, ein Beispiel für e-Mail
als Kommunikationsweg zu geben.

> **Important**
>
> Icinga bietet **keinerlei** Methoden zur Benachrichtung irgendeines
> Kontaktes, den Sie definiert haben, so dass die Einrichtung und
> Konfiguration von Mail, SMS, Pager oder welchen Weg Sie auch immer
> wählen mögen, ganz allein Ihre Aufgabe und nicht Teil dieser
> Dokumentation ist. Wenn Sie Mail betrachten, dann müssen Sie ein
> Mail-Programm (postfix, sendmail oder jeden anderen MTA, mit dem Sie
> sich wohlfühlen) installieren, "Relaying" auf dem Icinga-Server
> einrichten (postfix: `/etc/postfix/main.cf`, Direktive "relayhost";
> sendmail: `/etc/mail/sendmail.cf`, Directive "DS"), "Relaying" auf
> Ihrem zentralen Mail-Server einrichten für Mails, die vom
> Icinga-Server eintreffen und prüfen, dass Sie Mails von Ihrem
> Icinga-Server aus senden können als Benutzer, mit dem auch der
> Icinga-Prozess läuft.
>
> Wenn Sie keine Meldungen von der Kommandozeile Ihres Icinga-Servers
> aus senden können, dann ist es nicht sinnvoll, dass Sie weiterlesen.

**Voraussetzungen**

-   Wie bereits oben angemerkt benötigen Sie einen funktionierenden Weg,
    um Meldungen von der Kommandozeile aus zu versenden. Wenn das nicht
    funktioniert, dann müssen Sie das zuerst reparieren!

-   Sie benötigen mindestens eine Kontaktdefinition ähnlich der
    folgenden:

         define contact {
                contact_name                    jdoe
                host_notifications_enabled      1
                host_notification_period        24x7
                host_notification_options       d,u,r
                host_notification_commands      host-notify-by-email
                service_notifications_enabled   1
                service_notification_period     workhours
                service_notification_options    w,u,c,r
                service_notification_commands   notify-by-email
                email                           jdoe@some.domain.name
                }

    Die Definition enthält alle benötigten Direktiven und eine
    semi-optionale (email).

    -   Benachrichtigungen sind für Hosts und Services aktiviert

    -   Benachrichtigungen werden innerhalb des Zeitfensters "24x7" und
        während "workhours" für Services verschickt. Diese Zeitfenster
        erfordern entsprechende
        [Zeitfenster-Definitionen](#objectdefinitions-timeperiod). Wir
        nehmen an, dass "24x7" 24 Stunden und sieben Tage die Woche und
        "workhours" Montag bis Freitag von 09:00 Uhr bis 17:00 Uhr
        bedeutet. Bitte beachten Sie, dass "notification\_period" etwas
        anderes ist als "check\_period", die in Host- und
        Service-Definitionen zu finden ist. Ersteres gibt das
        Zeitfenster an, in welchem Meldungen versandt werden, wenn alle
        in "[Benachrichtungen](#notifications)" beschriebenen Prüfungen
        erfolgreich durchlaufen wurden.

    -   Meldungen werden für Hosts versandt, die in die Zustände
        UNREACHABLE und DOWN wechseln bzw. wieder in den UP-Status
        zurückkehren. Für Services, die in die Zustände WARNING,
        CRITICAL und UNREACHABLE wechseln bzw. wieder in den OK-Status
        zurückkehren, werden ebenfalls Meldungen verschickt.

    -   Hosts und Services benutzen unterschiedliche Befehle, um den
        Kontakt zu benachrichtigen.

    -   Außer "email" können Sie verschiedene andere Adressen
        definieren, die zur Benachrichtigung des Kontakt genutzt werden
        können.

-   Sie benötigen verschiedene Befehlsdefinitionen für
    "host-notify-by-email" und "notify-by-email". Die gezeigten
    Definitionen stammen aus den Icinga-Beispielkonfigurationsdateien.
    Die Befehlszeile wurde umformatiert.

         # 'notify-host-by-email' command definition
         define command {
                command_name   notify-host-by-email
                command_line   /usr/bin/printf "%b" "***** Icinga *****\n\n \
                               Notification Type: $NOTIFICATIONTYPE$\n \
                               Host: $HOSTNAME$\n \
                               State: $HOSTSTATE$\n \
                               Address: $HOSTADDRESS$\n \
                               Info: $HOSTOUTPUT$\n\n \
                               Date/Time: $LONGDATETIME$\n" \
                               | /usr/bin/mailx -s \
                                 "** $NOTIFICATIONTYPE$ Host Alert: \
                                 $HOSTNAME$ is $HOSTSTATE$ **" \
                                 $CONTACTEMAIL$
                }

         # 'notify-service-by-email' command definition
         define command {
                command_name   notify-service-by-email
                command_line   /usr/bin/printf "%b" "***** Icinga *****\n\n \
                               Notification Type: $NOTIFICATIONTYPE$\n\n \
                               Service: $SERVICEDESC$\n \
                               Host: $HOSTALIAS$\n \
                               Address: $HOSTADDRESS$\n \
                               State: $SERVICESTATE$\n\n \
                               Date/Time: $LONGDATETIME$\n\n \
                               Additional Info:\n\n \
                               $SERVICEOUTPUT$\n" 
                               | /usr/bin/mailx -s \
                                 "** $NOTIFICATIONTYPE$ Service Alert: \
                                 $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **" \
                                 $CONTACTEMAIL$
                }

    > **Note**
    >
    > Bitte überprüfen Sie, dass die Programme (`printf`, `mailx`)
    > tatsächlich an den angegebenen Stellen existieren. Dies kann je
    > nach Distribution abweichen.

    Es gibt viele [Makros](#macrolist), die benutzt werden können, um
    die Benachrichtigungen mit Informationen zu füllen.

    > **Note**
    >
    > Verschiedene Makros haben einen eingeschränkten
    > Gültigkeitsbereich, z.B. sind CONTACT\*-Makros innerhalb von
    > Event-Handlern nicht verfügbar.

    Sie können Ihren eigenen Benachrichtigungsbefehl durch hinzufügen
    oder löschen von Makros schreiben. Stellen Sie sicher, dass er die
    Informationen enthält, die der Empfänger benötigt. Sie möchten
    vielleicht ein ausgeklügeltes Skript schreiben, das eine Datenbank
    prüft, um den Weg festzulegen, über den ein Kontakt informiert
    werden soll abhängig von der Zeit, zu der eine Benachrichtigung
    versandt werden soll (per Mail während der Arbeitszeit, zusätzlich
    per SMS außerhalb der Arbeitszeit, gar nicht während des Urlaubs).

Einige Beispiele
----------------

Wir werden ein paar Services definieren und dabei nur einige Direktiven
verwenden. Bei den anderen (notwendigen) nehmen wir an, dass sie mit
Hilfe eines Templates definiert wurden. Wir zeigen Ihnen auch, worauf
Sie achten sollten:

     define service {
            use                      service_template
            host_name                san_host
            service_description      spare_disks
            notification_period      24x7
            notification_interval    60
            notification_options     c,w,r
            check_command            check_spare!2!1
            contacts                 jdoe
            contact_groups           admins
            }

     define service {
            use                      service_template
            host_name                login_host
            service_description      users
            notification_period      workhours
            notification_interval    0
            notification_options     c,r
            check_command            check_user!20!50
            contacts                 jdoe
            }        
           
     define service {
            use                      service_template
            host_name                app_host
            service_description      memory
            notification_period      workhours
            notification_interval    10
            notification_options     c,w,r,s,r,f,n
            check_command            check_memory!90%!95%
            contacts                 admins
            }

-   Der erste Service überwacht die Anzahl von Ersatz-Festplatten
    innerhalb eines Disk-Shelfs. Normalerweise sind zwei Festplatten
    verfügbar. Wenn nur eine verfügbar ist, soll eine Warnung erfolgen,
    bei keiner freien wird das als kritisch angesehen.
    Benachrichtigungen werden jederzeit versandt, wobei
    Benachrichtigungen im Fehlerfall erneut alle 60 Minuten erfolgen.
    John Doe ist nicht Mitglied der Admin-Gruppe, so dass er gesondert
    angegeben wird.

-   Der zweite Service überwacht die Anzahl von angemeldeten Benutzern.
    Bei mehr als 20 Benutzer soll gewarnt werden und mehr als 50
    Benutzer ist kritisch. Der Betrieb ist außerhalb der Arbeitszeit
    geschlossen und inaktive Benutzer werden nach einer gewissen Zeit
    automatisch abgemeldet, so dass es keine Notwendigkeit für
    Benachrichtigungen außerhalb der Arbeitszeit gibt. Bitte beachten
    Sie, dass bei einer Warnung *keine* Benachrichtigung versandt wird,
    weil dies nicht in den "notification\_options" angegeben wurde! Es
    gibt lediglich eine Benachrichtigung im Falle eines
    nicht-OK-Zustand, auch wenn der Zustand zwischen WARNING und
    CRITICAL wechselt.

-   Der letzte Service prüft die Speicherauslastung einer Maschine, auf
    der ständig Batch-Jobs ausgeführt werden. Warnungen werden bei mehr
    als 90% RAM-Belegung erzeugt und jenseits von 95% wird es als
    kritisch angesehen. Der Versand von Meldungen im 10-Minuten-Takt
    scheint eine gute Idee zu sein, aber dies nur während der
    Arbeitszeit zu tun ist vielleicht nicht ausreichend. **Aber**:
    Obwohl eine Vielzahl von Benachrichtigungsoptionen angegeben wurde,
    wird die Admins-Gruppe niemals eine Meldung bekommen! Der Grund?
    Bitte prüfen Sie selbst die Bedeutung jedes möglichen Wertes von
    "notification\_options", indem Sie die Beschreibung der
    Host-/Service-Definition lesen.

Fehlersuche
-----------

Falls Benachrichtigungen nicht zu funktionieren scheinen, dann gibt es
verschiedene Dinge, die man prüfen kann:

-   Ist der Host/Service bereits in einem "Hard"-Zustand? Prüfen Sie den
    Zustand, indem Sie sich die Host/Service-Details ansehen

-   Ist das Makro in dem Kontext gültig, in dem Sie es benutzen

-   Ist das Programm zum Senden von Benachrichtigungen (mail / pager /
    ...) installiert und lauffähig? Ist es möglich, Benachrichtigungen
    von der Kommandozeile aus an die in der Kontaktdefinition angegebene
    Adresse zu versenden mit dem Benutzer, unter dem auch der
    Icinga-Prozess läuft? Anmerkung: Aus Sicherheitsgründen könnte es
    sein, dass die Login-Shell deaktiviert ist, so dass Sie dies
    vorübergehend ändern müssen

-   Anstatt Meldungen zu versenden können Sie die Ausgabe auch in eine
    Datei umleiten, indem Sie "`| /usr/bin/mail
            ...`" durch etwas wie "`> /tmp/notification.log`" ersetzen,
    um zu prüfen, ob alles Makros korrekt ersetzt werden

-   Prüfen Sie das Icinga-Log, Mail-Log und System-Log auf Meldungen

-   Editieren Sie `icinga.cfg` und ändern Sie die folgenden Direktiven:

         debug_level=32                  # notifications
         debug_verbosity=2               # very detailed
         max_debug_file_size=1000000000  # max 1GB of debug file

    Starten Sie Icinga neu und verschicken Sie über das klassische UI
    eine "custom notification", um die Einstellungen zu prüfen.

Benachrichtigungen
Beispiele und Fehlersuche
