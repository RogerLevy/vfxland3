: ?load-sample  ( var zstr - )
    dup 0= if 2drop exit then
    dup zcount FileExist? if
        over @ ?dup if al_destroy_sample then
        cr dup zcount type
        al_load_sample swap !
    else drop drop then
;

: just-play-sample ( var - )
    @ dup 0= if  drop  exit  then  
    1e 0e 1e  ALLEGRO_PLAYMODE_ONCE   here  al_play_sample
;

: ?stream-sample ( loopmode var zstr - )
    over 0= if 3drop exit then
    3 2048  al_load_audio_stream
        dup 0= if  2drop  exit  then
        >r
    dup @ ?dup if al_destroy_audio_stream  then
    r@ swap !
    r@ al_set_audio_stream_playmode drop
    r> mixer al_attach_audio_stream_to_mixer drop
;

: stop-audio-stream ( var - )
    @ 0 al_set_audio_stream_playing drop
;

: resume-audio-stream ( var - )
    @ 1 al_set_audio_stream_playing drop
;