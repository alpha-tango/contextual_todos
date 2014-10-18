class Task < ActiveRecord::Base
  belongs_to :context
  belongs_to :project
  default_scope { order('created_at DESC') }
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

  def update_complete(checked)
    if checked == 'checked'
      self.update(complete: true)
    else
      self.update(complete: false)
    end
  end
end
