class Product
    attr_accessor :id, :type, :options

    @@all = []

    def initialize(id, type, options)
        @id = id
        @type = type
        @options = options
        @@all << self
        #Initializes a new instance of a Product and adds it to the @@all array
    end

    def self.all
        @@all
        #Returns the full array of Product instances
    end
    
end 