class Museum
  attr_reader :name,
              :exhibits,
              :revenue

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(name, cost)
    @exhibits << {name=>cost}
  end

  def admit(patron)
  end

end