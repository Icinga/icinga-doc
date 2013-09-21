Maßgeschneiderte Objektvariablen
================================

Maßgeschneiderte Objektvariablen
Einführung
----------

Benutzer fragen oft nach neuen Variablen in Host-, Service- und
Kontaktdefinitionen. Dazu gehören Variablen für die SNMP-Community,
MAC-Adressen, AIM-Benutzernamen, Skype-Nummern und Straßennamen. Die
Liste ist endlos. Das Problem, was wir darin sehen ist, dass NAME-ICINGA
weniger generisch und mehr infrastrukturspezifisch wird. NAME-ICINGA war
dazu gedacht, flexibel zu sein, was bedeutet, dass die Dinge in einer
generischen Art und Weise geplant waren. Host-Definitionen in
NAME-ICINGA zum Beispiel haben eine generische "address"-Variable, die
alles von einer IP-Adresse bis zu menschlich-lesbaren Wegbeschreibungen
enthalten kann - was immer für die Umgebung des Benutzers angemessen
ist.

Trotzdem muss es eine Methode für Administratoren geben, in ihrer
NAME-ICINGA-Konfiguration Informationen zu ihren
Infrastrukturkomponenten zu speichern, ohne anderen einen Satz von
speziellen Variablen aufzubürden. NAME-ICINGA versucht dieses Problem zu
lösen, indem es Benutzern erlaubt, maßgeschneiderte Variablen in ihren
Objektdefinitionen anzugeben. Maßgeschneiderte Variablen erlauben es
Benutzern, zusätzliche Eigenschaften in ihren Host-, Service- und
Kontaktdefinitionen anzugeben und ihre Werte in Benachrichtigungen,
Eventhandlern sowie Host- und Service-Prüfungen zu benutzen.

Grundlagen zu maßgeschneiderten Variablen
-----------------------------------------

Es gibt ein paar wichtige Dinge, die Sie bei maßgeschneiderten Variablen
beachten sollten:

-   maßgeschneiderte Variablennamen müssen mit einem Unterstrich (\_)
    beginnen, um einen Namenskonflikt mit Standardvariablen zu
    verhindern

-   maßgeschneiderten Variablennamen werden vor der Benutzung in
    Großbuchstaben umgewandelt

-   maßgeschneiderten Variablen werden von Objektvorlagen wie normale
    Variablen [geerbt](#objectinheritance)

-   Scripts können sich mit [Makros und Umgebungsvariablen](#macros) auf
    die Werte von maßgeschneiderten Variablen beziehen

> **Important**
>
> Maßgeschneiderte Variablen werden erst *zur Laufzeit* ersetzt, weder
> bei der Überprüfungsphase (icinga -v icinga.cfg) noch während des
> NAME-ICINGA-Startprozesses, so dass das Platzieren in Host-Namen,
> Service-Beschreibungen oder verschiedenen anderen Stellen der
> Objektdefinition während der Überprüfung zu einer Fehlermeldung
> ähnlich "`<object>
>       contains one or more illegal characters.`" führt. Das Ändern der
> Direktive "illegal\_object\_name\_chars" wird *nicht* das Problem
> lösen.

Maßgeschneiderte Objektvariablen
Ersetzung erst zur Laufzeit
Beispiele
---------

Hier ein Beispiel, wie maßgeschneiderte Variablen in verschiedenen Arten
von Objektdefinitionen definiert werden können:

     define host{
            host_name       linuxserver
            _mac_address    00:06:5B:A6:AD:AA       ; <-- Custom MAC_ADDRESS variable
            _rack_number    R32                     ; <-- Custom RACK_NUMBER variable
            ...
            }
     define service{
            host_name       linuxserver
            description     Memory Usage
            _SNMP_community public                  ; <-- Custom SNMP_COMMUNITY variable
            _TechContact    Jane Doe                ; <-- Custom TECHCONTACT variable
            ....
            }
     define contact{
            contact_name    john
            _AIM_username   john16                  ; <-- Custom AIM_USERNAME variable
            _YahooID        john32                  ; <-- Custom YAHOOID variable
            ...
            }

maßgeschneiderte Variablen als Makros
-------------------------------------

Maßgeschneiderte Variablen können über [Makros](#macros) oder
Umgebungsvariablen in Scripts und Programmen eingesetzt werden, die
NAME-ICINGA für Prüfungen, Benachrichtigungen usw. ausführt.

Um Namenskonflikte zwischen maßgeschneiderten Variablen aus
verschiedenen Objektarten zu verhindern, stellt NAME-ICINGA "\_HOST",
"\_SERVICE" oder "\_CONTACT" an den Anfang von maßgeschneiderten Host-,
Service- oder Kontaktvariablennamen in Makros und Umgebungsvariablen.
Die folgende Tabelle zeigt die entsprechenden Namen für maßgeschneiderte
Variablen, die im obigen Beispiel definiert wurden.

  ------------------ ------------------ ------------------ ------------------
  **Objekttyp**      **Variablenname**  **Makroname**      **Umgebungsvariabl
                                                           e**

  Host               MAC\_ADDRESS       \$\_HOSTMAC\_ADDRE ICINGA\_\_HOSTMAC\
                                        SS\$               _ADDRESS

  Host               RACK\_NUMBER       \$\_HOSTRACK\_NUMB ICINGA\_\_HOSTRACK
                                        ER\$               \_NUMBER

  Service            SNMP\_COMMUNITY    \$\_SERVICESNMP\_C ICINGA\_\_SERVICES
                                        OMMUNITY\$         NMP\_COMMUNITY

  Service            TECHCONTACT        \$\_SERVICETECHCON ICINGA\_\_SERVICET
                                        TACT\$             ECHCONTACT

  Contact            AIM\_USERNAME      \$\_CONTACTAIM\_US ICINGA\_\_CONTACTA
                                        ERNAME\$           IM\_USERNAME

  Contact            YAHOOID            \$\_CONTACTYAHOOID ICINGA\_\_CONTACTY
                                        \$                 AHOOID
  ------------------ ------------------ ------------------ ------------------

maßgeschneiderte Variablen und Vererbung
----------------------------------------

Maßgeschneiderte Objektvariablen werden genau wie Standard-Host-,
Service- oder Kontaktvariablen [vererbt](#objectinheritance).
