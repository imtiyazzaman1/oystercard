require 'journey'

describe Journey do
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
end
