class CircuitInspection
  def run

    StoreWorkstation.busy.each do |workstation|
      if workstation.workflow_id.blank? || workstation.current_workflow.blank? || workstation.current_workflow.deleted
        workstation.free
        next
      end

      if workstation.current_workflow.ended_at < Time.now
        workstation.current_workflow.complete!
      end
    end

  end
end
