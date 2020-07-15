class CLI

    attr_accessor :search_type, :search_options

    def initialize(args)
        #Checks if arguments were passed in to CLI. If not, instruct user to do so and exits the CLI.
        if args.length === 0
            puts "Please enter a product type with 0 or more options.".colorize(:red)
            exit
        end

       #Since first argument given by user is always product_type, set @search_type equal to it
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

            if filtered_products.empty?
                puts "Sorry, one or more of your options is invalid. Please try again.".colorize(:red)
                exit
            end

            Product.create_product_hash(filtered_products)
            cli.display_results_with_options(Product.get_product_hash)
        else

            Product.create_product_hash(cli.filter_product)
            cli.display_results_without_options(Product.get_product_hash)
        end
    end


    def self.create_products(product_data)
        product_data.each do |product|
            Product.new(product["id"], product["product_type"], product["options"])
        end
    end

    def filter_product
        #Search for products that match type given by user
        Product.all.filter do |product|
            product.type == @search_type
        end
    end

    def filter_by_options(products)
        #Filter products by type and all options given by user
        products.filter do |product|
            @search_options.all? do |option|
                product.options.value?(option)
            end
        end
    end

    def display_results_without_options(product_hash)
        product = product_hash.keys.include?(@search_type)

        if product
            product_hash[@search_type].each do |category, options|
                puts "#{category.capitalize}:".colorize(:blue) + " #{options.join(" ")}"
            end
        else
            puts "Please enter a valid product type with 0 or more options.".colorize(:red)
            exit
        end
    end

    def display_results_with_options(product_hash)
        new_hash = {}

        product = product_hash.keys.include?(@search_type)

        if product
            #Check if the values of product_hash[@search_type] include @search_options. If it does, calls except! to remove that key/value pair from the hash and set the remaining hash to new_hash.
            @search_options.each do |option|
                product_hash[@search_type].each do |key, value|
                    if value.include?(option)
                        new_hash = product_hash[@search_type].except!(key)
                    end
                end
            end

            new_hash.each do |category, options|
                puts "#{category.capitalize}:".colorize(:blue) + " #{options.join(" ")}"
            end
        else
            puts "Please enter a valid product type with 0 or more options.".colorize(:red)
            exit
        end
    end
end