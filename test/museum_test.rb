require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'

class MuseumTest < MiniTest::Test
  def setup
    @museum = Museum.new("Denver Museum of Nature and Science")
  end

  def test_museum_exists
    assert_instance_of Museum, @museum
  end

  def test_museum_has_name
    assert_equal "Denver Museum of Nature and Science", @museum.name
  end

  def test_museum_has_no_exhibits_to_start
    assert_equal [], @museum.exhibits
  end

  def test_museum_can_have_one_exhibit
    @museum.add_exhibit("The Industrial Revolution", 20)
    assert_equal [{"The Industrial Revolution"=>20}], @museum.exhibits
  end

  def test_museum_can_have_multiple_exhibits
    @museum.add_exhibit("The Industrial Revolution", 20)
    @museum.add_exhibit("Gems and Minerals", 0)
    @museum.add_exhibit("Impressionist Paintings", 30)
    expected = [
      {"The Industrial Reovlution"=>20},
      {"Gems and Minerals"=>0},
      {"Impressionist Paintings"=>30}
    ]
    assert_equal expected, @museum.exhibits
  end

  def test_museum_exhibits_have_correct_cost
    @museum.add_exhibit("The Industrial Revolution", 20)
    @museum.add_exhibit("Gems and Minerals", 0)
    assert_equal 20, @museum.exhibits[0]["The Industrial Revolution"]
    assert_equal 20, @museum.exhibits[1]["Gems and Minerals"]
  end
end