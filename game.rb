require 'sinatra'

# before we process a route, we'll set the response as
# plain text and setup an array of viable moves that
# a player (and a computer) can perform
before do
	content_type :txt
	@defeat = {rock: :scissors, paper: :rock, scissors: :paper}
	@throws = @defeat.keys
end

get '/throw/:type' do
	# get params[] hash stores querystring and form data.
	player_throw = params[:type].to_sym

	# in the case of a player providing a throw that is not valid,
	# we halt with a status code of 403 (Forbidden) and let them
	# and let them know they need to make a valid throw
	if !@throws.include?(player_throw)
		halt 403, "You must throw one of the following #{@throws}"
	end

	# now we can select a random throw for the computer
	computer_throw = @throws.sample

	# compare the player and the computer throws to determine the winner
	if player_throw == computer_throw
		"You tied, try it again!"
	elsif computer_throw == @defeat[player_throw]
		"Cool, you won! #{player_throw} beats #{computer_throw}!"
	else
		"Nah, #{computer_throw} beats #{player_throw} Play again brah."
	end
end
