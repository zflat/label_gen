module LabelGen
  class NumberGenerator

    def initialize(n_numbers)
      @count = n_numbers.floor
      @n_initial = NumberRecord.max_number_confirmed
      @number = @n_initial
    end

    attr_reader :number, :count
    
    def pull
      if has_next?
        NumberRecord.put_used(@number += 1)
      end
    end

    def has_next?
      number < number_max
    end

    private
    
    def number_max
      @number_max ||= @n_initial + count
    end

  end
end
