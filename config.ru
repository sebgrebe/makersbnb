require_relative "./controller"

use Rack::Static, :urls => ['/stylesheets', '/src'], :root => 'public'

run MakersBnB
