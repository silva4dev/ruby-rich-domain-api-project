# typed: true
# frozen_string_literal: true

require_relative '../../test_helper'
require_relative '../../../src/core/value_object/cpf'

module Core
  module ValueObject
    class CpfTest < Minitest::Test
      def test_cpf_initialization
        @cpf = Cpf.new('17724117012')

        assert @cpf, '177.241.170-12'
      end

      def test_cpf_initialization_with_invalid
        assert_raises(ArgumentError, 'Cpf Inválido') do
          Cpf.new('123456789')
        end
      end
    end
  end
end
