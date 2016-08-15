require 'scatter_swap/version'
require 'scatter_swap/hasher'

module ScatterSwap

  # Hash the given +plain_integer+ into its obfuscated +String+ form.
  #
  # @note To obtain the corresponding hashed *integer* value call {ScatterSwap.hash}(plain_integer).to_i
  # @param [Fixnum] plain_integer the numeric value to be hashed.
  # @param [Fixnum] spin the seed value for the hashing algorithm.
  # @param [Fixnum] length the number of digits in the returned hash.
  # @return [String] a '0' padded string of +length+ digits containing the hashed numeric value.
  #
  def self.hash(plain_integer, spin = 0, length = 10)
    Hasher.new(plain_integer, spin, length).hash
  end


  # Reverse +hashed_integer+ from its obfuscated form to its serial value.
  #
  # @note To obtain the corresponding reverse-hashed *integer* value call {ScatterSwap.reverse_hash}(hashed_integer).to_i
  # @param [Fixnum] hashed_integer the numeric value to be hashed.
  # @param [Fixnum] spin the seed value for the hashing algorithm.
  # @param [Fixnum] length the number of digits in the returned hash.
  # @return [String] a '0' padded string of +length+ digits containing the reverse-hashed numeric value.
  #
  def self.reverse_hash(hashed_integer, spin = 0, length = 10)
    Hasher.new(hashed_integer, spin, length).reverse_hash
  end
end
