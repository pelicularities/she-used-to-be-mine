use_bpm 135
run_file "~/she-used-to-be-mine/she-used-to-be-mine-lyrics.rb"

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
             VERSE_THREE,VERSE_FOUR, BRIDGE, OUTRO].flatten

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

# drum loop
in_thread do
  TOTAL_BARS.times do
    with_fx :level, amp: 0.2 do
      sample :drum_bass_hard
      sleep organic_beat
      sample :drum_bass_soft
      sleep organic_beat
      sample :drum_bass_soft
      sleep organic_beat
      3.times do
        sample :drum_heavy_kick, amp: 0.75
        sleep organic_beat
        sample :drum_bass_soft
        sleep organic_beat
        sample :drum_bass_soft
        sleep organic_beat
      end
    end
  end
end

# hi-hat loop
in_thread do
  sleep count_in
  sleep ([INTRO, VERSE_ONE, VERSE_TWO, CHORUS].flatten.size - 1) * BEATS_PER_BAR
  [VERSE_THREE, VERSE_FOUR, BRIDGE].flatten.size.times do
    with_fx :level, amp: 0.2 do
      2.times do
        sample :drum_cymbal_pedal
        sleep 0.25 * BAR
        sample :drum_cymbal_closed
        sleep 0.25 * BAR
      end
    end
  end
end

# synth pad and bass
in_thread do
  
  sleep count_in
  
  SONG_BARS.each do |note|
    unless note.nil?
      use_synth :bass_foundation
      play note[:root], sustain: 8 * organic_beat, release: 3 * organic_beat, amp: 0.6
      play note[:harmony], sustain: 8 * organic_beat, release: 3 * organic_beat
      
      use_synth :organ_tonewheel
      play note[:root], sustain: 10 * organic_beat, release: 2 * organic_beat, amp: 0.5
    end
    sleep BAR
  end
end

