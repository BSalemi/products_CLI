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

    end 

    def self.run(product_data, args)
        cli = self.new(args)

        puts "hi test"
    end 




end