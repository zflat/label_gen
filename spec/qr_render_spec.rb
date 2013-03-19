require "spec_helper"

module LabelGen

  describe QrRender do
    context "with default params and default page" do
      let(:page){Page.new}
      let(:pdf){page.pdf}
      let(:sample_url){ 'http://qr.sample.com/item/abc-12345/' }
      let(:qr){RWRCode::QRCode.new(sample_url)}
      subject(:qr_print){QrRedner.new(qr)}
      
      it "is not nil" do
        expect(qr_print).to_no be_nil
      end

    end
  end
end
