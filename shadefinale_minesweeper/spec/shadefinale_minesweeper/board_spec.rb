require_relative '../../lib/shadefinale_minesweeper/board.rb'

describe Board do

  let(:board){Board.new}

  describe '#initialize' do

    it 'should have a 10x10 board' do
      expect(board.board_size).to eq(100)
    end

    it 'should have 9 mines' do
      expect(board.mine_count).to eq(9)
    end

  end

  describe "#clear" do
    it 'should clear board' do
      board.clear
      expect(board.mine_count).to eq(0)
    end

  end

  describe "#play" do
    it 'should remove flag from played square' do
      board.clear
      board.flag(2,2)
      board.play(2,2)
      expect(board.remaining_flags).to eq(9)
    end

    it 'should remove flag if square becomes revealed' do
      board.clear
      board.flag(2,2)
      expect(board.remaining_flags).to eq(8)
      board.play(5,5)
      expect(board.remaining_flags).to eq(9)
    end
  end

  describe '#get_neighbors' do

    it 'should have 3 neighbors for the origin (corner)' do
      expect(board.get_neighbors(9,9).length).to eq(3)
    end

    it 'should have 5 neighbors for the edge' do
      expect(board.get_neighbors(9,8).length).to eq(5)
    end

    it 'should have 8 neighbors for non-edge non-corner square' do
      expect(board.get_neighbors(8,8).length).to eq(8)
    end
  end

  describe '#flag_square' do

    it 'should properly set selected square to be flagged' do
      board.flag(2,3)
      expect(board.flagged?(2,3)).to be true
    end

    it 'should lower flag count when flagging 1 square' do
      board.flag(3,4)
      expect(board.remaining_flags).to eq(8)
    end

    it 'should lower flag count further when flagging multiple squares' do
      board.flag(8,8)
      board.flag(7,7)
      expect(board.remaining_flags).to eq(7)
    end

    it 'should toggle flag back off if trying to place flag more than once' do
      board.flag(9,9)
      board.flag(9,9)
      expect(board.remaining_flags).to eq(9)
    end

    it 'should raise error if out of flags to place' do
      board.flag(3,4)
      board.flag(4,5)
      board.flag(5,6)
      board.flag(6,7)
      board.flag(4,4)
      board.flag(3,6)
      board.flag(2,4)
      board.flag(3,7)
      board.flag(1,4)

      expect{board.flag(0,0)}.to raise_error("Out of flags!")
    end

  end

  context 'show board' do

    specify 'draw the board' do
      board.render
    end

  end

end