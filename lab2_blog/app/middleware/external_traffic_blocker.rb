class ExternalTrafficBlocker
  TRUSTED_IP_RANGES = [
    IPAddr.new('192.168.0.0/16'),
    IPAddr.new('10.0.0.0/8')
  ].freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    remote_ip = IPAddr.new(request.ip)

    if trusted_ip?(remote_ip)
      @app.call(env)
    else
      [403, { 'Content-Type' => 'text/plain' }, ["Access denied: External network traffic is not allowed."]]
    end
  end

  private

  def trusted_ip?(ip)
    TRUSTED_IP_RANGES.any? { |range| range.include?(ip) }
  end
end
