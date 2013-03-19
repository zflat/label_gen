require 'prawn'

module LabelGen

  class Page
    
    def initialize(params)
      @n_x = params[:n_x] || 1
      @n_y = params[:n_y] || 1
      @origin_x = params[:origin_x] || 0
      @origin_y = params[:origin_y] || 0
      @delta_x =  params[:delta_x] || 1
      @delta_y =  params[:delta_y] ||1
      @frame_width = params[:frame_width] || 1
      @frame_height = params[:frame_height] || 1
      @title = params[:title] || 'PDF Page'

      template_path = File.join(TEMPLATE_DIR, 'ol875.pdf')
      
      @pdf = Prawn::Document.new(:page_size => "LETTER", 
                                 :page_layout => :portrait,
                                 :margin => [36, 14, 36, 14],
                                 :template => template_path, :template_page => 1,
                                 :info => {
                                   :Title =>@title
                                 })
      
      @pdf.define_grid(:columns => @n_x, 
                       :rows => @n_y, 
                       :row_gutter => @delta_y, 
                       :column_gutter => @delta_x)
      @pdf.grid.show_all
      @pdf.grid(0,0).bounding_box do
        h = (@pdf.bounds.top_right[1]-@pdf.bounds.bottom_right[1])
        w = (@pdf.bounds.top_right[0]-@pdf.bounds.top_left[0])
        i_y = 0.5*h
        i_x = 0.5*w
        # @pdf.text "TEST TEXT mid_h=#{i_y}, mid_w=#{i_x}"
        @pdf.move_down 20
        @pdf.font_size 42
        @pdf.text "12345"
        @pdf.fill_color "FF00FF"
        @pdf.fill_rectangle([125, 60], 50, 50)
      end
      # @pdf.start_new_page(:template => template_path, :template_page => 0)
    end
    
    attr_reader :origin_x, :origin_y, :n_x, :n_y, :delta_x, :delta_y, :frame_width, :frame_height
    attr_reader :pdf, :title

    

  end
end
