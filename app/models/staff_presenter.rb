class StaffPresenter
  delegate :name, :xx, to: :@subject
  def initialize(subject)
    @subject = subject
  end
end
