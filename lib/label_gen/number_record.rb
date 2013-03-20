module LabelGen
  class NumberRecord

    include DataMapper::Resource

    # Get the last number record from the database
    # or the max number from the configuration,
    # whichever is higher
    def self.max_number_used
      [LabelGen.configuration.max_number_used,
       self.max_number_persisted].max
    end

    # Get the last confirmed number from the database
    # or the max number from the configuration,
    # whichever is higher
    def self.max_number_confirmed
      [LabelGen.configuration.max_number_used,
       self.max_persisted_confirmed].max
    end
    
    # Store the given number as used
    # unless it is already stored
    def self.put_used(number)
      unless self.confirmed?(number)
        number if self.first(:number => number) || self.new(number, :used => true).save
      end
    end

    # Store a record to confirm that the number was used
    def self.confirm_used(number)
      r = self.first(:number => number)
      ret = r.confirm!(true) unless r.nil?
    end

    # Check if the number has been used
    def self.used?(number)
      r = self.first(:number => number)
      r && r.used?
    end

    # Check if the number has been used and confirmed
    def self.confirmed?(number)
      r = self.first(:number => number)
      r && r.used? && r.confirmed?
    end

    property :id, Serial
    property :number, Integer
    property :used_at, DateTime
    property :confirmed_at, DateTime

    validates_uniqueness_of :number

    def initialize(number_val, flags={})
      self.number = number_val

      self.use! flags[:used]
      self.confirm! flags[:confirm]
    end
    
    attr_reader :number

    def use!(check)
      if check
        self.used_at = Time.now
        self.save
      end
    end

    def confirm!(check)
      if self.used? && check
        self.confirmed_at = Time.now
        self.save
      end
    end

    # Indicate if the number
    # is in the database
    def used?
      self.used_at
    end

    # Indicate if the number is 
    # confirmed as used
    def confirmed?
      self.confirmed_at
    end

    private
    
    # Get the highest number that is stored
    # or 0 if nothing is stored
    def self.max_number_persisted
      self.count > 0 ? self.last.number : 0
    end

    def self.max_persisted_confirmed
      max_persisted = self.last(:confirmed_at.not => nil)
      (max_persisted.nil?) ? 0 : max_persisted.number
    end

  end
end
