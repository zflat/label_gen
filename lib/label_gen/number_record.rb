module LabelGen
  class NumberRecord
    
    # Get the last confirmed number from the database
    # or the max number from the configuration,
    # whichever is higher
    def self.max_number_used
      LabelGen.configuration.max_number_used
    end

    # Store the given number as used
    def self.put_used(number)
      number
    end

    # Confirm that the number was used
    def self.confirm_used(number)
      number
    end

    def initialize(number)
      @number = number
    end

    attr_reader :number

    # Indicate if the number
    # is in the database
    def used?
    end

    # Indicate if the number is 
    # confirmed as used
    def confirmed?
    end

  end
end
