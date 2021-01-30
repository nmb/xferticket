$LOAD_PATH.push File.expand_path('./lib', __dir__)

#set :run, false
#set :environment, :production
module XferTickets
  ROOT = File.expand_path('.', __dir__)
end

require "xferticket"
run XferTickets::Application
