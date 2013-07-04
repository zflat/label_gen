require "spec_helper"

module LabelGen

  describe "rendering page" do

    context "configured with template Ol875" do
      let(:fname){'page_render_spec_0.pdf'}      
      let(:fpath){File.join(SPEC_TMP_PATH, fname)}
      let(:template_name){"Ol875Plain"}
      let(:page){Page.new(:title => fname)}
      let(:n_pages){1.0/2}
      let(:n_vals){n_pages * LabelGen.configuration.template.labels_per_page}
      let(:vals){NumberGenerator.new(n_vals)}

      before :each do
        LabelGen.configure do |conf|
          conf.template_name = template_name
        end
        # page.pdf.grid.show_all
        @last_filled_num = page.fill_labels(vals)
      end

      it "renders a pdf", :launch => true do
        expect(page.pdf.render_file(fpath)).to be_true
        t = Launchy.open(fpath)
      end

      after :each do
        LabelGen.configuration = nil
        LabelGen.configure {}
      end
    end

    context "with qr code" do
      let(:fname){'page_render_spec_1.pdf'}
      let(:fpath){File.join(SPEC_TMP_PATH, fname)}
      let(:page){Page.new(:title => fname)}
      let(:n_pages){1.0/2}
      let(:n_vals){n_pages * LabelGen.configuration.template.labels_per_page}
      let(:vals){NumberGenerator.new(n_vals)}

      before :each do
        @last_filled_num = page.fill_labels(vals)
      end

      it "has the corret number of grid cells" do
        expect(page.cells.count).to eq LabelGen.configuration.template.labels_per_page
      end

      it "prints up to and including the last number in the generator on the page" do
        expect(@last_filled_num).to eq vals.number
      end
      
      it "renders a pdf", :launch => true do
        expect(page.pdf.render_file(fpath)).to be_true
        t = Launchy.open(fpath)
      end
    end # context "with qr code" 
  end # describe "rendering page"
end # module LabelGen
