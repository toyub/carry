class StoreStaffLoginSerializer < ActiveModel::Serializer

   attributes :id, :encrypted_password, :salt, :app_login_enabled, :store_id, :store_position,
            :store_department, :login_name, :full_name, :store, :store_chain_id, :erp_login_enabled

   def initialize(object)
       super(object)
   end

   def locked?
     !app_login_enabled || !erp_login_enabled
   end

   def position
     self.store_position.name if self.store_position
   end

   def department
     self.store_department.name if self.store_department
   end

   def user_name
     login_name
   end

   def name
     full_name
   end

   def cash_auth
     "0"
   end

   def store_name
     store.try(:name)
   end

   def photo
     "http://7xnnp5.com2.z0.glb.qiniucdn.com/FqDwPdqIc3p11utb-qEFURPRXJ8Z"
   end
 end
