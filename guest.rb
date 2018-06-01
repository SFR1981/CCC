class Guest

  attr_reader(:name, :wallet)

  def initialize(name, wallet)

    @name = name
    @wallet = wallet

  end


  def spend(amount)

    @wallet -= amount
    
  end

end
