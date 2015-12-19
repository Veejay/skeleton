require "minitest/autorun"

describe Skeleton do
  before do
    @skeleton = Skeleton.new "bigger.json"
  end

  describe "" do
    it "must read the data correctly" do
      @skeleton.extractor.skeleton.asset_block {|s| s.has_key('bgSection')}
    end
  end

end
