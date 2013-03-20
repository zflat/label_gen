require "spec_helper"

module LabelGen

  describe "Cell formatting" do
    describe "label" do
      context "for value 1" do
        let(:number){1}
        subject(:label){I18n.translate('label_gen.number_label', :number => number)}
        it "should have 5 digits" do
          expect(label.length).to eq 5
        end
      end # context "for value 1" do
    end # describe "label"
  end # describe "Cell formatting"

end # module LabelGen
