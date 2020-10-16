RSpec.describe Taleo::Activity do
  let(:activity_id) { 1 }
  let(:activity) { client.activity(activity_id) }

  describe 'properties' do
    it 'has an ID' do
      expect(activity.id).to be_a(Integer)
    end

    it 'has an employee' do
      expect(activity.employee_id).to be_a(Integer)
    end
  end

  describe 'relationships' do
    it 'has an employee' do
      expect(activity.employee).to be_a(Taleo::Employee)
    end
  end
end
