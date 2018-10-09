require 'station'

describe Station do

  let(:station) {Station.new("Aldgate East", 1)}
  it "should have a name" do
    expect(station.name).to eq "Aldgate East"
  end

  it "should be in zone 1" do
    expect(station.zone).to eq 1
  end

end
