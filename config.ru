require "./lib/codebreaker/racker"

use Rack::Session::Cookie, key: 'rack.session',
                           path: '/',
                           secret: 'secret'

use Rack::Static, urls: %w(/css /js), root: 'lib/assets'
run Racker