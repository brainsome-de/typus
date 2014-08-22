module Admin
  class Engine < Rails::Engine

    initializer :assets do |config|

      # Add all "frontend libraries" (bootcamp etc.) to the load path for the asset pipeline. 
      # This is necessary since typus has a nondefault directory structure in vendor/assets.
      extra_asset_paths = Dir.glob(File.join(root, 'vendor/assets/*/{img,images,css,js}'))
      Rails.application.config.assets.paths += extra_asset_paths

      # Add nondefault image directory to the precompile array, otherwise images in there they won't
      # become available for the asset pipeline.
      Rails.application.config.assets.precompile << %r{^img/.+}

    end
  end
end
