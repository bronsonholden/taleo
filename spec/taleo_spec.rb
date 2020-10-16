# frozen_string_literal: true

RSpec.describe Taleo do
  describe 'client' do
    describe 'service locator' do
      it 'does not raise error' do
        expect { client.api_url! }.not_to raise_error
      end

      it 'returns API URL' do
        expect(client.api_url!).to be_a(String)
      end
    end
  end
end
