module AlgoPath
  class ShortPath
    def initialize(map2d)
      @map2d = map2d
    end

    def find_path
      start = @map2d.start_position
      @queue = [Cell.new(start.dx, start.dy, [start])]
      @path
      @visited = []

      while !@queue.empty? && !@path
        process_cell(@queue.shift)
      end

      @path
    end

    private

    def process_cell(cell)
      return if @visited.include?(cell.to_point)

      @visited << cell.to_point
      return (@path = cell.path) if cell.to_point == finish_position
      moves = @map2d.moves_from(cell.x, cell.y)

      moves.sort_by{rand}.each do |mv|
        @queue << Cell.new(mv.dx, mv.dy, cell.path + [mv]) unless @visited.include?(mv)
      end  
    end

    def finish_position
      @finish_position ||= @map2d.finish_position
    end
  end    
end