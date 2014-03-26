class Tag

  include DataMapper::Resource

  has n, :links, :through => Resource

  # 'has n' means 'has many', so this means the tag has many links

  property :id, Serial
  property :text, String

  
  
end