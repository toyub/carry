module V1
  class MessageRecords < Grape::API

    resource :message_records do
      add_desc '短信记录列表'
      get do
        params[:q][:created_at_lteq] = Time.zone.parse(params[:q][:created_at_lteq]).end_of_day
        q = SmsRecord.ransack(params[:q])# 添加多态后需要条件查询
        present q.result(distince: true), with: ::Entities::MessageRecord
      end
    end

  end
end
