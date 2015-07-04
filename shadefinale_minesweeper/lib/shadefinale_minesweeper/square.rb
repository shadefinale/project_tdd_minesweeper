class Square

  attr_accessor :hint

  attr_writer :mine

  def initialize
    @mine = false
    @hint = 0
    @show = false
    @flag = false
  end

  def toggle_flag
    if @flag
      @flag = false
    else
      @flag = true
    end
  end

  def flag?
    @flag
  end

  def empty?
    !@mine && hint == 0
  end

  def mine?
    @mine
  end

  def visible?
    @show
  end

  def reveal
    @show = true
  end
end