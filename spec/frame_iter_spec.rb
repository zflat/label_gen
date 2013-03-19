require "spec_helper"

describe FrameIter do

  context "with default options" do
    subject(:frames){FrameIter.new}
    
    it "is not nil" do
      expect(frames).to_not be_nil
    end
  end
end
