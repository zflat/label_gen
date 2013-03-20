module LabelGen
  class NumberGenerator

    def initialize(n_numbers)
      @count = n_numbers
      @n_initial = LabelGen.configuration.initial_number
      @number = @n_initial
      @number_max = @number + @count
    end

    attr_reader :number, :count

    def pull
      if has_next?
        @number += 1
      end
    end

    def has_next?
      number < @number_max
    end

  end
end
