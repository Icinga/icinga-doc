 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

Copyright 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team.

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


* * * * *

**Inhaltsverzeichnis**

​1. [Über](ch01.md)

1.1. [Über Icinga](about.md)
1.2. [What's New in Icinga 1.13](whatsnew.md)

​2. [Los geht's](ch02.md)

2.1. [Hinweise für Neulinge](beginners.md)
2.2. [Ich bin neu bei...](newbie.md)
2.3. [Schnellstart-Installationsanleitungen](quickstart.md)\
2.4. [Icinga-Schnellstart auf Linux](quickstart-icinga.md)
2.5. [Icinga-Schnellstart auf FreeBSD](quickstart-icinga-freebsd.md)\
2.6. [Icinga-Schnellstart mit IDOUtils](quickstart-idoutils.md)
2.7. [Icinga-Schnellstart mit IDOUtils auf FreeBSD](quickstart-idoutils-freebsd.md)\
2.8. [Icinga Pakete für Linux-Distributionen](icinga_packages.md)\
2.9. [Links zu weiteren Howtos](howtos.md)\
2.10. [Icinga aktualisieren](upgrading.md)
2.11. [IDOUtils-Datenbank aktualisieren](upgrading_idoutils.md)\
2.12. [Monitoring-Überblick](monitoring-overview.md)\
2.13. [Windows-Maschinen überwachen](monitoring-windows.md)
2.14. [Linux/Unix-Rechner überwachen](monitoring-linux.md)
2.15. [Netware-Server überwachen](monitoring-netware.md)\
2.16. [Netzwerk-Drucker überwachen](monitoring-printers.md)
2.17. [Router und Switches überwachen](monitoring-routers.md)
2.18. [Öffentlich zugängliche Dienste überwachen](monitoring-publicservices.md)

​3. [Icinga konfigurieren](ch03.md)

3.1. [Konfigurationsüberblick](config.md)

3.2. [Optionen der Hauptkonfigurationsdatei](configmain.md)

3.3. [Überblick Objektkonfiguration](configobject.md)

3.4. [Objektdefinitionen](objectdefinitions.md)

3.5. [Maßgeschneiderte Objektvariablen](customobjectvars.md)

3.6. [Optionen CGI-Konfigurationsdatei](configcgi.md)

​4. [Icinga starten/stoppen/prüfen](ch04.md)

4.1. [Überprüfen Ihrer Icinga-Konfiguration](verifyconfig.md)

4.2. [Icinga starten und stoppen](startstop.md)

​5. [Die Grundlagen](ch05.md)

5.1. [Icinga Plugins](plugins.md)
5.2. [Makros verstehen und wie sie arbeiten](macros.md)
5.3. [Standard-Makros in Icinga](macrolist.md)
5.4. [Host-Prüfungen (Host checks)](hostchecks.md)
5.5. [Service-Prüfungen (Service Checks)](servicechecks.md)
5.6. [Aktive Prüfungen (Active Checks)](activechecks.md)
5.7. [Passive Prüfungen (Passive Checks)](passivechecks.md)
5.8. [Statustypen](statetypes.md)
5.9. [Zeitfenster](timeperiods.md)
5.10. [Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts](networkreachability.md)
5.11. [Benachrichtigungen](notifications.md)
5.12. [Benachrichtigungen: Beispiele und Fehlersuche](notifications2.md)

​6. [Die Benutzeroberflächen](ch06.md)

6.1. [Icinga Classic UI: Informationen über die Classic UI-Module](cgis.md)\
6.2. [Authentifizierung und Autorisierung im Classic UI](cgiauth.md)
6.3. [Informationen zu den Classic UI-Modul-Parametern](cgiparams.md)
6.4. [Ausführen von Classic UI-Modulen (CGIs) auf der Kommandozeile](cgicmd.md)
6.5. [Installation des Icinga Web Frontend](icinga-web-scratch.md)
6.6. [Konfigurationsübersicht Icinga Web](icinga-web-config.md)
6.7. [Aktualisierung von Icinga Web und Icinga Web Datenbank](upgrading_icingaweb.md)
6.8. [Einführung in Icinga Web](icinga-web-introduction.md)\
6.9. [Integration von PNP4Nagios in das Icinga Web Frontend](icinga-web-pnp.md)

​7. [Fortgeschrittene Themen](ch07.md)

7.1. [Externe Befehle](extcommands.md)

7.2. [Liste der externen Befehle](extcommands2.md)

7.3. [Eventhandler](eventhandlers.md)

7.4. [sprunghafte Services](volatileservices.md)

7.5. [Service- und Host-Frische-Prüfungen](freshness.md)

7.6. [Verteilte Überwachung](distributed.md)

7.7. [Redundante und Failover-Netzwerk-Überwachung](redundancy.md)

7.8. [Erkennung und Behandlung von Status-Flattern](flapping.md)

7.9. [Benachrichtigungseskalationen](escalations.md)

7.10. [Eskalations-Bedingung](escalation_condition.md)

7.11. [Bereitschafts-Rotation](oncallrotation.md)

7.12. [Service- und Host-Gruppen überwachen](clusters.md)

7.13. [Host- und Service-Abhängigkeiten](dependencies.md)

7.14. [Status Stalking](stalking.md)

7.15. [Performance-Daten](perfdata.md)

7.16. [Geplante Ausfallzeiten](downtime.md)

7.17. [Wiederkehrende Ausfallzeiten](recurring_downtimes.md)

7.18. [Benutzen des Embedded Perl Interpreters](embeddedperl.md)

7.19. [Adaptive Überwachung](adaptive.md)

7.20. [Vorausschauende Abhängigkeitsprüfungen](dependencychecks.md)

7.21. [Zwischengespeicherte Prüfungen](cachedchecks.md)

7.22. [Passive Host-Zustandsübersetzung](passivestatetranslation.md)

7.23. [Service- und Host-Prüfungsplanung](checkscheduling.md)

7.24. [Angepasste Classic UI-Modul-Kopf- und
Fußzeilen](cgiincludes.md)

7.25. [Modifizierte Attribute](modified_attr.md)

7.26. [Objektvererbung](objectinheritance.md)

7.27. [Zeitsparende Tricks für Objektdefinitionen](objecttricks.md)

​8. [Sicherheit und Leistungsoptimierung](ch08.md)

8.1. [Sicherheitsüberlegungen](security.md)

8.2. [Verbesserte Classic UI Modul-Sicherheit und
Authentifizierung](cgisecurity.md)

8.3. [Icinga für maximale Leistung optimieren](tuning.md)

8.4. [Schnellstart-Optionen](faststartup.md)

8.5. [Large Installation Tweaks](largeinstalltweaks.md)

8.6. [Nutzung des Icingastats-Utilitys](icingastats.md)

8.7. [Grafische Darstellung von Performance-Informationen mit
PNP4Nagios](perfgraphs.md)

8.8. [Temporäre Daten](temp_data.md)

​9. [Integration mit anderer Software](ch09.md)

9.1. [Integrationsüberblick](integration.md)
9.2. [SNMP-Trap-Integration](int-snmptrap.md)\
9.3. [TCP-Wrapper-Integration](int-tcpwrappers.md)
9.4. [MKLiveStatus-Integration](int-mklivestatus.md)
9.5. [Installation von Icinga Reporting mit JasperReports Server](reporting.md)

​10. [weitere Software](ch10.md)

10.1. [Icinga Addons](addons.md)\
10.2. [NRPE](nrpe.md)
10.3. [NSCA](nsca.md)

​11. [Entwicklung](ch11.md)

11.1. [Nagios Plugin API](pluginapi.md)
11.2. [Entwickeln von Plugins für die Nutzung mit Embedded Perl](epnplugins.md)
11.3. [Keine Icinga API mehr zu installieren](icinga-api.md)
11.4. [Die Icinga Web REST API](icinga-web-api.md)

​12. [IDOUtils](ch12.md)

12.1. [Einleitung](db_intro.md)

12.2. [Komponenten](components.md)

12.3. [Konfiguration der IDOUtils](configido.md)

12.4. [Beispielkonfigurationen](example-configs.md)

12.5. [IDOUtils Database Model](db_model.md)

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


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
