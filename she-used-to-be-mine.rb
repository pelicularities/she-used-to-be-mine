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
OUTRO       = [G_MAJOR, nil, nil, nil,
               nil]

SONG_BARS = [INTRO, VERSE_ONE, VERSE_TWO, CHORUS,
             VERSE_THREE,VERSE_FOUR, BRIDGE, OUTRO].flatten

DRUM_BARS_COUNT = COUNT_IN_BARS + [INTRO, VERSE_ONE, VERSE_TWO, CHORUS].flatten.size

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

# voice
in_thread do
  with_fx :reverb, mix: 0.8 do
    live_audio :voice, input: 2
  end
end

# live guitar
in_thread do
  with_fx :reverb, mix: 0.8 do
    with_fx :distortion, amp: 0.7, distort: 0.9, mix: 1 do
      live_audio :guitar, input: 1
    end
  end
end

# drum loop
in_thread do
  with_fx :level, amp: 0.05 do
    DRUM_BARS_COUNT.times do
      sample :drum_bass_hard
      sleep 0.25 * BAR
      3.times do
        sample :drum_heavy_kick, amp: 0.75
        sleep 0.25 * BAR
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
  sample :drum_cymbal_open, amp: 0.2
  sleep 0.25 * BAR
end

# synth pad and bass
in_thread do
  sleep count_in
  SONG_BARS.each do |note|
    unless note.nil?
      use_synth :bass_foundation
      play note[:root], sustain: 8 * organic_beat, release: 3 * organic_beat, amp: 0.1
      play note[:harmony], sustain: 8 * organic_beat, release: 3 * organic_beat, amp: 0.2

      use_synth :organ_tonewheel
      play note[:root], sustain: 10 * organic_beat, release: 2 * organic_beat, amp: 0.2
    end
    sleep BAR
  end
end
