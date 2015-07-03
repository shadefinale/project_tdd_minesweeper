class Board

  @@BOARD_WIDTH = 10
  @@BOARD_HEIGHT = 10
  @@SQUARE = {value: ".", neighbors: 0}

  def initialize
    @state = Array.new(@@BOARD_WIDTH){
      |content2| content2 = Array.new(@@BOARD_HEIGHT){
        |content| content = @@SQUARE}}
    add_mines_to_board
  end

  def add_mines_to_board(number = 9)
    until number <= 0
      render
      ypos = (0..number).to_a.sample
      xpos = (0..number).to_a.sample
      unless @state[ypos][xpos][:value] == "X"
        @state[ypos][xpos][:value] = "X"
        number -= 1
      end
    end

  end

  def out_of_bounds?(y, x)
    y >= @@BOARD_HEIGHT || y < 0 || x >= @@BOARD_WIDTH || x < 0
  end

  def get_square(x, y)
    unless out_of_bounds?(y,x)
      @state[y][x]
    end
    return nil
  end

  def mine_count
    state.reduce(0){|acc, row| acc += row.select{|col| col[:value] = "."}.length}

  end

  def board_size
    @state.reduce(0){|acc, row| acc += row.length}
  end

  def render
    @state.each_with_index do |row, y|
      row.each_with_index do |col, x|
        print @state[y][x][:value]
      end
      print "\n"
    end
    puts @state[0][1]
    puts @state[9][9]
  end
end