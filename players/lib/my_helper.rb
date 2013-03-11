module MyHelper

  ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')
  COMMON_FREQ = "etaoinshrdlcumwfgypbvkjxqz".split('')
  FIRST_LETTER_FREQ = "tashwiobmfcldpnegryuvjkqxz".split('')

  def self.answer(state, guesses)
    potential = COMMON_FREQ - guesses
    p potential
    return potential.first
    #found = false
    #while(!found)
    # "_____" - state
  end

  def find_possible_words(state)
    @possible_words ||= begin
      length = state.length
      File.open("dictionary", "r") do |dictionary|
        dictionary.gets.select { |word| word.strip.length == length }
      end
    end
  end
end

# 10.times { p MyHelper.answer("______", "abcdef".split('')) }
