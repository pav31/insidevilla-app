require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'Validation' do
    let(:estate) { Fabricate(:estate) }
    let(:move_in) { Date.current }
    let(:move_out) { move_in + 5.days }
    let!(:booking) { Fabricate.build(:booking, estate: estate, status: :pending, move_in_at: move_in, move_out_at: move_out) }

    context '#validate_status_approval' do
      let!(:other_booking) { Fabricate(:booking, estate: estate, status: :approved, move_in_at: move_in, move_out_at: move_out) }

      context "is not valid" do
        describe 'when same estates and status approved' do
          it 'they are really the same' do
            expect(booking.estate_id).to eq(other_booking.estate_id)
          end

          it 'has approved bookings' do
            expect(Booking.approved).not_to be_empty
          end

          it 'when move in and move out dates already booked' do
            expect(booking).to be_invalid
          end

          it 'when other_move_out > move_out > other_move_in' do
            booking.move_out_at = move_out - 1.day
            expect(booking.move_out_at).to be > other_booking.move_in_at
            expect(booking.move_out_at).to be < other_booking.move_out_at
            expect(booking).to be_invalid
          end

          it 'when other_move_out > move_in > other_move_in' do
            booking.move_in_at = move_in + 1.day
            expect(booking.move_in_at).to be > other_booking.move_in_at
            expect(booking.move_in_at).to be < other_booking.move_out_at
            expect(booking).to be_invalid
          end
        end
      end

      context "is valid" do
        it 'when estate_ids are different and dates are the same' do
          other_booking.update(estate: Fabricate(:estate))
          expect(other_booking.approved?).to be_truthy
          expect(booking.estate_id).not_to eq(other_booking.estate_id)
          expect(booking.move_in_at).to eq(other_booking.move_in_at)
          expect(booking).to be_valid
        end

        it 'when move_in == other_move_out' do
          booking.move_in_at = move_out
          booking.move_out_at = move_out + 1.day
          expect(booking.move_in_at).to eq(other_booking.move_out_at)
          expect(booking).to be_valid
        end

        it 'when booking dates prior to other booking dates' do
          other_booking.move_in_at = move_out
          other_booking.move_out_at = move_out + 1.day
          other_booking.save
          expect(booking).to be_valid
        end

        it 'when booking dates ahead of other booking dates' do
          booking.move_in_at = move_out
          booking.move_out_at = move_out + 1.day
          expect(booking).to be_valid
        end

        it 'when approved and updating record' do
          expect(other_booking.approved?).to be_truthy
          other_booking.pending!
          expect(other_booking.approved?).to be_falsey
          expect(other_booking).to be_valid
        end

        it 'when other_booking not approved' do
          other_booking.pending!
          expect(other_booking.approved?).to be_falsey
          expect(booking.move_in_at).to eq(other_booking.move_in_at)
          expect(booking).to be_valid
        end
      end
    end

    context "#validate_move_in_at && #validate_move_out_at" do
      context "is valid" do
        it 'when move_in is today' do
          booking.move_in_at = Date.current
          expect(booking).to be_valid
        end

        it 'when move_out > move_in' do
          booking.move_out_at = move_in + 1.day
          expect(booking).to be_valid
        end

        it 'when updating and move_in is in the past' do
          booking.save!
          booking.move_in_at = Date.current - 1.day
          expect(booking).to be_valid
        end
      end

      context "is not valid" do
        it 'when move_in date is in the past' do
          booking.move_in_at = Date.current - 1.day
          expect(booking).to be_invalid
        end

        it 'when move_in date is not present' do
          booking.move_in_at = nil
          expect(booking.move_in_at).to be_nil
          expect(booking).to be_invalid
        end

        it 'when move_out date is not present' do
          booking.move_out_at = nil
          expect(booking.move_out_at).to be_nil
          expect(booking).to be_invalid
        end

        it 'when move_out < move_in' do
          booking.move_out_at = move_in - 1.day
          expect(booking.move_out_at).to be < move_in
          expect(booking).to be_invalid
        end

        it 'when move_out == move_in' do
          booking.move_out_at = move_in
          expect(booking.move_out_at).to be == move_in
          expect(booking).to be_invalid
        end
      end
    end
  end
end
