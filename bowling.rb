class Bowling
  attr_accessor :frames

  def initialize
    self.frames = [Frame.new(1)]
  end

  def roll(pins)
    if current_frame.full?
      frames << current_frame.create_next_frame
    end
    current_frame.roll(pins)
  end

  def score
    frames.map(&:score).sum
  end

  private

  def current_frame
    frames.last
  end
end

class Frame
  attr_accessor :next_frame, :number, :rolls

  def initialize(number)
    self.number = number
    self.rolls = []
  end

  def create_next_frame
    self.next_frame = self.class.new(number + 1)
    next_frame
  end

  def full?
    return false if number == 10
    rolls.length == 2 || strike?
  end

  def roll(pins)
    rolls << pins
  end

  def roll_one
    rolls.first
  end

  def roll_two
    rolls[1]
  end

  def raw_score
    rolls.sum
  end

  def score
    return raw_score if number == 10
    return raw_score + next_frame.roll_one if spare?
    return strike_score if strike?
    raw_score
  end

  def spare?
    raw_score == 10 && roll_one != 10
  end

  def strike?
    roll_one == 10
  end

  def strike_score
    if number == 9
       raw_score + next_frame.roll_one + next_frame.roll_two
    elsif next_frame.strike?
      raw_score + next_frame.roll_one + next_frame.next_frame.roll_one
    else
      raw_score + next_frame.raw_score
    end
  end
end
