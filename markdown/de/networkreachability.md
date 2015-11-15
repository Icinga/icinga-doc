![Icinga](../images/logofullsize.png "Icinga")

5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts

[Zurück](timeperiods.md) 

Kapitel 5. Die Grundlagen

 [Weiter](notifications.md)

* * * * *

5.10. Ermitteln des Zustands und der Erreichbarkeit von Netzwerk-Hosts
----------------------------------------------------------------------

5.10.1. [Einführung](networkreachability.md#introduction)

5.10.2. [Beispiel-Netzwerk](networkreachability.md#examplenetwork)

5.10.3. [Definieren von
Eltern/Kind-Beziehungen](networkreachability.md#parentchildrelations)

5.10.4. [Erreichbarkeits-Logik in
Aktion](networkreachability.md#logicinaction)

5.10.5. [UNREACHABLE Zustände und
Benachrichtigungen](networkreachability.md#unreachableandnotifications)

### 5.10.1. Einführung

Falls Sie jemals im technischen Support gearbeitet haben, hatten Sie
zweifelsohne Benutzer, die Ihnen erzählt haben, "das Internet sei down".
Als Techniker waren Sie ziemlich sicher, daß keiner den Stromstecker aus
dem Internet gezogen hatte. Irgendetwas muss schiefgehen zwischen dem
Stuhl des Benutzers und dem Internet.

Angenommen es ist ein technisches Problem, dann werden Sie nach dem
Problem suchen. Vielleicht ist der PC des Benutzers ausgeschaltet oder
das Netzwerkkabel ist gezogen oder der zentrale Router Ihres Unternehmen
nimmt gerade eine Auszeit. Was immer das Problem sein mag, eines ist
sehr sicher - das Internet ist nicht down. Es ist lediglich nicht für
den Benutzer erreichbar.

Icinga ist in der Lage festzustellen, ob die Hosts, die Sie überwachen,
in einem DOWN- oder UNREACHABLE-Zustand sind. Dies sind sehr
unterschiedliche (obwohl durchaus verwandte) Zustände und können Ihnen
helfen, schnell die Grundursache für Netzwerkprobleme festzustellen.
Hier nun, wie die Netzwerk-Erreichbarkeitslogik arbeitet, um zwischen
diesen beiden Zuständen zu unterscheiden...

### 5.10.2. Beispiel-Netzwerk

Werfen Sie einen Blick auf das einfache Netzwerk-Diagramm. Lassen Sie
uns annehmen, dass Sie alle Hosts (Server, Router, Switches, etc.)
überwachen, die abgebildet sind. Icinga ist installiert und lauffähig
auf dem *Icinga*-Host.

![](../images/reachability1.png)

### 5.10.3. Definieren von Eltern/Kind-Beziehungen

Um Icinga in die Lage zu versetzen, zwischen DOWN und
UNREACHABLE-Zuständen der überwachten Hosts zu unterscheiden, müssen Sie
Icinga mitteilen, wie diese Hosts miteinander verbunden sind - vom
Standpunkt des Icinga-Daemons aus gesehen. Um dies zu tun verfolgen Sie
den Weg, den ein Datenpaket vom Icinga-Daemon zu jedem einzelnen Host
nehmen würde. Jeder Switch, Router und Server, den das Paket trifft oder
passiert, wird als "Hop" angesehen und erfordert, dass Sie eine
Eltern/Kind-Beziehung in Icinga definieren. Hier nun, wie die
Host-Eltern/Kind-Beziehung aus der Sicht von Icinga aussieht:

![](../images/reachability2.png)

Nun, da Sie wissen, wie die Eltern/Kind-Beziehungen für überwachte Hosts
aussehen, wie konfigurieren Sie Icinga, um sie abzubilden? Die
*parents*-Direktive in Ihren
[Host-Definitionen](objectdefinitions.md#objectdefinitions-host)
erlaubt Ihnen, das zu tun. Hier nun, wie die (verkürzten)
Host-Definitionen mit Eltern/Kind-Beziehung für dieses Beispiel aussehen
würden:

~~~~ {.programlisting}
 define host{
        host_name               Icinga   ; <-- der lokale Host hat keine Eltern - es ist der am weitesten oben stehende Host
        }
 define host{
        host_name       Switch1
        parents         Icinga
        }
 define host{
        host_name       Web
        parents         Switch1
        }
 define host{
        host_name       FTP
        parents         Switch1
        }
 define host{
        host_name       Router1
        parents         Switch1
        }
 define host{
        host_name       Switch2
        parents         Router1
        }
 define host{
        host_name       Wkstn1
        parents         Switch2
        }
 define host{
        host_name       HPLJ2605
        parents         Switch2
        }
 define host{
        host_name       Router2
        parents         Router1
        }
 define host{
        host_name       somewebsite.com
        parents         Router2
        }
~~~~

### 5.10.4. Erreichbarkeits-Logik in Aktion

Nachdem Sie Icinga mit den passenden Eltern/Kind-Beziehungen
konfiguriert haben, lassen Sie uns sehen, was passiert, wenn Probleme
auftauchen. Nehmen Sie an, dass zwei Hosts, *Web* und *Router1*, offline
gehen...

![](../images/reachability3.png)

Wenn Hosts den Status wechseln (d.h. von UP zu DOWN) wird die
Host-Erreichbarkeitslogik in Icinga anspringen. Die
Erreichbarkeits-Logik wird parallele Prüfungen der Eltern und Kinder
aller Hosts veranlassen, deren Status sich ändert. Dies erlaubt es
Icinga schnell den aktuellen Status Ihrer Netzwerk-Infrastruktur zu
ermitteln, wenn Änderungen auftreten.

![](../images/reachability4.png)

In diesem Beispiel wird Icinga feststellen, dass *Web* und *Router1*
beide im DOWN-Status sind, weil der "Pfad" zu diesen Hosts nicht
blockiert ist.

Icinga wird feststellen, dass alle Hosts "unterhalb" *Router1* alle in
einem UNREACHABLE Status sind, weil Icinga sie nicht erreichen kann.
*Router1* ist DOWN und blockiert den Weg zu diesen anderen Hosts. Diese
Hosts können wunderbar funktionieren oder offline sein - Icinga weiß es
nicht, weil es sie nicht erreichen kann. Deshalb wird Icinga sie als
UNREACHABLE ansehen anstatt DOWN.

### 5.10.5. UNREACHABLE Zustände und Benachrichtigungen

Standardmäßig wird Icinga Kontakte über Hosts im DOWN und
UNREACHABLE-Status informieren. Als ein Admin/Techniker möchten Sie
vielleicht keine Benachrichtigungen über Hosts erhalten, die UNREACHABLE
sind. Sie kennen Ihre Netzwerkstruktur und wenn Icinga Sie informiert,
dass der Router/die Firewall unten ist, dann wissen Sie, dass alles
dahinter nicht erreichbar ist.

Falls Sie sich eine Flut von Benachrichtigungen über
UNREACHABLE-Zustände während eines Netzwerkausfalls ersparen möchten,
können Sie die unreachable (u)-Option der
*notification\_options*-Direktive in Ihren
[Host](objectdefinitions.md#objectdefinitions-host)-Definitionen
und/oder die *host\_notification\_options*-Direktive in Ihren
[Kontakt](objectdefinitions.md#objectdefinitions-contact)-Direktiven
ausschließen.

* * * * *

  ----------------------------- -------------------------- -------------------------------
  [Zurück](timeperiods.md)    [Nach oben](ch05.md)      [Weiter](notifications.md)
  5.9. Zeitfenster              [Zum Anfang](index.md)    5.11. Benachrichtigungen
  ----------------------------- -------------------------- -------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
