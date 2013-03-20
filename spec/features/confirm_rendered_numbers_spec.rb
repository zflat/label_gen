require "spec_helper"

module LabelGen
  describe "confirming numbers" do
    context "after they have been rendered to a page" do
      let(:fname){'confirm_render_spec_0.pdf'}
      let(:fpath){File.join(SPEC_TMP_PATH, fname)}
      let(:doc){Page.new(:title => fname)}
      let(:n_vals){5}
      let(:vals){NumberGenerator.new(n_vals)}
      
      before :all do
        DataMapper.auto_migrate!
        doc.fill_labels(vals)
        NumberRecord.confirm_used(vals.number)        
      end

      it "records the last number from the generator as the max used" do
        expect(NumberRecord.max_number_confirmed).to eq vals.number
      end

      context "more numbers are rendered" do
        let(:n_vals_more){7}
        let(:vals_more){NumberGenerator.new(n_vals_more)}
          
        before :all do
          doc.fill_labels(vals_more)
        end

        it "generates a higher number than the previous generator" do
          expect(vals_more.number).to be_> vals.number
        end

        it "records the last number in the generator as used" do
          expect(NumberRecord.max_number_used).to eq vals_more.number
        end

        describe "confirming the additional numbers" do
          before :all do
            NumberRecord.confirm_used(vals_more.number)                    
          end

          it "records the last number from the generator as the max used" do
            expect(NumberRecord.max_number_confirmed).to eq vals_more.number
          end
        end # describe "confirming the additional numbers"
      end # context "more nebers are rendered"
    end # context "after they have been rendered to a page"
  end # describe "confirming numbers" do
end
