0 value dev?
0 value fullscreen?
0 value export?
0 value doublebuf?
-1 value mswin?
640 value winw
480 value winh

: argkey  over >r s" =" search drop nip r> swap ;
: argval  s" =" search drop 1 /string ;

:noname
    CommandLine 2drop
    argc 1 ?do
        i argv[ zcount 
            2dup s" -dev" compare 0= dev? or to dev?
            2dup s" -fullscreen" compare 0= fullscreen? or to fullscreen?
            2dup s" -export" compare 0= export? or to export?
            2dup s" -doublebuf" compare 0= doublebuf? or to doublebuf?
            2dup argkey
              2dup s" -winw" compare 0= if  2dup argval to winw  then
              2dup s" -winh" compare 0= if  2dup argval to winh  then
            2drop
        2drop 
    loop
; execute

dev? [if]
    synonym turnkey SaveConsole
[else]
    synonym turnkey save
[then]

dev? [if]
    : require  get-order depth >R require depth R> >
        abort"  Stack item(s) left behind" set-order ;
[then]

