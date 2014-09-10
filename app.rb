require 'pg'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

configure do
  set :views, 'app/views' #changes location of views directory
end

#this part requires all the files, instead of requiring relative each

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file  #this is a sinatra reloader thing
end

get '/' do
  @categories = Todo.categories
  @todos = Todo.all

  erb :index
end

post '/todos' do
  params[:todo]['category'] = categorize(params[:todo])
  todo = Todo.create(params[:todo])
  redirect '/'
end

def categorize (todo)
  do_verb = todo[:body].split.first.downcase
  do_text = todo[:body].downcase

  verbs = {
    "call" => "phone calls",
    "order" => "online",
    "read" => "reading or offline",
    "cook" => "home",
    "clean" => "home",
    "draft" => "reading or offline",
    "write" => "online",
    "look up" => "online",
    "research" => "online",
    "return" => "errands",
    "buy" => "errands",
    "learn" => "online",
    "mail" => "errands",
    "email" => "online",
    "e-mail" => "online",
    "watch" => "online",
    "drop off" => "errands"
  }

  words = {
    "systems check" => "Launch",
    "comet" => "Launch",
    "challenge" => "Launch",
    "breakable toy" => "Launch"
  }

  # word_cat = ""
  #   words.each do |hash|
  #     if do_text.include?(hash[0])
  #       word_cat<<hash[1]
  #     end
  #   end

  # binding.pry
  verb_cat = verbs[do_verb]

  verb_cat || word_cat
end
