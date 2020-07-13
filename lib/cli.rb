class CLI

    attr_accessor :type, :options, :product_data

    def initialize(args)
        #Checks if arguments were passed in to CLI. If not, instruct user to do so and exits the CLI.
        if args.length === 0
            puts "Please enter a product type with 0 or more options (i.e. tshirt red).".colorize(:red)
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

        puts Product.first.inspect
        #testing
    end


    def self.create_products(product_data)
        product_data.each do |product|
            Product.new(product["id"], product["product_type"], product["options"])
        end
    end

end