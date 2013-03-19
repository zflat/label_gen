require 'prawn'
require 'rqrcode'

module LabelGen

  class QrRender
    
    def initialize(code, optns = {})
      @qr = code
      @dark_rgb = optns[:dark_rgb] || "000000"
      @light_rgb = optns[:light_rgb] || "FFFFFF"
    end

    attr_reader :qr, :dark_rgb, :light_rgb

    def fill(pdf)
      qr.modules.each_index do |x|
        qr.modules.each_index do |y|
          color = qr.dark?(x,y) ? dark_rgb : light_rgb
          pdf.fill_color color
          # pdf.fill_rectangle
        end
      end
    end # print

  end
end
