module MyHelper

  ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')
  COMMON_FREQ = "etaoinshrdlcumwfgypbvkjxqz".split('')
  #FIRST_LETTER_FREQ = "tashwiobmfcldpnegryuvjkqxz".split('')

  def self.answer(state, guesses)
    find_possible_words(state)
    words_for_state = possible_words_for_pattern(state, guesses)
    most_common_letter(words_for_state, guesses)
  end

  def self.possible_words_for_pattern(state, guesses)
    reg = Regexp.new("^#{state.gsub('_', "[^#{guesses.join}]")}$")
    p reg
    self.possible_words.select{|w| w =~ reg}
  end

  def self.most_common_letter(words, guesses)
    bin = Hash.new{|k,v| k[v] = 0}
    letters = words.map{|w| w.split("")}.flatten - guesses
    letters.map{|l| bin[l] += 1}
    return bin.to_a.sort_by{ |k,v| v }.last[0]
  end

  def self.blank_state?(state)
    (state =~ /^_+$/) == 0
  end

  def self.possible_words
    @possible_words
  end

  def self.find_possible_words(state)
    @possible_words ||= begin
      length = state.length
      words = []
      File.open("/usr/share/dict/words", "r") do |dictionary|
        while (word = dictionary.gets)
          word = word.strip
          words << word if word.length == length
        end
      end
      words
    end
  end
end

#puts MyHelper.most_common_letter(["asdf", "qaswqa"], ["a", "q"])
#puts MyHelper.most_common_letter(["abc", "bad", "dddddd", "ff", "c"])
# 10.times { p MyHelper.answer("______", "abcdef".split('')) }
# p MyHelper.answer("_______", ["e", "a"])
