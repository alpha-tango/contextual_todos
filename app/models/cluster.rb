class Cluster
  attr_accessor :center, :tasks, :context

  def initialize(center)
    @center = center
    #points is an array of tasks, which maybe means line 15 needs rewriting
    @tasks = []
    @context_id = nil
  end

  def find_context
    counts = {}

    @tasks.each do |task|
      counts[task.context_id] += 1
    end

    counts.select { |id, count| count == counts.values.max}.keys

  end

  def vectors
    vectors = []
    tasks.each do |task|
      vectors << task.vector
    end
  end

  def recenter!
    old_center = center
    #@ center = some array of 0 points

    sum = vectors.each do |vector|
      vector.each_with_index do |coord, i|
        center[i] += coord
      end
    end

    average = sum.each do |coord|
      coord / vectors.length
    end

    center = average
    old_center.dist_to(center)
  end
