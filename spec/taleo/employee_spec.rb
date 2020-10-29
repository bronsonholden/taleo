# frozen_string_literal: true

RSpec.describe Taleo::Employee do
  let(:employee_id) { 1 }
  let(:employee) { client.employee(employee_id) }

  describe 'search' do
    it 'returns results' do
      expect(client.employees.items).to all(be_a(Taleo::Employee))
    end
  end

  describe 'properties' do
    it 'has an ID' do
      expect(employee.id).to be_a(Integer)
    end

    it 'has a first name' do
      expect(employee.first_name).to be_a(String)
    end

    it 'has a last name' do
      expect(employee.last_name).to be_a(String)
    end

    it 'has a location ID' do
      expect(employee.location_id).to be_a(Integer)
    end

    it 'has an SSN' do
      expect(employee.ssn).to be_a(String)
    end
  end

  describe 'relationships' do
    it 'has a candidate' do
      expect(employee.candidate).to be_a(Taleo::Candidate)
    end

    it 'has packets' do
      expect(employee.packets).to all(be_a(Taleo::Packet))
    end

    it 'has a location' do
      expect(employee.location).to be_a(Taleo::Location)
    end

    it 'has attachments' do
      expect(employee.attachments).to all(be_a(Taleo::Attachment))
    end
  end
end
