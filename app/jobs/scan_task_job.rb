class ScanTaskJob < ActiveJob::Base
  queue_as :default

  def perform

    StoreWorkstation.busy.each do |workstation|
      if workstation.workflow_id.blank? || workstation.current_workflow.blank? || workstation.current_workflow.deleted
        workstation.free
        next
      end

      if workstation.current_workflow.processing?
        if workstation.current_workflow.ended_at.to_i <= Time.now.to_i
          workstation.current_workflow.complete!
        end
      end
    end

    StoreWorkstation.idle.each do |w|
      w.assign_workflow!
    end

  end
end
