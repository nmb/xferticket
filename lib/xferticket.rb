# frozen_string_literal: true
require "rubygems"
require "bundler/setup"
require "sinatra/base"
require "sinatra/config_file"
require "sinatra/flash"
require "rufus/scheduler"
require "minitar"
require "securerandom"
require "logger"
require 'pp'
require 'sequel'
require 'sqlite3'

require "xferticket/application.rb"
require "xferticket/directoryuser.rb"
require "xferticket/ticket.rb"

