require 'rails_helper'

describe Product do
  subject { Product.new(id: 1) }

  it { expect(subject.encoded_id).to eq(623140965) }
end