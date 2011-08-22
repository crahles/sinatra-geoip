ENV["TZ"] = "UTC"

disable :logging

configure do
  GEOIP_DB = GeoIP::City.new('data/GeoLiteCity.dat')
end

get "/geoip/api/locate.json" do
  ip_info = GEOIP_DB.look_up(params[:ip])
  unless ip_info.nil?
    ip_info.each do |key, value|
      ip_info[key] = value.force_encoding("UTF-8") if value.is_a? String
    end
  end
  content_type 'application/json', :charset => 'utf-8'
  ip_info.to_json
end
