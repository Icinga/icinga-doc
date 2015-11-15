![Icinga](../images/logofullsize.png "Icinga")

6.2. Authentifizierung und Autorisierung im Classic UI

[Zurück](cgis.md) 

Kapitel 6. Die Benutzeroberflächen

 [Weiter](cgiparams.md)

* * * * *

6.2. Authentifizierung und Autorisierung im Classic UI
------------------------------------------------------

6.2.1. [Einführung](cgiauth.md#introduction)

6.2.2. [Definitionen](cgiauth.md#definitionscgiauth)

6.2.3. [Erstellen von authentifizierten
Benutzern](cgiauth.md#configwebusers)

6.2.4. [Aktivieren der Authentifizierungs/Autorisierungsfunktionalität
im Classic UI](cgiauth.md#enablecgiauth)

6.2.5. [Standardberechtigungen für Classic
UI-Informationen](cgiauth.md#defaultpermissions)

6.2.6. [Zusätzliche Berechtigungen zu Classic UI-Informationen
gewähren](cgiauth.md#additionalpermissions)

6.2.7. [Classic
UI-Autorisierungsanforderungen](cgiauth.md#requirementscgiauth)

6.2.8. [Authentifizierung auf sicheren
Web-Servern](cgiauth.md#securedwebservers)

### 6.2.1. Einführung

Dieses Dokument beschreibt, wie das Icinga-Classic UI (früher "CGIs"
genannt) entscheiden, wer die Überwachungs- und
Konfigurationsinformationen sehen darf und wer über das Web-Interface
Befehle an den Icinga-Daemon erteilen darf.

### 6.2.2. Definitionen

Bevor wir fortfahren, ist es wichtig, dass Sie die Bedeutung und den
Unterschied zwischen authentifizierten Benutzern und authentifizierten
Kontakten verstehen:

-   Ein **authentifizierter Benutzer** ist jemand, der sich dem
    Web-Server gegenüber mit Benutzer und Passwort authentifiziert hat
    und dem Zugang zum Icinga-Classic-Web-Interface gewährt wurde.

-   Ein **authentifizierter Kontakt** ist ein authentifizierter
    Benutzer, dessen Benutzername mit dem Kurznamen einer
    [Kontakt-Definition](objectdefinitions.md#objectdefinitions-contact)
    übereinstimmt.

### 6.2.3. Erstellen von authentifizierten Benutzern

Wenn wir annehmen, dass Sie Ihren Web-Server wie in der
[Schnellstart-Anleitung](quickstart.md "2.3. Schnellstart-Installationsanleitungen")
konfiguriert haben, dann sollte er Sie dazu auffordern, sich zu
authentifizieren, bevor Sie das Icinga-Classic UI benutzen können. Sie
sollten außerdem ein Benutzerkonto (*icingaadmin*) haben, das Zugang zum
Classic UI hat.

Während Sie weitere
[Kontakte](objectdefinitions.md#objectdefinitions-contact) definieren,
um Host- und Service-Benachrichtigungen zu erhalten, möchten Sie
wahrscheinlich auch, dass sie Zugang zum Icinga-Web-Interface haben. Sie
können den folgenden Befehl benutzen, um zusätzliche Benutzer
hinzuzufügen, die sich beim Classic UI authentifizieren können. Ersetzen
Sie \<username\> durch den Benutzernamen, den Sie hinzufügen möchten. In
den meisten Fällen sollte der Benutzername mit dem Kurznamen eines
[Kontakts](objectdefinitions.md#objectdefinitions-contact)
übereinstimmen, den Sie definiert haben.

~~~~ {.screen}
 htpasswd /usr/local/icinga/etc/htpasswd.users <username>
~~~~

### 6.2.4. Aktivieren der Authentifizierungs/Autorisierungsfunktionalität im Classic UI

Als nächstes sollten Sie sicherstellen, dass das Classic UI so
konfiguriert ist, dass es die Authentifizierungs- und
Autorisierungsfunktionalität nutzt, um festzulegen, welchen Zugang
Benutzer zu Informationen und/oder Befehlen haben. Dies wird durch die
[use\_authentication](configcgi.md#configcgi-use_authentication)-Variable
in der [Classic
UI-Konfigurationsdatei](configcgi.md "3.6. Optionen CGI-Konfigurationsdatei")
erreicht, die einen Wert ungleich Null haben muss. Beispiel:

~~~~ {.programlisting}
 use_authentication=1
~~~~

Okay, nun sind Sie fertig mit dem Einstellen der grundlegenden
Authentifizierungs- und Autorisierungsfunktionalität in den Classic
UI-Modulen.

### 6.2.5. Standardberechtigungen für Classic UI-Informationen

Welche Standardberechtigungen haben Benutzer im Classic UI, wenn die
Authentifizierungs- und Autorisierungsfunktionalität aktiviert ist?

Classic UI-Daten

Authentifizierte
Kontakte^[\*](cgiauth.md#definitionscgiauth "6.2.2. Definitionen")^

andere authentifizierte
Benutzer^[\*](cgiauth.md#definitionscgiauth "6.2.2. Definitionen")^

Host-Statusinformationen

Ja

Nein

Host-Konfigurationsinformationen

Ja

Nein

Host-Verlauf

Ja

Nein

Host-Benachrichtigungen

Ja

Nein

Host-Befehle

Ja

Nein

Service-Statusinformationen

Ja

Nein

Service-Konfigurationsinformationen

Ja

Nein

Service-Verlauf

Ja

Nein

Service-Benachrichtigungen

Ja

Nein

Service-Befehle

Ja

Nein

Alle Konfigurationsinformationen

Nein

Nein

System/Prozessinformationen

Nein

Nein

System/Prozessbefehle

Nein

Nein

*Authentifizierten
Kontakten^[\*](cgiauth.md#definitionscgiauth "6.2.2. Definitionen")^*
werden die folgenden Berechtigungen für jeden **Service** gewährt, bei
dem sie als Kontakt eingetragen sind (aber "Nein" für Services, bei
denen sie nicht als Kontakt eingetragen sind)...

-   Autorisierung, um Service-Statusinformationen zu sehen

-   Autorisierung, um Service-Konfigurationsinformationen zu sehen

-   Autorisierung, um Verlauf und Benachrichtigungen für den Service zu
    sehen

-   Autorisierung, um Service-Befehle zu erteilen

*Authentifizierten
Kontakten^[\*](cgiauth.md#definitionscgiauth "6.2.2. Definitionen")^*
werden die folgenden Berechtigungen für jeden **Host** gewährt, bei dem
sie als Kontakt eingetragen sind (aber "Nein" für Hosts, bei denen sie
nicht als Kontakt eingetragen sind)...

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

-   die Log-Datei über das [showlog-Modul](cgis.md#cgis-showlog_cgi)
    anzusehen

-   Icinga-Prozessinformationen über das [extended
    information-Modul](cgis.md#cgis-extinfo_cgi) anzusehen

-   Icinga-Prozessbefehle über das
    [command-Modul](cgis.md#cgis-cmd_cgi) zu erteilen

-   Definitionen für Hostgruppen, Kontakte, Kontaktgruppen, Zeitfenster
    und Befehle über das
    [configuration-Modul](cgis.md#cgis-config_cgi) anzusehen

Sie werden unzweifelhaft Zugang zu diesen Informationen haben wollen, so
dass Sie wie unten beschrieben zusätzliche Rechte für sich (und
vielleicht andere Benutzer) zuweisen möchten.

### 6.2.6. Zusätzliche Berechtigungen zu Classic UI-Informationen gewähren

Uns ist klar, dass die verfügbaren Optionen es nicht erlauben, sehr
genau auf bestimmte Berechtigungen einzugehen, aber es ist besser als
nichts...

Benutzern können zusätzliche Autorisierungen gegeben werden, indem sie
den folgenden Variablen in der Classic UI-Konfigurationsdatei
hinzugefügt werden...

-   [authorized\_for\_system\_information](configcgi.md#configcgi-authorized_for_system_information)

-   [authorized\_for\_system\_commands](configcgi.md#configcgi-authorized_for_system_commands)

-   [authorized\_for\_configuration\_information](configcgi.md#configcgi-authorized_for_configuration_information)

-   [authorized\_for\_all\_hosts](configcgi.md#configcgi-authorized_for_all_hosts)

-   [authorized\_for\_all\_host\_commands](configcgi.md#configcgi-authorized_for_all_host_commands)

-   [authorized\_for\_all\_services](configcgi.md#configcgi-authorized_for_all_services)

-   [authorized\_for\_all\_service\_commands](configcgi.md#configcgi-authorized_for_all_service_commands)

### 6.2.7. Classic UI-Autorisierungsanforderungen

Wenn Sie verwirrt sind, welche Autorisierung Sie benötigen, um Zugang zu
verschiedenen Informationen im Classic UI zu bekommen, lesen Sie
[hier](cgis.md "6.1. Icinga Classic UI: Informationen über die Classic UI-Module")
den Abschnitt ***Autorisierungsanforderungen***, in dem jedes Modul
beschrieben ist.

### 6.2.8. Authentifizierung auf sicheren Web-Servern

Wenn Ihr Web-Server in einer sicheren Domäne steht (d.h. hinter einer
Firewall) oder wenn Sie SSL benutzen, dann können Sie einen
Standard-Benutzernamen definieren, der verwendet werden kann, um das
Classic UI aufzurufen. Dies wird durch die Definition der
[default\_user\_name](configcgi.md#configcgi-default_user_name)-Option
in der [Classic
UI-Konfigurationsdatei](configcgi.md "3.6. Optionen CGI-Konfigurationsdatei")
erreicht. Durch die Definition eines Standard-Benutzernamens, der die
Classic UI-Module aufrufen kann, können Sie Benutzern erlauben, das
Classic UI aufzurufen, ohne dass sie sich am Web-Server authentifizieren
müssen. Sie möchten das vielleicht nutzen, um die Verwendung der
Basis-Web-Authentifizierung zu verhindern, weil diese Passwörter im
Klartext über das Internet überträgt.

**Wichtig:** Definieren Sie *keinen* Standard-Benutzernamen, solange Sie
nicht einen sicheren Web-Server haben und sicher sind, dass sich jeder,
der das Classic UI aufruft, in irgendeiner Weise authentifiziert hat.
Wenn Sie diese Variable definieren, dann wird jeder, der sich am
Web-Server authentifiziert, alle Rechte dieses Benutzers erben!

* * * * *

  ------------------------------------------------------------------- -------------------------- --------------------------------------------------------
  [Zurück](cgis.md)                                                 [Nach oben](ch06.md)      [Weiter](cgiparams.md)
  6.1. Icinga Classic UI: Informationen über die Classic UI-Module    [Zum Anfang](index.md)    6.3. Informationen zu den Classic UI-Modul-Parametern
  ------------------------------------------------------------------- -------------------------- --------------------------------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
