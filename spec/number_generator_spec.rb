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
      end # context "after #count pulls"

      context "when some numbers are used but not confirmed" do
        let(:count_sub){rand(90)+10}
        subject(:gen_sub){NumberGenerator.new(count_sub)}
        
        before :each do
          (0..gen.count).each do 
            gen.pull
          end
        end

        it "starts with the first number as the max confirmed, not max used" do
          expect(NumberRecord.max_number_used).to_not eq NumberRecord.max_number_confirmed
          expect(gen_sub.number).to_not eq NumberRecord.max_number_used
          expect(gen_sub.number).to eq NumberRecord.max_number_confirmed
        end
      end # context "when some numbers are used but not confirmed"

    end # context "with random amount, greater than 9, of numbers" 
  end # describe NumberGenerator
end
