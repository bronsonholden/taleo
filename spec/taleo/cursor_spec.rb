# frozen_string_literal: true

RSpec.describe Taleo::Cursor do
  let(:params) { {'lastUpdated_from': '2000-01-01T00:00PST'} }
  let(:start_cursor) { client.employees(1, params: params) }
  let(:end_cursor) { client.employees(999999, params: params) }

  describe 'pagination checks' do
    it 'has next results' do
      expect(start_cursor.has_next?).to be_truthy
      expect(end_cursor.has_next?).to be_falsey
    end

    it 'has previous results' do
      expect(start_cursor.has_previous?).to be_falsey
      expect(end_cursor.has_previous?).to be_truthy
    end

    it 'returns next page' do
      expect(start_cursor.next_page.items.size).to be > 0
      expect { end_cursor.next_page }.to raise_error(Taleo::Error)
    end

    it 'returns previous page' do
      expect { start_cursor.previous_page }.to raise_error(Taleo::Error)
      # Do this instead of using end cursor, so we're guaranteed to get
      # results from previous_page. Taleo searches don't clamp to valid
      # result ranges.
      expect(start_cursor.next_page.previous_page.items.size).to be > 0
    end
  end
end
