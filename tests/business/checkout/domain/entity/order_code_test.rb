# typed: true
# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/business/checkout/domain/entity/order_code'

class OrderCodeTest < Minitest::Test
  def setup
    @date = Time.new(2023, 10, 16)
    @sequence = 1
    @order_code = Checkout::Domain::Entity::OrderCode.new(@date, @sequence)
  end

  def test_initialize
    expected_code = '2300000001'

    assert_equal expected_code, @order_code.value
  end

  def test_generate_code
    code = @order_code.generate_code(@date, @sequence)
    expected_code = '2300000001'

    assert_equal expected_code, code
  end

  def test_generate_code_with_different_sequence
    sequence = 123
    code = @order_code.generate_code(@date, sequence)
    expected_code = '2300000123'

    assert_equal expected_code, code
  end

  def test_generate_code_with_sequence_zero
    sequence = 0
    code = @order_code.generate_code(@date, sequence)
    expected_code = '2300000000'

    assert_equal expected_code, code
  end
end
