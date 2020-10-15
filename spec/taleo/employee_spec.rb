RSpec.describe Taleo::Employee do
  let(:employee_id) { 1 }
  let(:employee) { client.employee(employee_id) }

  describe 'properties' do
    it 'has an ID' do
      expect(employee.id).to be_a(Integer)
    end
  end
end
