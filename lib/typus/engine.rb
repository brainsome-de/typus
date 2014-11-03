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
      Rails.application.config.assets.precompile += %w( glyphicons-halflings.png glyphicons-halflings-white.png)
    end

    # Moved from config/routes.rb to this initializer. This was done to prevent
    # Rails::Application::RoutesReloader#reload! from loading them twice.
    initializer :add_routing_paths do |app|
      app.routes.append do
        routes_block = lambda do

          dashboard = Typus.subdomain ? "/dashboard" : "/admin/dashboard"

          get "/" => redirect(dashboard)
          get "dashboard" => "dashboard#index", :as => "dashboard_index"
          get "dashboard/:application" => "dashboard#show", :as => "dashboard"

          if Typus.authentication == :session
            resource :session, :only => [:new, :create], :controller => :session do
              delete :destroy, :as => "destroy"
            end

            resources :account, :only => [:new, :create, :show] do
              collection do
                get :forgot_password
                post :send_password
              end
            end
          end

          Typus.models.map(&:to_resource).each do |_resource|
            get "#{_resource}(/:action(/:id))(.:format)", :controller => _resource
            post "#{_resource}(/:action(/:id))(.:format)", :controller => _resource
            patch "#{_resource}(/:action(/:id))(.:format)", :controller => _resource
            delete "#{_resource}(/:action(/:id))(.:format)", :controller => _resource
          end

          Typus.resources.map(&:underscore).each do |_resource|
            get "#{_resource}(/:action(/:id))(.:format)", :controller => _resource
            post "#{_resource}(/:action(/:id))(.:format)", :controller => _resource
          end

        end

        if Typus.subdomain
          constraints :subdomain => Typus.subdomain do
            namespace :admin, :path => "", &routes_block
          end
        else
          scope "admin", {:module => :admin, :as => "admin"}, &routes_block
        end
      end
    end

  end
end
