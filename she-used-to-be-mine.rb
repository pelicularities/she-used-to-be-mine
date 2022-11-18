use_bpm 135
run_file "~/code/she-used-to-be-mine/she-used-to-be-mine-lyrics.rb"

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
  
  def print_lyrics(lyrics)
    in_thread do
      sleep @beats_per_bar * 0.75
      lyrics.each do |line|
        puts line unless line.empty?
        sleep @bar
      end
    end
  end
  
  def play_accompaniment(bars = [])
    bars.each do |note|
      use_synth :bass_foundation
      play note[:root], sustain: 8 * organic_beat, release: 3 * organic_beat, amp: 0.1
      play note[:harmony], sustain: 8 * organic_beat, release: 3 * organic_beat, amp: 0.2
      
      use_synth :organ_tonewheel
      play note[:root], sustain: 10 * organic_beat, release: 2 * organic_beat, amp: 0.2
      sleep @bar
    end
  end
  
  def play_hi_hats
    with_fx :level, amp: 0.2 do
      2.times do
        sample :drum_cymbal_pedal
        sleep 0.25 * @bar
        sample :drum_cymbal_closed
        sleep 0.25 * @bar
      end
    end
  end
  
  def play_beats
    with_fx :level, amp: 0.05 do
      sample :drum_bass_hard
      sleep 0.25 * @bar
      3.times do
        sample :drum_heavy_kick, amp: 0.75
        sleep 0.25 * @bar
      end
    end
  end
  
  def count_in
    play_beats
  end
  
  def play_verse_with_drums(bars = [])
    in_thread do
      play_accompaniment(bars)
    end
    
    in_thread do
      bars.size.times { play_beats }
    end
    
    sleep bars.size * @bar
  end
  
  def play_chorus(bars = [])
    in_thread do
      play_accompaniment(bars)
    end
    
    in_thread do
      bars.size.times { play_beats }
    end
    
    in_thread do
      (bars.size - 1).times { sleep @bar }
      1.times { play_hi_hats }
    end
    
    sleep bars.size * @bar
  end
  
  def play_verse_with_hi_hats(bars = [])
    in_thread do
      play_accompaniment(bars)
    end
    
    in_thread do
      bars.size.times { play_hi_hats }
    end
    
    sleep bars.size * @bar
  end
  
  def play_bridge(bars = [])
    in_thread do
      play_accompaniment(bars)
    end
    
    in_thread do
      (bars.size - 1).times { play_hi_hats }
      sample :drum_cymbal_open, amp: 0.15
    end
    sleep bars.size * @bar
  end
end

song = Song.new

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

in_thread do
  song.count_in
  song.print_lyrics(LYRICS)
  song.play_verse_with_drums([G_MAJOR])
  song.play_verse_with_drums([G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
                              G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR])
  song.play_chorus([G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
                    G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
                    G_MAJOR])
  song.play_verse_with_hi_hats([G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
                                G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR])
  song.play_bridge([G_MAJOR, D_MAJOR, E_MINOR, C_MAJOR,
                    G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR,
                    G_MAJOR, B_SEVEN, E_MINOR, C_MAJOR])
  song.play_accompaniment([G_MAJOR])
end
