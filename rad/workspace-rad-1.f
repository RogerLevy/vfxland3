\ Workspace test #1

cwd ..
\ include config/options.f
\ include lib/vfxland3.f

variable penx
variable peny

: at@  penx @ peny @ ;
: at  peny ! penx ! ;

create world 0 , 
world value me
create os  $100 allot
variable >os 

: [[  me >os @ os + !  >os @ cell+ $ff and >os !  to me ;
: ]]  >os @ cell- $ff and >os !  >os @ os + @ to me ;
: objvar  create dup , cell+  does> @ me + ;

0
objvar lnk
objvar kind
objvar x
objvar y
objvar w
objvar h
objvar flags
objvar 'step
objvar 'draw
objvar 'react
create %object , 0 ,

%object constant %app

: sizeof  @ ;
: kind.init  cell+ ;
: ?execute  ?dup if execute then ;

: extend  sizeof ;

: init  kind @ kind.init @ ?execute ;

: link-after  ?dup 0= if exit then  me swap [[ lnk ! ]] ;
    
: object  ( n - obj )
    me >r  here [[  allot&erase  r> link-after  me ]] ;

: init-app  ( kind app - )
    [[ kind ! ]] ;
    
\ : app  ( - <name> app )
\     create  workspace [[ dup sizeof object dup init-app ]] ;

variable (in)
: ?kind ( - kind )
    >in @ (in) !  bl word dup find if
        >body nip
    else
        drop  count included  (in) @ >in !  bl word find if
            >body
        else
            -1 abort" Improper kind definition; kind doesn't match filename or not defined!"
        then
    then ;

: (obj)  ( kind - )
    dup sizeof object to me  kind !  at@ y ! x ! ;

: obj  ( - <kind> )
    ?kind  (obj) ;

: create-obj ( - <kind> <name> ) ( - obj )
    ?kind  create  (obj) ;

: as  to me ;
: >first  [[ lnk @ ]] ;
    
0 value xt
: each  ( obj xt - )  ( - continue? )
    xt >r  to xt  [[  
        begin  me  while
            xt execute 0= if  leave  then
            lnk @ to me
        repeat
    ]]  r> to xt ;

: each>  r> each ;

-sin

create workspace %object sizeof object drop

filedev: #1

: .workspace
    workspace >first each>        
        x @ . y @ . ." at  "
        ." create-obj "
        kind @ >name count type  space  me >name count type  cr
        -1 ;

: write> ( a c - )
    w/o #1 open-gio abort" file open err" drop
    OP-HANDLE @  #1 OP-HANDLE !
    r> execute
    OP-HANDLE !  #1 close-gio drop ;
        
: save ( - )
    s" output.f" write> .workspace ;

workspace as
include rad/ws1/workspace
app1 as  init
app2 as  init
app3 as  init

