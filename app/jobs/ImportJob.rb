class ImportJob < ApplicationJob
  queue_as :default

  def perform_now(csv)
  end
end