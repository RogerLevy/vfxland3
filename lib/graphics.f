create pen 0 , 0 ,

: @+  dup cell+ swap @ ;
: 2!  dup >r  cell+ ! r> ! ;
: at  pen 2! ;
: at@f  pen @+ s>f @ s>f ;
: +at  pen cell+ +!  pen +! ;

: transformed ( f: x y angle sx sy - )
    m al_scale_transform 
    deg>rad m al_rotate_transform 
    m al_translate_transform
    m al_use_transform ;

: identity ( - )
    m al_identity_transform
    m al_use_transform ;