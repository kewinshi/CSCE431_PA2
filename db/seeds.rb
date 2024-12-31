# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def remove_duplicates
    Movie.group(:title).having("count(*) > 1").pluck(:title).each do |title|
      movies_to_remove = Movie.where(title: title).offset(1)
      movies_to_remove.destroy_all
    end
  end
  
  more_movies = [
    {:title => 'My Neighbor Totoro', :rating => 'G', :release_date => '1988-04-16'},
    {:title => 'Green Book', :rating => 'PG-13', :release_date => '2018-11-16'},
    {:title => 'Parasite', :rating => 'R', :release_date => '2019-05-30'},
    {:title => 'Nomadland', :rating => 'R', :release_date => '2021-02-19'},
    {:title => 'CODA', :rating => 'PG-13', :release_date => '2021-08-13'},
    # added 3
    {:title => 'Goodwill Hunting', :rating => 'R', :release_date => '1997-03-05'},
    {:title => 'Forest Gump', :rating => 'PG-13', :release_date => '1994-07-06'},
    {:title => 'Godzilla Minus One', :rating => 'PG-13', :release_date => '2023-11-23'}
  ]
  
  more_movies.each do |movie|
    Movie.find_or_create_by!(title: movie[:title]) do |m|
      m.rating = movie[:rating]
      m.release_date = movie[:release_date]
    end
  end
  
  remove_duplicates
  