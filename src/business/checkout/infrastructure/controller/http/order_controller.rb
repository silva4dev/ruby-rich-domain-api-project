# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../../http/http'
require_relative '../../database/connection'
require_relative '../../repository/database/item_repository_database'
require_relative '../../../application/preview_order'

module Checkout
  module Infrastructure
    module Controller
      module Http
        class OrderController
          extend T::Sig

          sig { params(http: Checkout::Infrastructure::Http::HttpAdapter, connection: Checkout::Infrastructure::Database::Connection).void }
          def initialize(http, connection)
            http.on('post', '/orderPreview', lambda { |_, body|
              item_repository = Repository::Database::ItemRepositoryDatabase.new(connection)
              preview_order = Application::PreviewOrder.new(item_repository)
              output = preview_order.execute(body)
              output
            })
          end
        end
      end
    end
  end
end
