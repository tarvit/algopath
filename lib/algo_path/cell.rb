module AlgoPath
  class Cell
    attr_reader :x, :y
    attr_accessor :path

    def initialize(x, y, path = [])
      @x = x
      @y = y
      @path = path
    end

    def to_point
      @point ||= [x, y]
    end
  end
end