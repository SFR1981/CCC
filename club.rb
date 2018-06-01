class Club

attr_reader :rooms, :cost, :guests, :till

  def initialize(rooms, cost)
    @rooms = rooms
    @cost = cost
    @guests = []
    @till = 0
    @capacity = 50



  end

  def arriving_customer(guest)
    return if @guests.length() == @capacity
    return if guest.wallet() < @cost
    @till += @cost
    guest.spend(@cost)
    @guests << guest


  end

  def arriving_group(multiple_guests)
    multiple_guests.each do |guest|
      if guest.wallet() >= @cost
        @guests << guest if @guests.length() < @capacity
        guest.spend(@cost)
        @till += @cost
      end
    end



  end

  def leaving_guest(guest)

      removal = [guest]
      @guests -= removal

  end

  def leaving_group(guests)
    removal = guests
    @guests -= removal
  end




end
