require 'rails_helper'

describe Address, 'Validations' do
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
end

describe Address, 'Associations' do
  it { should belong_to(:contact) }
end
