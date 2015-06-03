Rails.application.routes.draw do
  mount_dre

  scope 'custom' do
    mount_dre do
      controllers devices: 'custom_devices'
    end
  end
end
