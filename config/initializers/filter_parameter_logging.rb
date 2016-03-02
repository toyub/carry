# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]
Rails.application.config.filter_parameters += [:password_confirmation]
Rails.application.config.filter_parameters += [:new_password]
Rails.application.config.filter_parameters += [:new_password_confirmation]
