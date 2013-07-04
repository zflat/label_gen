module LabelGen
  module Template
    class Ol875Plain
      def initialize
        @template_path = File.join(TEMPLATE_DIR, 'ol875.pdf')
        @options = {
          :margin => [36, 14, 36, 14],
          :page_size => "LETTER", 
          :page_layout => :portrait,
          :n_x => 3,
          :n_y => 10,
          :delta_x => 12,
          :delta_y => 0,
          :origin_x => 0,
          :origin_y => 0
        }
      end

      attr_reader :options, :template_path
      
      def labels_per_page
        30
      end

      class Cell
        def initialize(pdf, label)
          @pdf = pdf
          @label = label
        end
        
        attr_reader :pdf, :label
        
        def fill
          pdf.move_down 10
          pdf.font_size 66
          pdf.font "Helvetica", :style => :bold
          pdf.fill_color "000000"
          pdf.text label, :character_spacing => -0.5, :indent_paragraphs => 2
        end # def fill
      end # class Cell
    end # class Ol875
  end # module Tempate
end # module LabelGen
