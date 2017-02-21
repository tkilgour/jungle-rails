require 'rails_helper'

RSpec.feature "Visitor clicks 'Add' to to see their shopping cart quantity increase", type: :feature, js: true do
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

  scenario 'They click \'Add\' and their cart quantity increases by one' do
    visit root_path

    within('.navbar') { expect(page).to have_content('My Cart (0)') }
    save_screenshot 'add-to-cart.png'
    
    first('article.product footer .btn-primary').click

    within('.navbar') { expect(page).to have_content('My Cart (1)') }
    save_screenshot 'add-to-cart2.png'
  end
end
