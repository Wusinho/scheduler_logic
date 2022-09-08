# frozen_string_literal: true

require_relative '../../lib/helpers'

describe 'Helpers' do
  include Helpers
  let(:range) { ['0-24'] }
  let(:range2) { %w[0-6 9-12] }
  let(:range_i) { available_hours_str_to_i(%w[0-6 9-12]) }


  describe 'available_hours_str_to_i it changes string range of worker available hrs to integers' do
    it 'creates changes a string range value to integer' do
      expect(available_hours_str_to_i(range)).to eql [[0, 24]]
    end
    it 'creates range value to integer when there are gaps' do
      expect(available_hours_str_to_i(range2)).to eql [[0, 6], [9, 12]]
    end
  end

  describe 'creates an array of the workers availability' do
    it 'creates a various arrays that represent the workers availability' do
      expect(create_daily_ranges(range_i)).to eql [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [9, 10], [10, 11], [11, 12]]
    end

  end

end
