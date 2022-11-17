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

song = Song.new

MAIN = self
class Parent < SimpleDelegator
  def self.new(*args)
    super(MAIN).tap do |obj|
      obj.on_init(*args) if obj.respond_to?(:on_init)
    end
  end
end

G_MAJOR = { root: :G2, harmony: chord(:G2, :major) }
D_MAJOR = { root: :D2, harmony: chord(:D2, :major) }
E_MINOR = { root: :E2, harmony: chord(:E2, :minor) }
C_MAJOR = { root: :C3, harmony: chord(:C3, :major) }
B_SEVEN = { root: :B2, harmony: chord(:B2, '7')    }

class Song < Parent
  attr_reader :bar
  
  def on_init
    @beat = 1
    @beats_per_bar = 12
    @bar = @beat * @beats_per_bar
    @count_in_bars = 1
  end
  
  def organic_beat
    @beat * rrand(995, 1005) / 1000
  end
  
  def count_in
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
      sample :drum_bass_hard
    end
  end
  
  def play_bars(bars = [])
    bars.each do |note|
      use_synth :bass_foundation
      play note[:root], sustain: 8 * organic_beat, release: 3 * organic_beat, amp: 0.6
      play note[:harmony], sustain: 8 * organic_beat, release: 3 * organic_beat
      
      use_synth :organ_tonewheel
      play note[:root], sustain: 10 * organic_beat, release: 2 * organic_beat, amp: 0.5
      sleep @bar
    end
  end
  
  def play_rhythm_bar
    with_fx :level, amp: 0.2 do
      2.times do
        sample :drum_cymbal_pedal
        sleep 0.25 * BAR
        sample :drum_cymbal_closed
        sleep 0.25 * BAR
      end
    end
  end
  
  def play_intro
    bars = [G_MAJOR]
    in_thread do
      play_bars(bars)
    end
  end
  
  def play_verse_one
    bars = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR]
    in_thread do
      play_bars(bars)
    end
  end
  
  def play_verse_two
    bars = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR]
    in_thread do
      play_bars(bars)
    end
  end
  
  def play_chorus
    bars = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
            G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
            G_MAJOR]
    
    # accompaniment
    in_thread do
      play_bars(bars)
    end
    
    # hi-hat lead-in
    in_thread do
      (bars.size - 1).times { sleep @bar }
      1.times { play_rhythm_bar }
    end
  end
  
  def play_verse_three
    bars = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR]
    
    # accompaniment
    in_thread do
      play_bars(bars)
    end
    
    # hi-hat
    in_thread do
      bars.size.times { play_rhythm_bar }
    end
  end
  
  def play_verse_four
    bars = [G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR]
    
    # accompaniment
    in_thread do
      play_bars(bars)
    end
    
    # hi-hat
    in_thread do
      bars.size.times { play_rhythm_bar }
    end
  end
  
  def play_bridge
    bars = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
            G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR,
            G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR]
    
    # accompaniment
    in_thread do
      play_bars(bars)
    end
    
    # hi-hat
    in_thread do
      (bars.size - 1).times { play_rhythm_bar }
    end
  end
  
  def play_outro
    bars = [G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
            G_MAJOR]
    
    # accompaniment
    in_thread do
      play_bars(bars)
    end
  end
end

##| # live guitar
##| in_thread do
##|   with_fx :reverb, mix: 0.7 do
##|     live_audio :guitar, input: 1
##|   end
##| end

in_thread do
  song.count_in
  
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
  
  song.play_bridge
  sleep 12 * song.bar
  
  song.play_outro
  sleep 4 * song.bar
end
