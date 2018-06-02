require_relative("./bar.rb")
require_relative("./club.rb")
require_relative("./drinks.rb")
require_relative("./guest.rb")
require_relative("./room.rb")
require_relative("./song.rb")
require("pry")

def setup

  @beers = Drinks.new("Beer", 4.0)
  drinks = {@beers => 50}
  @bar1 = Bar.new("Rock Bar", drinks)
  @bar2 = Bar.new("80s Bar", drinks)
  @bar3 = Bar.new("Hell Bar", drinks)
  @bar4 = Bar.new("Lounge Bar", drinks)
  @room1 = Room.new("Rock", 5, @bar1)
  @room2 = Room.new("80s", 5, @bar2)
  @room3 = Room.new("Tunes from hell", 5, @bar3)
  @lounge = Room.new("Lounge", 50, @bar4)
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
  @song42 = Song.new("Set you free - N-trance")
  @hell = [@song9, @song10, @song11, @song12]
  @allsongs = @rock + @eighties + @hell
  @number = [0,0,0,0,3,3,3,5,5,11,1,1,2,2,1,-1]
  @room1.add_playlist(@rock)
  @room2.add_playlist(@eighties)
  @room3.add_playlist(@hell)
  @lounge.add_playlist([@song42])
  @rooms = [@room1, @room2, @room3]
  @ccc = Club.new(@rooms, 5.00)
  @guest1 = Guest.new("Marti Pellow", 100.00)
  @guest2 = Guest.new("Dave", 35.00)
  @guest3 = Guest.new("Donatello", 50.00)
  @guest4 = Guest.new("Gordon", 40.00)
  @guest5 = Guest.new("Shirley", 40.00)
  @guest6 = Guest.new("Sonia", 40.00)
  @guest7 = Guest.new("Mike", 75.00)
  @guest8 = Guest.new("A rabid dog", 30.00)
  @guest9 = Guest.new("A haunted suit of armour", 35.00)
  @guest10 = Guest.new("Slimer", 50.00)
  @guest11 = Guest.new("A sentient microwave", 40.00)
  @guest12 = Guest.new("A swarm of wasps", 50.00)
  @guest13 = Guest.new("Sub-Zero", 1000.00)
  @guest14 = Guest.new("The Eye of Sauron", 666.00)

  @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5,@guest6,@guest7,@guest8,@guest9,@guest10,@guest11,@guest12,@guest13,@guest14])
  @ccc.guests.each do |guest|
    guest.overwrite_favourite_song(@allsongs.shuffle.pop())
    guest.drinks_drank = @number.shuffle.pop()

  end
  @lounge.check_in_multi_guests(@ccc.guests())



  @count = 0

end

def instructions
  p "[------CCC controller------------------]"
  p "Press return to move time forward by twenty minutes."
  p "Other commands:"
  p "'a' shows favourite songs"
  p "'b' shows how much beer everyone has had"
  p " 's' shuffles favourite songs"
  p " and you can hit 'q' to quit"

end

def twenty_minutes_later
  print %x{clear}
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
      room = @ccc.what_room(guest)
      if room != @lounge && !room.is_a?(Array)
        room.check_out_one_guest(guest)
        @lounge.check_in_one_guest(guest)
      end

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


def shuffle
  @ccc.guests.each do |guest|
    guest.overwrite_favourite_song(@allsongs.shuffle.pop())
  end
end

# def chaos
#     bad_guys = [@guest8,@guest9,@guest10,@guest11,@guest12,@guest13,@guest14]
#     bad_guys.each do |bad_guy|
#       bad_guy.overwrite_favourite_song(@allsongs.shuffle.pop())
#     end
#     @ccc.arriving_group([@guest8,@guest9,@guest10,@guest11,@guest12,@guest13,@guest14])
# end








puts "Welcome to CC Caraoke! type 'y' to begin or anything else to quit. The fun ends when there are no guests left!"
input = gets.chomp().downcase()
  return if  input != "y"
  puts "creating club"
  setup()

  until @ccc.guests == []

    # p "#{@instructions}"
    instructions
    input = gets.chomp().downcase()

    twenty_minutes_later

    case input
    when "q" then break
    when "s" then shuffle
    when "c" then chaos
    when "a" then @ccc.guests.each { |guest| p "#{guest.name()} is here and they want to hear #{guest.favourite_song.title_and_artist}"}
    when "b" then @ccc.guests.each { |guest| p "#{guest.name()} has had #{guest.drinks_drank()} beers" }
    end
  end




#@rooms.each do |room|
#      room.guests.each {|guest| p "#{guest.name()} is in the #{room.name()} room" }
#      end
