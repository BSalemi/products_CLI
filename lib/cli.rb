class CLI

    attr_accessor :type, :options, :product_data

    def initialize(args)
        #Checks if arguments were passed in to CLI. If not, instruct user to do so and exits the CLI.
        if args.length === 0
            puts "Please enter a product type with 0 or more options.".colorize(:red)
            exit
        end

        #Sets the first argument of args to the @type instance variable.
        @type = args.first.downcase

        self.set_options(args) if args.length > 1
        
    end

    def set_options(options)
        #Stores the remaining options entered by the user to the @options instance variable.
        @options = options.slice(1, options.length)
    end

    def self.run(product_data, args)
        cli = self.new(args)

        self.create_products(product_data)

        Product.create_product_hash(product_data)

        cli.display_results(Product.get_product_hash)
        
    end


    def self.create_products(product_data)
        product_data.each do |product|
            Product.new(product["id"], product["product_type"], product["options"])
        end
    end

    def display_results(product_hash)
        product_keys = product_hash.keys
        product = product_keys.include?(@type)

        if product

            if @options.nil?
                #If product is one of the keys in product_hash and @@options is nil.
                self.results_no_options(product_hash)
            else
                product_values = product_hash[@type].values.flatten 

                if !@options.any?{|option| product_values.include?(option)}
                    puts "Sorry, one or more of your options is invalid. Please try again.".colorize(:red)
                    exit
                end
                #If options are found within the product_hash
                new_hash = {}

                #Create an empty hash and set the options (without the product_type) equal to prod_options
                @options.each do |option|
                    product_hash[@type].each do |key, value|
                        if value.include?(option)
                            new_hash = product_hash[@type].except!(key)
                        end
                    end
                end
                #Iterate over the options and @@product_hash to check if any of the values include
                #the current option. If so use except! method to remove the entire key (with values)
                #from the hash and set that equal to new_hash.

                new_hash.each do |category, options|
                    puts "#{category.capitalize}:".colorize(:green)
                    puts" #{options.join(" ")}"
                end

                #Iterate over new_hash and print out the remaining category names with capitalized
                #first letters and the corresponding option types below them
            end
        else
            puts "Please enter a valid product type (i.e. #{product_keys.join(", ")}) with 0 or more options.".colorize(:red)
            exit
        end
    end

    def results_no_options(product_hash)
        product_hash[@type].each do |category, options|
            puts "#{category.capitalize}:".colorize(:green)
            puts" #{options.join(" ")}"
        end
    end

    
end