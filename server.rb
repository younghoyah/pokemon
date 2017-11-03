require 'sinatra'
require 'csv'
require 'pry'

get '/' do

  redirect '/pokedex'
end

# @pokemon instance vairable to be able to use it in the index.erb file.
# CSV.read allows us to read the CSV file.  the CSV file returns array of arrays.
get '/pokedex' do
  @pokemons = CSV.read('pokemon.csv', headers: true)
# binding.pry
  erb :index
end

# params must match 'name' from ERB file.
#params is returning a hash, must be in quotes because its matching name
post '/pokedex' do
  new_pokemon = params["pokemon"]
  # this if statement will not post empty strings.  .strip takes away blank spaces 
  if new_pokemon.strip != ""
# with a method, must be in () if youre putting something into it
# new_pokemon is in an array because of CSV file
    CSV.open('pokemon.csv', 'a') do |csv_file|
      csv_file.puts([new_pokemon])
    end
  end
 redirect '/pokedex'
end
