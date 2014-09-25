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
  @tasks = Task.all
  @contexts = Context.all
  @words = []
    @tasks.each do |task|
      @words << task.arrayify(task.body)
    end
  @words = @words.flatten

  d = @words.length
  n = @tasks.length
  K = n/2

  @cluster_centers = create_neighbors(K, d)
  @tasks_with_knn = {}

  15.times do
    @tasks.each do |task|
      distances = {}
      @cluster_centers.each_with_index do |center, i|
        vector = task.vectorize(task.body, @words)
        distances[i] = euclidean_distance(vector, center)
      end
      @tasks_with_knn[task] = @cluster_centers[least_value_key(distances)]
    end

    @knns_with_tasks = {}
    @tasks_with_knn.each do |task,knn|
      @knns_with_tasks[knn] = []
    end

    @tasks_with_knn.each do |task,knn|
      @knns_with_tasks[knn] << task
    end

    @knns_with_tasks.each do |knn, assoc|
      n = assoc.length
      if n > 1
        start = assoc.pop.vectorize(assoc.pop.body, @words)
        vectors = []
        assoc.each do |task|
          vectors << task.vectorize(task.body, @words)
        end
        sum = start.zip(*vectors)
        avg = sum.map do |x|
          x.reduce(:+).to_f / n
        end
        i = @cluster_centers.index(knn)
          @cluster_centers[i] = avg
      else
        i = @cluster_centers.index(knn)
        @cluster_centers[i] = assoc.pop[:vector]
      end
    end
  end

  @task = Task.create(params[:todo])
  erb :index
end

post '/:id' do
  @task=Task.find_by(id: params[:id])
  @task.update(context_id: params[:categories])

  redirect '/'
end


################
# METHODS
################

def arrayify(string)
  string.downcase.split(' ').uniq
end

def vectorize(string, word_array)
  elements = arrayify(string)
  vector = word_array.map do |word|
    elements.include?(word) ? 1 : 0
  end
end

def create_neighbors (k, d)
  neighbors = []

  K.times do
    random_neighbor = []
    d.times do
      random_neighbor << rand()
    end
    neighbors << random_neighbor
  end
  neighbors
end

def euclidean_distance(array, same_length_array)
  zipped_array = array.zip(same_length_array)
  dimensional_array = zipped_array.map { |x| (x[1] - x[0])**2}
  sum = dimensional_array.reduce(:+)
  Math.sqrt(sum)
end

def least_value_key(an_hash)
  sorted_array = an_hash.sort_by { |key, value| value}
  sorted_array.first.first
end
