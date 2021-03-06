module GiphysHelper

  def search_gif(search)
    HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_ID"]}&q=#{search}&limit=1&offset=0&rating=r&lang=en")
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

  def find_giphy(blog)
    @giphy_blog = blog
    searched_gif = search_gif(@giphy_blog.title)
    @giphy = parse_giphy(searched_gif)
  end

end
