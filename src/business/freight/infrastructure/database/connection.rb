# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Freight
  module Infrastructure
    module Database
      class Connection
        extend T::Sig

        sig { params(statement: String, params: T.untyped).returns(T.untyped) }
        def query(statement, params); end

        sig { returns(NilClass) }
        def close; end
      end
    end
  end
end
