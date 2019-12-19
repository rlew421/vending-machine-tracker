require 'rails_helper'

RSpec.describe Snack, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :price}
  end

  describe 'relationships' do
    it {should have_many :machine_snacks}
    it {should have_many(:machines).through(:machine_snacks)}
  end

  describe 'instance methods' do
    it "#average_price" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Super Awesome Vending Machine")

      hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 150)
      pringles = dons.snacks.create!(name: "Pringles", price: 250)
      sour_patch_kids = dons.snacks.create!(name: "Sour Patch Kids", price: 200)

      expect(dons.average_price).to eq(2.00)
    end
  end
end
