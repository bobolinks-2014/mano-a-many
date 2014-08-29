require 'rails_helper'
require_relative '../../app/models/user_squaring'

describe UserSquaring do
  it { should belong_to(:user) }
  it { should belong_to(:squaring_event) }

end
