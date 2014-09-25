class Task < ActiveRecord::Base
  belongs_to :context
  belongs_to :project
  attr_accessor :vector

  def vector
    @vector = vectorize
  end

  def vectorize(string, word_array)
    elements = arrayify(string)
    vector = word_array.map do |word|
      elements.include?(word) ? 1 : 0
    end
  end

  def arrayify(string)
    string.downcase.split(' ').uniq
  end

  def dist_to(point)
    zipped_array = vector.zip(point)
    dimensional_array = zipped_array.map { |x| (x[1] - x[0])**2}
    sum = dimensional_array.reduce(:+)
    Math.sqrt(sum)
  end
end
