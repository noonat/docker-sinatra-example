require 'logger'
require 'sinatra/base'

class App < Sinatra::Base
  enable :static
  set :root, File.join(File.dirname(__FILE__))

  get '/' do
    erb :index
  end
end
