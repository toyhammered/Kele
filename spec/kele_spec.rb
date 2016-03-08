require 'spec_helper'

describe Kele, type: :request do
  context '.kele' do
    describe '#initialize' do
      it 'returns error with invalid email or password' do
        email = ENV['BLOC_EMAIL']
        password = "fakefake"
        response = HTTParty.post("https://www.bloc.io/api/v1/sessions?email=#{email}&password=#{password}")
        puts response.header.inspect
        expect(response.header).to raise_error(Net::HTTPUnauthorized)
      end

      it 'returns auth token' do
        email = ENV['BLOC_EMAIL']
        password = ENV['BLOC_PASSWORD']
        response = HTTParty.post("https://www.bloc.io/api/v1/sessions?email=#{email}&password=#{password}")
        expect(response.header).to have_http_status(:success)
      end
    end
  end

end
