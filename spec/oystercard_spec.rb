require 'oystercard'

describe Oystercard do
  let (:station) { double :station }
  let (:station_2) { double :station }
  let(:journey){ {from: station, to: station_2} }

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
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "should not be able to touch in if balance is below the minimum fare" do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient balance"
    end

    it "should create a new instance of journey" do
      subject.top_up(Oystercard::MIN_FARE)
      expect(subject.touch_in(station)).to be_an_instance_of(Journey)
    end

  end

  describe "#touch_out" do
    before {
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
    }

    it "should be able to touch out" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "should deduct money on touch out" do
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MIN_FARE)
    end
  end

  it "should start with an empty journey history" do
    expect(subject.journey_history).to be_empty
  end

  describe "#journey_history" do
    before {
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      subject.touch_out(station_2)
    }
    it "should store instaces of Journey" do
      expect(subject.journey_history.first).to be_an_instance_of Journey
    end
    it "should remember the entry station" do
      expect(subject.journey_history.first.entry_station).to eq station
    end

    it "should remember the entry station" do
      expect(subject.journey_history.first.exit_station).to eq station_2
    end
  end

  describe "#fare" do
    before {
      subject.top_up(10)
    }
    it "should return the minimum fare" do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.fare).to eq Oystercard::MIN_FARE
    end

    it "should charge a penalty fare if no entry station" do
      subject.touch_out(station)
      expect(subject.fare).to eq Oystercard::PENALTY_FARE
    end

    it "should charge a penalty fare if there is no exit station" do
      subject.touch_in(station)
      subject.touch_in(station)
      expect(subject.fare).to eq Oystercard::PENALTY_FARE
    end
  end
end
