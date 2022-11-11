use_bpm 150

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

# in_thread do
#   with_fx :reverb do
#     live_audio :foo, input: 1
#   end
# end

# pad
in_thread do
  sleep 1 * BAR
  
  use_synth :bass_foundation
  
  # chorus
  # she's imperfect, but she tries
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  # she is good, but she lies
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :D2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :Ds2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # she is hard on herself
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :E2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :G2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # she is broken and won't ask for help
  play :C3, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :C3, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :B2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # she is messy but she's kind
  play :G2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :D2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  # she is lonely most of the time
  play :D2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :A2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  # she is all of this mixed up and baked in a beautiful pie
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :E2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :G2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # she is gone, but she used to be mine
  play :C3, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :C3, sustain: 2 * BEAT, release: 2 * BEAT
  sleep 4 * BEAT
  play :B2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :A2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  # verse 3
  # it's not what I asked for
  play chord(:G3, :maj), sustain: 6 * BEAT, release: 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  # sometimes life just slips in through a back door
  play chord(:D3, :maj), sustain: 6 * BEAT, release: 6 * BEAT
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  # and carves out a person who makes you believe it's all true
  play chord(:E3, :m), sustain: 6 * BEAT, release: 6 * BEAT
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :E2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :G2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # and now I've got you
  play chord(:C4, :maj), sustain: 6 * BEAT, release: 6 * BEAT
  play :C3, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :C3, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :B2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # verse 4
  # you're not what I asked for
  play chord(:G3, :maj), sustain: 6 * BEAT, release: 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  
  # if I'm honest I know I would give it all back
  play chord(:B3, '7'), sustain: 6 * BEAT, release: 6 * BEAT
  play :B2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :B2, sustain: 2 * BEAT, release: 1 * BEAT
  sleep 3 * BEAT
  play :B2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :A2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :Ds2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # for a chance to start over and rewrite an ending or two
  play chord(:E3, :m), sustain: 6 * BEAT, release: 6 * BEAT
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play :E2, sustain: 2 * BEAT, release: 1 * BEAT
  sleep 4 * BEAT
  play :Fs2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :G2, sustain: 1 * BEAT, release: 1 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # for the girl that I knew
  play chord(:C4, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :C3, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:C4, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :C3, sustain: 2 * BEAT, release: 2 * BEAT
  sleep 4 * BEAT
  play :B2, sustain: 1 * BEAT, release: 1 * BEAT, amp: 0.5
  sleep 2 * BEAT
  
  # bridge
  # who was reckless, just enough
  play chord(:G3, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:G3, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :G2, sustain: 2 * BEAT, release: 1 * BEAT
  sleep 3 * BEAT
  play :G2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :Fs2, sustain: 1 * BEAT, release: 1 * BEAT, amp: 0.5
  sleep 2 * BEAT
  
  # who gets hurt, but who learns how to toughen up
  play chord(:D3, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :D2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:D3, :maj), sustain: 2 * BEAT, release: 1 * BEAT
  play :D2, sustain: 2 * BEAT, release: 1 * BEAT
  sleep 2 * BEAT
  play :D2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play chord(:D3, :maj), sustain: 2 * BEAT, release: 1 * BEAT
  play :D2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :D2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :Ds2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # when she's bruised and gets used by a man who can't love
  play chord(:E3, :m), sustain: 3 * BEAT, release: 3 * BEAT
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:E3, :m), sustain: 3 * BEAT, release: 3 * BEAT
  play :E2, sustain: 2 * BEAT, release: 1 * BEAT
  sleep 3 * BEAT
  play :E2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :G2, sustain: 1 * BEAT, release: 1 * BEAT, amp: 0.5
  sleep 2 * BEAT
  
  # then she'll get stuck
  
  # and be scared of the life that's inside her
  play chord(:G3, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :G2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:G3, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :G2, sustain: 2 * BEAT, release: 1 * BEAT
  sleep 3 * BEAT
  play :Fs2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :G2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  play :A2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # getting stronger each day, till it finally reminds her
  play chord(:B3, '7'), sustain: 3 * BEAT, release: 3 * BEAT
  play :B2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:B3, '7'), sustain: 3 * BEAT, release: 3 * BEAT
  play :Ds3, sustain: 2 * BEAT, release: 1 * BEAT
  sleep 3 * BEAT
  play :B2, sustain: 1 * BEAT, release: 1 * BEAT, amp: 0.5
  sleep 2 * BEAT
  play :Fs2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # to fight just a little and bring back the fire in her eyes
  play chord(:E3, :m), sustain: 3 * BEAT, release: 3 * BEAT
  play :E2, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:E3, :m), sustain: 3 * BEAT, release: 3 * BEAT
  play :E2, sustain: 3 * BEAT, release: 2 * BEAT
  sleep 5 * BEAT
  play :Fs2, sustain: 0.5 * BEAT, release: 0.5 * BEAT, amp: 0.5
  sleep 1 * BEAT
  
  # that's been gone but used to be mine
  play chord(:C4, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :C3, sustain: 3 * BEAT, release: 3 * BEAT
  sleep 6 * BEAT
  play chord(:C4, :maj), sustain: 3 * BEAT, release: 3 * BEAT
  play :C3, sustain: 2 * BEAT, release: 2 * BEAT
  sleep 4 * BEAT
  play :B2, sustain: 1 * BEAT, release: 1 * BEAT, amp: 0.5
  sleep 2 * BEAT
  
  
end
