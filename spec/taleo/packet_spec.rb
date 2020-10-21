# frozen_string_literal: true

RSpec.describe Taleo::Packet do
  let(:packet_id) { 1 }
  let(:packet) { client.packet(packet_id) }

  describe 'properties' do
    it 'has an ID' do
      expect(packet.id).to be_a(Integer)
    end

    it 'has an employee ID' do
      expect(packet.employee_id).to be_a(Integer)
    end
  end

  describe 'relationships' do
    it 'has a employee' do
      expect(packet.employee).to be_a(Taleo::Employee)
    end
  end
end
