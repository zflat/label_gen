require "spec_helper"

module LabelGen

  describe Page do
    context "with default options" do
      let(:fname){'page_spec_0.pdf'}
      let(:fpath){File.join(SPEC_TMP_PATH, fname)}
      subject(:page){Page.new({})}

      it "is not nil" do
        expect(page).to_not be_nil
      end

      it "has a pdf document" do
        expect(page.pdf).to_not be_nil
      end

    end
    context "with 30 grid cells" do
      let(:fname){'page_spec_1.pdf'}
      let(:fpath){File.join(SPEC_TMP_PATH, fname)}
      subject(:page)do
        Page.new({
                   :n_x => 3,
                   :n_y => 10,
                   :delta_x => 12
                 })
      end
      
      it "is not nil" do
        expect(page).to_not be_nil
      end

      it "has a pdf document" do
        expect(page.pdf).to_not be_nil
      end

      it "ouputs a pdf" do
        expect(page.pdf.render_file(fpath)).to be_true
        # t = Launchy.open(fpath)
      end
    end
  end

end
