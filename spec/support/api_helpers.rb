module ApiHelpers
  def json_body
    JSON.parse(response.body)
  end

  RSpec.configure do |config|
    config.include ApiHelpers, type: :request
  end
end
