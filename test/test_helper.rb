require 'bundler' ; Bundler.require :development, :test
require 'subexec-notifications'
require 'minitest/spec'
require 'minitest/mock'
require 'minitest/autorun'

class Subexec
  module Notifications
    class TestCase < MiniTest::Spec

      let(:callback)  { lambda { |*args| event(*args) } }

      after do
        clear_event!
      end


      private

      def subscribed(name="subexec.run")
        subscriber = ActiveSupport::Notifications.subscribe(name, &callback)
        yield
      ensure
        ActiveSupport::Notifications.unsubscribe(subscriber)
      end

      def event(*args)
        @event ||= ActiveSupport::Notifications::Event.new(*args)
      end

      def clear_event!
        @event = nil
      end

    end
  end
end
