require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "user_confirmation" do
    @expected.subject = 'Notifier#user_confirmation'
    @expected.body    = read_fixture('user_confirmation')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_user_confirmation(@expected.date).encoded
  end

  test "admin_confirmation" do
    @expected.subject = 'Notifier#admin_confirmation'
    @expected.body    = read_fixture('admin_confirmation')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_admin_confirmation(@expected.date).encoded
  end

end
