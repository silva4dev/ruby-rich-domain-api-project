# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module ValueObject
  class Cpf
    extend T::Sig

    DIGIT_1_FACTOR = 10
    DIGIT_2_FACTOR = 11

    sig { returns(String) }
    attr_reader :value

    sig { params(value: String).void }
    def initialize(value)
      raise ArgumentError, 'Cpf Inválido' unless validate(value)

      @value = value
    end

    sig { params(cpf: T.nilable(String)).returns(T::Boolean) }
    def validate(cpf)
      return false if cpf.nil? || cpf.empty?

      cpf = remove_non_digits(cpf)
      return false unless is_valid_length(cpf)
      return false if all_digits_the_same(cpf)

      digit1 = calculate_digit(cpf, DIGIT_1_FACTOR)
      digit2 = calculate_digit(cpf, DIGIT_2_FACTOR)
      check_digit = extract_check_digit(cpf)
      calculated_check_digit = "#{digit1}#{digit2}"

      check_digit == calculated_check_digit
    end

    sig { params(cpf: String).returns(String) }
    def remove_non_digits(cpf)
      cpf.gsub(/\D+/, '')
    end

    sig { params(cpf: String).returns(T::Boolean) }
    def is_valid_length(cpf)
      cpf.length == 11
    end

    sig { params(cpf: String).returns(T::Boolean) }
    def all_digits_the_same(cpf)
      first_digit = cpf[0]
      cpf.chars.all?(first_digit)
    end

    sig { params(cpf: String, factor: Integer).returns(Integer) }
    def calculate_digit(cpf, factor)
      total = 0
      cpf.chars.each do |digit|
        total += digit.to_i * factor if factor > 1
        factor -= 1
      end
      rest = total % 11
      rest < 2 ? 0 : 11 - rest
    end

    sig { params(cpf: String).returns(T.nilable(String)) }
    def extract_check_digit(cpf)
      cpf[-2..]
    end
  end
end
