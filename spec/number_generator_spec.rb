require "spec_helper"

module LabelGen
  describe NumberGenerator do
    context "with random amount, greater than 9, of numbers" do
      let(:count){rand(90)+10}
      subject(:gen){NumberGenerator.new(count)}
      
      it "has next" do
        expect(gen).to have_next
      end

      it "provides the number with #pull" do
        expect(gen.pull).to_not be_nil
      end

      it "has a count > 9" do
        expect(gen.count).to be_> 9
      end

      it "has the correct count" do
        expect(gen.count).to eq count        
      end

      it "has monotonically increasing values" do
        n0 = gen.number
        while gen.has_next?
          n = gen.pull
          expect(n).to be_> n0
        end
      end

      context "after #count pulls" do
        before :each do
          (0..gen.count).each do 
            gen.pull
          end
        end
        
        it "does not have a next" do
          expect(gen).to_not have_next
        end

        it "returns nil on pull" do
          expect(gen.pull).to be_nil
        end
      end

    end
  end
end
