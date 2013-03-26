require "spec_helper"

module LabelGen
  module Template
    describe Ol875 do
      
      context "as configured default" do
        before :all do
          LabelGen.configure do |conf|
            conf.template_name = 'Ol875'
          end
        end

        context "with template layout" do
          let(:fname){"template_#{LabelGen.configuration.template_name}_spec_0.pdf"}
          let(:fpath){File.join(SPEC_TMP_PATH, fname)}
          let(:page) do
            Page.new(:title => fname,
                     :template_path => LabelGen.
                     configuration.template.template_path)
          end

          describe "Page render with a shown grid" do
            before :each do
              page.pdf.grid.show_all
            end

            it "renders PDF output", :launch => true do
              expect(page.pdf.render_file(fpath)).to be_true
              t = Launchy.open(fpath)
            end # render PDF output
          end # describe "Page render"

        end # context "with template layout"
      end # context "as configured default"
    end

  end # module Template
end # module LabelGen
