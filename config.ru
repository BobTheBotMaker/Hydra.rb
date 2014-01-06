# config.ru
require 'sinatra'
require 'faye'
require File.expand_path('../app', __FILE__)

use Faye::RackAdapter, :mount => '/faye', :timeout => 25

run Sinatra::Application