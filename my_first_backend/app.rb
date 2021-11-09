require 'sinatra'

set :bind, '0.0.0.0'
set :port, 8080

helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end
  
    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    end
  end

    get '/' do
      ['All of You','Come Back to Me','Head on My Pillow','You, My Love'].sample()
    end

    get '/birth_date' do
        'December 12, 1915'
    end
    
    get    '/birth_city' do
            'Hoboken, New Jersey'
        end

        get '/wives' do
            ['Nancy Barbato', 'Ava Gardner','Mia Farrow' ,'Barbara Marx']
        end

    get '/picture' do
       redirect 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Frank_Sinatra_in_1957.jpg/220px-Frank_Sinatra_in_1957.jpg'
    end

    get '/public' do
        'Everyone can see this page'
    end

    get '/protected' do
        protected!
        'Welcom authenticated client'
    end