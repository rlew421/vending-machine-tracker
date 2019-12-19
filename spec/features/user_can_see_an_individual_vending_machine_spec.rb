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
    dons  = owner.machines.create(location: "Don's Super Awesome Vending Machine")

    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 150)
    pringles = dons.snacks.create!(name: "Pringles", price: 250)
    sour_patch_kids = dons.snacks.create!(name: "Sour Patch Kids", price: 200)

    visit machine_path(dons)

    within "#snack-#{hot_cheetos.id}" do
      expect(page).to have_content(hot_cheetos.name)
      expect(page).to have_content("Price: $#{hot_cheetos.price}")
    end

    within "#snack-#{pringles.id}" do
      expect(page).to have_content(pringles.name)
      expect(page).to have_content("Price: $#{pringles.price}")
    end

    within "#snack-#{sour_patch_kids.id}" do
      expect(page).to have_content(sour_patch_kids.name)
      expect(page).to have_content("Price: $#{sour_patch_kids.price}")
    end
  end

  it "I see an average price for all the snacks in that machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Super Awesome Vending Machine")

    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 175)
    pringles = dons.snacks.create!(name: "Pringles", price: 250)
    sour_patch_kids = dons.snacks.create!(name: "Sour Patch Kids", price: 200)

    visit machine_path(dons)

    expect(page).to have_content("Average Price: $2.08")
  end
end
