require "spec_helper"

module LabelGen

  describe "rendering page" do
    context "with qr code" do
      let(:page){Page.new}
      let(:pdf){page.pdf}
      let(:sample_url){ 'http://qr.sampledomain.com/item/abc-12345/' }
      let(:qr){RQRCode::QRCode.new(sample_url, :size => 5, :level => :h)}
      let(:qr_print){QrRender.new(qr, :length => 62)}

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
        pdf.grid.show_all
        page.pdf.grid(0,0).bounding_box do
          label = "12345"
          url = "http://qr.domainsample.com/items/abc-#{label}"
          qr = RQRCode::QRCode.new(url, :size => 5, :level => :h)
          Cell.new(page.pdf, "12345", qr).fill
        end
      end
      
      it "ouputs a pdf" do
        expect(page.pdf.render_file(fpath)).to be_true
        t = Launchy.open(fpath)
      end

    end # context "with qr code" 
  end # describe "rendering page"
end # module LabelGen
