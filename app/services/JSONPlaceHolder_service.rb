class JSONPlaceHolderService
  def initialize(method, path, data = {})
    @base_url = 'https://jsonplaceholder.typicode.com'
    @headers = { 'Content-Type' => 'application/json' }
    @method = method
    @path = path
    @data = data
  end

  def send_request
    headers = { 'Content-Type' => 'application/json' }
    HTTParty.send(@method, "#{@base_url}#{@path}", headers:, body: @data.to_json)
  end

  def fetch_data
    response = Net::HTTP.get(URI("#{@base_url}#{@path}"))
    JSON.parse(response)
  end
end
