class Cluster
  attr_accessor :center, :points, :context

  def initialize(center)
    @center = center
    @points = []
  end

  def recenter!
    old_center = center
    #@ center = some array of 0 points

    sum = points.each do |point|
      point.each_with_index do |coord, i|
        center[i] += coord
      end
    end

    average = sum.each do |coord|
      coord / points.length
    end

    center = average
    old_center.dist_to(center)
  end
