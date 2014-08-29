require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Transaction, :type => :model do
   
  it { should belong_to(:debtor).class_name("User") }
  
  it { should belong_to(:creditor).class_name("User") }
  
  it { should belong_to(:squaring_event) }
  
  it { should validate_presence_of(:amount) }
  
  it { should validate_presence_of(:debtor_id) }
  
  it { should validate_presence_of(:creditor_id) }

  it { should validate_presence_of(:description) }

end