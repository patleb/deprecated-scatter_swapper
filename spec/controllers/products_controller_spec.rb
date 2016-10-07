require 'rails_helper'

describe ProductsController do
  describe '#show' do
    let(:encoded_id) { 623140965 }
    let(:decoded_id) { 1 }

    it 'converts :id param' do
      get :show, params: { id: encoded_id }

      expect(response.body).to include("<p>#{decoded_id}</p>")
    end

    context 'when ' do
      before do
        ScatterSwapper.configure do |config|
          config.skip_controller_params = true
        end
      end

      after { ScatterSwapper.class_variable_set :@@config, nil }

      it 'does not convert :id params' do
        get :show, params: { id: encoded_id }

        expect(response.body).to include("<p>#{encoded_id}</p>")
      end
    end
  end
end
