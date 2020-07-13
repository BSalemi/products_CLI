class Product
    attr_accessor :id, :type, :options

    @@all = []

    @@product_hash = {}

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

    def self.create_product_hash(product_data)
        @@product_hash = {}
        product_data.each do |product|
            product_type = product["product_type"]
            # If the product is not already in our product_hash then we should add it.
          if @@product_hash[product_type].nil?
            @@product_hash[product_type] = {}  # The product's indiviual options

             #Create a new list of choices for each option
            product["options"].each do |key, value|
              @@product_hash[product_type][key] = [value]
            end
          else
            #If the product is already in our list, then add the new choices to the
            # product_hash if they are not already included.
            product["options"].each do |key, value|
              unless @@product_hash[product_type][key].include?(value)
                @@product_hash[product_type][key].push(value)
              end
            end
          end
        end
        binding.pry
    end

end 