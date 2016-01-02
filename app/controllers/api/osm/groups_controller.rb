module Api
  module Osm

    class GroupsController < BaseController
      def index
        respond_with [], location: nil
      end

      def create
        group = {id: 23, name: '信心小组'}
        respond_with group, location: nil
      end

      def update
        group = params[:group]
        respond_with group, location: nil
      end
    end

  end
end
