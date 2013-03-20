module LabelGen
  class NumberGenerator

    def initialize(n_numbers)
      @count = n_numbers
      @n_initial = NumberRecord.max_number_used
      @number_max = @n_initial + @count
      @number = @n_initial
    end

    attr_reader :number, :count
    
    def pull
      if has_next?
        NumberRecord.put_used(@number += 1)
      end
    end

    def has_next?
      number < @number_max
    end

  end
end
