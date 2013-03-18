require 'prawn'

module LabelGen
  module Template
    class N30of659x245
      def initialize
        @pdf = Prawn::Document.new
        build
      end
      
      attr_reader :pdf
      
      def render_file(path)
        pdf.render_file path
      end
      
      private
      
      def build
        pdf.text "Hello labels!"
      end
    end
  end
end
