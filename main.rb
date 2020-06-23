B = "B"
W = "W"
BLANK = "?"

class Board
  attr_accessor :board_config

  def initialize
    @board_config = Array.new()
    @dim = 4 # 4 slots
    @limit = 12
    for i in 0...@limit
      @board_config.push(["_", "_", "_", "_"]) # 4 by 12, 2 for 
    end
    @code = generate_code()
  end

  def feedback_code(guess)
    # black: correct colour and position
    # white: correct colour, wrong position
    feedback = []
    
    guess.each_with_index do |g, idx|
      # not sure about the rules
      if g == @code[idx]
        feedback.push(B)
      elsif @code.include?(g)  
        feedback.push(W)
      else
        feedback.push(BLANK)
      end
    end
    return feedback
  end

  private
  def generate_code
    # generate a 4 digit code peg
   
    code = []
    for i in 0...4
      seed = rand()
      code.push((10 *seed / 2).floor)
    end
    puts code.inspect
    return code
  end
end


def main
  board = Board.new()
  # IO w/ terminal example move
  guess = gets.strip.chars
  puts guess
  peg = board.feedback_code(guess)
  puts "Feedback"
  puts peg.inspect

end

main
