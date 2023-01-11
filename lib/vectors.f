\ 64-bit float vectors

\ scalars
: s@  sf@ f>s ;
: s!  swap s>f sf! ;
: s+!  swap s>f dup sf@ f+ sf! ;
: s,  s>f sf, ;
: fs@  sf@ ;
: fs!  sf! ;
: fs+!  sf+! ;
: fs*!  dup sf@ f* sf! ;
: fs,  sf, ;

\ 2d vectors
: v@  dup s@ swap 4 + s@ ;
: v!  dup >r 4 + s! r> s! ;
: v+!  dup >r 4 + s+! r> s+! ;
: v,  swap s, s, ;
: fv@  dup fs@ 4 + fs@ ;
: fv!  dup 4 + fs! fs! ;
: fv+!  dup 4 + fs+! fs+! ;
: fv*!  dup 4 + fs*! fs*! ;
: fv,  dup fswap fs, fs, ;

: v.  fv@ fswap f. f. ;

create test 1e 2e fv, 

