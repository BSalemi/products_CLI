require "cli"

describe CLI do

    let(:cli) {CLI.new(["tshirt", "red", "small"])}
    let(:product_hash) {{"sticker"=>{:size=>["x-small", "small", "medium", "large", "x-large"], :style=>[ "matte", "glossy"]}}}


    describe "#new" do
        it "takes an args array consisting of product_type and 0 or more options" do
            expect{CLI.new(["tshirt", "red"])}.to_not raise_error
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

    describe "#display_results_without_options" do
        xit "takes a product hash as an argument" do
            expect(cli.display_results_without_options(product_hash)).to_not raise_error
        end
        xit "iterates over the hash and outputs the information to the console" do
            expect(cli.display_results_without_options(product_hash)).to eq("Size: x-small small medium large x-large \n Style: matte glossy")
        end
    end

end