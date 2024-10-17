# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Checkout
  module Domain
    module Entity
      class Dimension
        extend T::Sig

        sig { params(width: Float, height: Float, length: Float, weight: Float).void }
        def initialize(width = 0.0, height = 0.0, length = 0.0, weight = 0.0)
          raise ArgumentError, 'Invalid dimension' if width.negative? || height.negative? || length.negative? || weight.negative?

          @width = width
          @height = height
          @length = length
          @weight = weight
        end

        sig { returns(Float) }
        def get_volume
          (@width / 100) * (@height / 100) * (@length / 100)
        end

        sig { returns(Float) }
        def get_density
          volume = get_volume
          return 0.0 if volume.zero?

          @weight / volume
        end

        private

        attr_reader :width, :height, :length, :weight
      end
    end
  end
end
