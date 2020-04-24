require "minitest/autorun"
require_relative "bowling.rb"

class BowlingTest < Minitest::Test
  attr_reader :game

  def setup
    @game = Bowling.new
  end

  def test_first_frame
    [1, 6].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 7
  end

  def test_spare
    [3, 7, 5, 0].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 20
  end

  def test_spare_without_gutter
    [3, 7, 5, 3].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 23
  end

  def test_strike
    [3, 3, 10, 3, 0].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 22
  end

  def test_strike_without_gutter
    [3, 3, 10, 3, 2].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 26
  end

  def test_two_strikes
    [10, 10, 0].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 30
  end

  def test_two_strikes
    [10, 10, 10, 0].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 60
  end

  def test_spare_then_strike
    [7, 3, 10, 0].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 30
  end

  def test_strike_then_spare
    [10, 7, 3, 0].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 30
  end

  def test_full_game_no_strike_or_spare
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 20
  end
  def test_four_strikes
    [10, 10, 10, 10, 0].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 90
  end

  def test_full_game_all_strikes
    [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 300
  end

  def test_full_all_spares
    [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 150
  end

  def test_full_all_spare_expect_strikes_in_tenth
    [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 10, 10, 10].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 170
  end

  def test_full_game_all_strikes_expect_spare_in_tenth
    [10, 10, 10, 10, 10, 10, 10, 10, 10, 5, 5, 5].each do |pins|
      game.roll(pins)
    end
    assert_equal game.score, 270
  end
end
