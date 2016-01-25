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
          optional :category_eq, type: String
          optional :created_at_gteq, type: String
          optional :created_at_lteq, type: String
        end
      end
      get do
        created_at_lteq = params[:q][:created_at_lteq]
        created_at_lteq = Time.zone.parse(created_at_lteq).end_of_day if created_at_lteq.present?
        params[:q][:first_category_eq], params[:q][:second_category_eq] = params[:q][:category_eq].scan(/\d{1,2}/) if params[:q][:category_eq].present?
        q = SmsRecord.by_store.ransack(params[:q])
        present q.result(distince: true).order('created_at desc'), with: ::Entities::MessageRecord
      end
    end

  end
end
