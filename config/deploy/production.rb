require 'net/ssh/proxy/command'
server 'transaction-load.p.devguru.co', user: 'transaction-load', roles: %w(web app db)
set :ssh_options, proxy: Net::SSH::Proxy::Command.new("ssh transaction-load@g.devguru.co -W %h:%p")
set :branch, 'production'
