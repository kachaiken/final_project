require 'themoviedb'
require 'pry'
class Movie
	attr_accessor :names, :genre, :genre_id, :mood, :imdb, :posters

	def initialize(mood)
		@client = Tmdb::Api.key("0e256689b31834b49bedd90fded01e27")
		@names = []
		@imdb = []
		@movie_id = []
		@posters = []
		@mood = mood
		self.match_mood_and_genre
		self.get_movie_genre_id
		self.get_movie_names
		self.get_movie_id
		self.imdb_link
		self.movie_images
	end

	def match_mood_and_genre
		if @mood == "Happy"
			@genre = "Comedy"
		elsif @mood == "Sad"
			@genre = "Drama"
		elsif @mood == "Romantic"
			@genre = "Romance"
		elsif @mood == "Bored"
			@genre = "Horror"
		elsif @mood == "Old"
			@genre = "History"
		elsif @mood == "Young"
			@genre = "Family"
		elsif @mood == "Adventerous"
			@genre = "Adventure"
		elsif @mood == "Energetic"
			@genre = "Thriller"
		elsif @mood == "Curious"
			@genre = "Mystery"
			elsif @mood == "Cultural"
			@genre = "Foreign"
		elsif @mood == "Imaginative"
			@genre = "Fantasy"
		elsif @mood == "Musical"
			@genre = "Music"
		end
	end

	def get_movie_genre_id

		movie_genres = Tmdb::Genre.list #this gives you all the genres
		movie_genres["genres"].each do |genre|
			if genre["name"] == @genre
				@genre_id = genre["id"]
			end
		end
		@genre_id
	end


	def get_movie_names
		genre_info = Tmdb::Genre.detail(@genre_id)
		genre_info.results.each do |movie|
			@names.push(movie["original_title"])
		end	
		@names
	end

	def get_movie_id
		genre_info = Tmdb::Genre.detail(@genre_id)
		genre_info.results.each do |id|
			@movie_id.push(id["id"])
	end
end

	def imdb_link
		@movie_id.each do |id|
			movie_info = Tmdb::Movie.detail(id)
			@imdb.push(movie_info["imdb_id"])
		end
		@imdb
	end

	def movie_images
		genre_info = Tmdb::Genre.detail(@genre_id)
		genre_info.results.each do |movie|
			#see if movie["original_title"] is a key in the @names hash
			# if @names.has_key?(movie["original_title"])
				# binding.pry
				# @names[movie["original_title"]] = 
				path = "https://image.tmdb.org/t/p/w185" + movie["poster_path"]
				@posters.push(path)
		    #if it is, change the value of that key from " " to movie["poster_path"]
			end
	end

end



