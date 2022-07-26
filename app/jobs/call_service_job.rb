class CallServiceJob < ApplicationJob
  queue_as :default

  def perform(service_klass, *args)
    service_klass.constantize.call(*args)
  end
end
