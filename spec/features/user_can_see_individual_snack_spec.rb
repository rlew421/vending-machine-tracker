require 'rails_helper'

RSpec.describe "snack show page" do
  it "I see the name of that snack along with the
  - price
  - a list of locations with vending machines that carry that snack
  - average price for snacks in those vending machines
  - a count of the different kinds of items in that vending machine" do

    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Super Awesome Vending Machine")
    pringles = dons.snacks.create!(name: "Pringles", price: 250)
    sour_patch_kids = dons.snacks.create!(name: "Sour Patch Kids", price: 200)
    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 175)

    julio = owner.machines.create(location: "Julio's Amazing Vending Machine")
    doritos = julio.snacks.create!(name: "Doritos", price: 200)
    ruffles = julio.snacks.create!(name: "Ruffles", price: 300)
    granola_bar = julio.snacks.create!(name: "Granola Bar", price: 500)

    julio.snacks << hot_cheetos

    visit "/snacks/#{hot_cheetos.id}"

    expect(page).to have_content("Price for #{hot_cheetos.name}: #{hot_cheetos.price}")

    within "#machine-#{dons.id}" do
      expect(page).to have_content(dons.location)
      expect(page).to have_content("Average Price: $2.08")
      # expect(page).to have_content("Snack Count: 3")
    end

    within "#machine-#{julio.id}" do
      expect(page).to have_content(julio.location)
      expect(page).to have_content("Average Price: $3.00")
      # expect(page).to have_content("Snack Count: 4")
    end
  end
end

# User Story 3 of 3
#
# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.
