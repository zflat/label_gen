module LabelGen
  module Template
    class Ol875
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
    end
  end # module Tempate
end
