class Article
  attr_accessor :title, :url, :description
  def initialize(title, url, description)
    @title = title
    @url = url
    @description = description
  end
end
