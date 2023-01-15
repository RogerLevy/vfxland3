\ objvar tm-cols  \ scalar
\ objvar tm-rows  \ scalar
\ objvar tm-dcols  \ scalar
\ objvar tm-drows  \ scalar
\ objvar tm-base  \ addr
\ objvar tm-tofs
\ objvar tm-stride
\ objvar tm-scrollx  \ scalar
\ objvar tm-scrolly  \ scalar
\ objvar tm-tw  \ scalar
\ objvar tm-th  \ scalar

0 value dx
0 value dy

: blit-tile ( v - )
    dup 0< if
        drop
    else
        dup 24 rshift swap $ffff and mblit
    then ;

: the-tilemap  ( - )

    tm-base @ 0= if exit then
    tm-drows v@ or 0= if exit then    

    1 al_hold_bitmap_drawing
    
    tm-scrollx s@ tm-tw s@ mod negate 
    tm-scrolly s@ tm-th s@ mod negate  +at

    tm-base @
        tm-scrollx s@ tm-tw s@ / cells +
        tm-scrolly s@ tm-th s@ / tm-stride @ * +
    ( addr )
    tm-drows s@ 0 do
        at@ >r >r 
        dup tm-dcols s@ cells bounds do
            i @ tm-tofs @ + blit-tile
            tm-tw s@ 0 +at 
        cell +loop
        tm-stride @ +
        r> r> tm-th s@ + at
    loop
    drop
  
    0 al_hold_bitmap_drawing ;

: tilemap-init  ( addr - )
    tm-base !
    16 16 tm-tw v!
    winw 16 / winh 16 / tm-dcols v!
    draw>  the-tilemap ;

\ : allot-tilemap  ( w h tilemap - )  \ w and h are in tiles; determine the buffer size
\     [[ init-tilemap
\     2dup tm-cols v!
\     2dup * cells here >r allot&erase r> tm-base !
\     drop cells tm-stride ! ]] ;
