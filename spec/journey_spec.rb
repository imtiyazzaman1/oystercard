require 'journey'
require 'pry'
describe Journey do
  let(:station) { double :station }
  let(:station_2) { double :station }

  it "has an entry station" do
    station = Station.new("Aldgate East", 1)
    subject = Journey.new(station)
    expect(subject.entry_station).to eq station
  end

  it "should have an exit station" do
    station = Station.new("Aldgate East", 1)
    subject = Journey.new(station)
    station2 = Station.new("Richmond", 4)
    subject.end(station2)
    expect(subject.exit_station).to eq station2
  end

  describe "#fare" do
    it "should return the minimum fare" do
      subject = Journey.new(station)
      subject.end(station_2)
      allow(station).to receive(:empty?).and_return false
      allow(station_2).to receive(:empty?).and_return false
      expect(subject.fare).to eq Oystercard::MIN_FARE
    end

    it "should return the penalty fare for a journey without an entry station" do
      subject = Journey.new()
      expect(subject.fare).to eq Oystercard::PENALTY_FARE
    end

    it "should return the penalty fare for a journey without an exit station" do
      allow(station).to receive(:empty?).and_return false
      subject = Journey.new(station)
      subject.end
      expect(subject.fare).to eq Oystercard::PENALTY_FARE
    end
  end
end
