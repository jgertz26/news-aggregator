require 'sinatra'
require 'shotgun'
require 'pry'
require 'csv'
require_relative 'article'

articles = []

get "/" do
  redirect "/articles"
end

get '/articles' do
  articles = []
  CSV.foreach('articles.csv', headers: true, header_converters: :symbol) do |row|
    article = row.to_hash
    articles << Article.new(article[:title], article[:url], article[:description])
  end
  erb :list_index, locals: { articles: articles }
end


get '/articles/new' do
  erb :form_index
end


post "/articles" do
  urls = []
  CSV.foreach('articles.csv', headers: true, header_converters: :symbol) do |row|
    article = row.to_hash
    urls << article[:url]
  end

  urls.each do |url|
    if url == params[:url]
      break
    end
  end

  article_info = params.values
  CSV.open('articles.csv', 'a+') do |csv|
    csv << article_info
  end

  redirect "/articles"

end
