RSpec.describe Taleo::Employee do
  let(:employee_id) { 1 }
  let(:employee) { client.employee(employee_id) }

  describe 'properties' do
    it 'has an ID' do
      expect(employee.id).to be_a(Integer)
    end
  end

  describe 'relationships' do
    it 'has a candidate' do
      expect(employee.candidate).to be_a(Taleo::Candidate)
    end

    it 'has packets' do
      expect(employee.packets).to all(be_a(Taleo::Packet))
    end
  end
end
