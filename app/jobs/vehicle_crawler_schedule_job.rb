class VehicleCrawlerScheduleJob < ActiveJob::Base
  queue_as :default

  def perform(letters = [])
    letters = 'A'..'Z' if letters.blank?
    letters.each do |letter|
      VehicleCrawlerJob.perform_later(letter)
    end
  end
end
