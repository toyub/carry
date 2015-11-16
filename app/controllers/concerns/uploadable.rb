module Uploadable
  extend ActiveSupport::Concern

  def save_picture
    resource.uploads.create(params[:results].map {|key| {img: key, creator: current_staff}})
    respond_with resource, location: nil
  end

  def resource
    raise 'resource method should be implemented'
  end

end
