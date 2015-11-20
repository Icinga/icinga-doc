 ![Icinga](../images/logofullsize.png "Icinga") 

* * * * *

2.2. Ich bin neu bei...
-----------------------

2.2.1. [Linux](newbie.md#newbie-linux)

2.2.2. [Mail](newbie.md#newbie-mail)

2.2.3. [SNMP](newbie.md#newbie-snmp)

2.2.4. [Pakete](newbie.md#newbie-packages)

2.2.5. [Überwachung](newbie.md#newbie-monitoring)

2.2.6. [Hilfe!](newbie.md#newbie-help)

Außerhalb des Computing wird ein "Newbie" mit "Neuling" bezeichnet und
das begann lange, bevor Sie Laufen lernten. Sie haben diese
Herausforderung gemeistert und so gibt es keinen Grund, jetzt
zurückzuschrecken. Die folgenden Abschnitte enthalten einige Hinweise zu
verschiedenen Themen. Bitte lesen Sie aufmerksam, wenn Sie meinen, dass
Sie irgendwo "neu" sind. Wir werden Sie hierhin verweisen, wenn wir der
Meinung sind, dass Ihnen ein wenig Grundlagen fehlen ;-).

### 2.2.1. Linux

Eine ansehnliche Zahl von Leuten ist beim Thema "Monitoring" neu, und
auch beim Thema Linux. Sie wurden aufgefordert, ein Monitoring-System zu
erstellen, das verschiedene Hosts und einige Services auf diesen Geräten
überwachen soll. Die Zahl selbst ist uninteressant, weil die erste Hürde
bereits das Betriebssystem ist.

Besonders junge Leute sind an grafische Benutzeroberflächen gewöhnt, die
es einfach machen, mit ein paar Maus-Klicks Software zu installieren,
währenddessen irgendwelche Werte in einen Lagerraum gesteckt werden, der
gemeinhin als "Registry" bekannt ist. Sogar Server-Betriebssysteme haben
heutzutage irgendeine Art von grafischer Benutzeroberfläche, aber es
trotzdem noch erforderlich, Befehle an einer textbasierten Konsole
einzugeben.

Holen Sie sich daher ein gutes Buch zu Linux-Grundlagen aus Ihrer
Stadtbibliothek, um einen Überblick über die Verzeichnisstruktur und
häufig benutzte Befehle zu bekommen. Benutzen Sie Ihren Browser, wenn
Sie keine Bücher mögen, aber stellen Sie bitte keine diesbezüglichen
Fragen in einem Monitoring-Forum (Sie würden auch nicht fragen, wie man
laufen lernt, wenn Sie das erste Mal in einem Fitness-Studio sind,
oder?).

![[Anmerkung]](../images/note.png)

Anmerkung

Die Verlockung, Befehle als "root" (alias "Administrator" auf
Windows-Systemen) auszuführen, ist hoch, aber bitte versuchen Sie dem zu
widerstehen, denn es kann relativ schnell zu einem unbrauchbaren System
führen, u.a. weil es nicht dauernd quängelnde Fragen gibt ("Sind Sie
sicher...?"). Bedingt durch die Berechtigungen dieses Superusers
bemerken Sie ggf. nicht bestimmte (notwendige) Beschränkungen des
Benutzers, der normalerweise zum Ausführen der Überwachungsausgaben
verwendet wird, was in Aussagen resultiert wie "das hat schon 'mal
funktioniert".

### 2.2.2. Mail

In den meisten Fällen wollen Sie Mitteilungen versenden, wenn überwachte
Objekte ausfallen oder sich wieder erholen, anstatt auf die
Benutzeroberfläche zu schauen. Das mag auf Ihrem lokalen System (dem
Überwachungs-Server) funktionieren, aber das Versenden von e-Mails an
andere Systeme erfordert von Ihnen, dass Sie Ihrem lokalen Postamt
sagen, wohin es sie schicken soll (eine "relaying" genannte Methode).
Moderne Systeme haben Sicherheitseinstellungen, die unerwünschte Mails
(bestenfalls) zurückschicken oder einfach ignorieren, so dass Sie das
empfangende Postamt anweisen müssen, die von Ihrem lokalen Postamt
eingehenden Mails tatsächlich anzunehmen und weiterzuleiten.









### 2.2.3. SNMP

"SNMP, ist ein Netzwerkprotokoll, das von der IETF entwickelt wurde, um
Netzwerkelemente (z. B. Router, Server, Switches, Drucker, Computer
usw.) von einer zentralen Station aus überwachen und steuern zu können."
([Zitat Wikipedia](http://en.wikipedia.org/wiki/SNMP)).

Mit Hilfe des check\_snmp-Plugins aus dem [Monitoring
Plugins](&url-monitoring-plugins;)-Paket können Sie Daten von "managed"
Systemen abrufen. Bitte stellen Sie sicher, dass auf dem Zielsystem ein
SNMP-Dämon läuft, der konfiguriert wurde, um auf Anfragen Ihres
Überwachungsrechners zu antworten. Führen Sie etwas wie
die Funktionalität zu prüfen.

Sie können OIDs in einer menschlich besser lesbaren Form angeben oder
rein numerisch. Letzteres verhindert die Notwendigkeit, die MIBs zu
lesen, ist schneller und weniger fehleranfällig.

### 2.2.4. Pakete

Bitte benutzen Sie Pakete, um die benötigte Software zu installieren, wo
immer das möglich ist. Es umgeht einige Probleme während Installation
Aktualisierungen. Als Monitoring-Neuling brauchen Sie sehr selten eine
Änderung, die im allerneusten Git-Snapshot enthalten ist. "Leading edge"
kann sehr schnell zu "bleeding edge" werden, und nachdem Sie
wahrscheinlich genug damit zu tun haben, das Produkt mit einem
begrenzten Wissen der ganzen Beziehungen zu installieren und lauffähig
zu bekommen, sollten Sie auf diese Art von Problemen verzichten und bei
einer stabilen Version bleiben.

### 2.2.5. Überwachung

"Monitoring" bedeutet, Informationen von anderen Systemen abzufragen.
Stellen Sie sicher, dass Sie berechtigt sind auf diese anderen Systeme
zuzugreifen, indem Sie die Personen fragen, die diese System
administrieren. Ports zu untersuchen und ähnliche Dinge zu tun könnte
als Angriff angesehen werden! Wenn es Firewall oder andere Maßnahmen
gibt, um den Zugang zu beschränken, dann bitten Sie darum, dass
geeignete Regeln/Ausnahmen definiert werden.

![[Anmerkung]](../images/note.png)

Anmerkung

Abhängig von den Datenschutzvorschriften sind Sie ggf. nicht berechtigt,
Workstations oder andere Systeme zu überwachen, an denen Einzelpersonen
arbeiten oder der Umfang der Überwachung könnte eingeschränkt sein.
Stellen Sie sicher, dass Sie eine schriftliche Genehmigung haben,
*bevor* Sie mit der Überwachung beginnen.

### 2.2.6. Hilfe!

Monitoring ist ein komplexes Thema und selbst wenn Sie gute Kenntnisse
Ihres Betriebssystem besitzen, tauchen Fragen vielleicht schneller auf
als gedacht. Nutzen Sie Ihre Suchmaschine. Jemand anders hatte ggf.
bereits dieses Problem und möglicherweise gibt es schon eine Lösung.
Wenn nicht, dann gibt es eine Vielzahl von Foren da draußen. Bitte
wählen Sie eins, das zu Ihrem Problem passt. Fragen, die zu Ihrem
Monitoring gehören, können am besten von Leuten beantwortet werden, die
sich auf dieses Gebiet spezialisiert haben, und Betriebssystem bezogene
Fragen werden besser an anderer Stelle gestellt.

Die Community ist bereit zu helfen, aber Sie sind der Einzige, der das
Problem sieht, also bitte ...









Je mehr (präzisere) Informationen Sie liefern, um so höher ist die
Chance, dass Sie Antworten erhalten, mit denen Sie Ihr Problem lösen
können. Anderenfalls verlieren Sie u.U. wertvolle Zeit, weil Sie nach
Informationen gefragt werden, die Sie bereits beim ersten Mal hätten
liefern können.

Seien Sie geduldig. Die Reaktionszeit auf Beiträge, die "dringend" oder
ähnliche Wörter enthalten, scheint reziprok dazu zu sein. Foren sind
meistens unentgeltliche Plattformen mit Leuten, die in ihrer Freizeit
antworten.

Bitte verzichten Sie auf
[Crossposting](http://de.wikipedia.org/wiki/Crossposting) (zur gleichen
Zeit die gleiche Frage an unterschiedlichen Stellen platzieren).

* * * * *


© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
