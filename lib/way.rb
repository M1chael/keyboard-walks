class Way

  attr_reader :direction

  def initialize(direction: nil, shifted: false)
    @direction = direction
    @shifted = shifted
  end

  def shifted?
    @shifted
  end

end
