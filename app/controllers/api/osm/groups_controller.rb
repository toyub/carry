module Api
  module Osm

    class GroupsController < BaseController
      def index
        respond_with [], location: nil
      end

      def create
        id = rand(2000)
        group = params[:group]
        group[:id] = id
        respond_with group, location: nil
      end

      def update
        group = params[:group]
        respond_with group, location: nil
      end
    end

  end
end
