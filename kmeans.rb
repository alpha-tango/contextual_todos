require 'pry'

task = "Call mom about package arrival"

tasks = [
            {body: "Call mom about package arrival", context: 1},
            {body:"Send Rory email", context: 2},
            {body: "Schedule groceries delivery", context: 2},
            {body: "Research Javascript", context: 2},
            {body: "Buy bday present for Melly", context: 3},
            {body: "Find Maureen's card", context: 4}
          ]
@words = ["call", "mom", "buy", "groceries", "schedule", "research", "find", "melly"]

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

#####################
# Stuff
###################

d = @words.length
n = tasks.length
K = n/2

tasks.each do |task|
  task[:vector] = vectorize(task[:body], @words)
end

@cluster_centers = create_neighbors(K, d)
@tasks_with_knn = {}

tasks.each do |task|
  distances = {}
  @cluster_centers.each_with_index do |center, i|
    distances[i] = euclidean_distance(task[:vector], center)
  end
  @tasks_with_knn[task] = @cluster_centers[least_value_key(distances)]
end

#stopped here with refactoring!

@knns_with_tasks = {}
@tasks_with_knn.each do |task,knn|
  @knns_with_tasks[knn] = []
end

@tasks_with_knn.each do |task,knn|
  @knns_with_tasks[knn] << task
end

@knns_with_tasks.each do |knn, assoc|
  n = assoc.length
  # THIS IS NOW BROKEN
  # if n > 1
  #   assoc.each do |task|
  #   start = vectors.pop
  #   sum = start.zip(*vectors)
  #
  #   avg = sum.map do |x|
  #     x.reduce(:+).to_f / n
  #   end

    # @cluster_centers[knn] = avg
  else
    # @cluster_centers[knn] = vectors
  end
end

binding.pry
#
#   @vectors.each do |vector|
#     #recursion until there are no more changes
#   end
