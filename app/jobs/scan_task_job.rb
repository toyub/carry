class ScanTaskJob < ActiveJob::Base
  queue_as :default

  def perform

    StoreWorkstation.busy.each do |workstation|
      if workstation.workflow_id.blank? || workstation.current_workflow.blank? || workstation.current_workflow.deleted
        workstation.free
        next
      end

      if workstation.current_workflow.processing? && workstation.current_workflow.ended_at < Time.now
        workstation.finish!
      end
    end

    StoreWorkstation.idle.each do |w|
      w.assign_workflow!
    end

  end
end
