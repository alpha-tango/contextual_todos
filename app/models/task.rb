class Task < ActiveRecord::Base
  belongs_to :context
  belongs_to :project
  attr_accessor :vector

  def vector(words)
    @vector = vectorize(words)
  end

  def vectorize(words)
    elements = arrayify(body)
    vector = words.map do |w|
      elements.include?(w) ? 1 : 0
    end
  end

  def arrayify(string)
    string.downcase.split(' ').uniq
  end
end
