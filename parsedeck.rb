#!/usr/bin/ruby
# Define global variables
Dir.chdir(File.dirname(__FILE__))
mainDeck=Hash.new
sideBoard=Hash.new
file=ARGV.first
decks=0
# Read the file from the path in ARGV
File.open(file, "r") do |infile|
	while (line = infile.gets)
		if line.chomp == "Deck" #Decklists in the input file should start with the word Deck on its own line
			decks=decks + 1 #Increment our count
			s=15		#Sets the sideboard counter to 15 until a blank line is parsed
		elsif line == "\r\n"	
			s=0		#Sets the sideboard counter to 0 after a blank line is parsed
		else
			if s < 15 #If the sideboard counter is less than 15, cards are read into the sideBoard hash
				number=line.split(" ",2)[0].to_i
				card=line.split(" ",2)[1].chomp
				if sideBoard[card].nil? == false
					sideBoard[card] = sideBoard[card] + number
					s = s + number
				else
					sideBoard[card] = number
					s = s + number
				end
			else	# If the sideboard is full, we're reading into the mainDeck hash
				number=line.split(" ",2)[0].to_i
				card=line.split(" ",2)[1].chomp
				if mainDeck[card].nil? == false
					mainDeck[card] = mainDeck[card] + number
				else
					mainDeck[card] = number
				end
			end
		end
	end
end
# For each card in the hash, round to the nearest integer as long as more than 2/3 of decks include a single copy
mainDeck.each do |value, key|
	if key.to_f/decks.to_f > 0.5
		puts (key.to_f/decks.to_f).round.to_s + " " + value.to_s
	end
end
puts #Outputs a blank line, for prettiness.
sideBoard.each do |value, key|
	if key.to_f/decks.to_f > 0.5
		puts (key.to_f/decks.to_f).round.to_s + " " + value.to_s
	end
end
