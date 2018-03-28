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
    @exhibits[name] = {cost: cost}
  end

  def admit(patron)
    @revenue += 10
    patron.interests.each do |interest|
      if @exhibits.include?(interest)
        @revenue += @exhibits[interest][:cost]
      end
    end
  end

  def add_patron_of_exhibit

  end 

end