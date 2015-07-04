require_relative "./shadefinale_minesweeper/board"

puts "Welcome to minesweeper! Input a board size!"
puts "Mine and flag count based on board size."
size = gets.chomp.to_i

board = Board.new(size)
until (board.win? || board.game_over?)
  board.render
  puts "Type F to flag! (or anything else to pick!)"
  choice = gets.chomp.upcase
  if choice == "F"
    puts "Type what square you want to flag! [0,0] to [9,9]"
    choice = gets.chomp.split(" ")
    begin
      board.flag(choice[0].to_i, choice[1].to_i)
    rescue Exception => e
      puts e
    end
  else
    puts "Type what square you want to play! [0,0] to [9,9]"
    choice = gets.chomp.split(" ")
    board.play(choice[0].to_i, choice[1].to_i)
  end
end

board.win? ? (puts "Hooray, you won!") : (puts "Dang, you lost!")
board.win? ? (board.render) : (board.render_game_over)