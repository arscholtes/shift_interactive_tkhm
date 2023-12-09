require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'is valid with valid attributes' do
    address = build(:address)
    expect(address).to be_valid
  end
end
