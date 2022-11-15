use_bpm 135
run_file "~/she-used-to-be-mine/she-used-to-be-mine-lyrics.rb"
require("./song")

BEAT = 1
BEATS_PER_BAR = 12
BAR = BEAT * BEATS_PER_BAR
COUNT_IN_BARS = 1

define :organic_beat do
  BEAT * rrand(995, 1005) / 1000
end

define :count_in do
  COUNT_IN_BARS * BEATS_PER_BAR * organic_beat
end

G_MAJOR = { root: :G2, harmony: chord(:G2, :major) }
D_MAJOR = { root: :D2, harmony: chord(:D2, :major) }
E_MINOR = { root: :E2, harmony: chord(:E2, :minor) }
C_MAJOR = { root: :C3, harmony: chord(:C3, :major) }
B_SEVEN = { root: :B2, harmony: chord(:B2, '7')    }

song = Song.new

INTRO       = [G_MAJOR]
VERSE_ONE   = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR]
VERSE_TWO   = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR]
CHORUS      = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
               G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
               G_MAJOR]
VERSE_THREE = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR]
VERSE_FOUR  = [G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR]
BRIDGE      = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
               G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR,
               G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR]
OUTRO       = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
               G_MAJOR]

SONG_BARS = [INTRO, VERSE_ONE, VERSE_TWO, CHORUS,
             VERSE_THREE, VERSE_FOUR, BRIDGE, OUTRO].flatten

TOTAL_BARS = COUNT_IN_BARS + SONG_BARS.size

# lyrics
in_thread do
  sleep count_in
  sleep (INTRO.size - 1) * BEATS_PER_BAR
  sleep BEATS_PER_BAR * 0.75
  LYRICS.each do |line|
    puts line unless line.empty?
    sleep BAR
  end
end

# live guitar
in_thread do
  with_fx :reverb, mix: 0.7 do
    live_audio :guitar, input: 1
  end
end

in_thread do
  song.count_in
  sleep song.bar

  song.play_intro
  sleep song.bar

  song.play_verse_one
  sleep 4 * song.bar

  song.play_verse_two
  sleep 4 * song.bar

  song.play_chorus
  sleep 9 * song.bar

  song.play_verse_three
  sleep 4 * song.bar

  song.play_verse_four
  sleep 4 * song.bar

  song.play_verse_bridge
  sleep 12 * song.bar

  song.play_outro
  sleep 4 * song.bar
end
