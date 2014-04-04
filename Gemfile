source 'https://www.rubygems.org/'


#install bcrypt?

#To talk to the database, we'll need the datamapper gem. It's an ORM (Object-relational mapper), which means that it's providing a convenient way 
#to interact with our data using classes and objects instead of working with database tables directly.
#Another advantage of datamapper is that is can be used with a variety of database engines, not only postgres. This 
#implies that we'll need to install an adapter to work with postgres, apart from the datamapper itself.

ruby '2.1.0'

gem 'sinatra'
gem 'data_mapper'
gem 'dm-postgres-adapter'
gem 'pg'
gem 'database_cleaner'
gem 'bcrypt-ruby'
gem 'rack-flash3'
gem 'sinatra-partial'
gem 'mandrill-api'
gem "rack-flash-session"

group :development, :test do
	gem 'poltergeist'
  gem 'capybara'
  gem 'shotgun'
  gem 'rspec'
end
