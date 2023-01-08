cwd ..
cr 
.( working directory:) pwd
include config/options.f
include lib/vfxland3.f

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
