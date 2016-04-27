module Api
  module Home
    class StaffTodosController < BaseController
      before_action :get_done, only: [:index, :clear_done]
      def create
        todo = current_user.todos.new(todo_params)
        if todo.save
          render json: {todo: todo}
        else
          render json: {msg: todo.errors.full_messages.first}, status: 400
        end
      end

      def index
        todos = current_user.todos.order("id desc")

        undone = current_user.todos.undone.order("id desc")
        render json: {done: @done, undone: undone, todos: todos}
      end

      def clear_done
        @done.destroy_all
        render json: {msg: '已删除完成的事项!'}
      end

      private
      def todo_params
        basic_params = {store_id: current_user.store_id}
        params.permit(:store_id, :content).merge(basic_params)
      end

      def get_done
        @done = current_user.todos.done.order("id desc")
      end
    end
  end
end
