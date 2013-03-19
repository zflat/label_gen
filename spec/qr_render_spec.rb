require "spec_helper"

module LabelGen

  describe QrRender do
    context "with default params and default page" do
      let(:pdf_with_grid){Prawn::Document.new}
      let(:sample_url){ "http://qr.sample.com/item/abc-12345/" }
      let(:qr){RQRCode::QRCode.new(sample_url, :size => 5, :level => :h)}
      subject(:qr_print){QrRender.new(qr, :dark_rgb => "0000FF", :light_rgb => "FFFF00")}
      
      before :each do
        pdf_with_grid.define_grid(:columns => 1, :rows => 1)
      end

      it "is not nil" do
        expect(qr_print).to_not be_nil
      end
      
      it "can print code" do
        expect(pdf_with_grid.grid(0, 0).bounding_box{qr_print.fill(pdf_with_grid)}).to be_true
      end

    end
  end
end
