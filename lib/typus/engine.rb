module Admin
  class Engine < Rails::Engine

    initializer :assets do |config|

      # Add all "frontend libraries" (bootstrap etc.) to the asset pipeline load path. 
      # This is necessary because typus uses a nondefault directory structure in vendor/assets.
      extra_asset_paths = Dir.glob(File.join(root, 'vendor/assets/*/{img,images,css,js}'))
      Rails.application.config.assets.paths += extra_asset_paths

      # Add nondefault image directory to the precompile array, otherwise images in there won't
      # become available for the asset pipeline.
      Rails.application.config.assets.precompile << %r{^img/.+}

    end
  end
end
