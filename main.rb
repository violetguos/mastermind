B = "B"
W = "W"
BLANK = "?"

class Board
  attr_accessor :board_config, :limit, :round

  def initialize
    @board_config = Array.new()
    @dim = 4 # 4 slots
    @limit = 12
    @round = 0
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

  def print_board()
    @board_config.each_with_index do |row, idx|
      row.each_with_index do |elem, elem_idx|
        print elem
        if elem_idx == (@limit - 1)
          print "\n"
        else
          print '|'
        end
      end
    end
  end
  
  def prompt()
    guess = ""
    loop do
      guess = gets.strip.chars
      if guess.length == 4
        break
      end
    end # end of do while

    @round +=1
    @board_config[@round] = guess
    peg = feedback_code(guess)
    puts "Feedback"
    puts peg.inspect
  end

  private
  def generate_code
    # generate a 4 digit code peg
   
    code = []
    for i in 0...4
      seed = rand()
      code.push((10 *seed / 2).floor.to_s)
      
    end
    puts code.inspect # only for debugging
    return code
  end
end






def main
  board = Board.new()
  while board.round < board.limit
    board.prompt()
  end
end

main
