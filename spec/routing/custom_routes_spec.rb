require 'rails_helper'

describe 'custom routes' do
  it 'GET /devices routes to custom devices controller' do
    expect(get('/custom/devices')).to(
      route_to('custom_devices#index')
    )
  end

  it 'PUT /devices/:token routes to custom devices controller' do
    expect(put('/custom/devices/adevicetoken')).to(
      route_to('custom_devices#register', token: 'adevicetoken')
    )
  end

  it 'DELETE /devices/:token routes to custom devices controller' do
    expect(delete('/custom/devices/adevicetoken')).to(
      route_to('custom_devices#deregister', token: 'adevicetoken')
    )
  end
end