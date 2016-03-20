require 'spec_helper'

describe Kele, type: :request do
  context '.kele' do
    describe '#initialize' do

      it 'raises error' do
        expect { Kele.new(ENV['BLOC_EMAIL'], "fakefake") }.to raise_error(InvalidStudentCodeError)
      end

      it 'authenticates user' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        expect(response.instance_variable_get(:@auth_token)).to be_a String
      end

    end

    describe '#get_me' do
      it 'returns an object' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        response = response.get_me
        expect(response.instance_variable_get(:@user_data)).to be_a Object
      end
    end

    describe '#get_mentor_availability' do

    end

  end

end
