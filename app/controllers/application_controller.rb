class ApplicationController < ActionController::API
  before_action :allow_cross_origin_requests

  private

  def find_skatepark(id = params['id'])
    Skatepark.where(id: id).first
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
