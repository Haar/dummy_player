require 'my_helper'
class Player

  ALPHABET = "abcdefghijklmnopqrstuvwxyz".split('')

  def name
    "SmallGuyMike"
  end

  def take_turn(state, guesses)
    MyHelper.answer(state, guesses)
  end
end
