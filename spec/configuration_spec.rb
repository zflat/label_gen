require "spec_helper"

module LabelGen
  describe Configuration do
    context "without modifications" do
      subject(:config){LabelGen.configuration}
      
      it "has a template" do
        expect(config.template).to_not be_nil
      end
    end # context "without modifications"

    context "with options set" do
      subject(:config){LabelGen.configuration}
      let(:base_url){"http://qr.domainsample.com/items/abc-"}
      let(:template_name){"Template01"}
      
      before :each do
        @locale_path0 = config.locale_path
        LabelGen.configure do |conf|
          conf.locale_path = File.dirname(__FILE__)
          conf.template_name = template_name
        end
      end

      after :each do
        LabelGen.configuration = nil
        LabelGen.configure {}
      end
      
      it "has a locale" do
        expect(config.locale).to_not be_nil
      end

      it "changes the locale path" do
        expect(config.locale_path).to_not eq @locale_path0
      end

      it "specifies a locale path" do
        expect(config.locale_path).to_not be_nil
      end

      it "has a template name" do
        expect(config.template_name).to eq template_name
      end
    end
  end
end
