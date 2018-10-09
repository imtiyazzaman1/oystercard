require 'journey'

describe Journey do
  it "has an entry station" do
    station = Station.new("Aldgate East", 1)
    subject = Journey.new(station)
    expect(subject.entry_station).to eq station
  end
end
