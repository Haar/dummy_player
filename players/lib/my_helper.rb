module MyHelper

  ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')
  COMMON_FREQ = "etaoinshrdlcumwfgypbvkjxqz".split('')

  def self.answer(state, guesses)
    find_possible_words(state)
    words_for_state = possible_words_for_pattern(state, guesses)
    most_common_letter(words_for_state, guesses)
  end

  def self.possible_words_for_pattern(state, guesses)
    if guesses.empty?
      reg = Regexp.new("^#{state.gsub('_', ".")}")
    else
      reg = Regexp.new("^#{state.gsub('_', "[^#{guesses.join}]")}")
    end
    self.possible_words.select{|w| w =~ reg}
  end

  def self.most_common_letter(words, guesses)
    if words.empty?
      (COMMON_FREQ - guesses).first
    else
      bin = Hash.new{|k,v| k[v] = 0}
      letters = words.map{|w| w.split("")}.flatten - guesses
      letters.map{|l| bin[l] += 1}
      return bin.to_a.sort_by{ |k,v| v }.last[0]
    end
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
          word = word.strip.downcase
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
#MyHelper.answer("undoin_s", ["u", "n", "d", "o", "i", "e", "t", "a", "s", "h", "r", "g", "l", "c"])
