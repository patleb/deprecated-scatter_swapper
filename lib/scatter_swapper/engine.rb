require 'scatter_swapper/configuration'

module ScatterSwapper
  class Engine < ::Rails::Engine
    initializer "scatter_swapper.configure" do
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.class_eval do
          include ActiveRecord::Obfuscator
        end
      end

      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.class_eval do
          include ActionController::Obfuscator
        end

        ::ActionController::API.class_eval do
          include ActionController::Obfuscator
        end
      end
    end
  end
end
