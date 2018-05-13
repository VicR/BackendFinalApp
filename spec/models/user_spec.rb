require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'valid' do
      it 'should create' do
        u = build(:user)
        expect(u.save).to eq(true)
      end
    end
    context 'invalid' do
      it 'shouldn\'t create with invalid name' do
        bad = build(:user, name: nil)
        expect(bad.save).to eq(false)
      end
      it 'shouldn\'t create with invalid email' do
        bad = build(:user, email: nil)
        expect(bad.save).to eq(false)
      end
      it 'shouldn\'t create with duplicate email' do
        good = create(:user)
        bad = build(:user, email: good.email)
        expect(bad.save).to eq(false)
      end
    end
  end
end
