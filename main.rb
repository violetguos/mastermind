B = "B"
W = "W"
BLANK = "?"

class Board
  attr_accessor :board_config, :limit, :round, :player

  def initialize(player)
    @player = player
    @board_config = Array.new()
    @dim = 4 # 4 slots
    @limit = 12
    @round = 0
    @peg_feedback = Array.new()
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
      else
        feedback.push(W)
      end
    end

    return feedback
  end

  def print_board()
    @board_config.each_with_index do |row, idx|
      row.each_with_index do |elem, elem_idx|
        print elem
        if elem_idx == (@dim - 1)
          print "\n"
        else
          print '|'
        end
      end
    end
  end

  def terminate?()
    @peg_feedback.each do |p|
      if p != B
        return false
      end
    end
    if !@peg_feedback.empty?
      return true
    end
  end

  def score()
    puts "Current score: #{round}"
  end

  def prompt()

    if @player == "human"
      guess = ""
      loop do
        guess = gets.strip.chars
        if guess.length == 4
          break
        end
      end # end of do while
    elsif @player == "computer"
      guess = self.code_break()
    end

    @round +=1
    @board_config[@round] = guess
    peg = feedback_code(guess)
    print_board
    puts "Feedback"
    puts peg.inspect
    @peg_feedback = peg
  end

  def code_break()
    possible_set = ["0", "1", "2", "3", "4", "5"]
    guess = []
    prev_guess = @board_config[@round]
    if @round == 0
      return ["0", "0", "0", "0"]
    else
      elems_to_replace = @peg_feedback.count(W)
      
      # sample idxs to replace
      if elems_to_replace == 4
        for i in 0...4
          guess.push(possible_set.sample(1)[0])
        end
      elsif
        guess = prev_guess.shuffle
        for i in 0...elems_to_replace
          guess[i] = possible_set.sample(1)[0]
        end
      end
      return guess
    end
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


class Game

  def initialize
    @mode = self.prompt()
    @board = Board.new(@mode)
    @score_human = 0
    @score_machine = 0
  end

  def human_code_breaker
    while @board.round < @board.limit && !@board.terminate?()
      @board.prompt()
    end
    @score_machine = @board.score
  end

  def prompt
    puts "Would you like to break code: [Y/N]"
    ans = gets.chomp
    if ans == "N"
      return "computer"
    else
      return "human"
    end
  end
end


def main

  game = Game.new()
  game.human_code_breaker
end

main
