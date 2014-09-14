class Task < ActiveRecord::Base
  belongs_to :context
  belongs_to :project

  def arrayify
    body.downcase.split(' ').uniq
  end

  def vectorize(word_array)
    elements = arrayify
    vector = word_array.map do |word|
      elements.include?(word) ? 1 : 0
    end
  end

end
