module ActiveRecord
  module Obfuscator
    extend ActiveSupport::Concern

    def encoded_id
      ScatterSwap.hash(id, 0, 9).try(:to_i) # use 9, so standard 32-bit Int won't overflow
    end
  end
end
