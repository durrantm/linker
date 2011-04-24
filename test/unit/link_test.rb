require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
#    assert(record.valid?)
#    assert true
    record = Link.new
    assert !record.valid?
  end
end
