module ScatterSwap
  class Hasher

    # @return [Array[Fixnum]]
    attr_reader :working_array

    # @return [Fixnum] the number of digits in the computed hashes.
    attr_reader :length

    # @return [Fixnum] A seed value to add some spice, so that different apps can have differently mapped hashes.
    attr_reader :spin

    # Construct a new +Hasher+.
    # @param [Fixnum] integer the numeric value to be hashed/reversed.
    # @param [Fixnum] spin a seed value.
    # @param [Fixnum] length the number of digits in the computed hashes.
    #
    def initialize(integer, spin = 0, length = 10)
      @original_integer = integer.freeze
      @spin = (spin || 0).freeze
      @length = length.freeze
      zero_pad = integer.to_s.rjust(length, '0')
      @working_array = zero_pad.split('').collect { |d| d.to_i }
    end

    # Obfuscate the original integer value to a zero-padded String of {#length} digits.
    # @return [String] the obfuscated hash.
    #
    def hash
      swap
      scatter
      completed_string
    end

    # De-obfuscate the original integer value to a zero-padded String of {#length} digits.
    # @return [String] the de-obfuscated hash.
    #
    def reverse_hash
      unscatter
      unswap
      completed_string
    end


    #-------------------------------------------------------------------------
    private

    def completed_string
      @working_array.join
    end

    # We want a unique map for each place in the original number
    def swapper_map(index)
      array = (0..9).to_a
      10.times.collect.with_index do |i|
        array.rotate!(index + i ^ spin).pop
      end
    end

    # Using a unique map for each of the ten places,
    # we swap out one number for another
    def swap
      @working_array = @working_array.collect.with_index do |digit, index|
        swapper_map(index)[digit]
      end
    end

    # Reverse swap
    def unswap
      @working_array = @working_array.collect.with_index do |digit, index|
        swapper_map(index).rindex(digit)
      end
    end

    # Rearrange the order of each digit in a reversible way by using the
    # sum of the digits (which doesn't change regardless of order)
    # as a key to record how they were scattered
    def scatter
      sum_of_digits = @working_array.inject(:+).to_i
      @working_array = length.times.collect do
        @working_array.rotate!(spin ^ sum_of_digits).pop
      end
    end

    # Reverse the scatter
    def unscatter
      scattered_array = @working_array
      sum_of_digits = scattered_array.inject(:+).to_i
      @working_array = []
      @working_array.tap do |unscatter| 
        length.times do
          unscatter.push scattered_array.pop
          unscatter.rotate! (sum_of_digits ^ spin) * -1
        end
      end
    end
  end
end
