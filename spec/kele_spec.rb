require 'spec_helper'

describe Kele do
  it 'has a version number' do
    expect(Kele::VERSION).not_to be nil
  end

  it 'does something useful' do
    user = Kele.new("test", "test1")
    expect(user).not_to be nil
  end
end
