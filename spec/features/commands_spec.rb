require "spec_helper"

module LabelGen
  describe "command:" do

    describe "'gen_pages'" do
      subject(:command){"gen_pages"}
      context "with arg N pages" do
        let(:n_pages){1}
        let(:config_last_number){1001}
        let(:fname){'command_gen_pages_spec_0.pdf'}
        let(:fpath){File.join(SPEC_TMP_PATH, fname)}
        let(:args){[n_pages, "--path=#{fpath}"]}
        let(:output){capture(:stdout){Utils.start [command, *args]}}
        
        before :each do
          LabelGen.configure { |c| c.max_number_used = config_last_number}
          DataMapper.auto_migrate!
        end
        
        it "runs the command" do
          expect(output).to_not be_nil
        end
          
        it "renders up to the last number" do
            last_number = LabelGen.configuration.template.
              labels_per_page*n_pages + config_last_number 
          pattern = Regexp.new("#{last_number}")
          expect(output =~ pattern).to_not be_nil
        end

      end # context "with arg N pages"
    end # describe "gen_pages"

    describe "'gen_labels'" do
      subject(:command){"gen_labels"}

      context "for a full page" do
        let(:n_labels){LabelGen.configuration.template.labels_per_page}
        let(:config_last_number){1001}
        let(:fname){'command_gen_labels_spec_0.pdf'}
        let(:fpath){File.join(SPEC_TMP_PATH, fname)}
        let(:args){[n_labels, "--path=#{fpath}"]}
        let(:output){capture(:stdout){Utils.start [command, *args]}}
        
        before :each do
          LabelGen.configure { |c| c.max_number_used = config_last_number}
          DataMapper.auto_migrate!
        end

        it "runs the command" do
          expect(output).to_not be_nil
        end

        it "renders up to the last number" do
          pattern = Regexp.new("#{config_last_number + n_labels}")
          expect(output =~ pattern).to_not be_nil
        end
        
      end # context "for a full page" do
      
      context "for a partial page" do
        let(:n_labels){LabelGen.configuration.template.labels_per_page / 2}
        let(:config_last_number){1001}
        let(:fname){'command_gen_labels_spec_1.pdf'}
        let(:fpath){File.join(SPEC_TMP_PATH, fname)}
        let(:args){[n_labels, "--path=#{fpath}"]}
        let(:output){capture(:stdout){Utils.start [command, *args]}}
        
        before :each do
          LabelGen.configure { |c| c.max_number_used = config_last_number}
          DataMapper.auto_migrate!
        end

        it "runs the command" do
          expect(output).to_not be_nil
        end

        it "does not render up to the last number" do
          pattern = Regexp.new("#{config_last_number + n_labels}")
          expect(output =~ pattern).to be_nil
        end
      end # context "for a partial page"
      
      context "--force=TRUE" do
        let(:n_labels){3}
        let(:config_last_number){1001}
        let(:fname){'command_gen_labels_spec_2.pdf'}
        let(:fpath){File.join(SPEC_TMP_PATH, fname)}
        let(:args){[n_labels, "--force=TRUE", "--path=#{fpath}"]}
        let(:output){capture(:stdout){Utils.start [command, *args]}}

        before :each do
          LabelGen.configure { |c| c.max_number_used = config_last_number}
          DataMapper.auto_migrate!
        end
        
        it "runs the command" do
          expect(output).to_not be_nil
        end

        it "indicates the last number" do
          pattern = Regexp.new("#{config_last_number + n_labels}")
          expect(output =~ pattern).to_not be_nil
        end
      end
    end # describe "gen_labels" do
    
    describe "'current_max_number'" do
      let(:config_last_number){101}
      let(:max_number){101}
      let(:output){ capture(:stdout){Utils.start ["current_max_number"]}}      

      before :each do
        LabelGen.configure do |config|
          config.max_number_used = max_number
        end
      end

      it "provides the correct number" do
        expect(output.strip).to eq max_number.to_s
      end
    end

    describe "'confirm_printed'" do
      subject(:command){"confirm_printed"}
      
      context "given a number not used" do
        let(:config_last_number){101}
        let(:max_number){102}
        let(:args){[max_number]}
        let(:output){capture(:stdout){Utils.start [command, *args]}}
        
        before :each do
          LabelGen.configure { |c| c.max_number_used = config_last_number}
          DataMapper.auto_migrate!
        end

        it "runs the command" do
          expect(output).to_not be_nil
        end

        it "indicates the error" do
          expect(output =~ /ERROR/).to_not be_nil
        end

        it "does not update the max confirmed number used" do
          expect(NumberRecord.max_number_used).to eq config_last_number
        end

      end # context "given a number not used"
      
      context "given a number after it was used" do
        let(:config_last_number){101}
        let(:max_number){102}
        let(:args){[max_number]}
        let(:output){capture(:stdout){Utils.start [command, *args]}}

        before :each do
          LabelGen.configure { |c| c.max_number_used = config_last_number}
          DataMapper.auto_migrate!
          
          # use the number
          NumberRecord.put_used(max_number)
        end
        
        it "runs the command" do
          expect(output).to_not be_nil
        end

        it "is error free" do
          expect(output =~ /ERROR/).to be_nil
        end

        it "updates the max confirmed number used" do
          expect(NumberRecord.max_number_used).to eq max_number
        end

      end # context "given a number after it was used" 
    end # describe "confirm_printed"

  end # describe "command: "
end
