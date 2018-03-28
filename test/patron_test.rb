require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'

class PatronTest < MiniTest::Test
  def setup
    @patron = Patron.new("Bob")
  end

  def test_patron_exists
    assert_instance_of Patron, @patron
  end

  def test_patron_has_name
    assert_equal "Bob", @patron.name
  end

  def test_patron_starts_without_interests
    assert_equal [], @patron.interests
  end

  def test_patron_can_have_one_interest
    @patron.add_interest("Dead Sea Scrolls")
    assert_equal %w[Dead\ Sea\ Scrolls], @patron.interests
  end

  def test_patron_can_have_multiple_interests
    @patron.add_interes("Dead Sea Scrolls")
    @patron.add_interes("Gems and Minerals")
    @patron.add_interes("The Industrial Revolution")
    expected = ["Dead Sea Scrolls", "Gems and Minerals", "The Industrial Revolution"]
    assert_equal expected, @patron.interests
  end
end
