class Oystercard
  attr_reader :balance

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    raise "Card limit of #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Insufficient balance" if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
