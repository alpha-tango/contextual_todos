require 'pry'

sample = "Call mom about package arrival"

strings = [
            "Call mom about package arrival",
            "Send Rory email",
            "Schedule groceries delivery",
            "Research Javascript",
            "Buy bday present for Melly",
            "Find Maureen's card"
          ]
@words = ["call", "mom", "buy", "groceries", "schedule", "research", "find", "melly"]


def arrayify(string)
  string.downcase.split(' ').uniq
end

def vectorize(string, word_array)
  arrayify(string)
  vector = word_array.map do |word|
    string_elements.include?(word) ? 1 : 0
  end
end

def create_neighbors (K, d)
  neighbors = []

  K.times do
    random_neighbor = []
    d.times do
      random_neighbor << rand()
    end
    neighbors << random_neighbor
end

def euclidean_distance(array, same_length_array)
  zipped_array = array.zip(same_length_array)
  dimensional_array = zipped_array.map { |x| (x[1] - x[0])**2}
  sum = dimensional_array.reduce(:+)
  Math.sqrt(sum)
end

def least_value_key(hash)
  sorted_array = array.sort_by { |key, value| value}
  sorted_array.first.first
end

d = @words.length
n = strings.length
K = n/2

@vectors = []

strings.each do |string|
  @vectors << vectorize(string, @words)
end

d = @words.length
n = strings.length
K = n/2

@cluster_centers = create_neighbors(K, d)
@vectors_with_knn = {}
@vectors.each do |vector|
  distances = {}
  @cluster_centers.each_with_index do |center, i|
    distances[i] = euclidean_distance(vector, center)
  end
  @vectors_with_knn[vector] = least_value_key(distances)
  #this is problematic because if have two of same vector will overwrite
end

@knns_with_vectors = {}
@vectors_with_knn.each do |vector,knn|
  @knns_with_vectors[knn] = []
end

@vectors_with_knn.each do |vector,knn|
  @knns_with_vectors[knn] << vector
end

@knns_with_vectors.each do |knn, vectors|
  n = vectors.length
  if n > 1
    start = vectors.pop
    sum = start.zip(*vectors)

    avg = sum.map do |x|
      x.reduce(:+).to_f / n
    end

    @cluster_centers[knn] = avg
  else
    @cluster_centers[knn] = vectors
  end
end

binding.pry
#
#   @vectors.each do |vector|
#     #recursion until there are no more changes
#   end
