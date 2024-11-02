# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../../cli/cli_manager'
require_relative '../../database/connection'
require_relative '../../repository/database/item_repository_database'
require_relative '../../../application/preview_order'

module Checkout
  module Infrastructure
    module Controller
      class CLIController
        extend T::Sig

        sig { params(cli_manager: Cli::CLIManager, connection: Checkout::Infrastructure::Database::Connection).void }
        def initialize(cli_manager, connection)
          @cpf = ''
          @order_items = []

          cli_manager.add_command('cpf', lambda { |params|
            @cpf = params
          })

          cli_manager.add_command('add-item', lambda { |params|
            id_item, quantity = params.split.map(&:to_i)
            @order_items.push({ idItem: id_item, quantity: quantity })
          })

          cli_manager.add_command('preview', lambda { |_|
            item_repository = Repository::Database::ItemRepositoryDatabase.new(connection)
            preview_order = Application::PreviewOrder.new(item_repository)
            input = Application::PreviewOrder::Input.new(cpf: @cpf, order_items: @order_items)
            output = preview_order.execute(input)
            "total: #{output.total}"
          })
        end
      end
    end
  end
end
