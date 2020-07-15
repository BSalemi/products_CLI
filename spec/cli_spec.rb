require "cli"
require "active_support/core_ext/hash"


describe CLI do

    #This was actually the first time I've written RSpec tests. I'm really excited to continue to learn how to write proper tests and I plan to continue researching the topic. I used the information from these two tutorials to write my tests to the best of my understanding. 
    # https://semaphoreci.com/community/tutorials/getting-started-with-rspec
    # https://www.rubyguides.com/2018/07/rspec-tutorial/

    let(:cli) {CLI.new(["tshirt", "red", "small"])}
    let(:cli2) {CLI.new(["sticker"])}
    let(:cli3) {CLI.new(["sticker", "glossy"])}
    let(:product_hash) {{"sticker"=>{:size=>["x-small", "small", "medium", "large", "x-large"], :style=>[ "matte", "glossy"]}}}
    let(:product_hash2) {{"sticker"=>{:size=>["medium", "large", "x-large"], :style=>[ "glossy"]}}}


    describe "#new" do
        it "takes an args array consisting of product_type and 0 or more options" do
            expect{CLI.new(["tshirt", "red"])}.to_not raise_error
        end
        it "sets @search_type equal to the first element in the args array" do
            expect(cli.instance_variable_get(:@search_type)).to eq("tshirt")
        end
    end

    describe ".run" do
        xit "takes product_data and args array as arguments and initializes a new CLI instance" do

            product_data = [{
                "id": 59,
                "product_type": "sticker",
                "options": {
                  "size": "large",
                  "style": "glossy"
                }
              },
              {
                "id": 60,
                "product_type": "sticker",
                "options": {
                  "size": "x-large",
                  "style": "glossy"
                }
              }]

            expect(CLI.run(product_data, ["tshirt","red"])).to_not raise_error 
            end
        end

    describe "#set_options" do
        it "takes an array of options and sets the elements from index 1 equal to @search_options" do
            expect(cli.set_options(["tshirt","red", "small"]))
            expect(cli.search_options).to eq(["red","small"])
        end
    end

    describe ".create_products" do
        it "takes an array of objects and uses it to create instances of the Product class" do

            product_data = [{
                "id": 59,
                "product_type": "sticker",
                "options": {
                  "size": "large",
                  "style": "glossy"
                }
              },
              {
                "id": 60,
                "product_type": "sticker",
                "options": {
                  "size": "x-large",
                  "style": "glossy"
                }
              }]

            expect(CLI.create_products(product_data))
            expect(Product.all).to_not equal([])
        end
    end

    describe "#filter_products" do
        it "returns an array of Product instances whose product_type matches @type" do

            red_shirt = Product.new(4, "tshirt", {:gender => "male", :color => "red", :size => "small"})
            matte_sticker = Product.new(5, "sticker", {:style => "matte", :size => "x-small"})
            blue_shirt = Product.new(6,"tshirt", {:gender => "male", :color => "blue", :size => "medium"})

            expect(cli.filter_products).to eq([red_shirt, blue_shirt])
        end
    end

    describe "#filter_by_options" do
        it "takes an array of products whose types match @type and filters them by @search_options" do

            tshirt_a = Product.new(7, "tshirt", {:gender => "female", :color => "red", :size => "small"})
            tshirt_b = Product.new(8,"tshirt", {:gender => "male", :color => "blue", :size => "medium"})
            tshirt_c = Product.new(9,"tshirt", {:gender => "female", :color => "red", :size => "large"})

            expect(cli.filter_by_options([tshirt_a, tshirt_b, tshirt_c])).to eq([tshirt_a])
        end
    end

    describe "#display_results_no_options" do
        xit "takes a product hash as an argument" do
            expect(cli2.display_results_no_options(product_hash)).to_not raise_error
        end
        xit "iterates over the hash and outputs the information to the console" do
            expect(cli2.display_results_no_options(product_hash)).to eq("Size: x-small small medium large x-large \n Style: matte glossy")
        end
    end

    describe "#display_results_with_options" do
        xit "takes a product hash as an argument" do 
            expect{cli3.display_results_with_options(product_hash2)}.to_not raise_error 
        end 
        xit "iterates over the hash, removes the keys & values that match @search_options, and outputs the remaining information to the console" do 
            expect(cli3.display_results_with_options(product_hash2)).to eq("Size: medium large x-large")
        end
    end

end