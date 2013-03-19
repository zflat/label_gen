require "spec_helper"

module LabelGen

  describe "rendering page" do
    context "with qr code" do
      let(:page){Page.new}
      let(:pdf){page.pdf}
      let(:sample_url){ 'http://qr.sampledomain.com/item/abc-12345/' }
      let(:qr){RQRCode::QRCode.new(sample_url, :size => 5, :level => :h)}
      let(:qr_print){QrRender.new(qr, :length => 62, :dark_rgb => "000000", :light_rgb => "FFFFFF")}

      let(:fname){'page_render_spec_0.pdf'}
      let(:fpath){File.join(SPEC_TMP_PATH, fname)}
      
      subject(:page)do
        Page.new({
                   :n_x => 3,
                   :n_y => 10,
                   :delta_x => 12
                 })
      end

      before :each do
        page.pdf.grid(0, 1).bounding_box do
          page.pdf.translate(120, -5) do
            qr_print.fill(page.pdf)
          end
        end
      end

      it "ouputs a pdf" do
        expect(page.pdf.render_file(fpath)).to be_true
        t = Launchy.open(fpath)
      end
    end
  end
end
