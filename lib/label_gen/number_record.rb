module LabelGen
  class NumberRecord

    include DataMapper::Resource

    # Get the last confirmed number from the database
    # or the max number from the configuration,
    # whichever is higher
    def self.max_number_used
      LabelGen.configuration.max_number_used
    end

    # Store the given number as used
    def self.put_used(number)
      unless confirm_used(number)
        number if self.new(number, :used => true).save
      end
    end

    # Confirm that the number was used
    def self.confirm_used(number)
      r = self.first(:number => number)
      r.confirm(true) unless r.nil?
    end

    property :id, Serial
    property :number, Integer
    property :used_at, DateTime
    property :confirmed_at, DateTime

    def initialize(number, flags={})
      @number = number

      self.use flags[:used]
      self.confirm flags[:confirm]
    end

    attr_reader :number

    def use(check)
      used_at = check ? Time.now : nil
    end

    def confirm(check)
      if self.used?
        confirmed_at = check ? Time.now : nil
      end
    end

    # Indicate if the number
    # is in the database
    def used?
    end

    # Indicate if the number is 
    # confirmed as used
    def confirmed?
      false
    end

  end
end
