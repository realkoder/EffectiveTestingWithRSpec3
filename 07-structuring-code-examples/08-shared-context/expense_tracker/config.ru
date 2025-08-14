# This file is needed to start Sinatra server - rackup

require_relative 'app/api'
run ExpenseTracker::API.new