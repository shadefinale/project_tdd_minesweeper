require_relative './square.rb'
require 'colorize'

class Board

  def initialize(size = 10)
    @board_size = size
    @state = Array.new(@board_size){
      |content2| content2 = Array.new(@board_size){
        |content| content = Square.new}}
    populate_board
    @flags = mine_count
    @game_over = false
  end

  def clear
    @state = Array.new(@board_size){
      |content2| content2 = Array.new(@board_size){
        |content| content = Square.new}}
  end

  def populate_board
    add_mines_to_board
    set_hints
  end

  def deep_copy(obj)
    Marshal.load(Marshal.dump(obj))
  end

  def add_mines_to_board
    number = 0
    until number > @board_size - 2
      ypos = (0..number).to_a.shuffle.sample
      xpos = (0..number).to_a.shuffle.sample
      unless @state[ypos][xpos].mine?
        @state[ypos][xpos].mine = true
        number += 1
      end
    end
  end

  def game_over?
    @game_over
  end

  def play(x,y)
    square = get_square(x,y)
    if square
      square.toggle_flag if square.flag?
      if square.mine?
        @game_over = true
      else
        reveal(x,y)
      end
    end
  end

  def empty?(x,y)
    get_square(x,y).hint == 0 && !get_square(x,y).mine? && !get_square(x,y).visible?
  end

  def reveal(x,y)
    new_square = get_square(x,y)
    new_square.reveal unless new_square.visible?
    nearby_squares(x,y).each do |s|
      reveal_next(s[0],s[1])
    end
  end

  def reveal_next(x, y)
    square = get_square(x, y)
    return if square.visible?

    if square.empty?
      square.toggle_flag if square.flag?
      square.reveal
      reveal(x, y)
    elsif !square.mine?
      square.reveal
    end
  end

  def flagged?(x,y)
    get_square(x,y).flag?
  end

  def flag(x,y)
    if remaining_flags > 0
      get_square(x,y).toggle_flag
    else
      raise "Out of flags!"
    end
  end

  def remaining_flags
    @flags - @state.reduce(0){|acc, row| acc += row.select{|col| col.flag?}.length}
  end

  def set_hints
    @state.each_with_index do |row, y|
      row.each_with_index do |col, x|
        @state[y][x].hint = count_nearby_mines(x, y)
      end
    end
  end

  def count_nearby_mines(x,y)
    (get_neighbors(x,y).select{|neighbor| neighbor.mine? }).length
  end


  def out_of_bounds?(x, y)
    y >= @board_size || y < 0 || x >= @board_size || x < 0
  end

  def get_square(x, y)
    unless out_of_bounds?(x,y)
      return @state[y][x]
    end
    return nil
  end

  def nearby_squares(x, y)
    map = [[-1,0],[-1,-1],[-1,1],[0,1],[0,-1],[1,0],[1,1],[1,-1]]
    nearby = []
    map.each do |dir|
      unless out_of_bounds?(dir[0] + x, dir[1] + y)
        nearby << [dir[0] + x, dir[1] + y]
      end
    end
    return nearby
  end

  def get_neighbors(x, y)
    nearby_squares(x, y).map{ |coord| get_square(coord[0],coord[1])}
  end

  def win?
    return get_mines == get_flags || ((@board_size ** 2) - revealed_count) == mine_count
  end

  def revealed_count
    @state.reduce(0){|acc, row| acc += row.select{|col| col.visible?}.length}
  end

  def get_mines
    mines = []
    @state.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if @state[y][x].mine?
          mines << [x,y]
        end
      end
    end
    return mines
  end

  def get_flags
    flags = []
    @state.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if @state[y][x].flag?
          flags << [x,y]
        end
      end
    end
    return flags
  end

  def mine_count
    @state.reduce(0){|acc, row| acc += row.select{|col| col.mine?}.length}
  end

  def board_size
    @state.reduce(0){|acc, row| acc += row.length}
  end

  def colorize(hint)
    case hint
    when 1
      :red
    when 2
      :light_red
    when 3
      :yellow
    when 4
      :light_green
    when 5
      :green
    when 6
      :light_cyan
    when 7
      :cyan
    when 8
      :light_magenta
    end
  end

  def render
    @state.each_with_index do |row, y|
      print "%2s" % y
      print " "
      row.each_with_index do |col, x|
        if @state[y][x].visible?
          if @state[y][x].mine?
            print "X"
          elsif @state[y][x].hint == 0
            print ".".colorize(:light_white)
          else
            print @state[y][x].hint.to_s.colorize(colorize(@state[y][x].hint))
          end
        elsif @state[y][x].flag?
          print "F".colorize(:color => :white, :background => :light_black)
        else
          print "_".colorize(:background => :black)
        end
      end
      print "\n"
    end
    print "Flags: " + ("F" * remaining_flags) + "\n"
  end

  def render_game_over
    @state.each_with_index do |row, y|
      print "%2s" % y
      print " "
      row.each_with_index do |col, x|

        if @state[y][x].mine?
          print "X"
        elsif @state[y][x].hint == 0
          print ".".colorize(:light_white)
        elsif @state[y][x].flag?
          print "F".colorize(:magenta)
        else
          print @state[y][x].hint.to_s.colorize(colorize(@state[y][x].hint))
        end

      end
      print "\n"
    end
  end
end