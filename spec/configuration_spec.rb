require "spec_helper"

module LabelGen
  describe Configuration do
    context "without modifications" do
      subject(:config){LabelGen.configuration}
      
      it "has a default template" do
        expect(config.default_template).to_not be_nil
      end
    end # context "without modifications"

    context "with options set" do
      subject(:config){LabelGen.configuration}
      let(:base_url){"http://qr.domainsample.com/items/abc-"}
      let(:template_name){"Template01"}
      
      before :each do
        LabelGen.configure do |conf|
          conf.default_template_name = template_name
        end
      end
      
      it "has a locale" do
        expect(config.locale).to_not be_nil
      end

      it "has a template name" do
        expect(config.default_template_name).to eq template_name
      end
    end
  end
end
