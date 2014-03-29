Rails.configuration.api = begin
  YAML::load_file 'config/api.yml'
rescue
  api_config = YAML::load ERB.new(File.read 'config/api.yml.erb').result

  messages = []

  if api_config['api_key'].blank?
    messages << 'API_KEY is not specified'
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
