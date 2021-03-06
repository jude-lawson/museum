class Museum
  attr_reader :name,
              :exhibits,
              :revenue

  def initialize(name)
    @name = name
    @exhibits = {}
    @revenue = 0
  end

  def add_exhibit(name, cost)
    @exhibits[name] = {cost: cost, patrons: []}
  end

  def admit(patron)
    @revenue += 10
    patron.interests.each do |interest|
      if @exhibits.include?(interest)
        @revenue += @exhibits[interest][:cost]
        add_patron_of_exhibit(patron, interest)
      end
    end
  end

  def add_patron_of_exhibit(patron, interest)
    @exhibits[interest][:patrons] << patron.name
  end 

  def patrons_of(exhibit)
    @exhibits[exhibit][:patrons]
  end

  def exhibits_by_attendees
    exhibits_sorted_by_number_of_patrons = @exhibits.sort_by do |exhibit|
      @exhibits[exhibit[0]][:patrons].length
    end.reverse
    exhibits_sorted_by_number_of_patrons.map do |exhibit_set|
      exhibit_set[0]
    end
  end

end