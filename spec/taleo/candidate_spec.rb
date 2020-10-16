# frozen_string_literal: true

RSpec.describe Taleo::Candidate do
  let(:candidate_id) { 1 }
  let(:candidate) { client.candidate(candidate_id) }

  describe 'properties' do
    it 'has an ID' do
      expect(candidate.id).to be_a(Integer)
    end

    it 'has an employee' do
      expect(candidate.employee_id).to be_a(Integer)
    end
  end

  describe 'relationships' do
    it 'has an employee' do
      expect(candidate.employee).to be_a(Taleo::Employee)
    end

    it 'has a resume' do
      expect(candidate.has_resume?).to be_truthy
      expect(candidate.resume).to be_a(StringIO)
    end

    it 'has attachments' do
      expect(candidate.has_attachments?).to be_truthy
      expect(candidate.attachments).to all(be_a(Taleo::Attachment))
    end
  end
end
