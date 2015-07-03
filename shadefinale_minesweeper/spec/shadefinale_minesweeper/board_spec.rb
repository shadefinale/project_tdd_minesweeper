require_relative '../../lib/shadefinale_minesweeper/board.rb'

describe Board do

  let(:board){Board.new}

  describe '#initialize' do

    it 'should have a 10x10 board' do
      expect(board.board_size).to eq(100)
    end

    it 'should have 9 mines' do
      expect(board.mine_count).to eq(9)
      board.render
    end

  end

end