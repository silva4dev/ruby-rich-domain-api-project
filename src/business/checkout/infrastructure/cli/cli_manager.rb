# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'input_device'
require_relative 'output_device'

module Checkout
  module Infrastructure
    module Cli
      class CLIManager
        extend T::Sig

        sig { returns(T::Hash[String, T.proc.params(params: String).returns(T.untyped)]) }
        attr_accessor :commands

        sig { params(input_device: InputDevice, output_device: OutputDevice).void }
        def initialize(input_device, output_device)
          @commands = {}
          @output_device = output_device

          input_device.on_data(->(text) { type(text) })
        end

        sig { params(command: String, callback: T.proc.params(params: String).returns(T.untyped)).void }
        def add_command(command, callback)
          @commands[command] = callback
        end

        sig { params(command: String).returns(T.untyped) }
        def execute(command)
          name, *params = command.split
          return unless name

          callback = @commands[name.strip]
          callback&.call(params.join(' '))
        end

        sig { params(text: String).void }
        def type(text)
          output = execute(text)
          @output_device.write(output) if output
        end
      end
    end
  end
end
