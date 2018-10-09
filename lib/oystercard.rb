class Oystercard
  attr_reader :balance, :entry_station, :journey_history

  LIMIT = 90
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = []
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    raise "Card limit of #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end


  def touch_in(station)
    raise "Insufficient balance" if @balance < MIN_FARE
    @in_journey = true
    @journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @in_journey = false
    @journey.end(station) if !@journey.nil?
    if @journey.nil?
      @journey = Journey.new
      @journey.end(station)
    end
    @journey_history << @journey
  end

  def fare
    if @journey_history.last.entry_station == ""
      PENALTY_FARE
    else
      MIN_FARE
    end 
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
