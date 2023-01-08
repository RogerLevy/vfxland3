max-bitmaps cell narray bitmaps
variable mir

: bitmap ( n - a )
    bitmaps entry ;

: bitmap! ( bitmap n - )
    dup bitmap @ ?dup if  al_destroy_bitmap  then
    bitmap ! ;

: blit  ( n - )
    bitmaps entry @ ?dup if
        at@f mir @ al_draw_bitmap
    then ;
    
: (tile) ( n bw tw th - x y tw th )
    locals| th tw bw n |
    n bw tw / mod tw *
    n bw tw / / th *
    tw th ;
    
: tile ( bn1 bn2 tw th - bitmap )
    locals| th tw bn2 bn1 |
    bn1 bitmap @
        bn2 bn1 bitmap @ al_get_bitmap_width tw th (tile)
        al_create_sub_bitmap ;