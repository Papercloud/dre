require 'rails_helper'

describe 'default routes' do
  it 'GET /devices routes to devices controller' do
    expect(get('/devices')).to route_to('dre/devices#index')
  end

  it 'PUT /devices/:token routes to devices controller' do
    expect(put('/devices/adevicetoken')).to route_to('dre/devices#register', token: 'adevicetoken')
  end

  it 'DELETE /devices/:token routes to devices controller' do
    expect(delete('/devices/adevicetoken')).to route_to('dre/devices#deregister', token: 'adevicetoken')
  end
end