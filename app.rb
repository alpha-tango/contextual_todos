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
  @words = build_comparison(@tasks)

  d = @words.length

  k = n/3  #this will give us one cluster for every three tasks
  #I am too lazy to do this properly using BIC or whatever.

  kmeans(@tasks, k, d) #this returns clusters

  #this repeats the code in the the kmeans method - so it should be refactored
  min_dist = +INFINITY
  min_cluster = cluster

  #Find the closest cluster
  clusters.each do |cluster|
    dist = @task.vector.dist_to(cluster.center)

    if dist < min_dist
      min_dist = dist
      min_cluster = cluster
    end
  end

  @task.context = min_cluster.find_context

  @task.save!
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

def build_comparison(task_array)
  words = []
    task_array.each do |task|
      words << task.arrayify(task.body)
    end
  words.flatten
end

#data must be an array of task objects

def kmeans(data, k, d, delta=0.001)
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
  while true
    #Assign task vectors to clusters
    data.each do |task|
      min_dist = +INFINITY
      min_cluster = nil

      #Find the closest cluster
      clusters.each do |cluster|
        dist = task.vector.dist_to(cluster.center)

        if dist < min_dist
          min_dist = dist
          min_cluster = cluster
        end
      end

      #Add task to closest cluster
      min_cluster.tasks.push task
    end

    #check deltas
    max_delta = -INFINITY

    clusters.each do |cluster|
      dist_moved = cluster.recenter!

      #get the largest delta
      if dist_moved > max_delta
        max_delta = dist_moved
      end
    end

    #check exit condition
    if max_delta < delta
      return clusters
    end

    #reset points for the next iteration
    clusters.each do |cluster|
      cluster.tasks = []
    end
  end
end
