# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../../../domain/entity/coupon'
require_relative '../../../domain/entity/order'
require_relative '../../../domain/entity/order_coupon'
require_relative '../../../domain/entity/order_item'
require_relative '../../../domain/repository/order_repository'
require_relative '../../database/connection'

module Checkout
  module Infrastructure
    module Repository
      module Database
        class OrderRepositoryDatabase < Domain::Repository::OrderRepository
          extend T::Sig

          sig { params(connection: Checkout::Infrastructure::Database::Connection).void }
          def initialize(connection)
            super()
            @connection = connection
          end

          sig { params(order: Domain::Entity::Order).returns(T.nilable(NilClass)) }
          def save(order)
            order_data = @connection.query(
              'INSERT INTO rich-db.order (code, cpf, issue_date, total, freight) VALUES ($1, $2, $3, $4, $5) RETURNING *',
              [order.get_code, order.cpf.value, order.date, order.get_total, order.freight]
            )
            order_data.each do |order_data_item|
              order.order_items.each do |order_item|
                @connection.query(
                  'INSERT INTO rich-db.order_item (id_order, id_item, price, quantity) VALUES ($1, $2, $3, $4)',
                  [order_data_item.id_order, order_item.id_item, order_item.price, order_item.quantity]
                )
              end
            end
          end

          sig { returns(Integer) }
          def count
            row = @connection.query('SELECT COUNT(*)::int FROM rich-db.order', [])
            row.count
          end

          sig { params(code: String).returns(Domain::Entity::Order) }
          def get(code)
            order_data = @connection.query('SELECT * FROM rich-db.order WHERE code = $1', [code])
            raise 'Order not found' if order_data.empty?

            order = Domain::Entity::Order.new(order_data[0].cpf, DateTime.parse(order_data[0].issue_date), order_data[0].sequence)
            order_items_data = @connection.query('SELECT * FROM rich-db.order_item WHERE id_order = $1', [order_data[0].id_order])
            order_items_data.each do |order_item_data|
              order_item = Domain::Entity::OrderItem.new(order_item_data.id_item, order_item_data.price.to_f, order_item_data.quantity)
              order.order_items.push(order_item)
            end
            order.coupon = Domain::Entity::OrderCoupon.new(order_data[0].coupon_code, order_data[0].coupon_percentage)
            order.freight = order_data[0].freight.to_f
            order
          end

          sig { returns(T.nilable(NilClass)) }
          def clean
            @connection.query('DELETE FROM rich-db.order_item', [])
            @connection.query('DELETE FROM rich-db.order', [])
          end
        end
      end
    end
  end
end
