module LabelGen
  class Page
    def initialize(params={})
      @def_optns = LabelGen.configuration.template.options
      @n_x = params[:n_x] || @def_optns[:n_x]
      @n_y = params[:n_y] || @def_optns[:n_y]
      @origin_x = params[:origin_x] || @def_optns[:origin_x]
      @origin_y = params[:origin_y] || @def_optns[:origin_y]
      @delta_x =  params[:delta_x] || @def_optns[:delta_x]
      @delta_y =  params[:delta_y] || @def_optns[:delta_y]
      @frame_width = params[:frame_width] || @def_optns[:frame_width]
      @frame_height = params[:frame_height] || @def_optns[:frame_height]
      @page_size = params[:page_size] || @def_optns[:page_size]
      @page_layout = params[:page_layout] || @def_optns[:page_layout]
      @margin = params[:margin] || @def_optns[:margin]
      @template_path = params[:template_path] || @def_optns[:template_path]
      @template_page = params[:template_page] || @def_optns[:template_page]
      @use_template = params[:template_path] || LabelGen.configuration.use_pdf_template
      @title = params[:title] || 'PDF Page'

      @pdf = Prawn::Document.new(:page_size => @page_size, 
                                 :page_layout => @page_layout,
                                 :margin => @margin,
                                 :template => (@template_path if @use_template),
                                 :template_page => (@template_page if @use_template),
                                 :info => {
                                   :Title =>@title
                                 })
      format_page
    end

    attr_reader :origin_x, :origin_y, :n_x, :n_y, :delta_x, :delta_y, :frame_width, :frame_height
    attr_reader :pdf, :title
    
    # Array of grid cells for the current
    # page of the pdf
    def cells
      @cells ||= []
      if  @cells.empty?
        (0..n_y-1).each do |j|
          (0..n_x-1).each do |i|
            @cells << pdf.grid(j,i)
          end
        end
      end
      @cells
    end

    # Pull values and add the corresponding label
    # to the next available grid, adding pages
    # to the pdf as necessary
    # 
    # @param NumberGenerator(#has_next?,#pull) values
    # 
    def fill_labels(values)
      while values.has_next?
        cells.each do |c|
          # String formatted label based on the given value
          label = Template::label(values.pull)

          c.bounding_box do
            LabelGen.configuration.cell.new(pdf, label).fill
          end
          
          unless values.has_next?
            # exit early because the page is not filled
            # even thouth all numbers are pulled
            return values.number
          end
        end # cells.each
        
        # not all numbers are pulled,
        # so start the next page
        pdf.start_new_page
      end # while count<max_count
      values.number
    end

    private

    def format_page
      pdf.define_grid(:columns => n_x, 
                      :rows => n_y, 
                      :row_gutter => delta_y, 
                      :column_gutter => delta_x)
      
    end

  end
end
