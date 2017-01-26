require 'rails_helper'

RSpec.describe Estate, type: :model do
  let!(:estate) { Fabricate(:estate) }

  describe 'estate#bookings' do
    let!(:start) { Date.current + 3.days }
    let!(:finish) { start + 2.days }

    let!(:other_estate) { Fabricate(:estate) }

    let!(:first_booking) { Fabricate(:booking, estate: estate, move_in_at: start - 3.days, move_out_at: finish - 1.day, status: :pending) }
    let!(:second_booking) { Fabricate(:booking, estate: estate, move_in_at: start, move_out_at: finish, status: :pending) }
    let!(:third_booking) { Fabricate(:booking, estate: estate, move_in_at: start + 1.day, move_out_at: finish + 1.day, status: :pending) }
    let!(:booking_before_start) { Fabricate(:booking, estate: estate, move_in_at: start - 3.days, move_out_at: start - 1.day, status: :pending) }
    let!(:booking_after_finish) { Fabricate(:booking, estate: estate, move_in_at: finish + 1.day, move_out_at: finish + 2.days, status: :pending) }
    let!(:other_estate_booking) { Fabricate(:booking, estate: other_estate, move_in_at: start, move_out_at: finish, status: :pending) }

    context '#bookings_within_dates' do
      it 'includes bookings that between the dates range' do
        expected_bookings = [first_booking, second_booking, third_booking]
        expect(estate.bookings_within_dates(start, finish)).to match_array(expected_bookings)
      end

      it 'ordered by move_in_at' do
        bookings = estate.bookings_within_dates(start, finish)
        expect(bookings.first).to eq(first_booking)
        expect(bookings.second).to eq(second_booking)
        expect(bookings.third).to eq(third_booking)
      end

      it 'doen\'t include bookings where move_out_at before start date' do
        expect(estate.bookings_within_dates(start, finish)).not_to include(booking_before_start)
      end

      it 'doen\'t include bookings where move_in_at after finish date' do
        expect(estate.bookings_within_dates(start, finish)).not_to include(booking_after_finish)
      end

      it 'doen\'t include bookings of other estate when within the dates range' do
        expect(estate.bookings_within_dates(start, finish)).not_to include(other_estate_booking)
      end
    end
  end

  context 'it creates images' do
    let(:image) { Fabricate.build(:image) }

    context "it creates image" do
      it 'creates indeed' do
        expect { estate.images.create(image.attributes) }.to change(Image, :count).by(1)
      end
    end
  end
end
