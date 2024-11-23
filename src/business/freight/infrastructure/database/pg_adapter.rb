# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'
require 'pg'

require_relative 'connection'

module Freight
  module Infrastructure
    module Database
      class PgAdapter < Connection
        extend T::Sig

        sig { void }
        def initialize
          super()
          @connection = PG.connect(
            dbname: 'app',
            user: 'postgres',
            password: '123456',
            host: 'localhost',
            port: 5432
          )
        end

        sig { params(statement: String, params: T.untyped).returns(T.untyped) }
        def query(statement, params)
          @connection.exec_params(statement, params)
        end

        sig { returns(NilClass) }
        def close
          @connection.close
        end
      end
    end
  end
end
