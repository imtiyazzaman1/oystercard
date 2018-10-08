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

  describe "#deduct" do
    it "should reduce the balance by 2" do
      subject.top_up(10)
      expect(subject.deduct(2)).to eq 8
    end
  end

  describe "#in_journey" do
    it { is_expected.not_to be_in_journey }
  end

  describe "#touch_in" do
    it "should be able to touch in" do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe "#touch_out" do
    it "should be able to touch out" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
