require "spec_helper"

module LabelGen

  describe QrRender do
    context "with default params and default page" do
      let(:pdf_with_grid){Prawn::Document.new}
      let(:sample_number){"12345"}
      let(:sample_url){ QrRender.build_url(sample_number) }
      let(:qr){RQRCode::QRCode.new(sample_url, :size => 6, :level => :h)}
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

      it "builds a qr_url containing the number" do
        expect(sample_url).to_not be_nil
        expect( sample_url.match(Regexp.new(sample_number)) ).to_not be_nil
      end

    end
  end
end
