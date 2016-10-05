module ActionController
  module Obfuscator
    extend ActiveSupport::Concern

    def params
      return super if ScatterSwapper.config.skip_controller_params

      @_params ||= begin
        super.each do |key, value|
          if key =~ /(?:^|_)id$/
            super[key] = ScatterSwap.reverse_hash(value, 0, 9).try(:to_i) # use 9, so standard 32-bit Int won't overflow
          end
        end
        super
      end
    end
  end
end
