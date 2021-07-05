class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  def slug(name)
    slug_name = name.sub(" ", "-")
    slug_name
  end

  def find_by_slug(slug)
    name = slug.sub("-", " ")
    name
    #[Song/Genre/Artist].find_by(name: name)
  end

end