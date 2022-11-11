BEAT = 1
BEATS_PER_BAR = 12
BAR = BEAT * BEATS_PER_BAR
COUNT_IN = 1 * BAR

# drum loop
in_thread do
  loop do
    with_fx :level, amp: 0.05 do
      sample :drum_bass_hard
      sleep 1
      sample :drum_bass_soft
      sleep 1
      sample :drum_bass_soft
      sleep 1
      sample :drum_bass_hard
      sleep 1
      sample :drum_bass_soft
      sleep 1
      sample :drum_bass_soft
      sleep 1
    end
  end
end


# bass
in_thread do
  sleep 1 * BAR
  
  # chorus
  use_synth :bass_foundation
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :D2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :Ds2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :E2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :G2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  play :C3, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :C3, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :B2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  play :G2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :D2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  play :D2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :A2, sustain: 0.5 * BEAT, release: 0.5 * BEAT
  sleep 1 * BEAT
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :E2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :G2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  play :C3, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :C3, sustain: 2 * BEAT, release: 2 * BEAT
  sleep 4 * BEAT
  play :B2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :A2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # verse 2
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  play chord(:G3, :maj), sustain: 6 * BEAT, release: 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  play chord(:D3, :maj), sustain: 6 * BEAT, release: 6 * BEAT
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
end
