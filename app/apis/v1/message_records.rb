module V1
  class MessageRecords < Grape::API

    resource :message_records do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '短信记录列表'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer
          optional :category_eq, type: String
          optional :created_at_gteq, type: String
          optional :created_at_lteq, type: String
        end
      end
      get do
        created_at_lteq = params[:q][:created_at_lteq]
        created_at_gteq = params[:q][:created_at_gteq]
        category_eq = params[:q][:category_eq]

        created_at_lteq = parse_date(created_at_lteq).beginning_of_day if created_at_lteq.present?
        created_at_gteq = parse_date(created_at_gteq).end_of_day if created_at_gteq.present?
        params[:q][:first_category_eq], params[:q][:second_category_eq] = category_eq.split('-') if category_eq.present?
        q = SmsRecord.by_store.ransack(params[:q])
        present q.result(distinct: true).order('created_at desc'), with: ::Entities::MessageRecord
      end
    end

    helpers do
      def parse_date(date)
        Time.zone.parse(date)
      end
    end

  end
end
