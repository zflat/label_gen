require "spec_helper"

module LabelGen

  describe FrameIter do
    
    context "with blank parameters" do
      subject(:frames){FrameIter.new({})}
      
      it "is not nil" do
        expect(frames).to_not be_nil
      end
      
       it "has a single frame" do
        expect(frames.count).to eq 1
      end
    end
    
    context "with [random n rows, random m columns]" do
      let(:n_rows){rand(7)+3}
      let(:m_cols){rand(7)+3}
      let(:count){n_rows * m_cols}
       subject(:frames) do
        FrameIter.new({
                        :n_x => n_rows,
                        :n_y => m_cols
                      })
      end
      
      describe "coordinates" do
        let(:x_col){frames.x_col}
        let(:y_col){frames.y_col}
        
        it "has count x values" do
          expect(x_col.count).to eq count
        end
        
        it "has alternatingly increasing x values" do
          x_col.each do |val0, val1|
            expect(val1).to_be gt val0  unless val1.nil?
          end
        end
        
        it "has count y values" do
          expect(y_col.count).to eq count
        end
        
        it "has periodically decreasing y values" do
          val0 = y_col[0]
          (0..m_cols).each do |i|
            ind0 = i*n_rows
            val1 = y_col[ind0]
            val1.should > val0 unless (i==0 || val1.nil?)
            val0 = val1
            
            unless val0.nil?
              y_col.slice(ind0, n_rows).each do |val|
                expect(val).to eq val0
              end
            end
          end
         end
        
        context "with random x_delta, random y_delta, frame width, frame height" do
          let(:n_rows){rand(7)+3}
          let(:m_cols){rand(7)+3}
          let(:frame_w){rand(7)+3}
          let(:frame_h){rand(7)+3}
          let(:delta_x){rand(7)+3}
          let(:delta_y){rand(7)+3}
          let(:count){n_rows * m_cols}
          subject(:frames) do
            FrameIter.new({
                            :n_x => m_cols,
                            :n_y => n_rows,
                            :frame_width => frame_w,
                            :frame_height => frame_h,
                            :delta_x => delta_x,
                            :delta_y => delta_y
                          })
          end
          
          it "has total height of n_rows(frame_height+delta_y)" do
            expect(frames.total_height).to eq n_rows*(frame_h+delta_y)
          end
          
          it "has total width of m_cols(frame_width+delta_x)" do
            expect(frames.total_width).to eq m_cols*(frame_w+delta_x)          
          end
          
          context "with random origin x and y" do
            let(:n_rows){rand(7)+3}
            let(:m_cols){rand(7)+3}
            let(:frame_w){rand(7)+3}
            let(:frame_h){rand(7)+3}
            let(:delta_x){rand(7)+3}
            let(:delta_y){rand(7)+3}
            let(:origin_x){rand(7)+3}
            let(:origin_y){rand(7)+3}
            let(:count){n_rows * m_cols}
            subject(:frames) do
              FrameIter.new({
                              :n_x => m_cols,
                              :n_y => n_rows,
                              :frame_width => frame_w,
                              :frame_height => frame_h,
                              :delta_x => delta_x,
                              :delta_y => delta_y,
                              :origin_x => origin_x,
                              :origin_y => origin_y
                            })
            end
            let(:total_height){frames.total_height}
            let(:total_width){frames.total_width}
            
            it "has min y coordinate at origin_y" do
              expect(frames.coordinates[0,1]).to eq origin_y
            end
            
            it "has min x coordinate at origin_x" do
              expect(frames.coordinates[0,0]).to eq origin_x
            end
            
            it "has maximum y coordinate at (origin_y+total_height)-(frame_height+deta_y)" do
              expect(frames.coordinates[-1, -1]).to eq ((origin_y+total_height)-(frame_h+delta_y))
            end
            
            it "has maximum x coordinate at (origin_x+total_width)-(frame_width+deta_x)" do
              expect(frames.coordinates[-1, 0]).to eq ((origin_x+total_width)-(frame_w+delta_x))
            end
           end #  context "with random origin x and y" do
          
        end # context "with random x_delta, random y_delta"
        
      end # context "with [random n rows, random m columns]"
      
      it "has the correct count of frames" do
        expect(frames.count).to eq count
      end
      
    end
  end #   describe FrameIter

end # module LabelGen
