cwd ..
cr 
.( working directory:) pwd
include config/allegro.f
include config/options.f
include lib/vfxland3.f

0.5e 0.25e 0e 1e al_clear_to_color
display al_flip_display

cr .( Loading and playing a WAV sample... )
variable smp
smp z" tests/data/link_haa.wav" ?load-sample
smp just-play-sample
1000 ms

cr .( Streaming an OGG file... )
variable strm
ALLEGRO_PLAYMODE_LOOP strm z" tests/data/mus_lab.ogg" ?stream-sample
3000 ms

cr .( Streaming an XM file simultaneously... )
variable strm2
ALLEGRO_PLAYMODE_LOOP strm2 z" tests/data/mountain.xm" ?stream-sample
3000 ms
strm stop-audio-stream
strm2 stop-audio-stream
