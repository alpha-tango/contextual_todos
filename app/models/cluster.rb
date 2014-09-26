class Cluster
  attr_accessor :center, :tasks, :context

  def initialize(center)
    @center = center
    #points is an array of tasks, which maybe means line 15 needs rewriting
    @tasks = []
  end

  def find_context
    counts = {}
    if @tasks != []
      @tasks.each do |task|
        if counts[task.context_id] != nil
          counts[task.context_id] += 1
        else
          counts[task.context_id] = 1
        end
      end

      context = counts.select { |id, count| count == counts.values.max}.keys
      return context.first
    end
  end

  def vectors
    vectors = []
    @tasks.each do |task|
      vectors << task.vector
    end
    vectors
  end

  def recenter!
    old_center = center

    i = 0
    while i < center.length
      center[i] = 0
    end

    vectors.each do |point|
      point.each_with_index do |coord, i|
        center[i] += coord
      end
    end

    average = []

    center.each do |coord|
      average << (coord / vectors.length)
    end

    center = average
    old_center.dist(center)
  end

  def dist(point)
    zipped_array = center.zip(point)
    dimensional_array = zipped_array.map { |x| (x[1] - x[0])**2}
    sum = dimensional_array.reduce(:+)
    Math.sqrt(sum)
  end
end
