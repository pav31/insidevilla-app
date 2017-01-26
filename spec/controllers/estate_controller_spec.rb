require 'rails_helper'

RSpec.describe EstatesController, type: :controller do
  let!(:user) { Fabricate(:user) }

  let(:valid_attributes) do
    {
      title_en: FFaker::HipsterIpsum.words(rand(1..2)).join(' '),
      title_ru: FFaker::HipsterIpsum.words(rand(1..2)).join(' '),
      description_en: FFaker::HipsterIpsum.paragraph(rand(5..10)),
      description_ru: FFaker::HipsterIpsum.paragraph(rand(5..10)),
      region: Estate.regions.sample,
      tenure_type: Estate.tenure_types.sample,
      estate_type: Estate.estate_types.sample,
      estate_class: Estate.estate_classes.sample,
      cleaning_period: (Estate.cleaning_periods + [nil]).sample,
      featured: [true, false].sample,
      address: FFaker::Address.street_address,
      latitude: FFaker::Geolocation.lat,
      longitude: FFaker::Geolocation.lng,
      area_size: rand(20..200),
      price_cents: rand(30..5000) * 100,
      available: true,
      draft: false,
      bedrooms: rand(1..5),
      bathrooms: rand(1..5),
      sea_distance: rand(0.1..20.0).round(2),
      main_image: Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/jpg'),
      slider: Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/jpg')
    }
  end

  let(:invalid_attributes) do
    {
      title_en: FFaker::HipsterIpsum.words(rand(1..2)).join(' '),
      title_ru: FFaker::HipsterIpsum.words(rand(1..2)).join(' ')
    }
  end

  let(:valid_image_attrs) do
    {
      name: FFaker::HipsterIpsum.words(rand(2)).join(' '),
      attachment: Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/jpg')
    }
  end

  describe "GET index" do
    before do
      Fabricate.times(2, :estate, tenure_type: 'rent')
      Fabricate.times(2, :estate, tenure_type: 'sale')
    end

    it 'returns estates' do
      get :index
      expect(response).to have_http_status :success
      expect(assigns(:estates).count).to eq 4
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'returns estates for rent' do
      get :index, tenure_type: 'rent'
      expect(assigns(:estates).count).to eq 2
      expect(assigns(:estates).map(&:id)).to match_array(Estate.rent.pluck(:id))
    end

    it 'returns estates for sale' do
      get :index, tenure_type: 'sale'
      expect(assigns(:estates).count).to eq 2
      expect(assigns(:estates).map(&:id)).to match_array(Estate.sale.pluck(:id))
    end
  end

  describe "PATCH update" do
    let!(:estate) { Fabricate(:estate, tenure_type: 'rent') }

    context 'when user signed in' do
      before { sign_in user }

      it 'updates tenure_type' do
        patch :update, id: estate.id, estate: { tenure_type: 'sale' }
        expect(response).to have_http_status :redirect
        expect(assigns(:estate).tenure_type).to eq('sale')
      end

      it 'redirects to estate show page' do
        patch :update, id: estate.id, estate: valid_attributes
        expect(response).to redirect_to(estate_path(estate))
      end
    end

    context 'when user NOT signed in' do
      before { sign_out user }

      it 'does not update estate' do
        patch :update, id: estate.id, estate: { tenure_type: 'sale' }
        expect(response).to have_http_status :redirect
        expect(estate.reload.tenure_type).to eq('rent')
      end

      it 'redirects to estate show page' do
        patch :update, id: estate.id, estate: valid_attributes
        expect(response).to redirect_to(estate_path(estate))
      end
    end
  end
end
