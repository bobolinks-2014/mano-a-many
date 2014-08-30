require 'rails_helper'
require_relative '../../app/models/group'

describe Group do
  describe 'relationships' do
    it { should have_many(:squaring_events) }
    it { should have_many(:memberships) }
    it { should have_many(:users).through(:memberships) }
  end
end
