class SettingForm
  attr_reader :setting
  attr_reader :options

  def initialize(service, options)
    @service = service
    @setting_type = options.delete(:setting_type)
    @options = parse_options(options)
  end

  def parse_options(options)
    workflow_options = regular? ? {workflows_attributes: [options]} : options
    {setting_type: @setting_type}.merge(workflow_options)
  end

  def regular?
    @setting_type == 0
  end

  def call
    @service.create_setting(@options)
  end

  def self.call(*args)
    new(*args).call
  end
end
