class AddMechanicCommissionTemplateIdToStoreServiceWorkflow < ActiveRecord::Migration
  def change
    remove_column :store_service_workflows, :sales_commission_subject, :integer
    remove_column :store_service_workflows, :sales_commission_template_id, :integer
    remove_column :store_service_workflows, :engineer_commission_subject, :integer
    remove_column :store_service_workflows, :engineer_commission_template_id, :integer

    remove_column :store_service_workflow_snapshots, :sales_commission_subject, :integer
    remove_column :store_service_workflow_snapshots, :sales_commission_template_id, :integer
    remove_column :store_service_workflow_snapshots, :engineer_commission_subject, :integer
    remove_column :store_service_workflow_snapshots, :engineer_commission_template_id, :integer

    add_column :store_service_workflows, :mechanic_commission_template_id, :integer
    add_column :store_service_workflow_snapshots, :mechanic_commission_template_id, :integer
  end
end
