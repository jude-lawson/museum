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
    
  end

  def test_patron_starts_without_interests
  end

  def test_patron_can_have_one_interest
  end

  def test_patron_can_have_multiple_interests
  end
end
