module Admin
  class Engine < Rails::Engine

    initializer :assets do |config|
      extra_dirs = Dir.glob(root.join('vendor/assets/*'))
      extra_dirs.each do |dir|
        %w(img css js).each do |asset_type|
          Rails.application.config.assets.paths << File.join(dir, asset_type)
        end
      end
    end
  end
end
