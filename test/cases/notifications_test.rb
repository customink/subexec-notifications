require 'test_helper'

class Subexec
  module Notifications
    class NotificationsTest < TestCase

      it 'runs a basic command' do
        sub = Subexec.run "echo 'hello'"
        sub.timeout.must_be_instance_of Fixnum
        sub.exitstatus.must_equal       0
        sub.pid.must_be_instance_of     Fixnum
        sub.output.must_equal           "hello\n"
        sub.command.must_equal          "echo 'hello'"
        sub.lang.must_equal             "C"
      end

      it 'instrements events' do
        subscribed { Subexec.run "echo 'hello'" }
        event.name.must_equal             'subexec.run'
        event.duration.must_be_close_to   15, 30
        event.payload.must_be_instance_of Hash
      end

      describe 'event' do

        it 'payload includes the Subexec object' do
          subscribed { Subexec.run "echo 'Subexec Object'" }
          sub = event.payload[:sub]
          sub.must_be_instance_of   Subexec
          sub.command.must_equal    "echo 'Subexec Object'"
          sub.exitstatus.must_equal 0
        end

        it 'payload includes the hostname' do
          Socket.stub :gethostname, 'vm22.bigcompany.com' do
            subscribed { Subexec.run "echo 'Important Work'" }
            event.payload[:hostname].must_equal 'vm22.bigcompany.com'
          end
        end

      end

    end
  end
end
