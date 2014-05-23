require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should not save without valid url" do
    post = Url.new
    assert !post.save
  end
end
