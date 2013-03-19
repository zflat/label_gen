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
    end
    
    attr_reader :origin_x, :origin_y, :n_x, :n_y, :delta_x, :delta_y, :frame_width, :frame_height
    attr_reader :pdf, :title

  end
end
