# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'
require 'date'

require_relative '../../../../core/value_object/cpf'
require_relative 'freight_calculator'
require_relative 'item'
require_relative 'order_code'
require_relative 'order_coupon'
require_relative 'order_item'

module Checkout
  module Domain
    module Entity
      class Order
        extend T::Sig

        sig { returns(T::Array[OrderItem]) }
        attr_reader :order_items

        sig { returns(Core::ValueObject::Cpf) }
        attr_reader :cpf

        sig { returns(T.nilable(OrderCoupon)) }
        attr_accessor :coupon

        sig { returns(Float) }
        attr_accessor :freight

        sig { returns(OrderCode) }
        attr_reader :code

        sig { returns(Date) }
        attr_reader :date

        sig { params(cpf: String, date: T.nilable(Time), sequence: Integer).void }
        def initialize(cpf, date = Time.now, sequence = 1)
          @cpf = Core::ValueObject::Cpf.new(cpf)
          @order_items = []
          @freight = 0.0
          date = Time.at(date.to_time.to_i) if date
          @code = OrderCode.new(date || Time.now, sequence)
        end

        sig { params(item: Item, quantity: Integer).void }
        def add_item(item, quantity)
          raise 'Duplicated item' if @order_items.any? { |order_item| order_item.id_item == item.id_item }

          @order_items << item.create_order_item(quantity)
          @freight += FreightCalculator.calculate(item) * quantity
        end

        sig { params(coupon: Coupon).void }
        def add_coupon(coupon)
          return if coupon.expired?(@code.date)

          @coupon = coupon.create_order_coupon
        end

        sig { returns(String) }
        def get_code
          @code.value
        end

        sig { returns(Float) }
        def get_total
          total = @order_items.reduce(0.0) { |sum, order_item| sum + order_item.get_total }
          total -= @coupon.get_discount(total) if @coupon
          total += @freight if @freight.positive?
          total
        end
      end
    end
  end
end
