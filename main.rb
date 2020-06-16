W = "W"
B = "B"
def generate_code()
    # generate a 4 digit code peg
    seed = rand()
    code = []
    for i in 0...4
      if seed > 0.5
        code.push(B)
      else
        code.push(W)
      end
    end
    return code
end

def feedback_code(guess, answer)
    # black: correct colour and position
    # white: correct colour, wrong position
    feedback = []
    
    guess.each_with_index do |g, idx|
      # not sure about the rules
      if g == answer[idx]
        feedback.push(B)
      else
        feedback.push(W)
      end
    
    end    
end

def main
  code = generate_code()
  puts code.inspect

  # hardcoded example move
  guess = [B, W, W, B]
  peg = feedback_code(guess, code)
  puts "Feedback"
  puts peg.inspect
end

main
