require 'rails_helper'

describe Product, type: :model do
  let(:encoded_id) { 623140965 }
  let(:decoded_id) { 1 }

  subject { Product.new(id: decoded_id) }

  it { expect(subject.encoded_id).to eq(encoded_id) }
end
