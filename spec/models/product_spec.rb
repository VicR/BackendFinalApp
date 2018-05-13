require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    context 'valid' do
      it 'should create' do
        pr = build(:product)
        expect(pr.save).to eq(true)
      end
    end
    context 'invalid' do
      it 'shouldn\'t create with invalid model' do
        bad = build(:product, model: nil)
        expect(bad.save).to eq(false)
      end
    end
  end
end
