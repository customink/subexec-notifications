class Subexec
  module Notifications
    module Extensions

      extend ActiveSupport::Concern

      included do
        alias_method_chain :run!, :notifications
      end

      def run_with_notifications!
        ActiveSupport::Notifications.instrument "subexec.run", notification_payload do
          run_without_notifications!
        end
      end

      private

      def notification_payload
        { sub: self, hostname: Socket.gethostname }
      end

    end
  end
end

Subexec.send :include, Subexec::Notifications::Extensions
