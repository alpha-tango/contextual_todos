require 'sinatra'
require 'sinatra/activerecord'

###################
# Configuration
###################

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
end

#####################
# Routing/Rendering
#####################

get '/' do
  @title = "Hello World"
  erb :index
end

post '/' do

  # @words = #select x number of words ordered by desc count
  # context = categorize(params[:body], @words)
  # @task = Task.new() #body: params[:body]  etc
  # @tasks = Task.all
end

#####################
# Methods
#####################
