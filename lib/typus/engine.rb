module Admin
  class Engine < Rails::Engine

    initializer :assets do |config|

      asset_libraries = Dir.glob(root.join('vendor/assets/*'))
      asset_libraries.each do |dir|
        %w(img css js).each do |asset_type|
          Rails.application.config.assets.paths << File.join(dir, asset_type)
        end
      end

      Rails.application.config.assets.precompile += ['glyphicons-halflings.png', 'glyphicons-halflings-white.png']

    end
  end
end
