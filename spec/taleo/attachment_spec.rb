# frozen_string_literal: true

RSpec.describe Taleo::Attachment do
  let(:candidate_id) { 1 }
  let(:candidate) { client.candidate(candidate_id) }
  let(:attachment) { candidate.attachments.first }

  describe 'downloading' do
    it 'can be downloaded' do
      expect(attachment.can_download?).to be_truthy
      expect(attachment.download).to be_a(StringIO)
    end
  end

  describe 'properties' do
    it 'has an ID' do
      expect(attachment.id).to be_a(Integer)
    end

    it 'has an attachment type' do
      expect(attachment.type).to be_a(String)
    end

    it 'has a content type' do
      expect(attachment.content_type).to be_a(String)
    end
  end
end
