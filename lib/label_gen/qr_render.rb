require 'rqrcode'

module LabelGen

  class QrRender
    
    def self.build_url(number)
      I18n.translate('label_gen.qr_url', :number => number)
    end
    
    def initialize(code, optns = {})
      @qr = code
      @dark_rgb = optns[:dark_rgb] || "000000"
      @light_rgb = optns[:light_rgb] || "FFFFFF"
      @length_overall = (optns[:length] || @qr.modules.count * 2) * 1.0
    end

    attr_reader :qr, :dark_rgb, :light_rgb, :length_overall

    def fill(pdf)
      qr.modules.each_index do |i|
        qr.modules.each_index do |j|
          pdf.fill_color module_color(i,j)
          pdf.fill_rectangle(module_top_left(i,j, pdf.bounds.top_left), 
                             module_length, module_length)
        end
      end
      return true
    end # fill

    private

    # Determine the square size to fill based on
    # the number of modules and the overall length
    def module_length
      @module_length ||= length_overall / qr.modules.count
    end


    # Get the top-left corner where the
    # module is located relative to
    # the given origin, wich is the top_left
    # of the current pdf bounding box
    #
    # @return Array [x, y]
    def module_top_left(mod_i, mod_j, bounds_origin)
      x = bounds_origin[0] + mod_i*module_length
      y = bounds_origin[1] - mod_j*module_length
      [x, y]
    end

    def module_color(mod_i,  mod_j)
      qr.dark?(mod_i,mod_j) ? dark_rgb : light_rgb      
    end

  end
end
