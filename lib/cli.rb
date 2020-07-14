class CLI

    attr_accessor :search_type, :search_options, :product_data

    def initialize(args)
        #Checks if arguments were passed in to CLI. If not, instruct user to do so and exits the CLI.
        if args.length === 0
            puts "Please enter a product type with 0 or more options.".colorize(:red)
            exit
        end

        #Sets the first argument of args to the @search_type instance variable.
        @search_type = args.first.downcase

        self.set_options(args) if args.length > 1
        
    end

    def set_options(options)
        #Stores the remaining options entered by the user to the @search_options instance variable.
        @search_options = options.slice(1, options.length)
    end

    def self.run(product_data, args)
        cli = self.new(args)

        self.create_products(product_data)

        if args.length > 1
            filtered_products = cli.filter_by_options(cli.filter_product)
            Product.create_product_hash(filtered_products)
            cli.display_results(Product.get_product_hash)
        else

        Product.create_product_hash(cli.filter_product)
        cli.display_results(Product.get_product_hash)
        end
    end


    def self.create_products(product_data)
        product_data.each do |product|
            Product.new(product["id"], product["product_type"], product["options"])
        end
    end

    def filter_product
        # search for products that match type given by user
        Product.all.filter do |product|
            product.type == @search_type
        end
    end

    def filter_by_options(products)
        products.filter do |product|
            @search_options.all? do |option|
                product.options.value?(option)
            end
        end
    end

    def display_results(product_hash)
        product_keys = product_hash.keys
        product = product_keys.include?(@search_type)

        if product

            if @search_options.nil?
                #If product is one of the keys in product_hash and @@search_options is nil.
                self.results_no_options(product_hash)
            else
                product_values = product_hash[@search_type].values.flatten 

                if !@search_options.any?{|option| product_values.include?(option)}
                    puts "Sorry, one or more of your options is invalid. Please try again.".colorize(:red)
                    exit
                end
                #If options are found within the product_hash
                self.results_with_options(product_hash)  
            end     
        else
            puts "Please enter a valid product type (i.e. #{product_keys.join(", ")}) with 0 or more options.".colorize(:red)
            exit
        end
    end

    def results_no_options(product_hash)
        product_hash[@search_type].each do |category, options|
            puts "#{category.capitalize}:".colorize(:green)
            puts" #{options.join(" ")}"
        end
    end

    def results_with_options(product_hash)
        new_hash = {}

        #Create an empty hash and set the options (without the product_type) equal to prod_options
        @search_options.each do |option|
            product_hash[@search_type].each do |key, value|
                if value.include?(option)
                    new_hash = product_hash[@search_type].except!(key)
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

end