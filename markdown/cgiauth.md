Authentifizierung und Autorisierung in den CGIs
===============================================

Einführung
----------

Dieses Dokument beschreibt, wie die NAME-ICINGA-CGIs entscheiden, wer
die Überwachungs- und Konfigurationsinformationen sehen darf und wer
über das Web-Interface Befehle an den NAME-ICINGA-Daemon erteilen darf.

Definitionen
------------

Bevor wir fortfahren, ist es wichtig, dass Sie die Bedeutung und den
Unterschied zwischen authentifizierten Benutzern und authentifizierten
Kontakten verstehen:

-   Ein **authentifizierter Benutzer** ist jemand, der sich dem
    Web-Server gegenüber mit Benutzer und Passwort authentifiziert hat
    und dem Zugang zum NAME-ICINGA-Web-Interface gewährt wurde.

-   Ein **authentifizierter Kontakt** ist ein authentifizierter
    Benutzer, dessen Benutzername mit dem Kurznamen einer
    [Kontakt-Definition](#objectdefinitions-contact) übereinstimmt.

Erstellen von authentifizierten Benutzern
-----------------------------------------

Wenn wir annehmen, dass Sie Ihren Web-Server wie in der
[Schnellstart-Anleitung](#quickstart) konfiguriert haben, dann sollte er
Sie dazu auffordern, sich zu authentifizieren, bevor Sie die
NAME-ICINGA-CGIs benutzen können. Sie sollten außerdem ein Benutzerkonto
(*icingaadmin*) haben, das Zugang zu den CGIs hat.

Während Sie weitere [Kontakte](#objectdefinitions-contact) definieren,
um Host- und Service-Benachrichtigungen zu erhalten, möchten Sie
wahrscheinlich auch, dass sie Zugang zum NAME-ICINGA-Web-Interface
haben. Sie können den folgenden Befehl benutzen, um zusätzliche Benutzer
hinzuzufügen, die sich bei den CGI authentifizieren können. Ersetzen Sie
\<username\> durch den Benutzernamen, den Sie hinzufügen möchten. In den
meisten Fällen sollte der Benutzername mit dem Kurznamen eines
[Kontakts](#objectdefinitions-contact) übereinstimmen, den Sie definiert
haben.

     htpasswd URL-ICINGA-BASE/etc/htpasswd.users <username>

Aktivieren der Authentifizierungs/Autorisierungsfunktionalität in den CGIs
--------------------------------------------------------------------------

Als nächstes sollten Sie sicherstellen, dass die CGI so konfiguriert
sind, dass sie die Authentifizierungs- und Autorisierungsfunktionalität
nutzen, um festzulegen, welchen Zugang Benutzer zu Informationen
und/oder Befehlen haben. Dies wird durch die
[use\_authentication](#configcgi-use_authentication)-Variable in der
[CGI-Konfigurationsdatei](#configcgi) erreicht, die einen Wert ungleich
Null haben muss. Beispiel:

     use_authentication=1

Okay, nun sind Sie fertig mit dem Einstellen der grundlegenden
Authentifizierungs- und Autorisierungsfunktionalität in den CGIs.

Standardberechtigungen für CGI-Informationen
--------------------------------------------

Welche Standardberechtigungen haben Benutzer in den CGIs, wenn die
Authentifizierungs- und Autorisierungsfunktionalität aktiviert ist?

  ------------------------ ------------------------ ------------------------
  CGI-Daten                Authentifizierte         andere authentifizierte
                           Kontakte^[\*](#definitio Benutzer^[\*](#definitio
                           nscgiauth)^              nscgiauth)^

  Host-Statusinformationen Ja                       Nein

  Host-Konfigurationsinfor Ja                       Nein
  mationen                                          

  Host-Verlauf             Ja                       Nein

  Host-Benachrichtigungen  Ja                       Nein

  Host-Befehle             Ja                       Nein

  Service-Statusinformatio Ja                       Nein
  nen                                               

  Service-Konfigurationsin Ja                       Nein
  formationen                                       

  Service-Verlauf          Ja                       Nein

  Service-Benachrichtigung Ja                       Nein
  en                                                

  Service-Befehle          Ja                       Nein

  Alle                     Nein                     Nein
  Konfigurationsinformatio                          
  nen                                               

  System/Prozessinformatio Nein                     Nein
  nen                                               

  System/Prozessbefehle    Nein                     Nein
  ------------------------ ------------------------ ------------------------

*Authentifizierten Kontakten^[\*](#definitionscgiauth)^* werden die
folgenden Berechtigungen für jeden **Service** gewährt, bei dem sie als
Kontakt eingetragen sind (aber "Nein" für Services, bei denen sie nicht
als Kontakt eingetragen sind)...

-   Autorisierung, um Service-Statusinformationen zu sehen

-   Autorisierung, um Service-Konfigurationsinformationen zu sehen

-   Autorisierung, um Verlauf und Benachrichtigungen für den Service zu
    sehen

-   Autorisierung, um Service-Befehle zu erteilen

*Authentifizierten Kontakten^[\*](#definitionscgiauth)^* werden die
folgenden Berechtigungen für jeden **Host** gewährt, bei dem sie als
Kontakt eingetragen sind (aber "Nein" für Hosts, bei denen sie nicht als
Kontakt eingetragen sind)...

-   Autorisierung, um Host-Statusinformationen zu sehen

-   Autorisierung, um Host-Konfigurationsinformationen zu sehen

-   Autorisierung, um Verlauf und Benachrichtigungen für den Host zu
    sehen

-   Autorisierung, um Host-Befehle zu erteilen

-   Autorisierung, um Statusinformationen für alle Services des Hosts zu
    sehen

-   Autorisierung, um Konfigurationsinformationen für alle Services des
    Hosts zu sehen

-   Autorisierung, um Verlauf und Benachrichtigungen für alle Services
    des Host zu sehen

-   Autorisierung, um Befehle für alle Services des Hosts zu erteilen

Es ist wichtig anzumerken, dass als Grundeinstellung **keiner**
autorisiert ist, das Folgende zu tun:

-   die Log-Datei über das [showlog CGI](#cgis-showlog_cgi) anzusehen

-   NAME-ICINGA-Prozessinformationen über das [extended information
    CGI](#cgis-extinfo_cgi) anzusehen

-   NAME-ICINGA-Prozessbefehle über das [command CGI](#cgis-cmd_cgi) zu
    erteilen

-   Definitionen für Hostgruppen, Kontakte, Kontaktgruppen, Zeitfenster
    und Befehle über das [configuration CGI](#cgis-config_cgi) anzusehen

Sie werden unzweifelhaft Zugang zu diesen Informationen haben wollen, so
dass Sie wie unten beschrieben zusätzliche Rechte für sich (und
vielleicht andere Benutzer) zuweisen möchten.

Zusätzliche Berechtigungen zu CGI-Informationen gewähren
--------------------------------------------------------

Uns ist klar, dass die verfügbaren Optionen es nicht erlauben, sehr
genau auf bestimmte Berechtigungen einzugehen, aber es ist besser als
nichts...

Benutzern können zusätzliche Autorisierungen gegeben werden, indem sie
den folgenden Variablen in der CGI-Konfigurationsdatei hinzugefügt
werden...

-   [authorized\_for\_system\_information](#configcgi-authorized_for_system_information)

-   [authorized\_for\_system\_commands](#configcgi-authorized_for_system_commands)

-   [authorized\_for\_configuration\_information](#configcgi-authorized_for_configuration_information)

-   [authorized\_for\_all\_hosts](#configcgi-authorized_for_all_hosts)

-   [authorized\_for\_all\_host\_commands](#configcgi-authorized_for_all_host_commands)

-   [authorized\_for\_all\_services](#configcgi-authorized_for_all_services)

-   [authorized\_for\_all\_service\_commands](#configcgi-authorized_for_all_service_commands)

CGI-Autorisierungsanforderungen
-------------------------------

Wenn Sie verwirrt sind, welche Autorisierung Sie benötigen, um Zugang zu
verschiedenen Informationen in den CGIs zu bekommen, lesen Sie
[hier](#cgis) den Abschnitt ***Autorisierungsanforderungen***, in dem
jedes CGI beschrieben ist.

Authentifizierung auf sicheren Web-Servern
------------------------------------------

Wenn Ihr Web-Server in einer sicheren Domäne steht (d.h. hinter einer
Firewall) oder wenn Sie SSL benutzen, dann können Sie einen
Standard-Benutzernamen definieren, der verwendet werden kann, um die CGI
aufzurufen. Dies wird durch die Definition der
[default\_user\_name](#configcgi-default_user_name)-Option in der
[CGI-Konfigurationsdatei](#configcgi) erreicht. Durch die Definition
eines Standard-Benutzernamens, der die CGIs aufrufen kann, können Sie
Benutzern erlauben, die CGIs aufzurufen, ohne dass sie sich am
Web-Server authentifizieren müssen. Sie möchten das vielleicht nutzen,
um die Verwendung der Basis-Web-Authentifizierung zu verhindern, weil
diese Passwörter im Klartext über das Internet überträgt.

**Wichtig:** Definieren Sie *keinen* Standard-Benutzernamen, solange Sie
nicht einen sicheren Web-Server haben und sicher sind, dass sich jeder,
der die CGIs aufruft, in irgendeiner Weise authentifiziert hat. Wenn Sie
diese Variable definieren, dann wird jeder, der sich am Web-Server
authentifiziert, alle Rechte dieses Benutzers erben!

CGI-Autorisierung
CGI-Authentifizierung
Authentifizierter Kontakt
CGI-Authentifizierung
Authentifizierter Benutzer
CGI-Authentifizierung
Erstellen von authentifizierten Benutzern
CGI-Authentifizierung
Aktivieren der Authentifizierungs/Autorisierungsfunktionalität in den
CGIs
CGI-Authentifizierung
Standardberechtigungen für CGI-Informationen
CGI-Authentifizierung
Zusätzliche Berechtigungen zu CGI-Informationen gewähren
CGI-Authentifizierung
Authentifizierung auf sicheren Web-Servern
