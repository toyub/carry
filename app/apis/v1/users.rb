module V1
  class Users < Grape::API

    resource :users, desc: "用户相关" do
      add_desc "测试"
      get :test_grape_api do
        result = {message: 'test'}
        present result
      end
    end

  end
end
