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


def vectorize(string, word_array)
  string_elements = string.downcase.split(' ').uniq
  vector = word_array.map do |word|
    string_elements.include?(word) ? 1 : 0
  end
end

@vectors = []

strings.each do |string|
  @vectors << vectorize(string, @words)
end

d = @words.length
n = strings.length
K = n/2

@cluster_centers = []

K.times do
  cluster_center = []
  d.times do
    cluster_center << rand()
  end
  @cluster_centers << cluster_center
end

@vectors_with_knn = {}

@vectors.each do |vector|
  distances = {}
  @cluster_centers.each_with_index do |center, i|
    dist = vector.zip(center)
    this = dist.map {|x| (x[1] - x[0])**2}.reduce(:+)
    distances[i] = Math.sqrt(this)
  end
  sorted_distances = distances.sort_by {|key, value| value }
  @vectors_with_knn[vector] = sorted_distances.first.first
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
