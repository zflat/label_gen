require 'matrix'

class FrameIter
  
  def initialize(params)
    @n_x = params[:n_x] || 1
    @n_y = params[:n_y] || 1
    @origin_x = params[:origin_x] || 0
    @origin_y = params[:origin_y] || 0
    @delta_x =  params[:delta_x] || 1
    @delta_y =  params[:delta_y] ||1
    @frame_width = params[:frame_width] || 1
    @frame_height = params[:frame_height] || 1
  end

  attr_reader :origin_x, :origin_y, :n_x, :n_y, :delta_x, :delta_y, :frame_width, :frame_height

  include Enumerable
  
  def x_col
    ((0..(n_x-1)).map {|i| i*(delta_x+frame_width) + origin_x }) * n_y
  end

  def y_col
    ((0..(n_y-1)).map {|i| [i*(delta_y+frame_height) + origin_y]*n_x }).flatten
  end

  def total_height
    y_col[-1]+delta_y+frame_height - origin_y
  end

  def total_width
    coordinates[-1,0]+delta_x+frame_width - origin_x
  end

  def coordinates
    Matrix[x_col, y_col].transpose
  end

  def each
    self.coordinates.row_vectors.each do |r|
      yield r
    end
  end #each

end
