
require 'sinatra'
require 'csv'
require 'pry'

set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'

def build_teams
  teams = {}

  CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
    if !teams[row[3]].is_a?(Array)
      teams[row[3]] = []
    end
    teams[row[3]] << { first_name: row[0], last_name: row[1], position: row[2] }
  end
  teams
end

teams_hash = build_teams

get '/' do
  @team_names = teams_hash.keys
  erb :index
end

get '/simpson_slammers' do
  @team = teams_hash['Simpson Slammers']
  erb :simpson_slammers
end

get '/jetson_jets' do
  @team = teams_hash['Jetson Jets']
  erb :jetson_jets
end

get '/flinestone_fire' do
  @team = teams_hash['Flinestone Fire']
  erb :flinestone_fire
end

get '/griffin_goats' do
  @team = teams_hash['Griffin Goats']
  erb :griffin_goats
end


