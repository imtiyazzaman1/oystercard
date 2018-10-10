class Journey

  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station
  end

  def start(station = nil)
    @entry_station = station
  end

  def end(station = nil)
    @exit_station = station
  end

  def fare
    return Oystercard::PENALTY_FARE unless complete?
    Oystercard::MIN_FARE if complete?
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end
end
