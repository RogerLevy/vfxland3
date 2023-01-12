\ experimental stage

cwd ..
include config/options.f
include lib/vfxland3.f

-sin  \ disable tokenization of all definitions from here

create alevt /ALLEGRO_EVENT allot&erase
variable x
variable y

: move-about
    <up> held if -1 y +! then
    <down> held if 1 y +! then
    <left> held if -1 x +! then
    <right> held if 1 x +! then
    <enter> pressed if 10 x +! then
    walt y +! x +! ;

100 bitmaps entry z" tests/data/lemming.png" ?load-bitmap
100 0 16 16 tile 20 bitmap!

: cls
    0.5e 0.25e 0e 1e al_clear_to_color ;

: present
    display al_flip_display ;

: handle-events
    begin  queue alevt al_get_next_event  while
        alevt ALLEGRO_EVENT.type @ ALLEGRO_EVENT_MOUSE_BUTTON_DOWN = if
            10 y +!
        then 
    repeat ;

: advance
    poll-keyboard poll-mouse
    handle-events
    move-about ;

: render
    cls
    x @ y @ at  20 blit
    present ;

: init
    reset-keyboard 
    display al_get_win_window_handle SetForegroundWindow drop ;

: go  init  begin  advance  render  pause  again ;
