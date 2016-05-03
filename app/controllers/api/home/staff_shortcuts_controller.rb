module Api
  module Home

    class StaffShortcutsController < BaseController
      def update
        shortcuts = current_user.home_shortcuts.to_a + params[:value]
        staff = current_user.update!(home_shortcuts: shortcuts)
        render json: {
            msg: '添加成功！', 
            home_shortcuts_ids: current_user.home_shortcuts,
            works: Menu.all_menus_for(current_user),
            my_shortcuts: Menu.shortcuts_for(current_user)
          }
      end

      def destroy
        work_idx = current_user.home_shortcuts - ([] << params[:id])
        current_user.update!(home_shortcuts: work_idx)
        render json: {msg: '删除成功!'}
      end
    end

  end
end
