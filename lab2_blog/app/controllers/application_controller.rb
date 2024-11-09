require 'socket'

class ApplicationController < ActionController::Base
=begin
  before_action :verify_network_characteristics
=end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :date_of_birth, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :date_of_birth, :avatar])
  end

  private

  def fetch_local_network_characteristics
    {
      mac_address: `ifconfig eth0 | grep ether | awk '{print $2}'`.strip,
      ip_address: Socket.ip_address_list.detect(&:ipv4_private?).ip_address
    }
  end

  def verify_network_characteristics
    if application_locked? || !network_characteristics_match?
      render plain: "Application locked. Contact the developer for access.", status: :forbidden
    end
  end

  def network_characteristics_match?
    stored_characteristics = { mac_address: 'YOUR_STORED_MAC', ip_address: 'YOUR_STORED_IP' }
    current_characteristics = fetch_local_network_characteristics
    stored_characteristics == current_characteristics
  end

  def application_locked?
    Rails.cache.fetch("application_locked", expires_in: 1.day) { false }
  end
end
