# typed: true
# frozen_string_literal: true

module Checkout
  module Infrastructure
    module Http
      class HttpAdapter
        extend T::Sig

        sig { params(method: String, url: String, callback: T.proc.params(params: T.untyped, body: T.untyped).returns(T.untyped)).void }
        def on(method, url, callback)
          raise NotImplementedError
        end

        sig { params(port: Integer).void }
        def listen(port)
          raise NotImplementedError
        end
      end
    end
  end
end
