require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'sinatra/reloader'

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
  @contexts = Context.all
  @tasks = Task.all
  erb :index
end

post '/' do
  # @words = #select x number of words ordered by desc count
  # context = categorize(params[:body], @words)
  @task = Task.create(params[:todo])
  @tasks = Task.all
  @contexts = Context.all
  erb :index
end

post '/:id' do
  @task=Task.find_by(id: params[:id])
  @task.update(context_id: params[:categories])

  redirect '/'
end
