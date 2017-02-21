require 'rails_helper'

RSpec.feature "Visitor clicks on product to navigate to product details page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('electronics2.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They click on product header and see product details page' do
    visit root_path
    first('article.product header').click

    expect(page).to have_css 'article.product-detail'
    save_screenshot 'product-detail.png'
  end

  scenario 'They click on product details button and see product details page' do
    visit root_path
    first('article.product footer .btn-default').click

    expect(page).to have_css 'article.product-detail'
    save_screenshot 'product-detail2.png'
  end
end
