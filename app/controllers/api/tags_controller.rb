module Api
  class TagsController < BaseController

    def create
      @tag = current_store.tags.create(append_store_attrs tag_params)
      respond_with @tag, location: nil
    end

    private
    def tag_params
      params.require(:tag).permit(:name)
    end

  end
end
