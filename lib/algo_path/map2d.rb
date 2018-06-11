module AlgoPath
  class Map2D
    SYMBOLS = {
      user: 'Y',
      wall: '@',
      land: '.',
      path: '+',
      gold: '$',
    }

    DIRECTIONS = {
      up: [0, -1],
      down: [0, 1],
      left: [-1, 0],
      right: [1, 0],
    }

    def initialize(chars_table)
      @chars_table = chars_table
    end

    def symbols
      @symbols ||= OpenStruct.new(SYMBOLS)
    end

    def find(char)
      go do |x, y, c|
        return [x, y] if c == char
      end
      nil
    end

    def start_position
      find(symbols.user)
    end

    def finish_position
      find(symbols.gold)
    end

    def go(&block)
      @chars_table.each_with_index do |row, y|
        row.each_with_index do |c, x|
          block.call(x, y, c)
        end
      end
    end

    def add_path(path)
      path[1..-2].each do |p|
        @chars_table[p.dy][p.dx] = symbols.path
      end
    end

    def moves_from(x, y)
      DIRECTIONS.values.map { |dr| [dr.dx + x, dr.dy + y] }.select { |p| valid?(p.dx, p.dy) && step?(p.dx, p.dy)}
    end

    def valid?(x, y)
      (0...width).include?(x) && (0...height).include?(y)
    end

    def step?(x, y)
       @chars_table[y][x] == symbols.land || @chars_table[y][x] == symbols.gold
    end

    def height
      @chars_table.size
    end

    def width
      @chars_table.first.size
    end

    def to_s
      @chars_table.map(&:join).join("\n")
    end

    class << self
      def load_from_file(path)
        content = File.read(path)
        rows = content.split("\n")
        chars_table = rows.map(&:chars)
        new(chars_table)
      end
    end
  end
end