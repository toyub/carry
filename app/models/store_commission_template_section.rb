#提成规则;
#注意： 用户可能设置了多个多种mode的提成规则（section）
#但是，当前激活状态的则是跟模板mode一致的section；
#
##
class StoreCommissionTemplateSection < ActiveRecord::Base
  include BaseModel
  belongs_to :store_commission_template

  def mode_type
    CommissionModeType.find(self.mode_id).name
  end

  def method_type
    CommissionSectionMethodType.find(self.type_id).name
  end

  def source_type
    CommissionSectionSourceType.find(self.source_id).name
  end

end
