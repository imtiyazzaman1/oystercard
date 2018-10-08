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
  end
end
