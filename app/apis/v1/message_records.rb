module V1
  class MessageRecords < Grape::API

    resource :message_records do
      add_desc '短信记录列表'
      before do
        authenticate_user!
      end
      
      params do
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer
          optional :first_category_eq, type: Integer
          optional :created_at_gteq, type: String
          optional :created_at_lteq, type: String
        end
      end
      get do
        params[:q] ||= {}
        if params[:q][:created_at_lteq].present?
          params[:q][:created_at_lteq] = Time.zone.parse(params[:q][:created_at_lteq]).end_of_day
        end

        q = SmsRecord.ransack(params[:q])# 添加多态后需要条件查询
        present q.result(distince: true), with: ::Entities::MessageRecord
      end
    end

  end
end
