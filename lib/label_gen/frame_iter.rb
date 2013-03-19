class FrameIter
  
  
  def initialize(params)
    params.merge!{
      :n_x => 1,
      :n_y => 1,
      :origin_x => 0,
      :origin_y => 0,
      :delta_x => 0,
      :delta_y => 0
      :frame_width => 0
      :frame_height => 0
    }
    @geom = OpenStruct.new(params)

    @n_x = params[:n_x] || 1
    @n_y = params[:n_y] || 1
    @origin_x = params[:origin_x] || 0
    @origin_y = params[:origin_y] || 0
    @delta_x =  params[:delta_x] || 0
    @delta_y =  params[:delta_x] ||0
    @frame_width = params[:frame_width] || 0
    @frame_height = params[:frame_height] || 0
  end

  attr_reader :origin_x, :origin_y, :n_x, :n_y, :delta_x, :delta_y, :frame_width, :frame_height

  include Enumerable
  
  def x_col
    ((0..(n_x-1)).map {|i| i*delta_x + origin_x })
  end

  def y_col
    ((0..(n_y-1)).map {|i| i*delta_y + origin_y })
  end

  def coord(i, j)
    [i*delta_x+origin_x, j*delta_y+origin_y]
  end
  
  def coordinates
    Matrix.build(n_x, n_y) do |i, j|
      coord(i,j)
    end
  end

  def each
    int x=origin_x
    int y=origin_y
    
    (0..n_x).each do |x_n|
      coord_x = x_n * 
    self.to_a.each do |s|
      yield s
    end
  end #each

end
