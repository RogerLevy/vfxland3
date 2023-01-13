\ experimental stage

cwd ..
include config/options.f
include lib/vfxland3.f

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
objvar en
objvar flags
objvar x
objvar y
objvar w
objvar h
objvar 'step
objvar 'draw
objvar 'react
create %object ,

: sizeof  @ ;

: ?execute  ?dup if execute then ;

: link-after  ?dup 0= if exit then  me swap [[ lnk ! ]] ;
    
: object  ( n - obj )
    me >r  here [[  allot&erase  r> link-after  me ]] ;

: pool ( n size - obj )
    here -rot  0 [[  swap 0 do  dup object to me  loop  ]]  drop ;

: create-pool  create pool  drop ;

: one  ( kind obj - obj )
    [[ begin
        en @ 0= if  en on  kind !  me ]] exit then
    lnk @ dup to me 0= until ]] nip ;

0 value xt
: each  ( obj xt - )  ( - continue? )
    xt >r  to xt  [[  
        begin  me  while
            xt execute 0= if  leave  then
            lnk @ to me
        repeat
    ]]  r> to xt ;

: each>  r> each ;

: draw>  r> 'draw ! ;
: step>  r> 'step ! ;
: react>  r> 'react ! ;

: bytes ;

100 256 bytes create-pool p

: 2!  dup >r cell+ ! r> ! ;
: 2@  @+ swap @ ;

: rnd  choose ;

%object sizeof
objvar tm-cols  \ scalar
objvar tm-rows  \ scalar
objvar tm-dcols  \ scalar
objvar tm-drows  \ scalar
objvar tm-base  \ addr
objvar tm-tofs
objvar tm-stride
objvar tm-scrollx  \ scalar
objvar tm-scrolly  \ scalar
objvar tm-tw  \ scalar
objvar tm-th  \ scalar
create %tilemap ,

include lib/tilemap.f

: hv,  $03000000 or , ;

create testmap
    0 , 1 , 2 , 3 ,           0 , 1 , 2 , 3 ,
    4 , 5 , 6 , 7 ,           4 , 5 , 6 , 7 ,
    8 , 9 , 10 , 11 ,         8 , 9 , 10 , 11 ,
    0 hv, 1 hv, 2 hv, 3 hv,   0 hv, 1 hv, 2 hv, 3 hv,
    4 hv, 5 hv, 6 hv, 7 hv,   4 hv, 5 hv, 6 hv, 7 hv,
    8 hv, 9 hv, 10 hv, 11 hv, 8 hv, 9 hv, 10 hv, 11 hv,

\ ------------------------------------------------------------------------------
-sin  \ disable tokenization of all definitions from here

100 bitmaps entry z" tests/data/lemming.png" ?load-bitmap
100 0 16 16 tile 20 bitmap!
\ 1 36 16 16 tile 3 bitmap!
\ 1 210 16 16 tile 4 bitmap!
:noname  p each>  640 rnd 480 rnd x v!  -1  draw> 20 blit ;
execute

101 bitmaps entry z" tests/data/castle-tileset.png" ?load-bitmap
: make-tiles  ( start end - )
    swap do  101 i 16 16 tile i bitmap!  loop ;

0 11 make-tiles

p constant tm
tm [[
    testmap tilemap-init
    0 0 x v!
    8 cells tm-stride !
    4 6 tm-dcols v!
    8 6 tm-cols v!
    :noname  step>  0.25e 0.25e tm-scrollx fv+! ; execute
]]

: cls
    0.5e 0.25e 0e 1e al_clear_to_color ;

\ : .me
\     kind @ body> >name count type ." kind !"

: advance-stage
    each>  'step @ ?execute  -1 ;

: render-stage
    each>  x v@ at  'draw @ ?execute  -1 ; 

: present
    display al_flip_display ;

: render
    p advance-stage  cls  p render-stage  present ;

: go  begin  render  pause again ;

\ go