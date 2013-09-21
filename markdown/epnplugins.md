Entwickeln von Plugins für die Nutzung mit Embedded Perl
========================================================

Einführung
----------

Stanley Hopcroft hat ziemlich viel mit dem eingebetten Perl-Interpreter
gearbeitet und die Vor- und Nachteile der Nutzung kommentiert. Er hat
auch verschiedene Hinweise gegeben, um Perl-Plugins zu erstellen, die
sauber mit dem eingebetteten Interpreter laufen. Der überwiegende Teil
dieser Dokumentation stammt aus seinen Kommentaren.

Es ist anzumerken, dass sich "ePN", wie in dieser Dokumentation
verwendet, auf den eingebetteten Perl-Interpreter, oder wenn Ihnen das
lieber ist, auf NAME-ICINGA kompiliert mit einem eingebetteten
Perl-Interpreter bezieht.

Zielgruppe
----------

-   Durchschnittliche Perl-Entwickler mit einem Verständnis für die
    mächtigen Eigenschaften der Sprache ohne Wissen der Interna bzw.
    einem vertieften Wissen dieser Eigenschaften.

-   die mit einem benutzenden Wissen statt einem tiefen Verständnis

-   wenn Sie glücklich sind mit Perl-Objekten, sprich Verwaltung,
    Datenstrukturen und dem Debugger, dann ist das wahrscheinlich
    ausreichend.

**Dinge, die Sie tun sollten, wenn Sie ein Perl-Plugin entwickeln (mit
ePN oder ohne)**

-   generieren Sie immer etwas Output

-   Verwenden Sie 'use utils' und importieren Sie die Dinge, die es
    exportiert (\$TIMEOUT %ERRORS &print\_revision &support)

-   Werfen Sie einen Blick darauf, wie die Standard-Plugins ihren Kram
    erledigen

    -   beenden Sie immer mit \$ERRORS{CRITICAL}, \$ERRORS{OK}, etc.

    -   verwenden Sie getopt, um Kommandozeilenparameter einzulesen

    -   denken Sie an Timeout-Verwaltung

    -   rufen Sie print\_usage auf (das Sie liefern müssen), wenn keine
        Kommandozeilenparameter übergeben wurden

    -   benutzen Sie Standard-Optionen (eg H 'host', V 'version')

Dinge, die Sie tun müssen, um ein Perl-Plugin für ePN zu entwickeln
-------------------------------------------------------------------

1.  \<DATA\> kann nicht verwendet werden, benutzen Sie statt dessen
    here-Dokumente, z.B.

        my $data = <<DATA;
        portmapper 100000
        portmap 100000
        sunrpc 100000
        rpcbind 100000
        rstatd 100001
        rstat 100001
        rup 100001
        ..
        DATA
        %prognum = map { my($a, $b) = split; ($a, $b) } split(/\n/, $data) ;

2.  BEGIN-Blöcke werden nicht so funktionieren, wie Sie das erwarten. Es
    wird das Beste sein, wenn Sie darauf verzichten.

3.  stellen Sie sicher, dass es während des Compile absolut sauber ist,
    d.h.

    -   use strict

    -   use perl -w (andere Switches [namentlich T] könnten nicht
        weiterhelfen)

    -   use perl -c

4.  Vermeiden Sie lexikalische Variablen (my) mit globalem
    Geltungsbereich, um damit \_\_variable\_\_ Daten in Unterroutinen zu
    übergeben. Das ist in der Tat \_\_fatal\_\_, wenn die Unterroutine
    mehrfach aufgerufen wird, während die Prüfung läuft. Solche
    Unterroutinen arbeiten als 'closures', die den ersten Wert der
    globalen lexikalischen Variable bei folgenden Aufrufen der
    Unterroutine beibehalten. Wenn die globale Variable allerdings
    read-only ist (bei einer komplizierten Struktur zum Beispiel), dann
    ist das kein Problem. Was Bekman [Ihnen statt dessen
    rät](http://perl.apache.org/docs/1.0/guide/), ist eines der
    folgenden Dinge:

    -   machen Sie die Unterroutine anonym und rufen Sie sie z.B. über
        eine Code-Referenz auf

            ändern Sie dies               in  
            my $x = 1 ;                   my $x = 1 ;
            sub a { .. Process $x ... }   $a_cr = sub { ... Process $x ... } ;
            .                             .
            .                             .
            a ;                           &$a_cr ;
            $x = 2                        $x = 2 ;
            a ;                           &$a_cr ;
            # anonyme Closures binden __immer__ den aktuellen lexikalischen Wert ein

    -   packen Sie globale Lexikale und die Unterroutine, die sie
        benutzt, in ihr eigenes Package (als ein Objekt oder Modul)

    -   übergeben Sie Informationen an Unterroutinen als Referenzen oder
        Aliases (\\\$lex\_var oder \$\_[n])

    -   ersetzen Sie Lexikale durch Package Globals und schließen Sie
        diese von 'use strict'-Beanstandungen durch 'use vars qw(global1
        global2 ..)' aus

