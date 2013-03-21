require "spec_helper"

module LabelGen
  describe Utils do
    
    context "without args" do
      let(:err){ capture(:stderr){Utils.start ["gen_pages"]}}

      it "gives argument instructions error message" do
        expect(err =~ /argument/).to_not be_nil
      end
    end # context "without args"

    describe "help gen_pages" do
      let(:output){ capture(:stdout){Utils.start ["help", "gen_pages"]}}
      it "gives instructions" do
        expect(output =~ /Usage/).to_not be_nil
      end
    end
    
  end # describe Utils
end
