Angepasste CGI-Kopf- und Fußzeilen
==================================

Einführung
----------

Wenn Sie NAME-ICINGA-Installationen für Kunden machen, dann möchten Sie
vielleicht, dass in den [CGIs](#cgis) angepasste Kopf- und Fußzeilen
angezeigt werden. Dies ist besonders dann nützlich, wenn Sie
Support-Kontaktinformationen u.ä. für den Endbenutzer anzeigen möchten.

Es ist wichtig anzumerken, dass angepasste Dateien mit Kopf- und
Fußzeilen nicht in irgendeiner Form vorverarbeitet werden (solange es
sich nicht um ausführbare Dateien handelt), bevor sie angezeigt werden.
Der Inhalt der Kopf- und Fußzeilen wird ganz einfach gelesen und in der
CGI-Ausgabe angezeigt. Das bedeutet, dass diese Dateien lediglich
Informationen enthalten können, die ein Web-Browser versteht (HTML,
JavaScript, usw.).

Wenn die angepassten Kopf- und Fußzeilendateien ausführbar sind, dann
werden sie ausgeführt und die Ausgaben an den Benutzer zurückgeliefert,
so dass die Dateien gültigen HTML-Code enthalten sollten. Auf diese
Weise können Sie Ihre eigenen CGIs nutzen, um Daten in der
NAME-ICINGA-Anzeige auszugeben. Dies kann genutzt werden, um mit ddraw
Grafiken aus rrdtool einzufügen und Befehlsmenüs im NAME-ICINGA-Fenster
anzuzeigen. Die ausführbaren angepassten Kopf- und Fußzeilendateien
werden mit der gleichen CGI-Umgebung ausgeführt wie das
NAME-ICINGA-Haupt-CGI, so dass Ihre Dateien die Abfrageinformationen,
Benutzerauthentifizierungsinformationen usw. analysieren können, um
entsprechende Ausgaben zu erzeugen.

Wie funktioniert es?
--------------------

Sie können angepasste Kopf- und Fußzeilen in die Ausgaben der CGIs
einschließen, indem Sie entsprechend benannte HTML-Dateien im
*ssi*-Unterverzeichnis des NAME-ICINGA-HTML-Verzeichnisses (z.B.
*URL-ICINGA-BASE/share/ssi*) ablegen.

Angepasste Kopfzeilen werden direkt hinter dem \<BODY\>-Tag in der
CGI-Ausgabe eingefügt, während angepasste Fußzeilen direkt vor dem
schließenden \</BODY\>-Tag eingefügt werden.

Es gibt zwei Arten von angepassten Kopf- und Fußzeilen:

-   Globale Kopf-/Fußzeilen: diese Dateien sollten *common-header.ssi*
    und *common-footer.ssi* benannt werden. Wenn diese Dateien
    existieren, werden sie in die Ausgaben aller CGIs eingefügt.

-   CGI-spezifische Kopf-/Fußzeilen: diese Dateinamen sollten im Format
    *CGINAME-header.ssi* und *CGINAME-footer.ssi* benannt werden, wobei
    *CGINAME* der (Datei-) Name des CGIs ohne die .cgi-Erweiterung ist.
    Die Kopf- und Fußzeilendateien des [alert summary
    CGI](#cgis-summary_cgi) (summary.cgi) würden beispielsweise
    *summary-header.ssi* und *summary-footer.ssi* heißen.

Sie sind nicht gezwungen, irgendwelche angepassten Kopf- und Fußzeilen
zu benutzen. Sie können nur eine globale Kopfzeile benutzen, wenn Sie
möchten. Sie können nur CGI-spezifische Kopfzeilen und eine globale
Fußzeile benutzen, wenn Sie möchten. Ganz wie Sie wollen. Wirklich.

Angepasste CGI-Kopf- und Fußzeilen
