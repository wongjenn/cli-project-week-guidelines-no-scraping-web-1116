require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

require_relative '../lib/collision_cli'
require_relative '../lib/collisions'
require_relative '../lib/nypd_mv_adapter'

require "open-uri"
require "json"
