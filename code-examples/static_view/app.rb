require "require_all"
require "sinatra"

require_all "controllers"
require_relative "helpers/helpers"
require_relative "db/db"
require_all "models"

enable :sessions
