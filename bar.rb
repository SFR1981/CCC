class Bar

attr_reader :name, :drinks, :till

  def initialize(name, drinks)
    @name = name
    @drinks = drinks
    @till = 0
  end

  def sells_drink(guest, drink)

    @drinks[drink] -= 1
    guest.spend(drink.cost())
    guest.drinks_drank += 1
    @till += drink.cost()

  end







end
