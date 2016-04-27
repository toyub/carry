module Api
  module Home
    class StaffTodosController < BaseController

      def create
        todo = current_user.todos.new(todo_params)
        if todo.save
          render json: {todo: todo}
        else
          render json: {msg: '创建失败!'}
        end
      end

      private
      def todo_params
        basic_params = {store_id: current_user.store_id}
        params.permit(:store_id, :content).merge(basic_params)
      end
    end
  end
end
