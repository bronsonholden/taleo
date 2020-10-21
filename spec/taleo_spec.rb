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

    describe 'login' do
      it 'does not raise error' do
        expect { client.login }.not_to raise_error
      end
    end

    describe 'logout' do
      it 'does not raise error' do
        expect { client.logout }.not_to raise_error
      end
    end
  end
end
