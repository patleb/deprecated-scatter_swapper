require 'scatter_swap'

module ActionController
  module Obfuscator
    extend ActiveSupport::Concern

    def params
      @_params ||= begin
        super.each do |key, value|
          if key =~ /(?:^|_)id$/
            super[key] = ScatterSwap.reverse_hash(value, 0, 9) # use 9, so standard 32-bit Int won't overflow
          end
        end
        super
      end
    end
  end
end
