require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

BASE_URL = 'https://www.imdb.com'

def get_url_of_top_movies(url, number)
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.titleColumn a')[0...number].map { |element| element['href']}
end

def get_movie_info(url)
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  title = html_doc.search('h1').text

  { cast: cast, director: director,
    storyline: storyline, title: title, year: year }
end

def imdb
  url = "#{BASE_URL}/chart/top/?ref_=nv_mv_250"
  movie_urls = get_url_of_top_movies(url, 25)
  movie_urls.each do |url|
    get_movie_info("#{BASE_URL}#{url}")
  end
end

imdb
