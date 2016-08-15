require 'spec_helper'
require 'scatter_swap'

describe ScatterSwap do

  it 'has a version number' do
    expect(ScatterSwap::VERSION).not_to be nil
  end

  describe '#hash' do

    it 'should not be sequential' do
      100.times do |integer|
        first  = ScatterSwap.hash(integer)
        second = ScatterSwap.hash(integer + 1)
        expect(second).not_to eq(first.to_i + 1)
      end
    end


    it 'should be reversible' do
      100.times do |integer|
        hashed = ScatterSwap.hash(integer)
        expect(ScatterSwap.reverse_hash(hashed).to_i).to eq(integer)
        puts "#{integer.to_s.rjust(4)} -> #{ScatterSwap.hash(integer)} -> #{ScatterSwap.reverse_hash(hashed).to_i.to_s.rjust(4)}"
      end
    end


    it 'should be consistent across platforms' do
      expect(ScatterSwap.hash(1234, 0, 10)).to eq('3942201503')
      expect(ScatterSwap.hash(9876543210, 99, 10)).to eq('5529302155')
    end


    it 'should produce a different value for each seed' do
      integer = 12345
      results = []
      100.times do |seed|
        results << ScatterSwap.hash(integer, seed)
      end
      results = results.sort.uniq
      expect(results.size).to eq(100)
      results.each_with_index { |r, i| puts "#{i.to_s.rjust(2)} -> #{r}" }
    end


    describe 'uniqueness of output' do

      let(:seed)   { 12345 }
      let(:length) { 3 }
      let(:max)    { '9'.ljust(length, '9').to_i }

      it 'should produce unique results' do
        puts "Testing numbers 0 to #{max}"
        results = []
        (0..max).each do |input|
          results << ScatterSwap.hash(input, seed, length)
        end

        expect(results.length).to eq(max + 1)
        sorted = results.sort.uniq
        expect(sorted.length).to eq(max + 1)

        (0...max).each do |i|
          expect(sorted[i].to_i).to eq(i)
        end
      end
    end


    describe 'length' do

      context 'default' do
        it 'should produce 10 digits' do
          100.times do |integer|
            expect(ScatterSwap.hash(integer).to_s.length).to eq 10
          end
        end
      end

      context '7 to 12 digits' do

        let(:seed) { 0 }

        (7..12).each do |length|

          it 'should produce 10 digits' do
            100.times do |input|
              output = ScatterSwap.hash(input, seed, length)
              expect(output.to_s.length).to eq length
            end
          end

          it 'should be reversible' do
            100.times do |input|
              hashed = ScatterSwap.hash(input, seed, length)
              reversed = ScatterSwap.reverse_hash(hashed, seed, length).to_i
              expect(reversed).to eq(input)
              puts "#{input.to_s.rjust(4)} -> #{hashed} -> #{reversed.to_s.rjust(4)}"
            end
          end
        end
      end
    end
  end


  describe 'private methods' do

    describe '#swapper_map' do

      let(:swapper_map_size) { 10.freeze }   # Must ALWAYS be 10!

      before do
        @map_set = []
        s = ScatterSwap::Hasher.new(1)
        swapper_map_size.times do |digit|
          @map_set.push s.send(:swapper_map, digit)   # Use send to access :private methods
        end
      end

      it 'should create a unique map array for each digit' do
        expect(@map_set.length).to eq(swapper_map_size)
        expect(@map_set.uniq.length).to eq(swapper_map_size)
      end

      it 'should include all 10 digits in each map' do
        @map_set.each do |map|
          expect(map.length).to eq(swapper_map_size)
          expect(map.uniq.length).to eq(swapper_map_size)
        end
      end
    end


    describe '#scatter' do
      it 'should return a number different from original' do
        100.times do |integer|
          s = ScatterSwap::Hasher.new(integer)
          original_array = s.working_array
          s.send(:scatter)
          expect(s.working_array).not_to eq(original_array)
        end
      end

      it 'should be reversible' do
        100.times do |integer|
          s = ScatterSwap::Hasher.new(integer)
          original_array = s.working_array.clone
          s.send(:scatter)
          s.send(:unscatter)
          expect(s.working_array).to eq(original_array)
        end
      end
    end


    describe '#swap' do
      it 'should be different from original' do
        100.times do |integer|
          s = ScatterSwap::Hasher.new(integer)
          original_array = s.working_array.clone
          s.send(:swap)
          expect(s.working_array).not_to eq(original_array)
        end
      end

      it 'should be reversible' do
        100.times do |integer|
          s = ScatterSwap::Hasher.new(integer)
          original_array = s.working_array.clone
          s.send(:swap)
          s.send(:unswap)
          expect(s.working_array).to eq(original_array)
        end
      end
    end
  end
end
