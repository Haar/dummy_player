require 'my_helper'
class Player

  ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')

  def name
    "SmallGuyMike"
  end

  def take_turn(state, guesses)
    potential = alphabet - guesses
    # common_frequencies = etaoinshrdlcumwfgypbvkjxqz
    # first_letter_frequencies = tashwiobmfcldpnegryuvjkqxz
    # "_____" - state
    MyHelper.answer
  end
end
