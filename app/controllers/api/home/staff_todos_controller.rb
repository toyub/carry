module Api
  module Home
    class StaffTodosController < BaseController

      def create
        todo = current_user.todos.new(todo_params)
        if todo.save
          render json: {todo: todo}
        else
          render json: {msg: todo.errors.full_messages.first}, status: 400
        end
      end

      def index

      end

      private
      def todo_params
        basic_params = {store_id: current_user.store_id}
        params.permit(:store_id, :content).merge(basic_params)
      end
    end
  end
end
