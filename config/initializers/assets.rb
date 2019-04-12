
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( pixelache/stylesheets/mobile.css print.css cms.css)
Rails.application.config.assets.precompile += %w( ckeditor/* )
Rails.application.config.assets.precompile += Ckeditor.assets
Rails.application.config.assets.paths << Rails.root.join("app", "assets",  "fonts")
Rails.application.config.assets.paths << Rails.root.join("app", "assets",  "themes", "breakingthe5thwall", "fonts")