#This class corresponds to a table in the database
#We can use it to manipulate the data 

class Link

	#this makes the instances of this class Datamapper resources
	include DataMapper::Resource

	has n, :tags, :through => Resource

  # 'has n' means 'has many', so this means the link has many tags


	#This block describes what resource our model will have
	property :id, Serial #Serial means that it will be auto-incremented for every record
	property :title, String
	property :url, String


end


