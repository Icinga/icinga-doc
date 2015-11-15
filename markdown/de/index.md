![Icinga](../images/logofullsize.png "Icinga")

Icinga Version 1.13 Dokumentation

 

 

 [Weiter](ch01.md)

* * * * *

Copyright 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team.

Teile Copyright © von Nagios/Icinga-Community-Mitgliedern - weitere
Informationen finden Sie in der Datei THANKS in den Icinga-Core-Sourcen.

Kudos an Yoann LAMY für die Erstellung des Vautour Style, den wir für
Icinga Classic UI nutzen.

Icinga und diese Dokumentation ist lizenziert unter den Bedingungen der
GNU General Public License Version 2 wie von der Free Software
Foundation veröffentlicht. Das gibt Ihnen das Recht, Icinga unter
bestimmten Bedingungen zu kopieren, zu verteilen und/oder zu
modifizieren. Lesen Sie die 'LICENSE'-Datei in der Icinga-Distribution
oder lesen Sie die Online-Version der Lizenz für weitere Einzelheiten.

Icinga wird zur Verfügung gestellt „SO WIE ES IST“ ohne „GARANTIE
JEGLICHER ART, EINSCHLIESSLICH DER GARANTIE DES DESIGNS, DER
VERMARKTBARKEIT UND DER TAUGLICHKEIT FÜR EINEN BESTIMMTEN ZWECK.“

Nagios ist lizenziert unter den Bedingungen der GNU General Public
License Version 2 wie von der Free Software Foundation veröffentlicht.
Das gibt Ihnen das Recht, Nagios unter bestimmten Bedingungen zu
kopieren, zu verteilen und/oder zu modifizieren. Lesen Sie die
'LICENSE'-Datei in der Nagios-Distribution oder lesen Sie die
Online-Version der Lizenz für weitere Einzelheiten.

Nagios und das Nagios-Logo sind registrierte Schutzmarken von Ethan
Galstad. Alle andere Schutzmarken, registrierte Schutzmarken und
Bezeichnungen, die in diesem Dokument genannt werden, können das
Eigentum der jeweiligen Besitzer sein. Die hierin enthaltenen
Informationen werden zur Verfügung gestellt „SO WIE SIE SIND“ ohne
„GARANTIE JEGLICHER ART, EINSCHLIESSLICH DER GARANTIE DES DESIGNS, DER
VERMARKTBARKEIT UND DER TAUGLICHKEIT FÜR EINEN BESTIMMTEN ZWECK.“

2015.03.13

  **Versionsgeschichte**
  --------------------------- ------------
  Version 1.12                2014-11-19
  1.12 Icinga Dokumentation
  Version 1.x                 2009-2015
  1.x Icinga Dokumentation
  Version 0.1                 2009-09-27
  Erste Ausgabe

* * * * *

**Inhaltsverzeichnis**

​1. [Über](ch01.md)

1.1. [Über Icinga](about.md)

