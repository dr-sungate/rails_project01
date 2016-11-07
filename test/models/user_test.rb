require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def test_valid_user
    hash = { email: 'xxx@xxx.xx',
             name: 'test user',
      password: 'password' }
  
    user =User.new(hash)
    user.admin = true
    
    assert user.valid?
  end
end
