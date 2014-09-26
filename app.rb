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
  @task = Task.new(params[:todo])
  @tasks = Task.all
  @contexts = Context.all
  words = Word.all
  @words = []
  words.each do |x|
    @words << x.element
  end

  d = @words.length
  k = @tasks.length/3  #this will give us one cluster for every three tasks
  #I am too lazy to do this properly using BIC or whatever.
  neighbors = kmeans(@tasks, k, d) #this returns clusters

  min_dist = 100
  min_cluster = nil

  #Find the closest cluster
  neighbors.each do |neighbor|
    dist = dist_to(@task.vector(@words), neighbor.center)

    if dist < min_dist
      min_dist = dist
      min_cluster = neighbor
    end
  end

  @task.context_id = min_cluster.find_context

  @task.save!
  erb :index
end

post '/:id' do
  binding.pry
  @task=Task.find_by(id: params[:id])
  @task.update(context_id: params[:categories])

  redirect '/'
end


################
# METHODS
################

def dist_to(some, point)
  zipped_array = some.zip(point)
  dimensional_array = zipped_array.map { |x| (x[1] - x[0])**2}
  sum = dimensional_array.reduce(:+)
  Math.sqrt(sum)
end

def kmeans(data, k, d, delta=0.01)
  clusters = []

  #Assign initial values for cluster points
  k.times do
    random_point = []
    d.times do
      random_point << rand()
    end
      cluster = Cluster.new(random_point)
    clusters << cluster
  end

  #Reassign each cluster to average of its closest points until no changes
  i = 0
  while i < 5
    #Assign task vectors to clusters
    data.each do |task|
      min_dist = 100
      min_cluster = nil
      #Find the closest cluster
      clusters.each do |z|
        dist = dist_to(task.vector(@words), z.center)

        if dist < min_dist
          min_dist = dist
          min_cluster = z
        end
      end

      #Add task to closest cluster
      min_cluster.tasks.push task
    end

    # #check deltas
    # max_delta = -100
    #
    # clusters.each do |cluster|
    #   dist_moved = cluster.recenter!
    #
    #   #get the largest delta
    #   if dist_moved > max_delta
    #     max_delta = dist_moved
    #   end
    # end

    # #check exit condition
    # if max_delta < delta
    #   return clusters
    # end

    if i == 4
      return clusters
    end

    #reset points for the next iteration
    clusters.each do |y|
      y.tasks = []
    end
    i += 1
  end
end
