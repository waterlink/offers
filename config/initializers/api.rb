Rails.configuration.api = begin
  YAML::load_file('config/api.yml')[Rails.env]
rescue
  api_config = YAML::load(ERB.new(File.read 'config/api.yml.erb').result)[Rails.env]

  messages = []

  if api_config['api_key'].blank?
    messages << 'API_KEY is not specified'
  end

  if api_config['endpoint'].blank?
    messages << 'API_ENDPOINT is not specified'
  end

  if api_config['signature_header'].blank?
    messages << 'API_SIGNATURE_HEADER is not specified'
  end

  api_config['params'].each do |k, v|
    if v.blank?
      messages << "API_#{k.upcase} is not specified"
    end
  end

  unless messages.blank?
    raise Exception.new messages
  end

  api_config
end
