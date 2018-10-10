require 'journey'
require 'oystercard'
require 'pry'
describe Journey do
  let(:station) { double :station }
  let(:station_2) { double :station }

  it "has an entry station" do
    subject.start(station)
    expect(subject.entry_station).to eq station
  end

  it "should have an exit station" do
    subject.end(station_2)
    expect(subject.exit_station).to eq station_2
  end

  describe "#fare" do
    it "should return the minimum fare" do
      allow(station).to receive(:empty?).and_return false
      allow(station_2).to receive(:empty?).and_return false
      subject.start(station)
      subject.end(station_2)
      expect(subject.fare).to eq Oystercard::MIN_FARE
    end

    it "should return the penalty fare for a journey without an entry station" do
      subject.start
      expect(subject.fare).to eq Oystercard::PENALTY_FARE
    end

    it "should return the penalty fare for a journey without an exit station" do
      allow(station).to receive(:empty?).and_return false
      subject.start(station)
      subject.end
      expect(subject.fare).to eq Oystercard::PENALTY_FARE
    end
  end
end
