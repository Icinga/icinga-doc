 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

5.12. Benachrichtigungen: Beispiele und Fehlersuche
---------------------------------------------------

5.12.1. [Einführung](notifications2.md#introduction)

5.12.2. [Einige Beispiele](notifications2.md#examples)

5.12.3. [Fehlersuche](notifications2.md#troubleshooting)

### 5.12.1. Einführung

Die Objektdefinitionen von
[Hosts](objectdefinitions.md#objectdefinitions-host),
[Services](objectdefinitions.md#objectdefinitions-service) und
[Kontakten](objectdefinitions.md#objectdefinitions-contact) /
[Kontaktgruppen](objectdefinitions.md#objectdefinitions-contactgroup)
wurden im Kapitel "Icinga konfigurieren" gezeigt, die verschiedenen zu
durchlaufenden Tests, um festzustellen, ob eine Benachrichtigung
versandt wird, wurden im Abschnitt
"[Benachrichtigungen](notifications.md "5.11. Benachrichtigungen")"
beschrieben.

Trotz all der Erklärungen scheint es immer noch einen Grad der
Unsicherheit zu geben, so dass wir versuchen, ein Beispiel für e-Mail
als Kommunikationsweg zu geben.

![[Wichtig]](../images/important.png)

Wichtig

Icinga bietet **keinerlei** Methoden zur Benachrichtung irgendeines
Kontaktes, den Sie definiert haben, so dass die Einrichtung und
Konfiguration von Mail, SMS, Pager oder welchen Weg Sie auch immer
wählen mögen, ganz allein Ihre Aufgabe und nicht Teil dieser
Dokumentation ist. Wenn Sie Mail betrachten, dann müssen Sie ein
Mail-Programm (postfix, sendmail oder jeden anderen MTA, mit dem Sie
sich wohlfühlen) installieren, "Relaying" auf dem Icinga-Server
einrichten (postfix: `/etc/postfix/main.cf`, Direktive
"relayhost"; sendmail: `/etc/mail/sendmail.cf`, Directive
"DS"), "Relaying" auf Ihrem zentralen Mail-Server einrichten für Mails,
die vom Icinga-Server eintreffen und prüfen, dass Sie Mails von Ihrem
Icinga-Server aus senden können als Benutzer, mit dem auch der
Icinga-Prozess läuft.

Wenn Sie keine Meldungen von der Kommandozeile Ihres Icinga-Servers aus
senden können, dann ist es nicht sinnvoll, dass Sie weiterlesen.

**Voraussetzungen**





















### 5.12.2. Einige Beispiele

Wir werden ein paar Services definieren und dabei nur einige Direktiven
verwenden. Bei den anderen (notwendigen) nehmen wir an, dass sie mit
Hilfe eines Templates definiert wurden. Wir zeigen Ihnen auch, worauf
Sie achten sollten:

 define service {

 define service {
 define service {
</code></pre>




### 5.12.3. Fehlersuche

Falls Benachrichtigungen nicht zu funktionieren scheinen, dann gibt es
verschiedene Dinge, die man prüfen kann:









* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
