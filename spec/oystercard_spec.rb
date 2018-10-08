require 'oystercard'

describe Oystercard do
  describe "#balance" do
    it "should report intial balance as 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "should increase the balance by 10" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "should raise an error if balance exceeds LIMIT" do
      subject.top_up(Oystercard::LIMIT)
      expect { subject.top_up(1) }.to raise_error "Card limit of #{Oystercard::LIMIT} exceeded"
    end
  end

  describe "#in_journey" do
    it { is_expected.not_to be_in_journey }
  end

  describe "#touch_in" do
    it "should be able to touch in" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "should not be able to touch in if balance is below the minimum fare" do
      expect{ subject.touch_in }.to raise_error "Insufficient balance"
    end
  end

  describe "#touch_out" do
    it "should be able to touch out" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it "should deduct money on touch out" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in
      expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MIN_FARE)
    end
  end

end
