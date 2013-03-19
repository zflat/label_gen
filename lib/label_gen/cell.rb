module LabelGen
  class Cell 
    
    def initialize(pdf, label, qr)
      @pdf = pdf
      @qr = qr
      @label = label
    end

    attr_reader :pdf, :height, :width, :qr, :label
    
    def fill
      pdf.move_down 18
      pdf.font_size 42
      pdf.font "Helvetica", :style => :bold
      pdf.fill_color "000000"
      pdf.text label, :character_spacing => -0.5, :indent_paragraphs => 2
      
      pdf.translate(120, -5) do
        QrRender.new(qr, :length => 62, 
                     :light_color => "FFFFFF", 
                     :dark_color => "000000").fill(pdf)
      end
    end

    def height
      @height ||= (pdf.bounds.top_right[1]-pdf.bounds.bottom_right[1])
    end

    def width
      @width ||= (pdf.bounds.top_right[0]-pdf.bounds.top_left[0])
    end

  end
end
