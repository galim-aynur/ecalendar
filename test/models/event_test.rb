require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'should not save event without title' do
    event = Event.new
    assert_not event.save
  end

  test 'title should be valid' do
    event = Event.create title: 'Test Event'
    assert event.title == 'Test Event'
  end
end
