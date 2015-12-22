class ApplicationController < ActionController::API
  before_action :allow_cross_origin_requests

  def preflight
    render nothing: true
  end

  private

  def not_found(object)
    render json: {
      error: "#{object} Not Found"
    }.to_json, status: 404
  end

  def send_status(status)
    render nothing: true, status: status
  end

  def allow_cross_origin_requests
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
  end
end
