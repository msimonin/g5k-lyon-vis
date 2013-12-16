require './sinatra'
require './faye'

use PDUs::PdusBackend

run PDUs::App
