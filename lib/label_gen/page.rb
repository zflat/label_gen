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
      @title = params[:title] || 'PDF Page'

      @pdf = Prawn::Document.new(:page_size => @page_size, 
                                 #:page_layout => @page_layout,
                                 :margin => @margin,
                                 :info => {
                                   :Title =>@title
                                 })
      format_page
    end

    attr_reader :origin_x, :origin_y, :n_x, :n_y, :delta_x, :delta_y, :frame_width, :frame_height
    attr_reader :pdf, :title

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

    def fill_labels(labels)
      count = 0
      max_count = labels.length
      while count<max_count
        cells.each do |c|
          l = labels[count]
          c.bounding_box do
            LabelGen.configuration.cell.new(pdf, l).fill
          end
          count +=1
          if count >= max_count
            return count
          end
        end # cells.each
        pdf.start_new_page
      end # while count<max_count
      count
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
