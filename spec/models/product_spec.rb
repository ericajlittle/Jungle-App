require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

  before(:each) do
    @category = Category.new()
    @category.name = 'test'

    @product = @category.products.new()
    @product.name = "shirt"
    @product.price = 1.9
    @product.quantity = 2
  end

  it "product has all validations" do
    @product.save
    expect(@product).to be_valid
  end

  it "prodcut name must be presented" do
    @product.name = nil
    @product.save
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end

  it "product quantity must be presented" do
    @product.quantity = nil
    @product.save
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end

  it "product category must be presented" do
    @product.category = nil
    @product.save
    expect(@product.errors.full_messages).to include("Category can't be blank")
  end

  it "product price must be presented" do
    @product.price_cents = nil
    @product.save
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end


  end
end
