class ScanTaskJob < ActiveJob::Base
  queue_as :default

  def perform

    StoreWorkstation.busy.each do |workstation|
      if workstation.workflow_id.blank? || workstation.current_workflow.blank? || workstation.current_workflow.deleted
        workstation.free
        next
      end

      if workstation.current_workflow.ended_at < Time.now
        workflow = workstation.current_workflow
        workflow.complete!
        if workflow.next_workflow.present?
          workflow.next_workflow.first.find_a_workstaion_and_execute_otherwise_waiting_in(workstation)
        else
          workflow.store_service.complete!
        end
      end
    end

    StoreWorkstation.idle.each do |w|
      w.assign_workflow!
    end

  end
end
