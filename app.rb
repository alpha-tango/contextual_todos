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
  @words = #select x number of words ordered by desc count
  context = categorize(params[:body], @words)
  @task = Task.new() #body: params[:body]  etc
  @tasks = Task.all
end

#####################
# Methods
#####################

def categorize(string, word_array)
  target = map_to_vector(string)
  find_best_knn(target, word_array)
  #return context
end

def map_to_vector(string, word_array)
  string_elements = string.split(' ').uniq

  vector = word_array.map do |word|
    string_elements.include?(word) ? 1 : 0
  end
end

def find_best_knn(target_vector, word_array)
  nns = find_existing_knns(word_array, @tasks) #this can't just appear there
  #find distance of each
  #least distance is best knn
end

def find_existing_knns(word_array, tasks)
  @vectors = tasks.map do |task|
    word_array.map do |word|
      task.body.include?(word) ? 1 : 0
    end
  end
  #this should return an array of task.length vectors, each with length word_array.length
  d = word_array.length
  K = #some constant <= n

  K.times do
    cluster_center = []
    d.times do
      cluster_center << rand()
    end
    @cluster_centers << cluster_center
  end

  @vectors.each do |vector|
    #find closest cluster center
    #assign vector to that cluster center
    #average all the vectors associated with that cluster center
    #assign the average as the new cluster center
    #recursion until there are no more changes
  end
