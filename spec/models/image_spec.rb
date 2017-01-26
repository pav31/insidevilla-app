require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image) { Fabricate.build(:image) }

  context "it creates image" do
    it 'creates indeed' do
      expect(image.save).to be_truthy
    end
  end
end
