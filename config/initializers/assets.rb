# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

#Rails.application.config.assets.paths.push(Rails.root.join("app", "assets", "templates").to_path)

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w[ tiny.js kucun.js settings.js xiaoshou.js xianchang.js soa.js pos.js crm.js sas.js]

Rails.application.config.assets.precompile += %w[ Linearicons-Free.eot Linearicons-Free.woff Linearicons-Free.ttf Linearicons-Free.svg icomoon.eot icomoon.woff icomoon.ttf icomoon.svg]

Rails.application.config.assets.precompile += %w[ login.css receipter_layout.css a4printer_layout.css open_layout.css ]
