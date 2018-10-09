class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = "")
    @entry_station = entry_station
  end

  def end(station = "")
    @exit_station = station
  end

  def fare
    return Oystercard::PENALTY_FARE unless complete?
    Oystercard::MIN_FARE if complete?
  end

  def complete?
    !@entry_station.empty? && !@exit_station.empty?
  end
end
