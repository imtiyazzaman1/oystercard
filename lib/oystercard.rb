class Oystercard
  attr_reader :balance, :journey_history

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

    @journey_history << @journey if !@journey.nil?
    @journey = Journey.new
    @journey.start(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @in_journey = false

    end_journey(station)
    @journey_history << @journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def end_journey(station)
    @journey = Journey.new if @journey.nil?
    @journey.end(station)
  end
end