5.  Seien Sie sich bewusst, woher Sie mehr Informationen bekommen
    können.

    Nützliche Informationen können Sie von den üblichen Verdächtigen
    bekommen (die O'Reilly-B�cher, plus Damien Conways "Object Oriented
    Perl"), aber um den wirklich nützlichen Kram im richtigen Kontext zu
    bekommen, starten Sie mit Stas Bekman's mod\_perl guide unter
    [http://perl.apache.org/guide/](http://perl.apache.org/guide/).

    Dieses wundervolle Dokument in Buchgröße hat überhaupt nichts mit
    NAME-ICINGA zu tun, aber dafür umso mehr mit dem Schreiben von
    Perl-Programmen für den eingebetteten Perl-Interpreter in
    NAME-APACHE (d.h. Doug MacEacherns mod\_perl).

    Die perlembed-Manpage ist wichtig für den Zusammenhang und die
    Ermunterung..

    Auf der Basis, dass Lincoln Stein und Doug MacEachern ein oder zwei
    Dinge über Perl und eingebettetes Perl wissen, ist ihr Buch 'Writing
    NAME-APACHE Modules with Perl and C' ziemlich sicher einen Blick
    wert.

6.  Achten Sie darauf, dass Ihr Plugin mit ePN vielleicht merkwürdige
    Werte zurückliefert und dass das wahrscheinlich an dem unter Punkt 4
    angesprochenen Problem liegt

7.  Seien Sie darauf vorbereitet, dass Sie debuggen über:

    -   ein Test-ePN und

    -   print-Befehle in Ihr Plugin einfügen, um Variablenwerte auf
        STDERR auszugeben (da Sie STDOUT nicht verwenden können)

    -   print-Befehle in p1.pl einfügen, um anzuzeigen, was ePN glaubt,
        was Ihr Plugin ist, bevor es versucht, das auszuführen (vi)

    -   ePN im Vordergrund-Modus auszuführen (möglicherweise in
        Verbindung mit den obigen Empfehlungen)

    -   das 'Deparse\#-Modul in Ihrem Modul zu benutzen, um zu sehen,
        wie der Parser es optimiert hat und was der Interpreter wirklich
        bekommt (lesen Sie 'Constants in Perl' von Sean M. Burke, The
        Perl Journal, Fall 2001)

    <!-- -->

         perl -MO::Deparse <your_program>

8.  Beachten Sie, in was ePN Ihr Plugin transformiert, und falls alles
    andere fehlschlägt, debuggen Sie die transformierte Version.

    Wie Sie unten sehen können, schreibt p1.pl Ihr Plugin um in eine
    Unterroutine namens 'hndlr' im Package
    'Embed::\<something\_related\_to\_your\_plugin\_file\_name\>'.

    Ihr Plugin wird ggf. Kommandozeilenparameter in @ARGV erwarten, so
    dass p1.pl auch @\_ an @ARGV zuweist.

    Dies wiederum wird 'eval'-t und falls dieser Test mit einem Fehler
    fehlschlägt (jeder Parse- oder Laufzeitfehler), wird das Plugin
    'rausgeschmissen'.

    Die folgenden Ausgaben zeigen, wie ein Test-ePN das
    *check\_rpc*-Plugin transformiert hat, bevor es versucht, es
    auszuführen. Der meiste Code des eigentlichen Plugins wird nicht
    gezeigt, weil wir nur an den Umformungen interessiert sind, die der
    ePN am Plugin vorgenommen hat). Zur Verdeutlichung sind die
    Umformungen in rot dargestellt:

         package main;
         use subs 'CORE::GLOBAL::exit';
         sub CORE::GLOBAL::exit { die "ExitTrap: $_[0] (Embed::check_5frpc)"; }
         package Embed::check_5frpc; sub hndlr { shift(@_);
         @ARGV=@_;
        #! /usr/bin/perl -w
        #
        # check_rpc plugin for NAME-ICINGA
        #
        # usage:
        #    check_rpc host service
        #
        # Check if an rpc service is registered and running
        # using rpcinfo - $proto $host $prognum 2>&1 |";
        #
        # Use these hosts.cfg entries as examples
        #
        # command[check_nfs]=/some/path/libexec/check_rpc $HOSTADDRESS$ nfs
        # service[check_nfs]=NFS;24x7;3;5;5;unix-admin;60;24x7;1;1;1;;check_rpc
        #
        # initial version: 3 May 2000 by Truongchinh Nguyen and Karl DeBisschop
        # current status: $Revision: 1.18 $
        #
        # Copyright Notice: GPL
        #

        }

9.  Nutzen Sie 'use diagnostics' nicht in einem produktiven ePN. Wir
    glauben, es sorgt dafür, dass \_\_alle\_\_ Perl-Plugins CRITICAL
    zurückliefern.

10. Überlegen Sie, ob Sie ein Mini-ePN benutzen, um Ihr Plugin zu
    testen. Das ist nicht ausreichend, um zu garantieren, dass Ihr
    Plugin mit einem ePN fehlerfrei ausgeführt wird, aber wenn bereits
    der Plugin-Test fehlschlägt, dann wird er auf jeden Fall mit Ihrem
    ePN fehlschlagen. *[ Ein Beispiel-Mini-ePN ist im
    *contrib/*-Verzeichnis der NAME-ICINGA-Distribution zu finden.
    Wechseln Sie in das contrib/-Verzeichnis und tippen Sie 'make
    mini\_epn', um es zu kompilieren. Es muss im gleichen Verzeichnis
    ausgeführt werden, in dem die p1.pl-Datei steht (diese Datei wird
    mit NAME-ICINGA ausgeliefert). ]*

Embedded Perl
entwickeln von Plugins für die Benutzung mit Embedded Perl
