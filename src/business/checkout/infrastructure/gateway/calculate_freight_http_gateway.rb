# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'
require 'net/http'
require 'json'

require_relative '../../application/gateway/calculate_freight_gateway'

module Checkout
  module Infrastructure
    module Gateway
      class CalculateFreightHttpGateway < Application::Gateway::CalculateFreightGateway
        extend T::Sig

        sig { params(input: Application::Gateway::CalculateFreightGateway::Input).returns(Application::Gateway::CalculateFreightGateway::Output) }
        def calculate(input)
          uri = URI('http://localhost:3002/calculateFreight')
          response = Net::HTTP.post(uri, input.to_json, 'Content-Type' => 'application/json')

          data = JSON.parse(response.body)
          Output.new(data['freight'])
        end
      end
    end
  end
end
