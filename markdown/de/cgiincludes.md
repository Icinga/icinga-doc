![Icinga](../images/logofullsize.png "Icinga")

7.24. Angepasste Classic UI-Modul-Kopf- und Fußzeilen

[Zurück](checkscheduling.md) 

Kapitel 7. Fortgeschrittene Themen

 [Weiter](modified_attr.md)

* * * * *

7.24. Angepasste Classic UI-Modul-Kopf- und Fußzeilen
-----------------------------------------------------

7.24.1. [Einführung](cgiincludes.md#introduction)

7.24.2. [Wie funktioniert es?](cgiincludes.md#howitworks)

### 7.24.1. Einführung

Wenn Sie Icinga-Installationen für Kunden machen, dann möchten Sie
vielleicht, dass in den [Classic
UI-Modulen](cgis.md "6.1. Icinga Classic UI: Informationen über die Classic UI-Module")
(CGIs) angepasste Kopf- und Fußzeilen angezeigt werden. Dies ist
besonders dann nützlich, wenn Sie Support-Kontaktinformationen u.ä. für
den Endbenutzer anzeigen möchten.

Es ist wichtig anzumerken, dass angepasste Dateien mit Kopf- und
Fußzeilen nicht in irgendeiner Form vorverarbeitet werden (solange es
sich nicht um ausführbare Dateien handelt), bevor sie angezeigt werden.
Der Inhalt der Kopf- und Fußzeilen wird ganz einfach gelesen und in der
Modul-Ausgabe angezeigt. Das bedeutet, dass diese Dateien lediglich
Informationen enthalten können, die ein Web-Browser versteht (HTML,
JavaScript, usw.).

Wenn die angepassten Kopf- und Fußzeilendateien ausführbar sind, dann
werden sie ausgeführt und die Ausgaben an den Benutzer zurückgeliefert,
so dass die Dateien gültigen HTML-Code enthalten sollten. Auf diese
Weise können Sie Ihre eigenen Module nutzen, um Daten in der
Icinga-Anzeige auszugeben. Dies kann genutzt werden, um mit ddraw
Grafiken aus rrdtool einzufügen und Befehlsmenüs im Icinga-Fenster
anzuzeigen. Die ausführbaren angepassten Kopf- und Fußzeilendateien
werden mit der gleichen Modul-Umgebung ausgeführt wie das
Icinga-Haupt-Modul, so dass Ihre Dateien die Abfrageinformationen,
Benutzerauthentifizierungsinformationen usw. analysieren können, um
entsprechende Ausgaben zu erzeugen.

### 7.24.2. Wie funktioniert es?

Sie können angepasste Kopf- und Fußzeilen in die Ausgaben der Module
einschließen, indem Sie entsprechend benannte HTML-Dateien im
*ssi*-Unterverzeichnis des Icinga-HTML-Verzeichnisses (z.B.
*/usr/local/icinga/share/ssi*) ablegen.

Angepasste Kopfzeilen werden direkt hinter dem \<BODY\>-Tag in der
Modul-Ausgabe eingefügt, während angepasste Fußzeilen direkt vor dem
schließenden \</BODY\>-Tag eingefügt werden.

Es gibt zwei Arten von angepassten Kopf- und Fußzeilen:

-   Globale Kopf-/Fußzeilen: diese Dateien sollten *common-header.ssi*
    und *common-footer.ssi* benannt werden. Wenn diese Dateien
    existieren, werden sie in die Ausgaben aller Module eingefügt.

-   Modul-spezifische Kopf-/Fußzeilen: diese Dateinamen sollten im
    Format *CGINAME-header.ssi* und *CGINAME-footer.ssi* benannt werden,
    wobei *CGINAME* der (Datei-) Name des Moduls ohne die
    .cgi-Erweiterung ist. Die Kopf- und Fußzeilendateien des [alert
    summary-Moduls](cgis.md#cgis-summary_cgi) (summary.cgi) würden
    beispielsweise *summary-header.ssi* und *summary-footer.ssi* heißen.

Sie sind nicht gezwungen, irgendwelche angepassten Kopf- und Fußzeilen
zu benutzen. Sie können nur eine globale Kopfzeile benutzen, wenn Sie
möchten. Sie können nur Modul-spezifische Kopfzeilen und eine globale
Fußzeile benutzen, wenn Sie möchten. Ganz wie Sie wollen. Wirklich.

* * * * *

  ------------------------------------------ -------------------------- -------------------------------
  [Zurück](checkscheduling.md)             [Nach oben](ch07.md)      [Weiter](modified_attr.md)
  7.23. Service- und Host-Prüfungsplanung    [Zum Anfang](index.md)    7.25. Modifizierte Attribute
  ------------------------------------------ -------------------------- -------------------------------

© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
