 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

8.1. Sicherheitsüberlegungen
----------------------------

8.1.1. [Einführung](security.md#introduction)

8.1.2. [Optimale Verfahren](security.md#bestpractices)

### 8.1.1. Einführung

![](../images/security.png)

Dies ist als ein kurzer Überblick einiger Dinge gedacht, die Sie bei der
Installation von Icinga im Hinterkopf behalten sollten, um es in einer
sicheren Weise aufzusetzen.

Ihr Überwachungsrechner sollte als eine Hintertür in Ihre anderen System
betrachtet werden. In vielen Fällen wird dem Icinga-Rechner der Zugriff
auf Firewalls gewährt, um entfernte Server zu überwachen. In den meisten
Fällen ist die Abfrage von verschiedenen Informationen der entfernten
Server erlaubt. Überwachenden Servern wird ein gewisses Maß an Vertrauen
entgegen gebracht, damit sie entfernte Systeme abfragen können. Das
bietet einem potenziellen Angreifer eine attraktive Hintertür zu Ihren
Systemen. Ein Angreifer könnte es einfacher haben, in Ihre Systeme
einzudringen, wenn er zuerst den Überwachungsserver kompromittiert. Das
trifft besonders dann zu, wenn Sie gemeinsame SSH-Schlüssel nutzen, um
entfernte Systeme zu überwachen.

Wenn ein Eindringling in der Lage ist, Prüfergebnisse oder externe
Befehle an den Icinga-Daemon zu erteilen, hat er die Möglichkeit,
falsche Überwachungsdaten zu übertragen, Sie mit falschen
Benachrichtigungen auf die Palme bringen oder Eventhandler-Scripte
auszulösen. Wenn Sie Eventhandler-Scripte haben, die Services neu
starten, Strom unterbrechen usw., dann kann das ziemlich problematisch
sein.

Ein weiterer zu beachtender Bereich ist die Möglichkeit von
Eindringlingen, Überwachungsdaten (Statusinformationen) zu belauschen,
während sie über den Draht gehen. Wenn Übertragungskanäle nicht
verschlüsselt sind, können Angreifer durch Beobachtung Ihrer
Überwachungsdaten wertvolle Informationen gewinnen. Nehmen Sie als
Beispiel die folgende Situation: ein Angreifer belauscht für eine
gewisse Zeit die Überwachungsdaten und analysiert die typische CPU- und
Plattenauslastung Ihrer Systeme zusammen mit der Zahl der Benutzer, die
typischerweise angemeldet sind. Der Angreifer ist dann in der Lage, die
beste Zeit für die Kompromittierung eines Systems und dessen Ressourcen
(CPU usw.) zu ermitteln, ohne bemerkt zu werden.

Hier sind einige Hinweise, wie Sie Ihre Systeme sichern können, wenn Sie
eine Icinga-basierte Überwachungslösung implementieren...

### 8.1.2. Optimale Verfahren












10. **Sichere Kommunikationskanäle**. Stellen Sie sicher, dass Sie die


* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
