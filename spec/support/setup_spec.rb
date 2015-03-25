require 'rails_helper'

describe 'setup initializer' do
  it 'sets an authentication method' do
    expect(Dre.authentication_method).to eq :authenticate_user!
  end

  it 'sets a current user method' do
    expect(Dre.current_user_method).to eq :current_user
  end
end
