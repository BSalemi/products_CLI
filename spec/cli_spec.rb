require "cli"

describe CLI do

    let(:cli) {CLI.new(["tshirt", "red", "small"])}

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
        it "Returns an array of Product instances whose product_type matches @type" do

            red_tshirt = Product.new(4, "tshirt", {:gender => "male", :color => "red", :size => "small"})
            matte_sticker = Product.new(5, "sticker", {:style => "matte", :size => "x-small"})
            blue_shirt = Product.new(6,"tshirt", {:gender => "male", :color => "blue", :size => "medium"})

            expect(cli.filter_products).to eq([red_tshirt, blue_shirt])
        end
    end
end