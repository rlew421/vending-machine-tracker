require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  it "I see the name of all the snacks associated with that vending machine along with their price" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 1.75)
    pringles = dons.snacks.create!(name: "Pringles", price: 2.50)
    sour_patch_kids = dons.snacks.create!(name: "Sour Patch Kids", price: 2.00)

    visit machine_path(dons)

    within "#snack-#{hot_cheetos.id}" do
      expect(page).to have_content(hot_cheetos.name)
      expect(page).to have_content(hot_cheetos.price)
    end

    within "#snack-#{pringles.id}" do
      expect(page).to have_content(pringles.name)
      expect(page).to have_content(pringles.price)
    end

    within "#snack-#{sour_patch_kids.id}" do
      expect(page).to have_content(sour_patch_kids.name)
      expect(page).to have_content(sour_patch_kids.price)
    end
  end
end
