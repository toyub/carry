module V1
  class MessageRecords < Grape::API

    resource :message_records do
      before do
        authenticate_user!
      end

      add_desc '短信记录列表'

      params do
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer
          optional :first_category_eq, type: Integer
          optional :created_at_gteq, type: String
          optional :created_at_lteq, type: String
        end
      end
      get do
        created_at_lteq = params[:q][:created_at_lteq]
        created_at_lteq = Time.zone.parse(created_at_lteq).end_of_day if created_at_lteq.present?
        q = SmsRecord.by_store.ransack(params[:q])
        present q.result(distince: true).order('created_at desc'), with: ::Entities::MessageRecord
      end
    end

  end
end
