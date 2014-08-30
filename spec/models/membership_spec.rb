require 'rails_helper'
require_relative '../../app/models/membership'

describe Membership do
  describe 'relationships' do
    it { should belong_to(:user)}
    it { should belong_to(:group)}
  end
end
