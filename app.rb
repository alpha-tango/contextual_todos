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

def kmeans(data, k, delta=0.001)
  clusters = []

  k.times do
    random_point = []
    d.times do
      random_point << rand()
    end
      cluster = Cluster.new(random_point)
    clusters << cluster
  end

  while true
    data.each do |point|
      min_dist = +INFINITY
      min_cluster = cluster

      clusters.each do |cluster|
        dist = point.dist_to(cluster.center)

        if dist < min_dist
          min_dist = dist
          min_cluster = cluster
        end
      end

      min_cluster.points.push point
    end

    max_delta = -INFINITY

    clusters.each do |cluster|
      dist_moved = cluster.recenter!

      if dist_moved > max_delta
        max_delta = dist_moved
      end
    end

    if max_delta < delta
      return clusters
    end

    clusters.each do |cluster|
      cluster.point = []
    end
  end
end
