module V1
  class MessageRecords < Grape::API

    resource :message_records do
      add_desc '短信记录列表'
      get do
        q = SmsRecord.includes(:store).ransack(params[:q])
        present q.result(distince: true), with: ::Entities::MessageRecord
      end
    end

  end
end