1.1.1. [Was ist das?](about.md#whatsicinga)

1.1.2. [Systemvoraussetzungen](about.md#system_requirements)

1.1.3. [Lizenzierung](about.md#licensing)

1.1.4. [Danksagungen](about.md#acknowledgements)

1.1.5. [Beschaffen der neuesten Version](about.md#downloading)

1.1.6. [Kompatibilität](about.md#compatibility)

1.2. [What's New in Icinga 1.13](whatsnew.md)

1.2.1. [CHANGES](whatsnew.md#whatsnew-changes)

1.2.2. [Core](whatsnew.md#whatsnew-core)

1.2.3. [Classic UI](whatsnew.md#whatsnew-classicui)

1.2.4. [IDOutils](whatsnew.md#whatsnew-idoutils)

1.2.5. [Icinga-Web](whatsnew.md#whatsnew-web)

1.2.6. [Docs](whatsnew.md#docs)

1.2.7. [More information](whatsnew.md#moreinfo)

​2. [Los geht's](ch02.md)

2.1. [Hinweise für Neulinge](beginners.md)

2.1.1. [Icinga-Überblick](beginners.md#icinga-overview)

2.1.2. [Icinga Web-GUI-Vergleich](beginners.md#icinga_gui_comparison)

2.2. [Ich bin neu bei...](newbie.md)

2.2.1. [Linux](newbie.md#newbie-linux)

2.2.2. [Mail](newbie.md#newbie-mail)

2.2.3. [SNMP](newbie.md#newbie-snmp)

2.2.4. [Pakete](newbie.md#newbie-packages)

2.2.5. [Überwachung](newbie.md#newbie-monitoring)

2.2.6. [Hilfe!](newbie.md#newbie-help)

2.3. [Schnellstart-Installationsanleitungen](quickstart.md)

2.4. [Icinga-Schnellstart auf Linux](quickstart-icinga.md)

2.4.1. [Einführung](quickstart-icinga.md#introduction)

2.4.2. [Voraussetzungen](quickstart-icinga.md#prerequisites)

2.4.3. [Installation der Pakete](quickstart-icinga.md#installpackages)

2.4.4. [Benutzerinformationen
erstellen](quickstart-icinga.md#createaccount)

2.4.5. [Icinga und die Plugins
herunterladen](quickstart-icinga.md#downloadicingaandplugins)

2.4.6. [Icinga kompilieren und
installieren](quickstart-icinga.md#compileinstall)

2.4.7. [Anpassen der
Konfiguration](quickstart-icinga.md#customiseconfig)

2.4.8. [Installieren und konfigurieren des klassischen
Web-Interface](quickstart-icinga.md#configclassicui)

2.4.9. [Kompilieren und installieren der Monitoring
Plugins](quickstart-icinga.md#compileinstallplugins)

2.4.10. [Anpassen der
SELinux-Einstellungen](quickstart-icinga.md#selinuxsettings)

2.4.11. [Icinga starten](quickstart-icinga.md#starticinga)

2.4.12. [Anmelden am klassischen
Web-Interface](quickstart-icinga.md#loginclassicui)

2.4.13. [Andere Anpassungen](quickstart-icinga.md#othermods)

2.4.14. [Fertig](quickstart-icinga.md#done)

2.5. [Icinga-Schnellstart auf FreeBSD](quickstart-icinga-freebsd.md)

2.6. [Icinga-Schnellstart mit IDOUtils](quickstart-idoutils.md)

2.6.1. [Einführung](quickstart-idoutils.md#introduction)

2.6.2. [Voraussetzungen](quickstart-idoutils.md#prerequisites)

2.6.3. [Neue Features für die
IDOUtils:](quickstart-idoutils.md#newfeatures)

2.6.4. [Installation der
Pakete](quickstart-idoutils.md#installpackages)

2.6.5. [Benutzerinformationen
erstellen](quickstart-idoutils.md#createaccount)

2.6.6. [Icinga und die Plugins
herunterladen](quickstart-idoutils.md#downloadicingaandplugins)

2.6.7. [Icinga und die IDOUtils kompilieren und
installieren](quickstart-idoutils.md#compileinstallidoutils)

2.6.8. [Kompilieren und
Installieren](quickstart-idoutils.md#compileinstall)

2.6.9. [Anpassen der
Konfiguration](quickstart-idoutils.md#customiseconfig)

2.6.10. [Aktivieren des
idomod-Eventbroker-Moduls](quickstart-idoutils.md#enableidomod)

2.6.11. [Anlegen und konfigurieren von Datenbank, Benutzer und
Berechtigungen](quickstart-idoutils.md#createidoutilsdatabase)

2.6.12. [Installieren und konfigurieren des klassischen
Web-Interface](quickstart-idoutils.md#configclassicui)

2.6.13. [Kompilieren und installieren der
Plugins](quickstart-idoutils.md#compileinstallplugins)

2.6.14. [Anpassen der
SELinux-Einstellungen](quickstart-idoutils.md#selinuxsettings)

2.6.15. [IDOUtils und Icinga
starten](quickstart-idoutils.md#startiido2dbandicinga)

2.6.16. [Automatischer Start von
IDOUtils](quickstart-idoutils.md#configstartup)

2.6.17. [Anmelden am klassischen
Web-Interface](quickstart-idoutils.md#loginclassicui)

2.6.18. [Andere Anpassungen](quickstart-idoutils.md#othermods)

2.6.19. [Fertig](quickstart-idoutils.md#done)

2.7. [Icinga-Schnellstart mit IDOUtils auf
FreeBSD](quickstart-idoutils-freebsd.md)

2.8. [Icinga Pakete für Linux-Distributionen](icinga_packages.md)

2.9. [Links zu weiteren Howtos](howtos.md)

2.10. [Icinga aktualisieren](upgrading.md)

2.10.1. [Aktualisierung von
Icinga](upgrading.md#upgradepreviousrelease)

2.10.2. [Upgrade von Nagios 3.x](upgrading.md#upgradenagios3x)

2.10.3. [Upgrade von Nagios 2.x](upgrading.md#upgradenagios2x)

2.10.4. [Aktualisierung einer
RPM-Installation](upgrading.md#upgradefromrpm)

2.11. [IDOUtils-Datenbank aktualisieren](upgrading_idoutils.md)

2.11.1. [Upgrading IDOUtils to
1.13](upgrading_idoutils.md#upgrade1.13)

2.12. [Monitoring-Überblick](monitoring-overview.md)

2.13. [Windows-Maschinen überwachen](monitoring-windows.md)

2.13.1. [Einführung](monitoring-windows.md#introduction)

2.13.2. [Überblick](monitoring-windows.md#overview)

2.13.3. [Schritte](monitoring-windows.md#steps)

2.13.4. [Was bereits für Sie vorbereitet
wurde](monitoring-windows.md#whatsdone)

2.13.5. [Voraussetzungen](monitoring-windows.md#prequisites)

2.13.6. [Installation des
Windows-Agenten](monitoring-windows.md#installwindowsagent)

2.13.7. [Icinga konfigurieren](monitoring-windows.md#configicinga)

2.13.8. [Passwortschutz](monitoring-windows.md#passwordprotect)

2.13.9. [Icinga neu starten](monitoring-windows.md#restarticinga)

2.13.10. [Troubleshooting](monitoring-windows.md#troubleshooting)

2.14. [Linux/Unix-Rechner überwachen](monitoring-linux.md)

2.14.1. [Einführung](monitoring-linux.md#introduction)

2.14.2. [Überblick](monitoring-linux.md#overview)

2.15. [Netware-Server überwachen](monitoring-netware.md)

2.16. [Netzwerk-Drucker überwachen](monitoring-printers.md)

2.16.1. [Einführung](monitoring-printers.md#introduction)

2.16.2. [Überblick](monitoring-printers.md#overview)

2.16.3. [Schritte](monitoring-printers.md#steps)

2.16.4. [Was bereits für Sie vorbereitet
wurde](monitoring-printers.md#whatsdone)

2.16.5. [Voraussetzungen](monitoring-printers.md#prerequisites)

2.16.6. [Icinga konfigurieren](monitoring-printers.md#configicinga)

2.16.7. [Icinga neu starten](monitoring-printers.md#restarticinga)

2.17. [Router und Switches überwachen](monitoring-routers.md)

2.17.1. [Einführung](monitoring-routers.md#introduction)

2.17.2. [Überblick](monitoring-routers.md#overview)

2.17.3. [Schritte](monitoring-routers.md#steps)

2.17.4. [Was bereits für Sie vorbereitet
wurde](monitoring-routers.md#whatsdone)

2.17.5. [Voraussetzungen](monitoring-routers.md#prereuisites)

2.17.6. [Icinga konfigurieren](monitoring-routers.md#configicinga)

2.17.7. [Icinga neu starten](monitoring-routers.md#restarticinga)

2.18. [Öffentlich zugängliche Dienste
überwachen](monitoring-publicservices.md)

2.18.1. [Einführung](monitoring-publicservices.md#introduction)

2.18.2. [Plugins zur Überwachung von
Services](monitoring-publicservices.md#pluginsformonitoringservices)

2.18.3. [erstellen einer
Host-Definition](monitoring-publicservices.md#createhostdefinition)

2.18.4. [erstellen von
Service-Definitionen](monitoring-publicservices.md#createservicedefinition)

2.18.5. [Icinga erneut
starten](monitoring-publicservices.md#restarticinga)

​3. [Icinga konfigurieren](ch03.md)

3.1. [Konfigurationsüberblick](config.md)

3.1.1. [Einführung](config.md#introduction)

3.1.2. [Dateinamen](config.md#config-filenames)

3.1.3. [Hauptkonfigurationsdatei](config.md#mainconfigfile)

3.1.4. [Ressource-Datei(en)](config.md#resourcefile)

3.1.5. [Objektdefinitionen-Dateien](config.md#objectdefinitionfiles)

3.1.6. [CGI-Konfigurationsdatei](config.md#cgiconfigfile)

3.2. [Optionen der Hauptkonfigurationsdatei](configmain.md)

3.3. [Überblick Objektkonfiguration](configobject.md)

3.4. [Objektdefinitionen](objectdefinitions.md)

3.4.1. [Host-Definition](objectdefinitions.md#host)

3.4.2. [Hostgruppen-Definition](objectdefinitions.md#hostgroup)

3.4.3. [Service-Definition](objectdefinitions.md#service)

3.4.4. [Servicegruppen-Definition](objectdefinitions.md#servicegroup)

3.4.5. [Kontakt-Definition](objectdefinitions.md#contact)

3.4.6. [Kontaktgruppen-Definition](objectdefinitions.md#contactgroup)

3.4.7. [Zeitfenster-Definition
(timeperiod)](objectdefinitions.md#timeperiod)

3.4.8. [Befehls-Definition (command)](objectdefinitions.md#command)

3.4.9. [Service-Abhängigkeits-Definition
(servicedependency)](objectdefinitions.md#servicedepdency)

3.4.10.
[Serviceeskalations-Definition](objectdefinitions.md#serviceescalation)

3.4.11. [Host-Abhängigkeits-Definition
(hostdependency)](objectdefinitions.md#hostdependency)

3.4.12.
[Host-Eskalations-Definition](objectdefinitions.md#hostescalation)

3.4.13. [erweiterte Hostinformations-Definition
(hostextinfo)](objectdefinitions.md#hostextinfo)

3.4.14. [erweiterte Serviceinformations-Definition
(serviceextinfo)](objectdefinitions.md#serviceextinfo)

3.4.15. [Module-Definition](objectdefinitions.md#module)

3.5. [Maßgeschneiderte Objektvariablen](customobjectvars.md)

3.5.1. [Einführung](customobjectvars.md#introduction)

3.5.2. [Grundlagen zu maßgeschneiderten
Variablen](customobjectvars.md#basicscustomvars)

3.5.3. [Beispiele](customobjectvars.md#examples)

3.5.4. [maßgeschneiderte Variablen als
Makros](customobjectvars.md#customvarsasmacros)

3.5.5. [maßgeschneiderte Variablen und
Vererbung](customobjectvars.md#inheritancecustomvars)

3.6. [Optionen CGI-Konfigurationsdatei](configcgi.md)

​4. [Icinga starten/stoppen/prüfen](ch04.md)

4.1. [Überprüfen Ihrer Icinga-Konfiguration](verifyconfig.md)

4.2. [Icinga starten und stoppen](startstop.md)

​5. [Die Grundlagen](ch05.md)

5.1. [Icinga Plugins](plugins.md)

5.1.1. [Einführung](plugins.md#introduction)

5.1.2. [Was sind Plugins?](plugins.md#overview)

5.1.3. [Plugins als eine
Abstraktionsschicht](plugins.md#abstractionlayer)

5.1.4. [Welche Plugins sind verfügbar?](plugins.md#available)

5.1.5. [Plugins beschaffen](plugins.md#obtaining)

5.1.6. [Zum Icinga-Benutzer wechseln](plugins.md#hints)

5.1.7. [Anpassen der Umgebung](plugins.md#extending)

5.1.8. [Wie benutze ich Plugin X?](plugins.md#plugins-howto)

5.1.9. [Integration eines neuen
Plugins](plugins.md#plugins-new_plugin)

5.1.10. [Raw command line](plugins.md#rawcommandline)

5.1.11. [Schwellwert und Bereiche](plugins.md#thresholdranges)

5.1.12. [Aktivieren der Definition](plugins.md#errors)

5.1.13. [Plugin API](plugins.md#pluginsapi)

5.2. [Makros verstehen und wie sie arbeiten](macros.md)

5.2.1. [Makros](macros.md#introduction)

5.2.2. [Makroersetzungen - wie Makros arbeiten](macros.md#howitworks)

5.2.3. [Beispiel 1: Host-Address Makro](macros.md#hostaddressexample)

5.2.4. [Beispiel 2:
Befehlsargument-Makros](macros.md#commandargexample)

5.2.5. [On-Demand-Makros](macros.md#ondemand)

5.2.6. [On-Demand-Gruppen-Makros](macros.md#ondemandgroup)

5.2.7. [Benutzervariablen-Makros](macros.md#customvar)

5.2.8. [Makrobereinigung](macros.md#cleaning)

5.2.9. [Makros als Umgebungsvariablen](macros.md#environmentvars)

5.2.10. [Verfügbare Makros](macros.md#availablelist)

5.3. [Standard-Makros in Icinga](macrolist.md)

5.3.1. [Makro-Geltungsbereich](macrolist.md#validity)

5.3.2.
[Makroverfügbarkeits-Aufstellung](macrolist.md#availabilitychart)

5.4. [Host-Prüfungen (Host checks)](hostchecks.md)

5.4.1. [Einführung](hostchecks.md#introduction)

5.4.2. [Wann werden Host-Prüfungen
durchgeführt?](hostchecks.md#whenrun)

5.4.3. [zwischengespeicherte Host-Prüfungen (cached host
checks)](hostchecks.md#caching)

5.4.4. [Abhängigkeiten und
Prüfungen](hostchecks.md#dependencieschecks)

5.4.5. [Parallelisierung von
Host-Prüfungen](hostchecks.md#parallelization)

5.4.6. [Host-Zustände](hostchecks.md#hoststates)

5.4.7. [Host-Statusermittlung](hostchecks.md#hoststatedetermination)

5.4.8. [Host-Statusänderungen](hostchecks.md#hoststatechanges)

5.5. [Service-Prüfungen (Service Checks)](servicechecks.md)

5.5.1. [Einführung](servicechecks.md#introduction)

5.5.2. [Wann werden Service-Prüfungen
durchgeführt?](servicechecks.md#when)

5.5.3. [Abhängigkeiten und
Prüfungen](servicechecks.md#dependencieschecks)

5.5.4. [Parallelisierung von
Service-Prüfungen](servicechecks.md#parallelization)

5.5.5. [Service-Zustände](servicechecks.md#servicestates)

5.5.6.
[Service-Statusermittlung](servicechecks.md#servicestatedetermination)

5.5.7.
[Service-Statusänderungen](servicechecks.md#servicestatechanges)

5.5.8. [Service-Zustand ist
"stale"](servicechecks.md#servicestatestale)

5.6. [Aktive Prüfungen (Active Checks)](activechecks.md)

5.6.1. [Einführung](activechecks.md#introduction)

5.6.2. [Wie werden aktive Prüfungen
durchgeführt?](activechecks.md#performed)

5.6.3. [Wann werden aktive Prüfungen
ausgeführt?](activechecks.md#executed)

5.7. [Passive Prüfungen (Passive Checks)](passivechecks.md)

5.7.1. [Einführung](passivechecks.md#introduction)

5.7.2. [Einsatzmöglichkeiten für passive
Prüfungen](passivechecks.md#usecases)

5.7.3. [Wie passive Prüfungen arbeiten](passivechecks.md#howitworks)

5.7.4. [Passive Prüfungen aktivieren](passivechecks.md#enable)

5.7.5. [Übermitteln von passiven
Service-Prüfungsergebnissen](passivechecks.md#servicecheckresults)

5.7.6. [Übermitteln von passiven
Host-Prüfungsergebnissen](passivechecks.md#hostcheckresults)

5.7.7. [Passive Prüfungen und
Host-Zustände](passivechecks.md#hoststates)

5.7.8. [Übermitteln von passiven Prüfungsergebnissen von entfernten
Hosts](passivechecks.md#checkresultsfromremotehosts)

5.8. [Statustypen](statetypes.md)

5.8.1. [Einführung](statetypes.md#introduction)

5.8.2. [Service- und
Host-Prüfungswiederholungen](statetypes.md#checkretries)

5.8.3. [Soft-Zustände](statetypes.md#softretries)

5.8.4. [Hard-Zustände](statetypes.md#hoststates)

5.8.5. [Beispiel](statetypes.md#example)

5.9. [Zeitfenster](timeperiods.md)

5.9.1. [Einführung](timeperiods.md#introduction)

5.9.2. [Vorrang bei Zeitfenstern](timeperiods.md#precedence)

5.9.3. [Wie Zeitfenster mit Host- und Service-Prüfungen
arbeiten](timeperiods.md#hostservicechecks)

5.9.4. [Wie Zeitfenster mit Kontakt-Benachrichtigungen
arbeiten](timeperiods.md#contactnotifications)

5.9.5. [Wie Zeitfenster mit Benachrichtigungs-Eskalationen
arbeiten](timeperiods.md#notificationescalations)

5.9.6. [Wie Zeitfenster mit Abhängigkeiten
arbeiten](timeperiods.md#dependenciestimeperiods)

5.10. [Ermitteln des Zustands und der Erreichbarkeit von
Netzwerk-Hosts](networkreachability.md)

5.10.1. [Einführung](networkreachability.md#introduction)

5.10.2. [Beispiel-Netzwerk](networkreachability.md#examplenetwork)

5.10.3. [Definieren von
Eltern/Kind-Beziehungen](networkreachability.md#parentchildrelations)

5.10.4. [Erreichbarkeits-Logik in
Aktion](networkreachability.md#logicinaction)

5.10.5. [UNREACHABLE Zustände und
Benachrichtigungen](networkreachability.md#unreachableandnotifications)

5.11. [Benachrichtigungen](notifications.md)

5.11.1. [Einführung](notifications.md#introduction)

5.11.2. [Wann erfolgen Benachrichtigungen?](notifications.md#when)

5.11.3. [Wer wird benachrichtigt?](notifications.md#who)

5.11.4. [Welche Filter müssen durchlaufen werden, damit
Benachrichtigungen versandt werden?](notifications.md#whatfilters)

5.11.5. [Programmweite Filter:](notifications.md#programwidefilters)

5.11.6. [Service- und
Host-Filter:](notifications.md#servicehostfilters)

5.11.7. [Kontakt-Filter:](notifications.md#contactfilters)

5.11.8. [Benachrichtigungs-Methoden](notifications.md#methods)

5.11.9. [Benachrichtigungstyp-Makro](notifications.md#typemacro)

5.11.10. [Hilfreiche Quellen](notifications.md#helpfulresources)

5.12. [Benachrichtigungen: Beispiele und
Fehlersuche](notifications2.md)

5.12.1. [Einführung](notifications2.md#introduction)

5.12.2. [Einige Beispiele](notifications2.md#examples)

5.12.3. [Fehlersuche](notifications2.md#troubleshooting)

​6. [Die Benutzeroberflächen](ch06.md)

6.1. [Icinga Classic UI: Informationen über die Classic
UI-Module](cgis.md)

6.2. [Authentifizierung und Autorisierung im Classic UI](cgiauth.md)

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

6.3. [Informationen zu den Classic UI-Modul-Parametern](cgiparams.md)

6.3.1. [Einführung](cgiparams.md#introduction)

6.3.2. [Ausführen der Classic UI-Modules auf der
Kommandozeile](cgiparams.md#executecmdline)

6.3.3. [Properties / Statustypes](cgiparams.md#propsstatustypes)

6.3.4. [Matrix Parameter / Module](cgiparams.md#matrixparamscgis)

6.3.5. [Einzelheiten zu den Parametern](cgiparams.md#cgiparams_expl)

6.3.6. [Abkürzungen, Classic UI-Module (CGIs),
Verweise](cgiparams.md#cgiparams_abbrev)

6.3.7. [Host- und
Service-Filter-Eigenschaften](cgiparams.md#cgiparams-filter)

6.3.8. [Host- und
Service-Statustypen](cgiparams.md#cgiparams-statustypes)

6.3.9. [Commands](cgiparams.md#idp11982752)

6.4. [Ausführen von Classic UI-Modulen (CGIs) auf der
Kommandozeile](cgicmd.md)

6.4.1. [Einführung](cgicmd.md#introduction)

6.4.2. [Voraussetzungen](cgicmd.md#prerequisites)

6.4.3. [Beispiele](cgicmd.md#examples)

6.5. [Installation des Icinga Web Frontend](icinga-web-scratch.md)

6.5.1. [Einleitung](icinga-web-scratch.md#introduction)

6.5.2. [Voraussetzungen](icinga-web-scratch.md#prerequisites)

6.5.3. [Die Installation](icinga-web-scratch.md#install)

6.5.4. [Einstellungen](icinga-web-scratch.md#settings)

6.5.5. [Testen](icinga-web-scratch.md#useit)

6.5.6. [Test & Fehler?](icinga-web-scratch.md#webtroubleshooting)

6.6. [Konfigurationsübersicht Icinga Web](icinga-web-config.md)

6.6.1. [Wo sind meine
Konfigurationsdateien?](icinga-web-config.md#configfilelocation)

6.6.2. [Index](icinga-web-config.md#configfileindex)

6.6.3. [Globale Konfiguration](icinga-web-config.md#globalconfig)

6.6.4. [Fehlersuche](icinga-web-config.md#troubleshooting)

6.6.5. [Modul-Konfiguration:](icinga-web-config.md#moduleconfig)

6.6.6. [Benutzerdefinierte
Konfiguration](icinga-web-config.md#customconfig)

6.7. [Aktualisierung von Icinga Web und Icinga Web
Datenbank](upgrading_icingaweb.md)

6.7.1. [Aktualisieren von Icinga
Web](upgrading_icingaweb.md#upgradingicingaweb)

6.7.2. [Die Aktualisierung von Icinga
Web](upgrading_icingaweb.md#upgrade)

6.7.3. [Aktualisieren der Icinga Web
Datenbank](upgrading_icingaweb.md#upgradedatabase)

6.8. [Einführung in Icinga Web](icinga-web-introduction.md)

6.8.1. [Einführung in Icinga Web (\>=
1.13)](icinga-web-introduction.md#icinga-web-intro)

6.9. [Integration von PNP4Nagios in das Icinga Web
Frontend](icinga-web-pnp.md)

6.9.1. [Installieren von PNP4Nagios](icinga-web-pnp.md#installpnp)

6.9.2. [Template-Extensions](icinga-web-pnp.md#templateextension)

6.9.3. [Löschen des Cache](icinga-web-pnp.md#idp12925840)

​7. [Fortgeschrittene Themen](ch07.md)

7.1. [Externe Befehle](extcommands.md)

7.1.1. [Einführung](extcommands.md#introduction)

7.1.2. [Externe Befehle aktivieren](extcommands.md#enable)

7.1.3. [Wann prüft Icinga auf externe
Befehle?](extcommands.md#whenchecked)

7.1.4. [Externe Befehle benutzen](extcommands.md#usage)

7.1.5. [Befehlsformat](extcommands.md#format)

7.2. [Liste der externen Befehle](extcommands2.md)

7.3. [Eventhandler](eventhandlers.md)

7.3.1. [Einführung](eventhandlers.md#introduction)

7.3.2. [Wann werden Eventhandler
ausgeführt?](eventhandlers.md#execution)

7.3.3. [Eventhandler-Typen](eventhandlers.md#idp12970304)

7.3.4. [Eventhandler aktivieren](eventhandlers.md#enable)

7.3.5.
[Eventhandler-Ausführungsreihenfolge](eventhandlers.md#executionorder)

7.3.6. [Eventhandler-Kommandos
schreiben](eventhandlers.md#writingcommands)

7.3.7. [Berechtigungen für
Eventhandler-Befehle](eventhandlers.md#commandpermissions)

7.3.8. [Service Event Handler
Beispiel](eventhandlers.md#serviceeventhandlerexample)

7.4. [sprunghafte Services](volatileservices.md)

7.4.1. [Einführung](volatileservices.md#introduction)

7.4.2. [Wofür sind sie nützlich?](volatileservices.md#usage)

7.4.3. [Was ist so besonders an flüchtigen
Services?](volatileservices.md#speciality)

7.4.4. [Die Macht der Zwei](volatileservices.md#poweroftwo)

7.4.5. [Icinga Konfiguration:](volatileservices.md#configvolatile)

7.4.6. [PortSentry
Konfiguration:](volatileservices.md#portsentryconfig)

7.4.7. [Portscan-Script:](volatileservices.md#portscanscript)

7.5. [Service- und Host-Frische-Prüfungen](freshness.md)

7.5.1. [Einführung](freshness.md#introduction)

7.5.2. [Wie funktioniert die
Frische-Prüfung?](freshness.md#howitworks)

7.5.3. [Frische-Prüfungen aktivieren](freshness.md#enable)

7.5.4. [Beispiel](freshness.md#example)

7.5.5. ["Check results ... are stale. Forcing an immediate check
...](freshness.md#stale)

7.6. [Verteilte Überwachung](distributed.md)

7.6.1. [Einführung](distributed.md#introduction)

7.6.2. [Ziele](distributed.md#goals)

7.6.3. [Referenzdiagramm](distributed.md#referencediagram)

7.6.4. [Zentraler Server vs. Verteilte
Server](distributed.md#centralvsdistributed)

7.6.5. [Service-Prüfungsinformationen von verteilten Servern
erhalten](distributed.md#servicecheckinfo)

7.6.6. [Verteilte
Server-Konfiguration](distributed.md#distributedconfig)

7.6.7.
[ocsp\_command=submit\_check\_result](distributed.md#oscpsubmitcheckresult)

7.6.8. [zentrale Server-Konfiguration](distributed.md#centralconfig)

7.6.9. [Probleme bei passiven
Prüfungen](distributed.md#problemspassive)

7.6.10. [Frische-Prüfung (Freshness
Checking)](distributed.md#freshnesschecks)

7.6.11. [Host-Prüfungen
durchführen](distributed.md#hostcheckperforming)

7.7. [Redundante und Failover-Netzwerk-Überwachung](redundancy.md)

7.7.1. [Einführung](redundancy.md#introduction)

7.7.2. [Voraussetzungen](redundancy.md#redprerequisites)

7.7.3. [Beispielscripts](redundancy.md#samplescripts)

7.7.4. [Scenario 1 - Redundante
Üverwachung](redundancy.md#redundantmonitoring)

7.7.5. [Scenario 2 - Failover
Überwachung](redundancy.md#failovermonitoring)

7.8. [Erkennung und Behandlung von Status-Flattern](flapping.md)

7.8.1. [Einführung](flapping.md#introduction)

7.8.2. [Wie Flatter-Erkennung arbeitet](flapping.md#howitworks)

7.8.3. [Beispiel](flapping.md#example)

7.8.4. [Flatter-Erkennung für Services](flapping.md#detectionservices)

7.8.5. [Flatter-Erkennung für Hosts](flapping.md#detectionhosts)

7.8.6. [Flatter-Erkennungsschwellwerte](flapping.md#thresholds)

7.8.7. [Zustände, die für die Flatter-Erkennung benutzt
werden](flapping.md#statesused)

7.8.8. [Flatter-Behandlung](flapping.md#handling)

7.8.9. [Aktivieren der Flatter-Erkennung](flapping.md#enable)

7.9. [Benachrichtigungseskalationen](escalations.md)

7.9.1. [Einführung](escalations.md#introduction)

7.9.2. [Wann werden Benachrichtigungen
eskaliert?](escalations.md#notificationsescalated)

7.9.3. [Kontaktgruppen](escalations.md#contactgroups)

7.9.4. [Überlappende
Eskalationsbereiche](escalations.md#overlappingranges)

7.9.5.
[Erholungsbenachrichtigungen](escalations.md#recoverynotifications)

7.9.6.
[Benachrichtigungsintervalle](escalations.md#notificationintervals)

7.9.7.
[Zeitfenster-Beschränkungen](escalations.md#timeperiodrestrictions)

7.9.8. [Status-Beschränkungen](escalations.md#staterestrictions)

7.10. [Eskalations-Bedingung](escalation_condition.md)

7.10.1. [Einleitung](escalation_condition.md#introduction)

7.10.2. [Syntax](escalation_condition.md#syntax)

7.10.3. [Beispiel](escalation_condition.md#example)

7.11. [Bereitschafts-Rotation](oncallrotation.md)

7.11.1. [Einführung](oncallrotation.md#introduction)

7.11.2. [Szenario 1: Urlaub und
Wochenenden](oncallrotation.md#holidaysweekends)

7.11.3. [Szenario 2: Abwechselnde
Tage](oncallrotation.md#alternatingdays)

7.11.4. [Szenario 3: Abwechselnde
Wochen](oncallrotation.md#alternatingweeks)

7.11.5. [Szenario 4: Urlaubstage](oncallrotation.md#vacationdays)

7.11.6. [Andere Szenarien](oncallrotation.md#others)

7.12. [Service- und Host-Gruppen überwachen](clusters.md)

7.12.1. [Einführung](clusters.md#introduction)

7.12.2. [Angriffsplan](clusters.md#planofattack)

7.12.3. [Das check\_cluster-Plugin
benutzen](clusters.md#checkclusterplugin)

7.12.4. [Service-Cluster überwachen](clusters.md#serviceclusters)

7.12.5. [Host-Cluster überwachen](clusters.md#hostclusters)

7.13. [Host- und Service-Abhängigkeiten](dependencies.md)

7.13.1. [Einführung](dependencies.md#introduction)

7.13.2. [Überblick Service-Abhängigkeiten](dependencies.md#overview)

7.13.3. [Service-Abhängigkeiten
definieren](dependencies.md#definition)

7.13.4. [Beispiel Service-Abhängigkeiten](dependencies.md#example)

7.13.5. [Wie Service-Abhängigkeiten getestet
werden](dependencies.md#test)

7.13.6. [Ausführungsabhängigkeiten](dependencies.md#execution)

7.13.7. [Benachrichtigungsabhängigkeiten](dependencies.md#inheritance)

7.13.8. [Abhängigkeitsvererbung](dependencies.md#dep_host)

7.13.9. [Host-Abhängigkeiten](dependencies.md#host)

7.13.10. [Beispiel Host-Abhängigkeiten](dependencies.md#examplehost)

7.14. [Status Stalking](stalking.md)

7.14.1. [Einführung](stalking.md#introduction)

7.14.2. [Wie funktioniert es?](stalking.md#howitworks)

7.14.3. [Sollte ich die Verfolgung aktivieren?](stalking.md#whyenable)

7.14.4. [Wie aktiviere ich die Verfolgung?](stalking.md#howenable)

7.14.5. [Wie unterschieden sich Verfolgung und "flüchtige
Services"?](stalking.md#differtovolatile)

7.14.6. [Risiken](stalking.md#caveats)

7.15. [Performance-Daten](perfdata.md)

7.15.1. [Einführung](perfdata.md#introduction)

7.15.2. [Typen von Performance-Daten](perfdata.md#typesperfdata)

7.15.3. [Plugin-Performance-Daten](perfdata.md#pluginperfdata)

7.15.4. [Performance-Daten verarbeiten](perfdata.md#processing)

7.15.5. [Performance-Daten verarbeiten durch
Befehle](perfdata.md#processingcommands)

7.15.6. [Performance-Daten in Dateien
schreiben](perfdata.md#writingtofiles)

7.15.7. [Format Performance-Daten](perfdata.md#formatperfdata)

7.16. [Geplante Ausfallzeiten](downtime.md)

7.16.1. [Einführung](downtime.md#introduction)

7.16.2. [Ausfallzeit einplanen](downtime.md#schedule)

7.16.3. [Feste und flexible
Ausfallzeiten](downtime.md#fixedvsflexible)

7.16.4. [ausgelöste Ausfallzeiten](downtime.md#triggered)

7.16.5. [Wie geplante Ausfallzeiten Benachrichtigungen
beeinflussen](downtime.md#affectednotifications)

7.16.6. [Überlappende geplante Ausfallzeiten](downtime.md#overlapping)

7.17. [Wiederkehrende Ausfallzeiten](recurring_downtimes.md)

7.17.1. [Ausfallzeiten
definieren](recurring_downtimes.md#introduction)

7.17.2. [Variable Daten](recurring_downtimes.md#variabledates)

7.17.3. [Lokale Feiertage](recurring_downtimes.md#localholidays)

7.17.4. [Eingaben von
Ausfallzeiten](recurring_downtimes.md#enteringdowntimes)

7.17.5. [Planen von
Ausfallzeiten](recurring_downtimes.md#planningdowntimes)

7.17.6. [Konvertieren von
Ausfallzeitdefinitionen](recurring_downtimes.md#conversion)

7.17.7. [Dateien](recurring_downtimes.md#files)

7.18. [Benutzen des Embedded Perl Interpreters](embeddedperl.md)

7.18.1. [Vorteile](embeddedperl.md#pros)

7.18.2. [Nachteile](embeddedperl.md#cons)

7.18.3. [Benutzung des eingebetteten
Perl-Interpreters](embeddedperl.md#interpreter)

7.18.4. [Icinga mit eingebettetem Perl
kompilieren](embeddedperl.md#compileicinga)

7.18.5. [Plugin-spezifische Benutzung des
Perl-Interpreters](embeddedperl.md#idp14800032)

7.18.6. [Plugins für die Nutzung mit Embedded Perl
entwickeln](embeddedperl.md#plugspecs)

7.19. [Adaptive Überwachung](adaptive.md)

7.19.1. [Einführung](adaptive.md#introduction)

7.19.2. [Was kann verändert werden?](adaptive.md#changed)

7.19.3. [Externe Befehle für adaptive
Überwachung](adaptive.md#extcommandsadaptive)

7.20. [Vorausschauende Abhängigkeitsprüfungen](dependencychecks.md)

7.20.1. [Einführung](dependencychecks.md#introduction)

7.20.2. [Wie arbeiten vorausschauende
Prüfungen?](dependencychecks.md#howitworks)

7.20.3. [Vorausschauende Prüfungen
aktivieren](dependencychecks.md#enable)

7.20.4. [Cached Checks](dependencychecks.md#idp14866704)

7.21. [Zwischengespeicherte Prüfungen](cachedchecks.md)

7.21.1. [Einführung](cachedchecks.md#introduction)

7.21.2. [Nur für Prüfungen nach
Bedarf](cachedchecks.md#ondemandchecks)

7.21.3. [Wie Zwischenspeicherung arbeitet](cachedchecks.md#howitworks)

7.21.4. [Was dies wirklich bedeutet](cachedchecks.md#whatthismeans)

7.21.5. [Konfigurationsvariablen](cachedchecks.md#configvars)

7.21.6. [Zwischenspeichereffektivität
optimieren](cachedchecks.md#optimizeeffectiveness)

7.22. [Passive Host-Zustandsübersetzung](passivestatetranslation.md)

7.22.1. [Einführung](passivestatetranslation.md#introduction)

7.22.2. [Verschiedene
Sichten](passivestatetranslation.md#differentviews)

7.22.3. [Status-Übersetzung
aktivieren](passivestatetranslation.md#enablestatetranslation)

7.23. [Service- und Host-Prüfungsplanung](checkscheduling.md)

7.23.1. [Einführung](checkscheduling.md#introduction)

7.23.2.
[Konfigurationsoptionen](checkscheduling.md#configurationoptions)

7.23.3. [Initiale Planung](checkscheduling.md#initialscheduling)

7.23.4. [Inter-Check-Verzögerung (inter-check
delay)](checkscheduling.md#serviceintercheckdelay)

7.23.5. [Service-Verschachtelung (service
interleaving)](checkscheduling.md#serviceinterleaving)

7.23.6. [Maximale Zahl gleichzeitiger
Service-Prüfungen](checkscheduling.md#maxconcurrentchecks)

7.23.7. [Zeitbeschränkungen](checkscheduling.md#timerestraints)

7.23.8. [Normale Planung](checkscheduling.md#normalscheduling)

7.23.9. [Planung bei Problemen](checkscheduling.md#problemscheduling)

7.23.10. [Host-Prüfungen](checkscheduling.md#hostcheckscheduling)

7.23.11. [Planungsverzögerungen](checkscheduling.md#schedulingdelays)

7.23.12. [Planungsbeispiel](checkscheduling.md#schedulingexample)

7.23.13. [Service-Definitionsoptionen, die die Planung
beeinflussen](checkscheduling.md#serviceoptions)

7.23.14. [TODO](checkscheduling.md#todo)

7.24. [Angepasste Classic UI-Modul-Kopf- und
Fußzeilen](cgiincludes.md)

7.24.1. [Einführung](cgiincludes.md#introduction)

7.24.2. [Wie funktioniert es?](cgiincludes.md#howitworks)

7.25. [Modifizierte Attribute](modified_attr.md)

7.25.1. [Einführung](modified_attr.md#introduction)

7.25.2. [Beispiel](modified_attr.md#example)

7.26. [Objektvererbung](objectinheritance.md)

7.26.1.
[Einführung](objectinheritance.md#objectinheritance-introduction)

7.26.2. [Grundlagen](objectinheritance.md#objectinheritance-basics)

7.26.3. [Lokale Variablen gegenüber vererbten
Variablen](objectinheritance.md#objectinheritance-localvsinveritedvars)

7.26.4.
[Vererbungsverkettung](objectinheritance.md#objectinheritance-inheritancechaining)

7.26.5. [Unvollständige Objektdefinitionen als Vorlagen
nutzen](objectinheritance.md#objectinheritance-templates)

7.26.6. [eigene Objektvariablen (custom object
variables)](objectinheritance.md#objectinheritance-customobjectvariables)

7.26.7. [Vererbung für Zeichenketten-Werte
aufheben](objectinheritance.md#objectinheritance-cancel_string)

7.26.8. [additive Vererbung von
Zeichenketten-Werten](objectinheritance.md#objectinheritance-add_string)

7.26.9. [Implizite
Vererbung](objectinheritance.md#objectinheritance-implied_inheritance)

7.26.10. [implizite/additive Vererbung bei
Eskalationen](objectinheritance.md#objectinheritance-implied_escalations)

7.26.11. [Wichtige Werte (important
values)](objectinheritance.md#objectinheritance-important_values)

7.26.12. [Mehrere
Vererbungsquellen](objectinheritance.md#objectinheritance-multiple_templates)

7.26.13. [Vorrang bei mehreren
Vererbungsquellen](objectinheritance.md#objectinheritance-multipleinheritancesources)

7.27. [Zeitsparende Tricks für Objektdefinitionen](objecttricks.md)

​8. [Sicherheit und Leistungsoptimierung](ch08.md)

8.1. [Sicherheitsüberlegungen](security.md)

8.1.1. [Einführung](security.md#introduction)

8.1.2. [Optimale Verfahren](security.md#bestpractices)

8.2. [Verbesserte Classic UI Modul-Sicherheit und
Authentifizierung](cgisecurity.md)

8.2.1. [Einführung](cgisecurity.md#introduction)

8.2.2. [Zusätzliche Techniken](cgisecurity.md#additionaltechniques)

8.2.3. [Implementieren der Digest
Authentication](cgisecurity.md#implementationdigest)

8.2.4. [Implementieren erzwungener
TLS/SSL-Kommunikation](cgisecurity.md#implementationssl)

8.2.5. [Implementieren von
IP-Subnetz-Beschränkung](cgisecurity.md#implementationlockdown)

8.2.6. [Wichtige Anmerkungen](cgisecurity.md#importantnotes)

8.3. [Icinga für maximale Leistung optimieren](tuning.md)

8.3.1. [Einführung](tuning.md#introduction)

8.3.2. [Optimierungshinweise:](tuning.md#optimizationtips)

8.4. [Schnellstart-Optionen](faststartup.md)

8.4.1. [Einführung](faststartup.md#introduction)

8.4.2. [Hintergrund](faststartup.md#background)

8.4.3. [Bewertung von Anlaufzeiten](faststartup.md#evalstartuptime)

8.4.4. [Pre-Caching der
Objektkonfiguration](faststartup.md#precacheobjectconfig)

8.4.5. [Überspringen der Tests von zirkulären
Pfaden](faststartup.md#skipcircularpathtests)

8.4.6. [Alles zusammenfassen](faststartup.md#puttogether)

8.5. [Large Installation Tweaks](largeinstalltweaks.md)

8.5.1. [Einführung](largeinstalltweaks.md#introduction)

8.5.2. [Effekte](largeinstalltweaks.md#effects)

8.6. [Nutzung des Icingastats-Utilitys](icingastats.md)

8.6.1. [Einführung](icingastats.md#introduction)

8.6.2. [Gebrauchshinweise](icingastats.md#usageinfo)

8.6.3. [menschlich-lesbare Ausgabe](icingastats.md#output)

8.6.4. [PNP4Nagios-Integration](icingastats.md#integration)

8.7. [Grafische Darstellung von Performance-Informationen mit
PNP4Nagios](perfgraphs.md)

8.7.1. [Einführung](perfgraphs.md#introduction)

8.7.2. [Voraussetzungen](perfgraphs.md#prerequisites)

8.7.3. [Durchschnittliche
Host-/Service-Prüfungslatenz](perfgraphs.md#avghostsvcchecklatency)

8.7.4. [Service-Statistiken](perfgraphs.md#servicestatistics)

8.7.5. [Host-Statistiken](perfgraphs.md#hoststatistics)

8.7.6. [Durchschnittliche
Ausführungszeiten](perfgraphs.md#avgexecutiontimes)

8.7.7. [Externe Befehle (external
commands)](perfgraphs.md#externalcommands)

8.7.8. [Puffer für externe Befehle (external command
buffers)](perfgraphs.md#externalcommandbuffers)

8.7.9. [Zwischengespeicherte Host- und Service-Prüfungen (cached host
and service checks)](perfgraphs.md#avgstatechanges)

8.7.10. [Durchschnittliche Zustandswechsel](perfgraphs.md#idp15945472)

8.8. [Temporäre Daten](temp_data.md)

​9. [Integration mit anderer Software](ch09.md)

9.1. [Integrationsüberblick](integration.md)

9.1.1. [Einführung](integration.md#introduction)

9.1.2. [Integrationsstellen](integration.md#points)

9.1.3. [Integrationsbeispiele](integration.md#examples)

9.2. [SNMP-Trap-Integration](int-snmptrap.md)

9.3. [TCP-Wrapper-Integration](int-tcpwrappers.md)

9.3.1. [Einführung](int-tcpwrappers.md#introduction)

9.3.2. [Einen Service
definieren](int-tcpwrappers.md#servicedefinitiontcpwrapper)

9.3.3. [TCP-Wrapper
konfigurieren](int-tcpwrappers.md#configtcpwrappers)

9.3.4. [Das Script schreiben](int-tcpwrappers.md#tcpwrapperscript)

9.3.5. [Aufräumen](int-tcpwrappers.md#finish)

9.4. [MKLiveStatus-Integration](int-mklivestatus.md)

9.4.1. [Einführung](int-mklivestatus.md#introduction)

9.4.2. [Installation /
Konfiguration](int-mklivestatus.md#installconfig)

9.5. [Installation von Icinga Reporting mit JasperReports
Server](reporting.md)

9.5.1. [Offizielle Dokumentation](reporting.md#introduction)

9.5.2. [Voraussetzungen](reporting.md#officialdocs)

9.5.3. [Icinga Reporting](reporting.md#icingareporting)

9.5.4. [Konfiguration](reporting.md#configuration)

9.5.5. [Reports](reporting.md#reports)

9.5.6. [Fehler](reporting.md#errors)

​10. [weitere Software](ch10.md)

10.1. [Icinga Addons](addons.md)

10.1.1. [Einführung](addons.md#introduction)

10.2. [NRPE](nrpe.md)

10.2.1. [Einführung](nrpe.md#introduction)

10.2.2. [Voraussetzungen](nrpe.md#prerequisites)

10.2.3. [Download](nrpe.md#download)

10.2.4. [Optionale Anpassungen](nrpe.md#optionalchanges)

10.2.5. [Kompilieren auf dem Icinga-Server](nrpe.md#compile)

10.2.6. [Erster Test](nrpe.md#firsttest)

10.2.7. [Entfernte/s System/e](nrpe.md#remotesystem)

10.2.8. [Voraussetzungen auf dem entfernten
System](nrpe.md#prerequisitesremotehost)

10.2.9. [Zweiter Test](nrpe.md#secondtest)

10.2.10. [Installation auf dem entfernten
Host](nrpe.md#remotehostinstall)

10.2.11. [Dritter Test](nrpe.md#thirdtest)

10.2.12. [Fehlersuche](nrpe.md#troubleshooting)

10.2.13. [Sicherheit](nrpe.md#security)

10.2.14. [Definition von lokalen
Prüfungen](nrpe.md#localcheckdefinition)

10.2.15. [Definitionen auf dem
Icinga-Server](nrpe.md#icingaserverdefinitions)

10.2.16. [Weitere Fehlersuche](nrpe.md#moretroubleshooting)

10.2.17. [Aktualisierung](nrpe.md#upgrading)

10.3. [NSCA](nsca.md)

10.3.1. [Einführung](nsca.md#introduction)

10.3.2. [Voraussetzungen](nsca.md#prerequisites)

10.3.3. [Download und Compile](nsca.md#downloadcompile)

10.3.4. [Anpassen](nsca.md#customise)

10.3.5. [Erster Test](nsca.md#firsttest)

10.3.6. [Installation](nsca.md#installnsca)

10.3.7. [Entfernte/s System/e](nsca.md#remotesystem)

10.3.8. [Dateien kopieren](nsca.md#copyfiles)

10.3.9. [Zweiter Test](nsca.md#secondtest)

10.3.10. [Fehlersuche](nsca.md#troubleshooting)

10.3.11. [Sicherheit](nsca.md#security)

10.3.12. [Betrieb](nsca.md#operation)

10.3.13. [Integration in Icinga](nsca.md#icingaintegration)

​11. [Entwicklung](ch11.md)

11.1. [Nagios Plugin API](pluginapi.md)

11.1.1. [Andere Ressourcen](pluginapi.md#otherresources)

11.1.2. [Plugin-Überblick](pluginapi.md#overview)

11.1.3. [Return-Code](pluginapi.md#returncode)

11.1.4. [Spezifikation der Plugin-Ausgabe(n)](pluginapi.md#outputspec)

11.1.5. [Plugin-Beispielausgaben](pluginapi.md#outputexamples)

11.1.6. [Längenbeschränkungen von
Plugin-Ausgaben](pluginapi.md#outputlengthrestrictions)

11.1.7. [Beispiele](pluginapi.md#examples)

11.1.8. [Perl-Plugins](pluginapi.md#perlplugins)

11.2. [Entwickeln von Plugins für die Nutzung mit Embedded
Perl](epnplugins.md)

11.2.1. [Einführung](epnplugins.md#introduction)

11.2.2. [Zielgruppe](epnplugins.md#targetaudience)

11.2.3. [Dinge, die Sie tun müssen, um ein Perl-Plugin für ePN zu
entwickeln](epnplugins.md#todo)

11.3. [Keine Icinga API mehr zu installieren](icinga-api.md)

11.3.1. [Installation und Benutzung der Icinga
API](icinga-api.md#idp16704272)

11.3.2. [Konfiguration](icinga-api.md#idp16734992)

11.3.3. [Unterstützte Backends](icinga-api.md#idp16737520)

11.4. [Die Icinga Web REST API](icinga-web-api.md)

11.4.1. [Warum sollten Sie die API benutzen?](icinga-web-api.md#why)

11.4.2. [Features der Icinga Web REST API](icinga-web-api.md#features)

11.4.3. [Was ist der Unterschied zwischen der Icinga API und der Icinga
Web REST API?](icinga-web-api.md#difference)

11.4.4. [Voraussetzungen](icinga-web-api.md#prerequisites)

11.4.5. [Referenzen](icinga-web-api.md#reference)

11.4.6. [GET](icinga-web-api.md#get)

11.4.7. [Die Struktur der URL:](icinga-web-api.md#geturlstructure)

11.4.8. [Die Parameter en Detail:](icinga-web-api.md#getparamdetails)

11.4.9. [Beispiele für GET](icinga-web-api.md#getexample)

11.4.10. [POST](icinga-web-api.md#post)

11.4.11. [Die Parameter en Detail](icinga-web-api.md#postparamdetail)

11.4.12. [Beispiele für POST](icinga-web-api.md#postexample)

​12. [IDOUtils](ch12.md)

12.1. [Einleitung](db_intro.md)

12.1.1. [Zweck](db_intro.md#purpose)

12.1.2. [Design-Überblick](db_intro.md#design)

12.1.3. [Instanzen](db_intro.md#instances)

12.1.4. [Installation](db_intro.md#install)

12.2. [Komponenten](components.md)

12.2.1. [Überblick](components.md#overview)

12.2.2. [IDOMOD](components.md#idomod)

12.2.3. [LOG2IDO](components.md#log2ido)

12.2.4. [FILE2SOCK](components.md#file2sock)

12.2.5. [IDO2DB](components.md#ido2db)

12.3. [Konfiguration der IDOUtils](configido.md)

12.3.1. [IDOMOD
Konfigurationsoptionen](configido.md#configido-idomod_options)

12.3.2. [IDO2DB
Konfigurationsoptionen](configido.md#configido-ido2db_options)

12.4. [Beispielkonfigurationen](example-configs.md)

12.4.1. [Einzelner Server, einzelne
Instanz](example-configs.md#singleserversingleinstance)

12.4.2. [Einzelner Server, mehrere
Instanzen](example-configs.md#singleservermultipleinstance)

12.4.3. [Einzelner Server, einzelne Instanz,
Log-Datei-Import](example-configs.md#singleserversingleinstancelogfile)

12.5. [IDOUtils Database Model](db_model.md)

12.5.1. [Central Tables](db_model.md#dbm_ct)

12.5.2. [Debugging Tables](db_model.md#dbm_dt)

12.5.3. [Historical Tables](db_model.md#dbm_ht)

12.5.4. [Current Status Tables](db_model.md#dbm_cu)

12.5.5. [Configuration Tables](db_model.md#dbm_cf)

12.6. [Datenbank-Anpassungen/Änderungen](db_changes.md)

​13. [Icinga Beispieldateien](ch13.md)

13.1. [Beispielkonfigurationsdateien und
Definitionen](sample-config.md)

13.2. [icinga.cfg](sample-icinga.md)

13.3. [cgi.cfg](sample-cgi.md)

13.4. [resource.cfg](sample-resource.md)

13.5. [httpd.conf](sample-httpd.md)

13.6. [commands.cfg](sample-commands.md)

13.7. [contacts.cfg](sample-contacts.md)

13.8. [localhost.cfg](sample-localhost.md)

13.9. [notifications.cfg](sample-notifications.md)

13.10. [printer.cfg](sample-printer.md)

13.11. [switch.cfg](sample-switch.md)

13.12. [templates.cfg](sample-templates.md)

13.13. [timeperiods.cfg](sample-timeperiods.md)

13.14. [windows.cfg](sample-windows.md)

[Stichwortverzeichnis](ix01.md)

**Abbildungsverzeichnis**

3.1. [Beispiel des neuen Headers](configcgi.md#idp6599040)

6.1. [Icinga Web instance down](icinga-web-config.md#idp12591168)

6.2. [Icinga Web
Login-Bildschirm](icinga-web-introduction.md#idp12717120)

6.3. [Icinga Web Überblick](icinga-web-introduction.md#idp12720896)

6.4. [Icinga Web Top-Menü](icinga-web-introduction.md#idp12724832)

6.5. [Icinga Web Live-Suche](icinga-web-introduction.md#idp12728864)

6.6. [Icinga Web Status-Cronk](icinga-web-introduction.md#idp12736208)

6.7. [Icinga Web Data-Cronks](icinga-web-introduction.md#idp12741824)

6.8. [Icinga Web Tactical
Overview-Cronks](icinga-web-introduction.md#idp12746128)

6.9. [Icinga Web
Reporting-Cronks](icinga-web-introduction.md#idp12747760)

6.10. [Icinga Web
"Misc"-Cronks](icinga-web-introduction.md#idp12753728)

6.11. [Icinga Web Cronk Menü
Umschalter](icinga-web-introduction.md#idp12757792)

6.12. [Icinga Web Zentrale
Übersicht](icinga-web-introduction.md#idp12762208)

6.13. [Icinga Web Host-Status](icinga-web-introduction.md#idp12766304)

6.14. [Icon-Balken](icinga-web-introduction.md#idp12769552)

6.15. [Verschieben von Icons](icinga-web-introduction.md#idp12773680)

6.16. [Neue Icons im Raster](icinga-web-introduction.md#idp12777616)

6.17. [Zurücksetzen der
Icon-Einstellungen](icinga-web-introduction.md#idp12781648)

6.18. [Icinga Web
Objekt-Information](icinga-web-introduction.md#idp12786224)

6.19. [Icinga Web
Service-Status](icinga-web-introduction.md#idp12790048)

6.20. [Icinga Web Service
Information](icinga-web-introduction.md#idp12794160)

6.21. [Icinga Web
Hostgruppenstatus](icinga-web-introduction.md#idp12798208)

6.22. [Icinga Web Log](icinga-web-introduction.md#idp12802160)

6.23. [Icinga Web
Cronk-Leiste](icinga-web-introduction.md#idp12806656)

6.24. [Icinga Web
Cronk-Leiste](icinga-web-introduction.md#idp12813056)

6.25. [Icinga Web
Host-Befehle](icinga-web-introduction.md#idp12822112)

6.26. [Icinga Web
Service-Befehle](icinga-web-introduction.md#idp12825952)

6.27. [Icinga Web
Filtereinschränkung](icinga-web-introduction.md#idp12830416)

6.28. [Icinga Web drag filter](icinga-web-introduction.md#idp12836448)

6.29. [Icinga Web drop filter](icinga-web-introduction.md#idp12838512)

6.30. [Icinga Web Filter Attribut
Selektierung](icinga-web-introduction.md#idp12844192)

6.31. [Icinga Web Filter
aktiv](icinga-web-introduction.md#idp12846944)

6.32. [Icinga Web filter advanced
filters](icinga-web-introduction.md#idp12850368)

6.33. [Icinga Web Top-Menü
Admin](icinga-web-introduction.md#idp12856016)

6.34. [Icinga Web
Benutzer-Administration](icinga-web-introduction.md#idp12859648)

6.35. [Icinga Web Benutzer
editieren](icinga-web-introduction.md#idp12867376)

6.36. [Icinga Web
Gruppen-Administration](icinga-web-introduction.md#idp12871600)

6.37. [Icinga Web Gruppen](icinga-web-introduction.md#idp12875312)

6.38. [Icinga Web Rollen](icinga-web-introduction.md#idp12878928)

6.39. [Icinga Web logs](icinga-web-introduction.md#idp12884480)

6.40. [Icinga Web Tasks](icinga-web-introduction.md#idp12888928)

6.41. [Expander-Icon](icinga-web-pnp.md#idp12893760)

6.42. [Icon-Balken](icinga-web-pnp.md#idp12897424)

6.43. [PNP4Nagios-Icons](icinga-web-pnp.md#idp12900992)

6.44. [Icon verschieben in Raster](icinga-web-pnp.md#idp12904640)

6.45. [Zurücksetzen von
Icon-Einstellungen](icinga-web-pnp.md#idp12908896)

8.1. [Durchschnittliche
Host-/Service-Prüfungslatenz](perfgraphs.md#idp15872672)

8.2. [Service-Statistiken](perfgraphs.md#idp15889184)

8.3. [Host-Statistiken](perfgraphs.md#idp15899664)

8.4. [Durchschnittliche Ausführungszeiten](perfgraphs.md#idp15910208)

8.5. [Externe Befehle](perfgraphs.md#idp15922912)

8.6. [Puffer für externe Befehle](perfgraphs.md#idp15929648)

8.7. [Zwischengespeicherte Host- und
Service-Prüfungen](perfgraphs.md#idp15938448)

8.8. [Durchschnittliche Zustandswechsel](perfgraphs.md#idp15946288)

9.1. [Icinga reporting datasource ido mysql](reporting.md#idp16123936)

9.2. [Icinga reporting](reporting.md#idp16128256)

9.3. [Icinga reporting](reporting.md#idp16135952)

10.1. [NRPE](nrpe.md#idp16250464)

10.2. [NRPE remote](nrpe.md#idp16255376)

10.3. [NSCA](nsca.md#idp16418304)

12.1. [Mögliche Anordnungen](db_intro.md#idp16857664)

12.2. [zukünfte Entwicklung: Eine Instanz, mehrere
Datenbanken](db_intro.md#idp16860752)

12.3. [Instanznamen basierend auf dem geografischen
Standorts](db_intro.md#idp16865600)

12.4. [Instanznamen basierend auf dem Zweck](db_intro.md#idp16868528)

12.5. [Geladenes IDOMOD-Event-Broker-Modul](components.md#idp16882992)

12.6. [IDOMOD-Möglichkeiten](components.md#idp16883888)

12.7. [LOG2IDO-Utility](components.md#idp16894080)

12.8. [FILE2SOCK-Utility](components.md#idp16898672)

12.9. [IDO2DB-Daemon](components.md#idp16904496)

12.10. [IDO2DB mit mehreren Clients](components.md#idp16907632)

12.11. [Einzelserver, Einzelinstanz](example-configs.md#idp17217504)

12.12. [Einzelner Server, mehrere
Instanzen](example-configs.md#idp17651920)

12.13. [Einzelner Server, einzelne Instanz,
Log-Datei-Import](example-configs.md#idp17665600)

12.14. [Relationship of Central Tables](db_model.md#idp17702560)

12.15. [Relationship of Debugging Tables](db_model.md#idp17754992)

12.16. [Relationship of Historical Tables](db_model.md#idp17836752)

12.17. [Relationship of Current Status
Tables](db_model.md#idp18616944)

12.18. [Relationship of Configuration Tables](db_model.md#idp19180272)

**Tabellenverzeichnis**

2.1. [Screenshots Icinga-Classic-Web](beginners.md#idp227792)

2.2. [Screenshots Icinga-New-Web](beginners.md#idp278032)

6.1. [Konfigurationsdateien](icinga-web-config.md#idp12410592)

* * * * *

  --- --- ----------------------
           [Weiter](ch01.md)
           Kapitel 1. Über
  --- --- ----------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
