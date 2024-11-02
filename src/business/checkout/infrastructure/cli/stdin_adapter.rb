# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'input_device'

module Checkout
  module Infrastructure
    module Cli
      class StdinAdapter < InputDevice
        extend T::Sig

        sig { params(callback: T.proc.params(text: String).void).void }
        def on_data(callback)
          $stdin.each do |chunk|
            text = chunk.to_s
            callback.call(text)
          end
        end
      end
    end
  end
end
