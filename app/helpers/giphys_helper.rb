module GiphysHelper

  def search_gif(search)
    HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{search}&limit=1&api_key=#{ENV["GIPHY_ID"]}")
  end

  def parse_giphy(response)
    data = JSON.parse(response.read_body)
    @giphy = data["data"]
    @giphys = []
    @giphy.each do |hash|
      @giphys << hash["images"]["fixed_height"]["url"]
    end
    @giphys
  end

end   