require "product"

describe Product do 

    let(:tshirt) {Product.new(1, "tshirt", {:gender => "male", :color => "red", :size => "small"})}

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

end 