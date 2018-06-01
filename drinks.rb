class Drinks

attr_reader(:name, :cost)
  def initialize(name, cost)

    @name = name
    @cost = cost

  end

  def return_cost
    return @cost
  end




end
