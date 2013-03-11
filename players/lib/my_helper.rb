module MyHelper

  ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')
  COMMON_FREQ = "etaoinshrdlcumwfgypbvkjxqz".split('')
  FIRST_LETTER_FREQ = "tashwiobmfcldpnegryuvjkqxz".split('')

  def self.answer(state, guesses)
    find_possible_words(state)

    if blank_state?(state)
      potential = COMMON_FREQ - guesses
      potential.first
    else
      words_for_state = possible_words_for_pattern(state)
      most_common_letter(words_for_state)
    end
  end

  def self.possible_words_for_pattern(state)
    reg = Rexexp.new("^#{state.gsub('_', '.')}$")
    self.possible_words.select{|w| w =~ reg}
  end

  def self.most_common_letter(words)
    bin = Hash.new{|k,v| k[v] = 0}
    letters = words.map{|w| w.split("")}.flatten
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
      File.open("words", "r") do |dictionary|
        dictionary.gets.select { |word| word.strip.length == length }
      end
    end
  end
end

#puts MyHelper.most_common_letter(["asdf", "qaswqa"])
#puts MyHelper.most_common_letter(["abc", "bad", "dddddd", "ff", "c"])
# 10.times { p MyHelper.answer("______", "abcdef".split('')) }
