require "product"

describe Product do 

    let(:tshirt) {Product.new(1, "tshirt", {:gender => "male", :color => "red", :size => "small"})}
    let(:matte_sticker) {Product.new(2, "sticker", {:style => "matte", :size => "small"})}
    let(:glossy_sticker) {Product.new(2, "sticker", {:style => "glossy", :size => "medium"})}

    let(:product_array) {[glossy_sticker, matte_sticker]}

    let(:product_hash) {{"sticker"=>{:size=>["medium", "small"], :style=>["glossy", "matte"]}}}



    describe '#new' do
        it "it takes in three arguments: an @id, @product_type, and @options" do
          expect{Product.new(1, "tshirt", {
            :gender => "male",
            :color => "red",
            :size => "small"
          })}.to_not raise_error
        end
        it "has a class variable, @@all, the points to an array of Product instances" do
          expect(Product.class_variable_get(:@@all)).to be_a(Array)
        end
    end

    describe ".all" do
        it "returns all instances of Product that have been created" do
          expect(Product.all).to include(tshirt)
        end
    end

    describe ".create_product_hash" do
        it "takes an array of Product instances as an argument" do
            expect{Product.create_product_hash(product_array)}.to_not raise_error
        end
        it "iterates over the array and populates the @@product_hash variable with the data" do
            expect(Product.class_variable_get(:@@product_hash)).to eq(product_hash)
        end
    end

    describe ".get_product_hash" do
        it "returns the @@product_hash" do
            expect(Product.get_product_hash).to equal(Product.class_variable_get(:@@product_hash))
        end
    end



end