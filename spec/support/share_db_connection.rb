module ActiveRecord
  class Base
    mattr_accessor :shared_connection
    class << self
      @shared_connection = nil

      def connection
        @shared_connection || retrieve_connection
      end
    end
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
