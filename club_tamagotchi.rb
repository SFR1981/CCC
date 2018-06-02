require_relative("./bar.rb")
require_relative("./club.rb")
require_relative("./drinks.rb")
require_relative("./guest.rb")
require_relative("./room.rb")
require_relative("./song.rb")

def setup

  @beers = Drinks.new("Beer", 4.0)
  drinks = {@beers => 50}
  @bar1 = Bar.new("Rock Bar", drinks)
  @bar2 = Bar.new("80s Bar", drinks)
  @bar3 = Bar.new("Hell Bar", drinks)
  @room1 = Room.new("Rock", 5, @bar1)
  @room2 = Room.new("80s", 5, @bar2)
  @room3 = Room.new("Tunes from hell", 5, @bar3)
  @song1 = Song.new("Last Resort - Papa Roach")
  @song2 = Song.new("Real American - Rick Derringer")
  @song3 = Song.new("Voices - Disturbed")
  @song4 = Song.new("Demanufacture - Fear Factory")
  @rock = [@song1, @song2, @song3, @song4]
  @song5 = Song.new("China in your hand - T'Pau")
  @song6 = Song.new("Heaven is a place on Earth - Belinda Carlisle")
  @song7 = Song.new("I think we're alone now - Tiffany")
  @song8 = Song.new("A little respect - Erasure")
  @eighties = [@song5, @song6, @song7, @song8]
  @song9 = Song.new("I am the music man - Black lace")
  @song10 = Song.new("Bat out of hell - Meatloaf")
  @song11= Song.new("The time warp - O'Brien, Quinn, Campbell, Gray")
  @song12 = Song.new("Summer nights - John Travolta & Olivia Newton-John")
  @hell = [@song9, @song10, @song11, @song12]
  @allsongs = @rock + @eighties + @hell
  @room1.add_playlist(@rock)
  @room2.add_playlist(@eighties)
  @room3.add_playlist(@hell)
  @rooms = [@room1, @room2, @room3]
  @ccc = Club.new(@rooms, 5.00)
  @guest1 = Guest.new("Marti Pellow", 100.00)
  @guest2 = Guest.new("Dave", 25.00)
  @guest3 = Guest.new("Donatello", 50.00)
  @guest4 = Guest.new("Gordon", 20.00)
  @guest5 = Guest.new("Shirley", 20.00)
  @guest6 = Guest.new("Sonia", 20.00)
  @guest1.overwrite_favourite_song(@allsongs.shuffle.pop())
  @guest2.overwrite_favourite_song(@allsongs.shuffle.pop())
  @guest3.overwrite_favourite_song(@allsongs.shuffle.pop())
  @guest4.overwrite_favourite_song(@allsongs.shuffle.pop())
  @guest5.overwrite_favourite_song(@allsongs.shuffle.pop())
  @guest6.overwrite_favourite_song(@allsongs.shuffle.pop())
  @ccc.arriving_customer(@guest1)
  @room1.check_in_one_guest(@guest1)
  #@ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5,@guest6])


  @instructions = "Press 'a' to move time forward and see the guest's favourite songs. Press 'b' to move time forward and see how much beer everyone has had. Hit any other key just to move time forward. (hit 'q' to quit)"
  @count = 0

end



def twenty_minutes_later
  p "total revenue is currently #{@ccc.total_revenue()}"

  @ccc.guests.each { |guest| @ccc.leaving_guest(guest) if guest.wallet() < 4}

  if @count % 3 == 0
    for room in @rooms
      for guest in room.guests
        room.guests_visits_bar(guest,@beers)
        room.guest_wants_to_sing(guest)

      end
    end
  end

  if @count % 2 == 0
    @ccc.guests.each do |guest|
      @ccc.what_room(guest).check_out_one_guest(guest)
    end


    @ccc.guests.each do |guest|
      room = @rooms.shuffle.pop()
      room.check_in_one_guest(guest)
    end


  end

  @ccc.guests.each { |guest| p "#{guest.name()} has had #{guest.drinks_drank()} beers and is wasted. They will leave soon!" if guest.drinks_drank > 8 }


  @ccc.guests.each { |guest| @ccc.leaving_guest(guest) if guest.drinks_drank > 9 }

  @count += 1
end




puts "are you ready? type 'y' for yes or anything else to quit!"
input = gets.chomp().downcase()
  return if  input != "y"
  setup()
  puts "creating club"
  until @ccc.guests == []

    p "what should we do?"
    p "#{@instructions}"
    input = gets.chomp().downcase()

    twenty_minutes_later

    case input
    when "q" then break
    when "a" then @ccc.guests.each { |guest| p "#{guest.name()} is here and they want to hear #{guest.favourite_song.title_and_artist}"}
    when "b" then @ccc.guests.each { |guest| p "#{guest.name()} is here and they have had #{guest.drinks_drank()} beers" }
    end
  end




#@rooms.each do |room|
#      room.guests.each {|guest| p "#{guest.name()} is in the #{room.name()} room" }
#      end
