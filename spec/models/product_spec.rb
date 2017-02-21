require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Validations' do

    before do
      @category = Category.new(name: 'Food')
    end

    it 'should validate presence of all attributes' do
      @product = Product.create(
        name: 'Timbits',
        price: 299,
        quantity: 20,
        category: @category
      )
      expect(@product.valid?).to eql(true)
    end

    it 'should not validate when name is nil' do
      @product = Product.create(
        name: nil,
        price: 299,
        quantity: 20,
        category: @category
      )
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not validate when price is nil' do
      @product = Product.create(
        name: 'Timbits',
        price: nil,
        quantity: 20,
        category: @category
      )
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not validate when quantity is nil' do
      @product = Product.create(
        name: 'Timbits',
        price: 299,
        quantity: nil,
        category: @category
      )
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not validate when category is nil' do
      @product = Product.create(
        name: 'Timbits',
        price: 299,
        quantity: 20,
        category: nil
      )
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    # it { is_expected.to validate_presence_of(:name) }
    # it { is_expected.to validate_presence_of(:price) }
    # it { is_expected.to validate_presence_of(:quantity) }
    # it { is_expected.to validate_presence_of(:category) }
  end
end
