# typed: true
# frozen_string_literal: true

require_relative '../../../../../src/business/freight/domain/entity/zipcode'
require_relative '../../../../test_helper'

module Freight
  module Domain
    module Entity
      class ZipcodeTest < Minitest::Test
        def setup
          @zipcode = Zipcode.new('12345-678', 1, 'Main Street', 'Downtown')
        end

        def test_initialization
          assert_equal '12345-678', @zipcode.code
          assert_equal 1, @zipcode.id_city
          assert_equal 'Main Street', @zipcode.street
          assert_equal 'Downtown', @zipcode.neighborhood
        end

        def test_code
          assert_equal '12345-678', @zipcode.code
        end

        def test_id_city
          assert_equal 1, @zipcode.id_city
        end

        def test_street
          assert_equal 'Main Street', @zipcode.street
        end

        def test_neighborhood
          assert_equal 'Downtown', @zipcode.neighborhood
        end
      end
    end
  end
end
