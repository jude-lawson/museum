require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'
require './lib/patron'

class MuseumTest < MiniTest::Test
  def setup
    @museum = Museum.new("Denver Museum of Nature and Science")
    @bob = Patron.new("Bob")
    @sally = Patron.new("Sally")
    @jack = Patron.new("Jack")
  end

  def test_museum_exists
    assert_instance_of Museum, @museum
  end

  def test_museum_has_name
    assert_equal "Denver Museum of Nature and Science", @museum.name
  end

  def test_museum_has_no_exhibits_to_start
    assert_equal ({}), @museum.exhibits
  end

  def test_museum_can_have_one_exhibit
    @museum.add_exhibit("The Industrial Revolution", 20)
    assert_equal ["The Industrial Revolution"], @museum.exhibits.keys
  end

  def test_museum_can_have_multiple_exhibits
    @museum.add_exhibit("The Industrial Revolution", 20)
    @museum.add_exhibit("Gems and Minerals", 0)
    @museum.add_exhibit("Impressionist Paintings", 30)
    expected = [
      "The Industrial Revolution",
      "Gems and Minerals",
      "Impressionist Paintings"
    ]
    assert_equal expected, @museum.exhibits.keys
  end

  def test_museum_exhibits_have_correct_cost
    @museum.add_exhibit("The Industrial Revolution", 20)
    @museum.add_exhibit("Gems and Minerals", 0)
    assert_equal 20, @museum.exhibits["The Industrial Revolution"][:cost]
    assert_equal 0, @museum.exhibits["Gems and Minerals"][:cost]
  end

  def test_starting_revenu_is_zero
    assert_equal 0, @museum.revenue
  end

  def test_revenue_with_one_admittance_and_no_included_interest
    @bob.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    assert_equal 10, @museum.revenue
  end

  def test_revenue_with_one_admittance_and_one_included_interest
    @museum.add_exhibit("The Industrial Revolution", 20)
    @bob.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    assert_equal 30, @museum.revenue
  end

  def test_revenue_with_three_admittances_and_no_included_interests
    @bob.add_interest("The Industrial Revolution")
    @sally.add_interest("Gems and Minerals")
    @jack.add_interest("Impressionist Paintings")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    assert_equal 30, @museum.revenue
  end

  def test_revenue_with_three_admittances_and_one_included_interest_each
    @museum.add_exhibit("Gems and Minerals", 0)
    @museum.add_exhibit("The Industrial Revolution", 20)
    @museum.add_exhibit("Impressionist Paintings", 30)
    @sally.add_interest("Gems and Minerals")
    @jack.add_interest("Impressionist Paintings")
    @bob.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    assert_equal 80, @museum.revenue
  end

  def test_revenue_with_three_admittances_and_two_same_included_interests
    @museum.add_exhibit("The Industrial Revolution", 10)
    @museum.add_exhibit("Impressionist Paintings", 65)
    @sally.add_interest("Impressionist Paintings")
    @jack.add_interest("Impressionist Paintings")
    @bob.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    assert_equal 170, @museum.revenue
  end

  def test_revenue_with_three_admittances_and_varied_interests_one_without_interest
    @museum.add_exhibit("The Industrial Revolution", 10)
    @museum.add_exhibit("Impressionist Paintings", 65)
    @sally.add_interest("Gems and Minerals")
    @jack.add_interest("Impressionist Paintings")
    @bob.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    assert_equal 105, @museum.revenue
  end

  def test_patrons_of_exhibit_with_one_patron
    @museum.add_exhibit("The Industrial Revolution", 20)
    @bob.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    assert_equal ["Bob"], @museum.patrons_of("The Industrial Revolution")
  end

  def test_patrons_of_exhibit_with_multiple_patrons
    @museum.add_exhibit("The Industrial Revolution", 20)
    @bob.add_interest("The Industrial Revolution")
    @sally.add_interest("The Industrial Revolution")
    @jack.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    assert_equal ["Bob", "Sally", "Jack"], @museum.patrons_of("The Industrial Revolution")
  end

  def test_patrons_of_exhibit_does_not_add_patron_without_interest
    @museum.add_exhibit("The Industrial Revolution", 20)
    @museum.add_exhibit("Impressionist Paintings", 30)
    @bob.add_interest("The Industrial Revolution")
    @sally.add_interest("The Industrial Revolution")
    @jack.add_interest("Impressionist Paintings")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    assert_equal ["Bob", "Sally"], @museum.patrons_of("The Industrial Revolution")
    assert_equal ["Jack"], @museum.patrons_of("Impressionist Paintings")
  end

  def test_sorted_exhibits_with_only_one_exhibit
    @museum.add_exhibit("The Industrial Revolution", 20)
    @bob.add_interest("The Industrial Revolution")
    @museum.admit(@bob)
    assert_equal ["The Industrial Revolution"], @museum.exhibits_by_attendees
  end

  def test_sorted_exhibits_with_only_one_attendee_each
    @museum.add_exhibit("The Industrial Revolution", 20)
    @museum.add_exhibit("Impressionist Paintings", 30)
    @museum.add_exhibit("Gems and Minerals", 0)
    @bob.add_interest("The Industrial Revolution")
    @sally.add_interest("Gems and Minerals")
    @jack.add_interest("Impressionist Paintings")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    expected = ["The Industrial Revolution", "Impressionist Paintings", "Gems and Minerals"]
    assert_equal expected, @museum.exhibits_by_attendees
  end

  def test_sorted_exhibits_returns_correct_array
    @museum.add_exhibit("Impressionist Paintings", 30)
    @museum.add_exhibit("The Industrial Revolution", 20)
    @bob.add_interest("The Industrial Revolution")
    @sally.add_interest("The Industrial Revolution")
    @jack.add_interest("Impressionist Paintings")
    @museum.admit(@bob)
    @museum.admit(@sally)
    @museum.admit(@jack)
    expected = ["The Industrial Revolutions", "Imapressionist Paintings"]
    assert_equal expected, @museum.exhibits_by_attendees
  end

end