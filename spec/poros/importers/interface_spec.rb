require 'rails_helper'

RSpec.describe Importers::Interface do
  let(:example_json_block) {
    JSON.parse(
      {
        "id": 500011,
        "full_name": "Brisbane Broncos",
        "name": "Broncos",
        "short_name": "BRI",
        "games": 0,
        "win": 0,
        "loss": 0,
        "draw": 0,
        "points": 0,
        "margin": 0,
        "odds": "",
        "odds_id": "",
        "odds_top4": "",
        "odds_top8": ""
      }.to_json
    )
  }
  let(:example_json_array) { [example_json_block] }
  let(:example_processor) { ExampleProcessor.new }

  before(:each) do
    allow(example_processor).to receive(:set_attrs).and_return(true)
    allow(example_processor).to receive(:create).and_return(true)
    allow(example_processor).to receive(:skip?).and_return(false)
  end

  it "calls set_attrs on the processor with the correct attrs" do
    expect(example_processor).to receive(:set_attrs).with(attrs: example_json_block)
    described_class.import(data: example_json_array, processor: example_processor)
  end

  it "calls create on the processor" do
    described_class.import(data: example_json_array, processor: example_processor)
    expect(example_processor).to have_received(:create)
  end

  it "calls skip? on the processor" do
    described_class.import(data: example_json_array, processor: example_processor)
    expect(example_processor).to have_received(:skip?)
  end

  it "doesnt call create if skip? is true" do
    allow(example_processor).to receive(:skip?).and_return(true)
    described_class.import(data: example_json_array, processor: example_processor)
    expect(example_processor).not_to have_received(:create)
  end
end

class ExampleProcessor
  def initialize
  end

  def set_attrs(attrs:)
  end

  def create
  end

  def skip?
  end
end