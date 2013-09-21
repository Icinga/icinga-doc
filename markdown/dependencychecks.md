Vorausschauende Abhängigkeitsprüfungen
======================================

Einführung
----------

Host- und Service-[Abhängigkeiten](#dependencies) können definiert
werden, um Ihnen größere Kontrolle darüber zu geben, wann Prüfungen
ausgeführt und wann Benachrichtigungen versandt werden. Da
Abhängigkeiten benutzt werden, um grundlegende Aspekte des
Überwachungsprozesses zu kontrollieren, ist es wichtig sicherzustellen,
dass die Status-Informationen in der Abhängigkeitslogik so aktuell wie
möglich sind.

NAME-ICINGA erlaubt Ihnen, vorausschauende Abhängigkeitsprüfungen für
Hosts und Services zu aktivieren, um sicherzustellen, dass die
Abhängigkeitslogik die aktuellsten Status-Informationen hat, wenn
Entscheidungen darüber getroffen werden müssen, ob Benachrichtigungen
verschickt werden oder um aktive Prüfungen für einen Host oder Service
zu erlauben.

Wie arbeiten vorausschauende Prüfungen?
---------------------------------------

Das nachfolgende Bild zeigt ein einfaches Diagramm von Hosts, die von
NAME-ICINGA überwacht werden, zusammen mit ihren Eltern/Kindbeziehungen
und Abhängigkeiten.

Der *Switch2*-Host in diesem Beispiel hat gerade den Status von UP in
einen Problemzustand gewechselt. NAME-ICINGA muss feststellen, ob der
Host DOWN oder UNREACHABLE ist, also wird es parallele Prüfungen für die
direkten Eltern (*Firewall1*) und Kinder (*Comp1*, *Comp2*, und
*Switch3*) auslösen. Das ist eine normale Funktion der
[Host-Erreichbarkeit](#networkreachability)s-Logik.

Sie werden auch feststellen, dass *Switch2* von *Monitor1* und *File1*
in Bezug auf Benachrichtigungen oder Prüfausführung abhängt (welches
davon ist unwichtig für dieses Beispiel). Wenn vorausschauende
Host-Abhängigkeitsprüfungen aktiviert sind, wird NAME-ICINGA parallele
Prüfungen von *Monitor1* und *File1* sowie gleichzeitig für die direkten
Eltern und Kinder von *Switch2* auslösen. NAME-ICINGA tut dies, weil es
wei�, dass es die Abhängigkeitslogik in der nahen Zukunft prüfen muss
(z.B. für Zwecke der Benachrichtigung) und es will sicherstellen, dass
es die aktuellsten Statusinformationen für die Hosts hat, die an der
Abhängigkeit beteiligt sind.

So arbeiten vorausschauende Abhängigkeitsprüfungen. Einfach, oder?

![](../images/note.gif) Anmerkung: Vorausschauende
Service-Abhängigkeitsprüfungen arbeiten in einer ähnlichen Weise wie
oben beschrieben. Außer natürlich, dass sie mit Services arbeiten statt
mit Hosts.

Vorausschauende Prüfungen aktivieren
------------------------------------

Vorausschauende Abhängigkeitsprüfungen verursachen ziemlich wenig
Overhead, also würden wir empfehlen, dass Sie diese aktivieren. In den
meisten Fällen werden die Vorteile, aktuelle Informationen für die
Abhängigkeitslogik zu haben, den zusätzlichen Overhead durch diese
Prüfungen mehr als ausgleichen.

Vorausschauende Abhängigkeitsprüfungen zu aktivieren ist einfach:

-   Vorausschauende Host-Abhängigkeitsprüfungen werden durch die
    [enable\_predictive\_host\_dependency\_checks](#configmain-enable_predictive_host_dependency_checks)-Option
    kontrolliert.

-   Vorausschauende Service-Abhängigkeitsprüfungen werden durch die
    [enable\_predictive\_service\_dependency\_checks](#configmain-enable_predictive_service_dependency_checks)-Option
    kontrolliert.

Cached Checks
-------------

Vorausschauende Abhängigkeitsprüfungen sind Prüfungen nach Bedarf und
daher den Regeln von [cached checks](#cachedchecks) unterworfen. Cached
checks können Ihnen Performance-Verbesserungen liefern, wenn NAME-ICINGA
darauf verzichtet, eine Host- oder Serviceprüfung durchzuführen, wenn es
statt dessen ein relativ aktuelles Prüfungsergebnis nutzen kann. Mehr
Informationen über cached checks finden Sie [hier](#cachedchecks).

Abhängigkeiten
vorausschauende Abhängigkeitsprüfungen
