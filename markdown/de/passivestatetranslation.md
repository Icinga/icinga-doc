 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

7.22. Passive Host-Zustandsübersetzung
--------------------------------------

7.22.1. [Einführung](passivestatetranslation.md#introduction)

7.22.2. [Verschiedene
Sichten](passivestatetranslation.md#differentviews)

7.22.3. [Status-Übersetzung
aktivieren](passivestatetranslation.md#enablestatetranslation)

### 7.22.1. Einführung

Wenn Icinga passive Host-Prüfungen von entfernten Quellen erhält (d.h.
andere Icinga-Instanzen in verteilten oder Failover-Umgebungen), gibt
der von der entfernten Quelle gelieferte Host-Status ggf. nicht genau
den aus Icinga-Sicht zutreffenden Zustand wieder. Weil verteilte und
Failover-Überwachungs-Installationen ziemlich identisch sind, ist es
wichtig einen Mechanismus anzubieten, um exakte Host-Zustände zwischen
verschiedenen Icinga-Instanzen sicherzustellen.

### 7.22.2. Verschiedene Sichten

Das folgende Bild zeigt eine vereinfachte Sicht für ein
Failover-Überwachungsaufbau.




![](../images/passivehosttranslation.png)

In welchem Status sind *Router-C* und *Router-D* gerade? Die Antwort
hängt davon ab, welche Icinga-Instanz Sie fragen.




Jede Icinga-Instanz hat eine unterschiedliche Sicht des Netzwerks. Die
Backup-Überwachungsserver sollten nicht blind passive Host-Zustände vom
primären Überwachungsserver akzeptieren oder Sie werden inkorrekte
Informationen über den aktuellen Zustand des Netzwerks haben.

Ohne die Übersetzung von passiven Host-Prüfergebnissen vom primären
Überwachungsserver (*Icinga-A*) würde *Icinga-C* den *Router-D* als
UNREACHABLE sehen, obwohl dieser vom eigenen Standpunkt aus eigentlich
DOWN ist. Ähnliches gilt für die DOWN/UNREACHABLE-Zustände von
*Router-C* und *Router-D* (vom Standpunkt von *Icinga-A* aus), die aus
Sicht von *Icinga-B* umgedreht werden sollten.

![](../images/note.gif) Anmerkung: Es kann einige Situationen geben, in
denen Sie nicht möchten, dass Icinga die DOWN/UNREACHABLE-Zustände von
entfernten Quellen in ihre "korrekten" Zustände vom Standpunkt der
lokalen Icinga-Instanz aus umsetzt. Zum Beispiel möchten Sie vielleicht
in verteilten Überwachungsumgebungen, dass die zentrale Icinga-Instanz
weiß, wie verteilte Instanzen ihre jeweiligen Teile des Netzwerks sehen.

### 7.22.3. Status-Übersetzung aktivieren

Per Default wird Icinga *nicht* automatisch die
DOWN/UNREACHABLE-Zustände von passiven Prüfergebnissen übersetzen. Sie
müssen dieses Feature aktivieren, wenn Sie es benötigen und nutzen
wollen.

Die automatische Übersetzung von passiven Host-Prüfzuständen wird durch
die
[translate\_passive\_host\_checks](configmain.md#configmain-translate_passive_host_checks)-Variable
kontrolliert. Durch die Aktivierung wird Icinga automatisch DOWN- und
UNREACHABLE-Zustände von entfernten Quellen in die korrekten Zustände
für die lokale Instanz übersetzen.

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
