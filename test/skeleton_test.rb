require "minitest/autorun"
require_relative "../lib/skeleton"

describe Skeleton do
  before do
    @skeleton = Skeleton.new "fixtures/bigger.json"
  end

  describe "Data extraction" do
    it "must read the data correctly" do
      # NOTE: The gory details do come out in the tests
      @skeleton.extractor.skeleton['children'][0].has_key?('bgSection').must_equal true
    end

    it "must not tamper with the data unless instructed to" do
      @skeleton.pristine?.must_equal true
    end
  end

  describe "Memory consumption" do
    it "should be reasonable in its use of memory" do
      before_sample = NewRelic::Agent::Samplers::MemorySampler.new.sampler.get_sample
      1000.times do
        @skeleton.pristine?
      end
      after_sample = NewRelic::Agent::Samplers::MemorySampler.new.sampler.get_sample
      (after_sample - before_sample).must_be :<, 30
    end
  end
end
