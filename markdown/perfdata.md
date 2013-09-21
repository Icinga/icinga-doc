Performance-Daten
=================

Einführung
----------

NAME-ICINGA ist ausgelegt, dass [Plugins](#plugins) neben den normalen
Statusinformationen optional auch Performance-Daten zurückliefern
können, die Sie außerdem zur weiteren Verarbeitung an externe
Applikationen übergeben können. Eine Beschreibung der verschiedenen
Typen von Performance-Daten wie auch Informationen darüber, wie diese
Daten verarbeitet werden, finden Sie im Folgenden...

Typen von Performance-Daten
---------------------------

Es gibt zwei grundlegende Kategorien von Performance-Daten, die von
NAME-ICINGA erhalten werden können:

1.  Prüf-Performance-Daten

2.  Plugin-Performance-Daten

Prüf-Performance-Daten sind interne Daten, die sich auf die aktuelle
Ausführung einer Host- oder Service-Prüfung beziehen. Dies kann Dinge
wie die Service-Prüfverzögerung enthalten (service check latency, d.h.,
wie viel Zeit von der geplanten Ausführung bis zu eigentlichen
Ausführung verging) oder die Anzahl der Sekunden, die die Ausführung
einer Host- oder Service-Prüfung dauerte. Dieser Typ von
Performance-Daten ist für alle ausgeführten Prüfungen verfügbar. Die
[\$HOSTEXECUTIONTIME\$](#macrolist-hostexecutiontime)- und
[\$SERVICEEXECUTIONTIME\$](#macrolist-serviceexecutiontime)-[Makros](#macros)
können benutzt werden, um die Anzahl der Sekunden zu ermitteln, die eine
Host- oder Service-Prüfung dauerte und die
[\$HOSTLATENCY\$](#macrolist-hostlatency)- und
[\$SERVICELATENCY\$](#macrolist-servicelatency)-Makros können zur
Ermittlung der "Verspätung" einer regulär geplanten Host- oder
Service-Prüfung genutzt werden.

Plugin-Performance-Daten sind externe Daten, die spezifisch für das
Plugin sind, das die Host- oder Service-Prüfung ausführt.
Plugin-spezifische Daten können Dinge wie Prozentsatz des
Paketverlustes, freie Plattenplatz, Prozessor-Load, Anzahl der
gegenwärtigen Benutzer usw. umfassen - generell jede Art von Metrik, die
das Plugin misst, wenn es ausgeführt wird. Plugin-spezifische
Performance-Daten sind optional und werden ggf. nicht von allen Plugins
unterstützt. Plugin-spezifische Performance-Daten (falls verfügbar)
werden durch die [\$HOSTPERFDATA\$](#macrolist-hostperfdata)- und
[\$SERVICEPERFDATA\$](#macrolist-serviceperfdata)-[Makros](#macros)
bereit gestellt. Lesen Sie weiter, um mehr Informationen darüber zu
erhalten, wie Plugins Performance-Daten an NAME-ICINGA zur
Bereitstellung durch die \$HOSTPERFDATA\$- und
\$SERVICEPERFDATA\$-Makros zurückliefern können.

Plugin-Performance-Daten
------------------------

Als Minimum müssen NAME-ICINGA-Plugins eine einzelne Zeile mit
menschlich lesbarem Text zurückliefern, die den Status eines Typs von
Messdaten enthält. Zum Beispiel könnte das check\_ping-Plugin eine
Textzeile wie die folgende zurückliefern:

     PING ok - Packet loss = 0%, RTA = 0.80 ms

Bei dieser einfachen Art von Ausgabe ist die gesamte Textzeile in den
\$HOSTOUTPUT\$- oder \$SERVICEOUTPUT\$-[Makros](#macros) verfügbar
(abhängig davon, ob dieses Plugin als Host- oder Service-Prüfung benutzt
wurde).

Plugins können in ihrer Ausgabe optionale Performance-Daten
zurückliefern, indem nach dem normalen, menschlich lesbaren Text ein
Pipe-Symbol (|) folgt und danach eine Zeichenkette, die ein oder mehrere
Performance-Daten-Metriken enthält. Lassen Sie uns das
check\_ping-Plugin als Beispiel nehmen und annehmen, dass es um die
Ausgabe von Performance-Daten-Metriken für den Prozentsatz von
Paketverlusten (percent paket loss) und durchschnittlicher Umlaufzeit
(average round trip time) erweitert wurde. Die Beispielausgabe des
Plugins könnte wie folgt aussehen:

     PING ok - Packet loss = 0%, RTA = 0.80 ms | percent_packet_loss=0 rta=0.80

wenn NAME-ICINGA dieses Plugin-Ausgabeformat sieht, wird es die Ausgabe
in zwei Teile aufteilen:

1.  alles vor dem Pipe-Symbol wird als "normale" Ausgabe des Plugins
    angesehen und im \$HOSTOUTPUT\$- oder \$SERVICEOUTPUT\$-Makro
    gespeichert

2.  alles nach dem Pipe-Symbol wird als Plugin-spezifische Ausgabe
    angesehen und in den \$HOSTPERFDATA\$- oder
    \$SERVICEPERFDATA\$-Makros gespeichert.

Im obigen Beispiel würde das \$HOSTOUTPUT\$- oder das
\$SERVICEOUTPUT\$-Makro "*PING ok - Packet loss = 0%, RTA = 0.80 ms*"
enthalten (ohne Anführungszeichen) und das \$HOSTPERFDATA\$- oder das
\$SERVICEPERFDATA\$-Makro würde "*percent\_packet\_loss=0 rta=0.80*"
enthalten (ohne Anführungszeichen).

NAME-ICINGA kann mehrere Zeilen Performance-Daten (ebenso wie normale
Textausgaben) von Plugins entgegennehmen, wie in der [plugin API
documentation](#pluginapi) beschrieben.

> **Note**
>
> Der NAME-ICINGA-Daemon verarbeitet Plugin-Performance-Daten nicht
> direkt, so dass es ihm egal ist, wie die Performance-Daten aussehen.
> Die Nagios-Entwicklerrichtlinien enthalten gewisse Vorgaben (siehe
> auch [Format Performance-Daten](#perfdata-format) weiter unten). Wenn
> Sie allerdings ein externes Addon benutzen, um die Performance-Daten
> zu verarbeiten (z.B. PNP oder PerfParse), erwartet das Addon die
> Performance-Daten möglicher Weise in einem bestimmten Format. Prüfen
> Sie die Dokumentation des Addon auf weitere Informationen.

Performance-Daten verarbeiten
-----------------------------

Wenn Sie die Performance-Daten, die von den Plugins und in NAME-ICINGA
verfügbar sind, müssen Sie folgendes tun:

1.  aktivieren Sie die
    [process\_performance\_data](#configmain-process_performance_data)-Option.

2.  konfigurieren Sie NAME-ICINGA so, dass Performance-Daten in Dateien
    geschrieben und/oder durch Befehle verarbeitet wird.

Lesen Sie weiter, um Informationen darüber zu erhalten, wie
Performance-Daten durch das Schreiben in Dateien oder die Ausführung von
Befehlen verarbeitet werden.

Performance-Daten verarbeiten durch Befehle
-------------------------------------------

Der flexibelste Weg, um Performance-Daten zu verarbeiten, besteht darin,
NAME-ICINGA Befehle ausführen zu lassen (die Sie angeben), um die Daten
zu verarbeiten oder sie umzulenken, damit sie später von externen
Applikationen verarbeiten werden. Die Befehle, die NAME-ICINGA ausführt,
um Host- und Service-Performance-Daten zu verarbeiten, werden durch die
[host\_perfdata\_command](#configmain-host_perfdata_command)- und
[service\_perfdata\_command](#configmain-service_perfdata_command)-Optionen
festgelegt.

Eine Beispiel-Befehlsdefinition, die Service-Prüf-Performance-Daten zur
späteren Verarbeitung durch eine andere Applikation in eine Textdatei
umleitet, finden Sie nachfolgend:

     # ACHTUNG: diese Definition funktioniert NICHT mit PNP!
     define command{
            command_name    store-service-perfdata
            command_line    /bin/echo -e "$LASTSERVICECHECK$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICESTATE$\t$SERVICEATTEMPT$\t$SERVICESTATETYPE$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$" >> URL-ICINGA-BASE/var/service-perfdata.dat
            }

![](../images/tip.gif) Hinweis: Diese Methode, obwohl flexibel, erzeugt
einen relativ hohen CPU-Overhead. Wenn Sie Performance-Daten für viele
Hosts und Services verarbeiten, dann ist es vielleicht besser, diese
Daten in eine Datei zu schreiben. Diese Methode wird im nächsten
Abschnitt beschrieben.

Performance-Daten in Dateien schreiben
--------------------------------------

Sie können NAME-ICINGA mit Hilfe der
[host\_perfdata\_file](#configmain-host_perfdata_file)- und
[service\_perfdata\_file](#configmain-service_perfdata_file)-Optionen
anweisen, die Host- und Service-Performance-Daten direkt in Textdateien
auszugeben. Das Format, in dem Host- und Service-Performance-Daten in
diese Dateien geschrieben wird, wird durch die
[host\_perfdata\_file\_template](#configmain-host_perfdata_file_template)-
und
[service\_perfdata\_file\_template](#configmain-service_perfdata_file_template)-Optionen
festgelegt.

Eine Beispiel-Dateiformatvorlage für Performance-Daten könnte wie folgt
aussehen:

     # ACHTUNG: diese Definition funktioniert NICHT mit PNP!
     service_perfdata_file_template=[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$

Per Default werden die Textdateien im "append"-Modus ("anhängen")
eröffnet. Wenn Sie den Modus auf "write" ("schreiben") oder
"non-blocking read/write" ("nicht-blockierendes Lesen/Schreiben",
nützlich beim Schreiben in Pipes) ändern, können Sie die
[host\_perfdata\_file\_mode](#configmain-host_perfdata_file_mode)- und
[service\_perfdata\_file\_mode](#configmain-service_perfdata_file_mode)-Optionen
nutzen.

Zusätzlich können Sie NAME-ICINGA mit den
[host\_perfdata\_file\_processing\_command](#configmain-host_perfdata_file_processing_command)-
und
[service\_perfdata\_file\_processing\_command](#configmain-service_perfdata_file_processing_command)-Optionen
anweisen, periodisch Befehle auszuführen, um regelmäßig die
Performance-Daten-Dateien zu verarbeiten (z.B., um sie zu rotieren). Das
Intervall, in dem diese Befehle ausgeführt werden, ist durch die
[host\_perfdata\_file\_processing\_interval](#configmain-host_perfdata_file_processing_interval)-
und
[service\_perfdata\_file\_processing\_interval](#configmain-service_perfdata_file_processing_interval)-Optionen
festgelegt.

Format Performance-Daten
------------------------

Die Nagios-Entwicklerrichtlinien
([http://nagiosplug.sourceforge.net/developer-guidelines.html](http://nagiosplug.sourceforge.net/developer-guidelines.html))
enthalten in [Abschnitt
2.6](http://nagiosplug.sourceforge.net/developer-guidelines.html#AEN201)
die Definition und eine Erklärung des Performance-Daten-Formats. Es wird
nachfolgend zu Ihrer Bequemlichkeit wiederholt (und übersetzt):

----- 8\< -----

*2.6.Performance-Daten*

Performance-Daten wird von Nagios definiert als "alles nach dem | der
Plugin-Ausgabe" - bitte werfen Sie einen Blick in die
Nagios(/Icinga)-Dokumentation für Information, wie man diese Daten in
Log-Dateien umlenken kann. Auf jeden Fall ist der Plugin-Autor dafür
verantwortlich, dass die Performance-Daten dem "Nagios-Plugin"-Format
entsprechen. Dies ist das erwartete Format:

'Bezeichnung'=Wert[UOM];[warn];[crit];[min];[max]

Anmerkungen:

1.  Leerzeichen trennen Listen von Bezeichnung/Werte-Paaren

2.  Bezeichnungen können beliebige Zeichen enthalten

3.  die Bezeichnung muss in Apostrophe eingeschlossen sein, wenn diese
    Gleichheitszeichen (=), Apostroph (') oder Leerzeichen ( ) enthält,
    ansonsten sind die Apostrophe optional

4.  die Länge der Bezeichnung ist beliebig, aber idealerweise sind die
    ersten 19 Zeichen eindeutig (aufgrund einer Beschränkung in RRD).
    Bitte beachten Sie, dass es eine Längenbegrenzung bei der Menge von
    Daten gibt, die von NRPE an Nagios geliefert werden kann

5.  um ein Apostroph darzustellen, nutzen Sie zwei einzelne Apostrophe

6.  warn, crit, min und/oder max können leer sein (z.B. wenn der
    Schwellwert nicht definiert ist oder wenn min oder max nicht
    zutreffen). Nachfolgende, nicht gefüllte Semikola können entfallen

7.  min und max sind nicht erforderlich, wenn UOM = %

8.  Wert, min und max sind aus der Klasse [-0-9.] (Ziffern, Minuszeichen
    und Dezimalpunkt). Alle müssen die gleiche UOM benutzen

9.  warn und crit sind im “Range”-Format (siehe Abschnitt 2.5 der
    Original-Dokumentation). Alle müssen die gleiche UOM benutzen

10. UOM (unit of measurement, Maßeinheit) ist eins von:

    -   keine Einheit angegeben - angenommen wird eine Zahl (int oder
        float) von Dingen (z.B. Benutzer, Prozesse, Load)

    -   s - Sekunden (auch us, ms)

    -   % - Prozent

    -   B - Bytes (auch KB, MB, TB; GB?)

    -   c - ein fortlaufender Zähler (z.B. Bytes, die über ein Interface
        übertragen werden)

Es bleibt Drittanbietern überlassen, aus den Performance-Daten Graphen
zu erzeugen.

----- 8\< -----

Ab und zu fragen sich Leute, ob ihre Performance-Daten gültig sind, so
dass wir hier einige Beispiele geben. Gezeigt werden die Informationen
nach dem Pipe-Symbol:

     loss=0 rta=0.80ms         # gültig (Regel 1,10)
     loss=0, rta=0.80ms        # ungültig (Regel 1, kein Komma erlaubt)
     loss=0 rta=0,80ms         # ungültig (Regel 8, kein Komman erlaubt) *1
     packet loss=0 rta=0.80    # ungültig (Regel 3, in Apostroph einschließen)
     'packet loss'=0 rta=0.80  # gültig version of line above
     'john''s disk'=83%        # gültig (Regel 5,10)
     'disk usage'=78%;80;90;;; # ungültig (nachfolgendes Semikolon hinter max-Wert)
     'disk usage'=78%;80;90    # gültig (Regel 6)
     'data packets'=11345234c  # gültig (Regel 6,10)
     drum=153482pages          # ungültig (Regel 10, ungültige UOM) *2
     temperature=23;;;20;30    # gültig (Regel 6)

> **Note**
>
> \*1: Wenn Sie ein Dezimalkomma statt eines Dezimalpunkts haben, dann
> kann das ein Hinweis darauf sein, dass Sie Ihre lokalen
> Spracheinstellungen benutzen. Vielleicht wird das von Ihrem
> Graphing-Tool intern korrigiert, aber verlassen Sie sich nicht darauf.
>
> \*2: Wenn Sie "pages" oder andere nicht-Standard-UOM (z.B. °C/°F)
> haben, dann kann das zu Fehlern oder verworfenen Performance-Daten
> führen, wenn Sie Addons wie
> [PNP4Nagios](http://docs.pnp4nagios.org/start) oder andere Tools zur
> Aufbereitung Ihrer Performance-Daten nutzen.

Performance-Daten
Performance Data
Data Format
