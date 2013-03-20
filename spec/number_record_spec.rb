require "spec_helper"

module LabelGen
  describe NumberRecord do
    context "with an empty db" do
      before :each do
        DataMapper.auto_migrate!
      end
      
      it "has a max number used as specified in the configuration" do
        expect(NumberRecord.max_number_used).to eq LabelGen.configuration.max_number_used
      end
      it "has no records" do
        expect(NumberRecord.count).to eq 0
      end
    end # context "with an empty db"

    describe "using a number" do
      let(:number){1}
      before :each do
        DataMapper.auto_migrate!
        @n = NumberRecord.put_used(number)
      end
      it "affirms the number" do
        expect(@n).to eq number
      end

      it "has a record" do
        expect(NumberRecord.first(:number => number)).to_not be_nil
        expect(NumberRecord.first(:number => number).number).to eq number
      end
      
      it "is used" do
        expect(NumberRecord.used?(number)).to be_true
      end
      
      it "makes the table non-empty" do
        expect(NumberRecord.count).to be_> 0
      end
      it "is not max confirmed" do
        expect(NumberRecord.max_number_confirmed).to_not eq number
      end

      it "has nil for confirmed_at" do
        expect(NumberRecord.all(:number => number)).to_not be_nil
        expect(NumberRecord.first(:number => number).confirmed_at).to be_nil        
      end

      context "which is larger than the max number" do
        let(:number_max){NumberRecord.max_number_confirmed + 1}

        before :each do
          DataMapper.auto_migrate!
          NumberRecord.put_used(number_max)
        end
        
        it "is the max number used" do
          expect(NumberRecord.max_number_used).to eq number_max
        end
        
        describe "is confirmed" do
          let(:confirmed_max){NumberRecord.max_number_confirmed + 1}
          before :each do
            DataMapper.auto_migrate!
            @bln_put = NumberRecord.put_used(confirmed_max)
            @bln_ret = NumberRecord.confirm_used(confirmed_max) unless confirmed_max.nil?
          end
          
          it "is used" do
            expect(NumberRecord.first(:number => confirmed_max)).to be_used
          end

          it "has DateTime for confirmed_at" do
            expect(NumberRecord.first(:number => confirmed_max).confirmed_at).to_not be_nil        
          end

          it "has succuess confirming" do
            expect(@bln_ret).to be_true
          end

          it "has succuess putting" do
            expect(@bln_put).to be_true
          end

          it "can be verified as confirmed" do
            expect(NumberRecord.max_number_confirmed).to eq confirmed_max
          end
        end # describe "is confirmed"

      end # context "which is larger than the max number"
    end # describe "using a number"

    describe "using a previously used, unconfirmed, number" do
      let(:number){1}
      before :each do
        DataMapper.auto_migrate!
        @n = NumberRecord.put_used(number)
      end
      
      it "returns the number" do
        expect(NumberRecord.put_used(number)).to eq number
      end
    
      it "does not add a new record" do
        expect(NumberRecord.all(:number => number).count).to eq 1
      end

    end # describe "using a previously used, unconfirmed, number" do

    describe "putting a previously confirmed number" do
      let(:number){1}
      before :each do
        DataMapper.auto_migrate!
        NumberRecord.put_used(number)
        NumberRecord.confirm_used(number)
      end

      it "returns nil" do
        expect(NumberRecord.put_used(number)).to be_nil
      end
    end # describe "using a previously confirmed number"
    
    describe "confirming an unused number" do
      let(:number){1}
      before :each do
        DataMapper.auto_migrate!
        NumberRecord.create(number)
      end
      
      it "is not successull" do
        expect(NumberRecord.confirm_used(number)).to_not be_true
      end
    end # describe "confirming an unused number"


    describe "confirming numbers" do
      context "that have been used" do
        context "when some numbers are already confirmed" do
          
          let(:pre_confirmed_max){NumberRecord.max_number_confirmed + 10}
          let(:max_to_confirm){NumberRecord.max_number_confirmed + 55}
          
          before :each do
            DataMapper.auto_migrate!
            (NumberRecord.max_number_confirmed..pre_confirmed_max).each do |n|
              NumberRecord.put_used(n)
              NumberRecord.confirm_used(n)
            end
            (NumberRecord.max_number_confirmed..max_to_confirm).each do |n|
              NumberRecord.put_used(n)            
            end
          end
          
          it "indicates the pre_confirmed max as the max_number_confirmed" do
            expect(NumberRecord.max_number_confirmed).to eq pre_confirmed_max
          end
        
          it "confirms each number in the series" do
            (NumberRecord.max_number_confirmed..max_to_confirm).each do |n|
            expect(NumberRecord.confirm_used(n)).to be_true
            end
          end
          
        end #  context "when some numbers are already confirmed" 
      end # context "that have been used"
    end # describe "confirming printed numbers" 

    
  end # describe NumberRecord
end # module LabelGen
